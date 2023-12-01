docker run \
    --rm \
    --gpus all \
    -it \
    --name comfyui \
    --publish 8188:8188 \
    --mount type=bind,source="$(pwd)"/ComfyUI,target=/ComfyUI \
    comfyui \
    python3 /ComfyUI/main.py --listen 0.0.0.0 --port 8188
