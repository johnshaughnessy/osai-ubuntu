A docker environment for running fastai's fastbook in jupyter lab.

```sh
pushd data
clone git@github.com:fastai/fastbook.git
popd

docker compose up -d
```

Check nvidia's docs for [driver capabilities](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/docker-specialized.html#driver-capabilities).
