# Use an official NVIDIA CUDA base image
FROM us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10

# Copy the script into the container
COPY check_cuda.py /app/check_cuda.py

# Command to run on container start
CMD ["python3", "/app/check_cuda.py"]
