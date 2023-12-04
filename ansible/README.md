# OSAI Machine Setup

Set up `docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) on `Ubuntu 22.04` using `ansible`.

## Background

[Ansible](https://www.ansible.com/) defines a _control node_ and a _target node_:

- The _control node_ is the computer where you will issue `ansible` commands.
- The _target node_ is the (remote) computer that you are trying to configure.

> If you are using a single machine, the control node and the target node are the same. In this case, ignore instructions about `ssh` and refer to the target node as "localhost".

## Pre-Installation

The control node user:

- Must have `ansible` installed.
- Must have `ssh` access to the target node (unless the target node is `localhost`).

The target node user:

- Must have `python3` and `sudo` installed. (These typically come pre-installed with Ubuntu.)
- Must must be allowed to run `sudo`.

## Run the setup script

Run the playbook with the command below.

- Replace `host,` with the host name or ip address of the target node, followed by a comma (`,`). (Use `"localhost,"` for single machine setup.)
- Replace `user` with your (target node) user name.

```sh
ansible-playbook setup.yml -i "host," -u "user" --ask-become-pass -vvv
```

> Setup takes 10-20 minutes to complete.

> The machine will reboot after installing the NVIDIA driver.

## Verifying Setup

After setup, verify that the target node has been setup correctly by running the [nvidia-ctk-test](../nvidia-ctk-test/README.md).
