# OSAI Machine Setup

This directory contains scripts for setting up `docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) on a fresh installation of Ubuntu 22.04 using `ansible`.

The purpose of this setup is to allow applications to run in isolated containers with minimal dependencies installed on the host. This simplifies dependency management, allowing each application to install whatever versions of python, pytorch, CUDA, etc that it needs. Keeping the host system simple and encouraging the use of containers also encourages users to be explicit with the dependencies of each application they are running or developing, and ensures that the machine can easily be shared between several (human) users with ease.

## Getting Started

For setup, you'll need a `control node` and a `target node`:

- The `control node` is the computer where you will issue `ansible` commands.
- The `target node` is the (remote) computer that you are trying to configure.

The target node should be running Ubuntu 22.04.

> The latest Ubuntu version is 23.10, but we use 22.04 because NVIDIA officially supports `cuda` and `nvidia-container-toolkit` on Ubuntu 22.04.

In order to run the `ansible` setup script:

- `ansible` needs to be installed on the control node,
- the target node needs `python3`
- the control node needs ssh access to the target machine
- the ssh user on the target machine must be able to run `sudo`

Optionally, add the target node's ssh configuration to `~/.ssh/config` so that ansible knows how to ssh into the target node. For example, mine looks like this:

```
Host osai-redwood
  HostName 192.168.2.234
  User john
  Port 22
  IdentityFile ~/.ssh/keys/jshaughnessy@mozilla.com
  ForwardAgent yes
```

### Running the setup script

Run the playbook with the command below, replacing `host` with the host name or ip address of the target node.

```sh
ansible-playbook setup-yml -i "host," --ask-become-pass -vvv
```

> The machine will reboot after installing the NVIDIA driver.

> Setup takes 10-20 minutes to complete.

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

![github ssh](/docs/github_ssh.png "Github SSH")
