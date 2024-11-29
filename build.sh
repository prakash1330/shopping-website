#!/bin/bash

# Adding env variable
export IMAGE_NAME=$(cat info.txt)
export TAG=$(cat tag.txt)

# Taking the container tage name from info.txt file
docker build -t ${IMAGE_NAME}:${TAG} .

# Stop the existing container
docker-compose down

# spin up a new container
docker-compose up -d








