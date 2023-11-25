#!/bin/bash
#
# Run a program in the stable-diffusion-webui docker container
#
# Usage: ./run.sh [program_name] [program_args]
#
# For example, to run bash you'd do:
#   ./run.sh /bin/bash
# By default, it will run the webui.

program_name=$1
if [[ -z "${program_name}" ]]; then
  docker run \
      --rm \
      --gpus all \
      -it \
      --name stable-diffusion-webui \
      --publish 7860:7860 \
      --mount type=bind,source="$(pwd)"/code,target=/code \
      --user "john":"john" \
      stable-diffusion-webui \
      ./webui.sh --listen
fi

# If the program name is not empty, run it and pass any additional arguments
docker run \
    --rm \
    --gpus all \
    -it \
    --name stable-diffusion-webui \
    --publish 7860:7860 \
    --mount type=bind,source="$(pwd)"/code,target=/code \
    --user "john":"john" \
    stable-diffusion-webui \
    "${program_name}" "${@:2}"
