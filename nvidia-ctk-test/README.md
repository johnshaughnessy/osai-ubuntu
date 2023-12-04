# NVIDIA CTK Test

This test verifies that the host can run gpu-accelerated docker containers.

Installed on the host:

- Docker
- NVIDIA Container Toolkit
- NVIDIA Driver

Installed in the container:

- python
- pip
- pytorch
- CUDA

## Build and run the test

Build the docker image:

```sh
docker build -t nvidia-ctk-test .
```

> Building the image may take up to ~30 minutes.

Run it:

```sh
docker run --gpus all nvidia-ctk-test
```

A successfully configured system will show output that looks something like this:

```
==========
== CUDA ==
==========

CUDA Version 12.1.1

Container image Copyright (c) 2016-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.

This container image and its contents are governed by the NVIDIA Deep Learning Container License.
By pulling and using the container, you accept the terms and conditions of this license:
https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license

A copy of this license is made available in this container at /NGC-DL-CONTAINER-LICENSE for your convenience.

CUDA version: 12.1
CUDA available: True
Number of CUDA devices available: 1
CUDA Device 0: Tesla T4
Device name: Tesla T4
```

The CUDA Device details should reflect what you have available on your system.
