# `jupyter-lab-base`

This directory contains dockerfiles for running various jupyter notebooks in jupyter lab. Typically, package management is done with python virtual environments, or sometimes it's not done at all, and the user just hopes their scripts don't get deprecated by newer versions of python libraries. Alternatively, people run their code on colab so that their notebooks don't have conflicting dependencies.

Instead of this, we'll try running the notebooks in containers with jupyter lab installed. Even though jupyter-lab is plenty capable of running many jupyter notebooks from many projects, it still requires the user manage the underlying dependencies. Since these dependencies are not just restricted to python dependencies, (e.g. A notebook might install an apt package by invoking a bash command), I to try managing this in docker containers instead.

# Build and run the `jupyter-lab-base` image

The base image just adds `jupyter-lab-base` (and `git`, for convenience) to our `cuda-pip-torch` image.

The assumption is that we'll clone notebooks into `./code/` and `.gitignore` them.

1. Build `jupyter-lab-base`:

```sh
docker build -f Dockerfile.jupyter-lab-base -t jupyter-lab-base .
```

2. Run jupyter lab in the container with:

```sh
docker run \
    --rm \
    --gpus all \
    -it \
    --name jupyter-lab-base \
    --publish 8000:8000 \
    --mount type=bind,source="$(pwd)"/code,target=/home/john/code \
    --user "john":"john" \
    jupyter-lab-base \
    /home/john/code/run-jupyter-lab.sh
```

3. Access it via http://192.168.2.234:8000/ (replacing the ip address with the target node's IP).

# Running `fastai/diffusion-nbs`

1. Build `jupyter-lab-base` (following the instructions above).
2. Clone the git repo.

```sh
pushd code
git clone https://github.com/fastai/diffusion-nbs
popd
```

3. Build `jupyter-lab-fastai-diffusion-nbs`

```sh
docker build -f Dockerfile.fastai-diffusion-nbs -t jupyter-lab-fastai-diffusion-nbs .
```

4.  Run it:

```sh
docker run \
     --rm \
     --gpus all \
     -it \
     --name jupyter-lab-fastai-diffusion-nbs \
     --publish 8000:8000 \
     --mount type=bind,source="$(pwd)"/code,target=/home/john/code \
     --user "john":"john" \
     jupyter-lab-fastai-diffusion-nbs \
     /home/john/code/run-jupyter-lab.sh
```

5. Access it via http://192.168.2.234:8000/ (replacing the ip address with the target node's IP).

## Note to self [John]

In the previous set up, I ran jupyter lab as a systemd service. This was not in a docker containter. It was just configured to use a particular virtual env (with mamba).

```sh
/home/john/mambaforge/envs/scratch/bin/jupyter lab --config=/home/john/.jupyter/jupyter_lab_config.py --NotebookApp.allow_origin='https://deeplearning8.com' --no-browser
```
