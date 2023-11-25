# Configuration for running `AUTOMATIC1111/stable-diffusion-webui`

This directory contains a docker image and setup instructions for running https://github.com/AUTOMATIC1111/stable-diffusion-webui inside of a docker container.

# Motivation

There are already a few other [docker-based setups linked in the wiki](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Containers).

So, why write another? Well, each of the existing docker setups are configured a bit differently than what I want to do.

The base repo has a good setup script that downloads and installs the project. I don't want to reinvent the setup script in docker. I just want to create the base image that is compatible with the setup script, which means:

- I make sure the [dependencies](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Dependencies) are met by the image and

- I follow [the instructions](https://github.com/AUTOMATIC1111/stable-diffusion-webui#automatic-installation-on-linux).

I don't want a copy of the repo inside of this one, so I will be using .gitignore to ignore all the code.

# Instructions

For first-time setup, run `init.sh`.

After that, run `run.sh`.

```sh
./init.sh

```

kk

```



run.sh


```
