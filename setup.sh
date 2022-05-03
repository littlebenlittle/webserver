#!/bin/sh

set -x

dnf -y upgrade
dnf -y install iptables-services podman
systemctl disable firewalld
systemctl enable --now iptables
systemctl enable --now ip6tables
systemctl enable --now podman.socket

dnf -y remove firewalld

# ip4
iptables -F
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo   -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -s 98.38.168.106/32 -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp  -m multiport -m state --destination-ports 53,80,4001 --state NEW -j ACCEPT
iptables -A INPUT -p udp  -m udp -m state --dport 53 --state NEW -j ACCEPT

iptables -P INPUT DROP

# drop all ip6
ip6tables -F
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT DROP

service iptables save

# hostnamectl set-hostname "podman-host-$LINODE_DATACENTERID-$LINODE_ID"
useradd -m user
usermod -aG wheel user

ssh=/home/user/.ssh
akeys=$ssh/authorized_keys
cat >/root/setup.sh <<EOF
#!/bin/bash

set -e

passwd user

sed -i \\
    -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' \\
    -e 's/PermitRootLogin yes/PermitRootLogin no/g' \\
    -e 's/#AddressFamily any/AddressFamily inet/g' \\
    /etc/ssh/sshd_config

mkdir $ssh
chown user $ssh
chgrp user $ssh
chmod 700  $ssh

cat >$akeys <<EOM
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeSf1+WWpg6Ub7fJNVSqK74pQvIvoM2eQ4VvWEBHpxJ1KzyNw7YJmTJ/ZbjBEM9458Aj15lBHKmKyNwPuLLIKLHYudINGn3jZNJ4YBFTzoIXsAUKXiDCDgcmTSTgUSK0qeehOcEaoI1c9/TW+zGfo8YhAPVln1ZyNKqW/ig8KfdtCUhbVs2RzeQbCPVZLM3CNXWxWdaoZD+8Y/yx3buXXCJUkFDDpuTT8ScpTuIbebzdlE+91dMR6fnQhBzptgZzMVDiYfycgQ/gpAHP69gfKPvlGPtp1L1pCJJTwWTZIFYnpiVAA3Ufvasm1VTw+CyZmP9Rp0UqAyaBbhGaP4SnlG9DsZMI9Y4HmxgLRqYLjLTR2cNDe7gdPU7jFP6ZoOSxMIhJAT4awU+dbz9y0nU/rNbVb5kAv1RHKYUdALsEv7Kr2kjpKDanbSQXgbiRK93Mn+sWxeYOEl1XR+rsHer7VucyfTDlbkbfPuF5iSPSoonZs3czKWU7EehAmaPccjP2o+I15s8Wije65X2r7jORl33XPsrNwhiKxRcaTIvev0McTD3/9hbndAAUT0rACqIB4GZxmt4RCm52G5gTQ1yU85EG/YG8FKZM6tehoPziN3TiZ/QaSHmB8FoK/fyW2IjlEq11eO3NE/E1LdyGk+eupWfzriD7Y0WiKvrHjlFp/3Cw== user@a-development
EOM
chown user $akeys
chgrp user $akeys
chmod 600  $akeys

systemctl restart sshd
EOF
chmod +x /root/setup.sh
