#!/bin/bash

export REGISTRY_HOST=ghcr.io
export USERNAME=getaux
export LAST_VERSION=1.0.0
export CONTAINER_NAME=worker

cd worker && \
docker build -t worker . --no-cache && \
docker tag worker $REGISTRY_HOST/$USERNAME/worker:$LAST_VERSION && \
docker push $REGISTRY_HOST/$USERNAME/worker:$LAST_VERSION && \
docker tag worker $REGISTRY_HOST/$USERNAME/worker:latest && \
docker push $REGISTRY_HOST/$USERNAME/worker:latest