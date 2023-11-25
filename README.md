# Open Source AI Machine Setup

This repo contains scripts to set up `cuda`, `docker`, and `nvidia-container-runtime` from a new installation of ubuntu server 23.10.

The setup scripts assume you have a `control node` and a `target node`:

- The `control node` is the computer where you will issue `ansible` commands.
- The `target node` is the (remote) computer that you are trying to configure.

## Prerequisites

Setup starts with a new copy of Ubuntu Server 23.10 on the target node.

> In retrospect, things would have been easier with 22.04, because NVIDIA officially support `cuda` and `nvidia-container-toolkit` on ubuntu 22.04.

In order to run the `ansible` setup script:

- `ansible` needs to be installed on the control node,
- the target node needs `python3`
- the control node needs ssh access to the target machine
- the ssh user on the target machine must be able to run `sudo`

Configure `ansible/inventory.ini` with the hostname of the target node. (Change the line that says `osai-redwood`.)

Add the target node's ssh configuration to `~/.ssh/config` so that ansible knows how to ssh into the target node. For example, mine looks like this:

```
Host osai-redwood
  HostName 192.168.2.234
  User john
  Port 22
  IdentityFile ~/.ssh/keys/jshaughnessy@mozilla.com
  ForwardAgent yes
```

## Running the setup script

Run the ansible setup script from inside the ansible directory:

```sh
cd ansible/
ansible-playbook setup.yml --ask-become-pass
```

> Some of the steps in the playbook take several minutes to complete.

## Testing the target node

After setup, you can test the target node using docker images defined in repo.

- Clone this git directory on the target node.
- Navigate to the `nvidia-ctk-test` directory.
- Follow the instructions in `nvidia-ctk-test/README.md`.

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

The CUDA Device details should reflect what you have available on your system.

## Running `fastbook` notebooks locally with jupyter lab.

The `fast.ai` course on deep learning and machine learning comes includes several jupyter notebooks which are available for free on github: https://github.com/fastai/fastbook . They suggest running these notebooks in google colab, but if you prefer to run them locally, you can use the setup scripts in this repo.

- Navigate to the `fastbook` directory.
- Follow the instructions in `fastbook/README.md`.
