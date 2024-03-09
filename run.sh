#!/bin/bash

set -e

docker run --rm --gpus=all -v $(pwd):/user/dev nvidia-docker-test -it

echo "done"
