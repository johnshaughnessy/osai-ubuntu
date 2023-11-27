Dockerfile for running jupyter lab

When notebooks have different requirements, it's helpful to separate each one into its own docker container.

# Build and run the `jupyter-lab-base` image

Build with:

```sh
docker build -f Dockerfile.jupyter-lab-base -t jupyter-lab-base .
```

Run with:

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
    bash
```

# Running fastai/diffusion-nbs.git

Spin up a `jupyter-lab-base` container. Then run:

```sh
git clone https://github.com/fastai/diffusion-nbs.git
cd diffusion-nbs
pip install -r requirements.txt
PATH=$PATH:~/.local/bin
```

Optionally, set a password with

```sh
jupyter lab password
```

Then run jupyter lab:

```
jupyter lab --config=/home/john/code/.jupyter/jupyter_lab_config.py --no-browser --port 8000 --ip 0.0.0.0
```

Access it via http://192.168.2.234:8000/ (replacing the ip address with the target node's IP).

## Note to self [John]

In the previous set up, I ran jupyter lab as a systemd service. This was not in a docker containter. It was just configured to use a particular virtual env (with mamba).

```sh
/home/john/mambaforge/envs/scratch/bin/jupyter lab --config=/home/john/.jupyter/jupyter_lab_config.py --NotebookApp.allow_origin='https://deeplearning8.com' --no-browser
```
