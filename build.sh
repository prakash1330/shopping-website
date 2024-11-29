#!/bin/bash

# Adding env variable
# export IMAGE_NAME=$(cat info.txt)
# export TAG=$(cat tag.txt)

# echo 

# Taking the container tage name from info.txt file
docker build -t $(cat info.txt):$(cat tag.txt) .








