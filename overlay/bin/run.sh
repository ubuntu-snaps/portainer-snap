#!/bin/bash

NAME="$SNAP_INSTANCE_NAME"
IMAGE=$(snapctl get image)

for PLUG in docker docker-executables; do
  if ! snapctl is-connected $PLUG
  then
    echo "WARNING: $PLUG interface not connected! Please run: /snap/${SNAP_INSTANCE_NAME}/current/bin/setup.sh"
  fi
done

if [ ! "$(docker ps --all --quiet --filter name="$NAME")" ]; then
    echo "Container does not exist. Creating ..."
    docker volume create portainer_data
    docker create \
        --name "$NAME" \
        --restart=always \
        -p 9443:9443 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
        "$IMAGE" \
        --admin-password="$(snapctl get admin-password)"
fi

echo "Starting container ..."
docker start --attach "$NAME"
