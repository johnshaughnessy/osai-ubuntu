Dockerfile for running jupyter lab

When notebooks have different requirements, it's helpful to separate each one into its own docker container.

Build with:

```sh
docker build -f Dockerfile.jupyter-lab-base -t jupyter-lab-base .
```
