#!/bin/bash

NAME="$SNAP_INSTANCE_NAME"
IMAGE=$(snapctl get image)

if [ ! "$(docker ps --all --quiet --filter name="$NAME")" ]; then
    echo "Container does not exist. Creating ..."
    docker volume create portainer_data
    docker create \
        --name "$NAME" \
        --restart=always \
        -p 9443:9443 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
        --log-driver none \
        "$IMAGE"
fi

echo "Starting container ..."
docker start --attach "$NAME"
