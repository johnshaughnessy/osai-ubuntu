# OSAI Machine Setup

This directory contains scripts for setting up `docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) on a fresh installation of Ubuntu 22.04 using `ansible`.

The purpose of this setup is to allow applications to run in isolated containers with minimal dependencies installed on the host. This simplifies dependency management, allowing each application to install whatever versions of python, pytorch, CUDA, etc that it needs. Keeping the host system simple and encouraging the use of containers also encourages users to be explicit with the dependencies of each application they are running or developing, and ensures that the machine can easily be shared between several (human) users with ease.

## Prerequisites

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

## Run the setup script

Run the playbook with the command below, replacing `host` with the host name or ip address of the target node.

```sh
ansible-playbook setup.yml -i "host," --ask-become-pass -vvv
```

> The machine will reboot after installing the NVIDIA driver.

> Setup takes 10-20 minutes to complete.

## Testing the target node

After setup, test the target node with [nvidia-ctk-test](../nvidia-ctk-test/README.md).
