#!/bin/bash

# Start the docker container, and mount ./code to /code
docker run \
    --rm \
    --gpus all \
    -it \
    --name stable-diffusion-webui \
    --publish 7860:7860 \
    --mount type=bind,source="$(pwd)"/code,target=/code \
    stable-diffusion-webui \
    bash
