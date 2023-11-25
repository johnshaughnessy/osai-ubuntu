mkdir -p code
docker build -f Dockerfile -t stable-diffusion-webui .
docker run \
    --rm \
    --gpus all \
    -it \
    --name stable-diffusion-webui \
    --publish 7860:7860 \
    --mount type=bind,source="$(pwd)"/code,target=/code \
    stable-diffusion-webui \
    "/container_init.sh"
