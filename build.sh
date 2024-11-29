#!/bin/bash
# Adding env variable
export IMAGE_NAME=$(cat info.txt)
export TAG_NAME=$(cat tag.txt)

# Stop the existing container
docker compose down

# Taking the container tage name from info.txt file
docker build -t $(cat info.txt) .

# spin up a new container
# Main
docker compose up -d








