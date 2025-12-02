#!/usr/bin/env bash
export IMAGE_NAME=$1
docker pull env.IMAGE_NAME
docker run -d -p 3000:3000 env.IMAGE_NAME