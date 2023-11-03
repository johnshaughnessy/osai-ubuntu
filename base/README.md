### Building a base layer image

The `base` directory contains dockerfiles that define a set of useful base layers.

```sh
gcloud auth login
gcloud config set project hubs-dev-333333
gcloud auth configure-docker us-central1-docker.pkg.dev

docker build -f Dockerfile.cuda-pip-torch --target cuda-pip-torch -t us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10 .

# Test it out:
docker run --rm --gpus all -it us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10 bash

docker push us-central1-docker.pkg.dev/hubs-dev-333333/ocho-osai/osai-ubuntu/cuda-pip-torch:ubuntu23.10
```

Unfortunately, the base images are ~14GB, which means that (at least for me), uploading the image to the registry takes quite a long time. You may have an easier time building the image.
