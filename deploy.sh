#!/bin/bash
# setting up evn variable
export IMAGE_NAME=$(cat info.txt)
export TAG=$(cat tag.txt)

# stopping the existing continer
docker-compose down

# spinning up new container
docker-compose up -d
