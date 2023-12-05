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

## Run the test

Run `./run.sh`.

The test builds a docker image with python, pip, pytorch, and cuda. Then it runs the image in a container to verify that everything is working correctly.

Building the image the first time may take up to ~30 minutes.

If the system is configured correctly, the output will end with:

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

PyTorch version: 2.1.1+cu121
CUDA version: 12.1
CUDA available: True
Number of CUDA devices available: 1
CUDA Device 0: Tesla T4
Device name: Tesla T4
```

## Interactively explore container

To start an interactive shell session inside the container, run:

```sh
docker run -it --gpus all nvidia-ctk-test bash
```
