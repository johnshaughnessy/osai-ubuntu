# nginx configuration

I want to be able to access any of the applications running on the target node easily.

## Setup

On the control node, add a line to `/etc/hosts` to make the osai machine accessible by entering `osai` into the browser's address bar:

```
192.168.2.234  osai
```

Replace `192.168.2.234` with the IP address of the target machine.

Run `./run.sh`
