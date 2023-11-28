# privateGPT in Docker

[Memory Cache](https://memorycache.ai/) is a project that connects a user's local documents to [privateGPT](https://github.com/imartinez/privateGPT) and integrates with Firefox via an extension to easily add to a personal knowledge repo.

These scripts/configs are meant to help run the Memory Cache / privateGPT backend in a docker container. In particular, this directory includes:

- a docker image for running privateGPT's primordial branch,
- configuration files for privateGPT,
- a script to run the docker image,
- a script to copy files from the control node to the remote node,
- directories that will be mounted into the docker image.

(The scripts are nothing special: they are just thin wrappers around `docker` commands.)

These configs focus on the privateGPT backend. The steps for setting up the front-end are well documented in the [Memory Cache README.md](https://github.com/misslivirose/memory-cache#memory-cache).

# Usage

After first-time setup:

- Run `sync.sh` on the control node
- Run `run.sh` on the remote node.

# Setup

## `privateGPT` backend

0. The scripts assume that the `osai-ubuntu` repo is cloned on the remote node at `/home/john/osai`. Clone it there if it isn't already.

1. Clone privateGPT into `/home/john/osai/memory-cache/code/privateGPT` and checkout the primordial branch:

```sh
git clone https://github.com/imartinez/privateGPT/
cd privateGPT
git checkout -b primordial origin/primordial
```

2. Build the docker image:

```sh
docker build -f Dockerfile.privategpt -t privategpt .
```

3. Download the LLM model into the `models` subdirectory:

```sh
wget https://gpt4all.io/models/ggml-gpt4all-j-v1.3-groovy.bin -O models/ggml-gpt4all-j-v1.3-groovy.bin
```

4. (Optionally) Configure the .env file (`code/.env`) if you wish to change the defaults.

5. Run the docker container with `./run.sh`.

## `Memory Cache` frontend

`Memory Cache` currently requires a custom build of firefox. Instructions for building it are on its [github page](https://github.com/misslivirose/memory-cache).

If you want to run firefox on the control node and run `privateGPT` on the remote node, the `sync.sh` script automatically copies files from the control node to the remote node. Simply run it from the control node. (Edit the script to set your source and destination directories appropriately.)
