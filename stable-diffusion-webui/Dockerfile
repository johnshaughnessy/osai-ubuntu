FROM us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10

RUN apt update
RUN apt install wget git python3 python3-venv libgl1 libglib2.0-0
COPY container_init.sh /container_init.sh
