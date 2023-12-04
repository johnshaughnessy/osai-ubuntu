# Test nvidia-container-toolkit

This test verifies that our machine can run gpu-accelerated docker containers.

Installed on the host:

- Docker
- NVIDIA Container Toolkit
- NVIDIA Driver

Installed in the container:

- python
- pip
- pytorch
- cuda

## Build and run the test

Build the docker image:

```sh
docker build -t nvidia-ctk-test .
```

> Building the image takes 10-20 minutes.

Run it:

```sh
docker run --gpus all nvidia-ctk-test
```

A successfully configured system will show output that looks something like this:

```
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

The CUDA Device details should reflect what you have available on your system.
