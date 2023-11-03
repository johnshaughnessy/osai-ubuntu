# Use an official NVIDIA CUDA base image
FROM us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10

RUN pip install fastbook

RUN apt-get update && apt-get install -y graphviz
