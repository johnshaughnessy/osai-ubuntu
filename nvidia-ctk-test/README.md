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

A successfully configured system will show output that looks something like this:

```
john@osai-redwood:~/osai/nvidia-ctk-test$ docker run --gpus all nvidia-ctk-test

==========
== CUDA ==
==========

CUDA Version 12.2.2

Container image Copyright (c) 2016-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.

This container image and its contents are governed by the NVIDIA Deep Learning Container License.
By pulling and using the container, you accept the terms and conditions of this license:
https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license

A copy of this license is made available in this container at /NGC-DL-CONTAINER-LICENSE for your convenience.

CUDA version: 12.1
CUDA available: True
Number of CUDA devices available: 2
CUDA Device 0: NVIDIA GeForce RTX 4090
Device name: NVIDIA GeForce RTX 4090
CUDA Device 1: NVIDIA GeForce RTX 4090
Device name: NVIDIA GeForce RTX 4090
```
