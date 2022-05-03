#!/bin/sh

podman build -t server -f ./nginx/Dockerfile .
