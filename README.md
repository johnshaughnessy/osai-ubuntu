# Open Source AI Machine Setup

This repo contains scripts for setting up `docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) on a fresh installation of Ubuntu Server.

The purpose of this setup is to allow applications to run in isolated containers with minimal dependencies installed on the host. This simplifies dependency management, allowing each application to install whatever versions of python, pytorch, CUDA, etc that it needs. Keeping the host system simple and encouraging the use of containers also encourages users to be explicit with the dependencies of each application they are running or developing, and ensures that the machine can easily be shared between several (human) users with ease.

More details are available in the [Background Info](/#background-info) section.

## Getting Started

For setup, you'll need a `control node` and a `target node`:

- The `control node` is the computer where you will issue `ansible` commands.
- The `target node` is the (remote) computer that you are trying to configure.

The target node should have a fresh installation of Ubuntu Server 23.10.

> In retrospect, things would have been easier with 22.04, because NVIDIA officially supports `cuda` and `nvidia-container-toolkit` on ubuntu 22.04.

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

### Running the setup script

Run the ansible setup script from inside the ansible directory:

```sh
cd ansible/
ansible-playbook setup.yml --ask-become-pass
```

> Some of the steps in the playbook take several minutes to complete.

### Testing the target node

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

## Background Info

Installing `NVIDIA` drivers and packages can be confusing. Here is a simplified explanation of the most relevant packages:

!["NVIDIA Container Toolkit simple graph"](/nvidia-dependencies-simple-2.png "NVIDIA Container Toolkit simple graph")

| Package                    | Purpose                                                                      |
| :------------------------- | :--------------------------------------------------------------------------- |
| `cuda-toolkit`             | Needed for developing CUDA applications                                      |
| `cuda-runtime`             | Needed for running CUDA applications                                         |
| `nvidia-driver`            | Needed to allow programs to use the GPU                                      |
| `nvidia-container-toolkit` | Exposes the `nvidia-driver` to containers (like `docker`, `containerd`, etc) |

With this set up, each application can be isolated in its own container. Applications relying on different versions of python, pytorch, or CUDA can be configured independently (without using python `venvs`.)

In practice, the `apt-cache` dependency graph ends up looking a bit more complicated than the diagram above.

A slightly more accurate picture (with specific version numbers) is available here:

<details>
<summary>nvidia-dependencies-simple.png</summary>
<img src="/nvidia-dependencies-simple.png" alt="NVIDIA Container Toolkit simple graph" title="NVIDIA Container Toolkit simple graph">
</details>

An even more detailed (but still incomplete) picture is available here:

<details>
<summary>nvidia-dependencies.png</summary>
<img src="/nvidia-dependencies.png" alt="NVIDIA Container Toolkit graph" title="NVIDIA Container Toolkit graph">
</details>

If you are curious and want to inspect the dependency graph yourself, you can use:

```sh
apt-cache depends cuda
```

## Running or developing applications

Once the base system is set up, users are encouraged to create a new docker container for each application they want to run or develop. If they wish to create a new base image, they will typically want to specify which CUDA dependencies they will need:

- For development, the `cuda` package (which includes both the `cuda-runtime`, `cuda-toolkit`, and some example programs) is usually best. Users may install `cuda-runtime` and `cuda-toolkit` instead of `cuda` for a smaller image (because the example programs will be omitted).
- For running applications, it may be enough to just install the `cuda-runtime` without `cuda-toolkit`.

### Running `fastbook` notebooks locally with jupyter lab.

The `fast.ai` course on deep learning and machine learning comes includes several jupyter notebooks which are available for free on github: https://github.com/fastai/fastbook . They suggest running these notebooks in google colab, but if you prefer to run them locally, you can use the setup scripts in this repo.

- Navigate to the `fastbook` directory.
- Follow the instructions in `fastbook/README.md`.

## Using ssh-agent to interact with github

You can use `ssh-agent` to avoid storing your github password or access tokens on target machine.

```sh
# Start ssh-agent from the control node:
eval $(ssh-agent)
# Add your github key:
ssh-add ~/.ssh/keys/johnshaughnessy@github.com
# Connect to the target node:
ssh osai-redwood
# Use git commands as usual
```

Note that you will want to set your `git remote` urls to the `ssh` variant:

![github ssh](/github_ssh.png "Github SSH")
