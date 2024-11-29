#!/bin/bash
# Adding env variable
export IMAGE_NAME=$(cat info.txt)
export TAG=$(cat tag.txt)

# Stop the existing container
docker compose down

# Taking the container tage name from info.txt file
docker build -t $(IMAGE_NAME):$(TAG) .

# spin up a new container
# Main
docker compose up -d








