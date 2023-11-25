docker build -f Dockerfile -t stable-diffusion-webui .
docker run \
    --rm \
    --gpus all \
    -t \
    --name stable-diffusion-webui \
    --publish 7860:7860 \
    --mount type=bind,source="$(pwd)"/code,target=/code \
    --user "john":"john" \
    stable-diffusion-webui \
    "/container_init.sh"
