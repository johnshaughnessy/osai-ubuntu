# Select the base image to use.
#  - If you want to use a locally built image, uncomment the line with "cuda-pip-torch" and comment the line with "us-central1-docker.pkg.dev".
#  - If you want to use Mozilla's pre-built image, uncomment the line with "us-central1-docker.pkg.dev" and comment the line with "cuda-pip-torch".
#
# FROM cuda-pip-torch
FROM us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10


# Copy the script into the container
COPY check_cuda.py /app/check_cuda.py

# Command to run on container start
CMD ["python3", "/app/check_cuda.py"]
