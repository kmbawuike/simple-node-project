#!/usr/bin/env bash
export IMAGE_NAME=$1
docker pull $IMAGE_NAME
docker run -d -p 3000:3000 $IMAGE_NAME