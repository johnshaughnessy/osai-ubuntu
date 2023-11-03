# Test nvidia-container-toolkit

The purpose of this docker container is to test whether all of the dependencies are set up and configured correctly to enable cuda-powered docker containers.

The ansible script should be enough to create a basic setup.

This test will ensure:

- The nvidia driver is installed
- Docker is installed
- Cuda is working (inside of docker)

It will also ensure that INSIDE the container, we can successfully get all these working together in harmony:

- python3
- pytorch
- cuda

Later, we can add additional dependencies (jupyter, fastai, fastbook, etc.)

## Building and running the test

Prerequisite: Setup the host according to the ansible scripts.

Then, build the docker image:

```sh
docker build -t nvidia-ctk-test:latest .
```

And run it:

```sh
docker run --gpus all nvidia-ctk-test:latest
```
