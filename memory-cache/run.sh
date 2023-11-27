#!/bin/bash

docker run \
    --rm \
    --gpus all \
    -it \
    --name privategpt \
    --publish 8001:8001 \
    --mount type=bind,source="$(pwd)"/code,target=/home/john/code \
    --mount type=bind,source="$(pwd)"/docs,target=/home/john/code/privateGPT/source_documents \
    --mount type=bind,source="$(pwd)"/vectorstore,target=/home/john/vectorstore \
    --mount type=bind,source="$(pwd)"/models,target=/home/john/models \
    --user "john":"john" \
    privategpt
