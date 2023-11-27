#!/bin/bash

docker exec \
    -it \
    --user "john":"john" \
    privategpt \
    poetry run bash
