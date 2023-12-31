# Open Source AI - Ubuntu

This repo contains scripts to configure Ubuntu 22.04 for running and developing AI applications.

The setup installs `Docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) to run applications in isolated containers. Dependency management is simplified by having each application specify the versions of python, pytorch, CUDA, or other system packages it needs.

## Installation

Run `./setup.sh` on the Ubuntu machine you want configured.

> You will need to reboot the machine after setup (because of `nvidia-driver`).
> If you already had `nvidia-driver` installed when you ran the script, you will only need to logout and login again (so that your user is added to the `docker` group).

Alternatively, an `ansible` playbook is available: [`ansible/README.md`](./ansible/README.md).

After setup, verify that the target node has been setup correctly by running the [nvidia-ctk-test](../nvidia-ctk-test/README.md).

## Background

AI applications often have dependencies that conflict with one another.

- For python dependency isolation, the usual solution is virtual environments ([`venv`](https://docs.python.org/3/library/venv.html)s).
- For system dependency isolation, the usual solution is containerization (e.g. [`Docker`](https://www.docker.com/)).

This setup uses `NVIDIA Container Toolkit` to ensure that our docker containers can access the GPU. This simplified diagram shows how this works:

!["NVIDIA Container Toolkit simple graph"](/docs/nvidia-dependencies-simple-2.png "NVIDIA Container Toolkit simple graph")

| Package                    | Purpose                                                                      |
| :------------------------- | :--------------------------------------------------------------------------- |
| `cuda-toolkit`             | Needed for developing CUDA applications                                      |
| `cuda-runtime`             | Needed for running CUDA applications                                         |
| `nvidia-driver`            | Needed to allow programs to use the GPU                                      |
| `nvidia-container-toolkit` | Exposes the `nvidia-driver` to containers (like `docker`, `containerd`, etc) |

In practice, the `apt-cache` dependency graph is more complicated than the diagram above.

<details>
<summary>This diagram shows version numbers. (Click to expand.)</summary>
<img src="/docs/nvidia-dependencies-simple.png" alt="NVIDIA Container Toolkit simple graph" title="NVIDIA Container Toolkit simple graph">
</details>

<details>
<summary>This diagram shows additional dependencies. (Click to expand.)</summary>
<img src="/docs/nvidia-dependencies.png" alt="NVIDIA Container Toolkit graph" title="NVIDIA Container Toolkit graph">
</details>

To inspect the dependency graph, run this command inside a container where CUDA is installed:

```sh
apt-cache depends cuda
```

## Running and developing applications

Users are encouraged to create new docker images as needed.

The [`OSAI Apps`](https://github.com/johnshaughnessy/osai-apps) repo has several examples and contains `Dockerfile`s that may be good starting points.
