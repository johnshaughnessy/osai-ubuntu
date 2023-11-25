# The `cuda-pip-torch` base image

Several machine learning programs require `CUDA`, `pip`, and `pytorch`. This image is a useful base image to use for those programs, and is extended by some of the other docker images in this repo (e.g. `nvidia-ctk-test/Dockerfile` and `fastbook/Dockerfile`).

There are two ways to acquire a base image:

- You can build the image.
- If you have access to Mozilla's private artifact registry on GCP, you can authenticate with `gcloud` on the command line and then download the image.

## Building the image

docker build -f Dockerfile.cuda-pip-torch --target cuda-pip-torch -t cuda-pip-torch .

## Downloading the image

```sh
gcloud auth login
gcloud config set project hubs-dev-333333
gcloud auth configure-docker us-central1-docker.pkg.dev

# Test it out:
docker run --rm --gpus all -it us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10 bash

```

## Building and Uploading to Mozilla's registry

```sh
gcloud auth login
gcloud config set project hubs-dev-333333
gcloud auth configure-docker us-central1-docker.pkg.dev

docker build -f Dockerfile.cuda-pip-torch --target cuda-pip-torch -t us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10 .

# Test it out:
docker run --rm --gpus all -it us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10 bash

docker push us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10
```

The base images are ~14GB, so uploading the image to the registry takes quite a long time.
