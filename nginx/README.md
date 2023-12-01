# nginx configuration

I want to be able to access any of the applications running on the target node easily.

## Setup

On the control node, add lines to `/etc/hosts` for each of the services running on the target node:

```
192.168.2.234  osai
192.168.2.234  comfyui.osai
192.168.2.234  jupyter-lab.osai
192.168.2.234  x11vnc.osai
192.168.2.234  stable-diffusion-webui.osai
```

Replace `192.168.2.234` with the IP address of the target machine.

Run `./run.sh`
