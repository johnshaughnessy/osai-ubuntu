# Open Source AI Machine Setup

This repo contains scripts for setting up `docker`, `nvidia-driver`, and [`NVIDIA Container Toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) on a fresh installation of Ubuntu Server.

The purpose of this setup is to allow applications to run in isolated containers with minimal dependencies installed on the host. This simplifies dependency management, allowing each application to install whatever versions of python, pytorch, CUDA, etc that it needs. Keeping the host system simple and encouraging the use of containers also encourages users to be explicit with the dependencies of each application they are running or developing, and ensures that the machine can easily be shared between several (human) users with ease.

## Getting Started

To set up a new machine, see `ansible/README.md`.

## Background Info

Installing `NVIDIA` drivers and packages can be confusing. Here is a simplified explanation of the most relevant packages:

!["NVIDIA Container Toolkit simple graph"](/docs/nvidia-dependencies-simple-2.png "NVIDIA Container Toolkit simple graph")

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
<summary>Click to expand nvidia-dependencies-simple.png</summary>
<img src="/docs/nvidia-dependencies-simple.png" alt="NVIDIA Container Toolkit simple graph" title="NVIDIA Container Toolkit simple graph">
</details>

An even more detailed (but still incomplete) picture is available here:

<details>
<summary>Click to expand nvidia-dependencies.png</summary>
<img src="/docs/nvidia-dependencies.png" alt="NVIDIA Container Toolkit graph" title="NVIDIA Container Toolkit graph">
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
