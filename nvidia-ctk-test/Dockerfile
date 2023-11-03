# Use an official NVIDIA CUDA base image
# FROM nvidia/cuda:12.3-devel-ubuntu22.04
FROM nvidia/cuda:12.2.2-devel-ubuntu22.04

# Set a working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install PyTorch compatible with CUDA 12.3 (adjust the version as needed)
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu123

# Copy the script into the container
COPY check_cuda.py /app/check_cuda.py

# Command to run on container start
CMD ["python3", "/app/check_cuda.py"]
