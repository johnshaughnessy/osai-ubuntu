docker run \
    --rm \
    --gpus all \
    -it \
    --name comfyui \
    --publish 8000:8000 \
    --mount type=bind,source="$(pwd)"/ComfyUI,target=/ComfyUI \
    --user "john":"john" \
    comfyui \
    python /ComfyUI/main.py
