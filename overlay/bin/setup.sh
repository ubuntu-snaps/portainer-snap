#!/bin/sh
set -e

# For access to Docker Daemon
snap connect $SNAP_INSTANCE_NAME:docker docker:docker-daemon
# For access to Docker CLI
snap connect $SNAP_INSTANCE_NAME:docker-executables docker:docker-executables
