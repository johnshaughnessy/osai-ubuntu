#!/bin/bash

docker build -f Dockerfile.nvidia-ctk-test -t nvidia-ctk-test .
docker run --gpus all nvidia-ctk-test
