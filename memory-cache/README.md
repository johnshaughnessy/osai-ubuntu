# Configs for Memory Cache

[Memory Cache](https://memorycache.ai/) is a project that connects a user's local documents to [privateGPT](https://github.com/imartinez/privateGPT) and integrates with Firefox via an extension to easily add to a personal knowledge repo.

This directory has configs and scripts to help run privateGPT on the remote node, so that memory cache can interact with it.

In particular, it includes:

- a docker image for running privateGPT's primordial branch,
- configuration files for privateGPT,
- a script to run the docker image,
- a script to copy files from the control node to the remote node,
- directories that will be mounted into the docker image.

(The scripts are nothing special: they are just thin wrappers around `docker` commands.)

However, it does not help with building the custom version of firefox or installing the memory cache extension, because those steps are already documented on the [memory cache website](https://memorycache.ai/) and you can choose whether to run the memory cache frontend (firefox) on the control node or the remote node.

# Usage

## Set up the remote node

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

4. Configure the .env file (`code/.env`) if you wish to change the defaults.

5. Run the docker container with `./run.sh`

## Set up Firefox

Memory Cache currently requires a custom build of firefox. Instructions for building it are on its [github page](https://github.com/misslivirose/memory-cache).

If (like me) you want to run firefox on the control node and run privateGPT on the remote node, the `code/sync.sh` script can be used to automatically copy files from the control node to the remote node. Simply run it from the control node.

On the remote node, you can autoingest the new files by running the `code/autoingest.sh` script from inside the running docker container.

It's useful to have two terminals open in the docker container: one for running the autoingest script, and one for running the privateGPT server. The `code/exec.sh` script can be used to open a second terminal in the running docker container.
