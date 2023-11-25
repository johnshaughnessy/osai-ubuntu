# Select the base image to use.
#  - If you want to use a locally built image, uncomment the line with "cuda-pip-torch" and comment the line with "us-central1-docker.pkg.dev".
#  - If you want to use Mozilla's pre-built image, uncomment the line with "us-central1-docker.pkg.dev" and comment the line with "cuda-pip-torch".
#
# FROM cuda-pip-torch
FROM us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10

RUN pip install fastbook

RUN apt-get update && apt-get install -y graphviz
