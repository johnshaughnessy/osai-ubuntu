# `X Window System`, `NVC`, and `x11nvc`

The `X Window System`, often known as `X11` or simply `X`, is a fundamental part of graphical user interfaces (GUIs) in Unix-like operating systems, including Linux, BSD, and others.

`NVC` is a graphical desktop-sharing system that uses the Remote Frame Buffer protocol (`RFB`) to remotely control another computer. It transmits the keyboard and mouse inputs from one computer to another, relaying the graphical screen updates back in the other direction, over a network.

`x11vnc` is a VNC server specifically for X Window System displays. It allows one to view remotely and interact with real X displays (i.e., a display corresponding to a physical monitor, keyboard, and mouse) with any VNC viewer.

The Dockerfile in this directory defines a basic Docker image for setting up `x11vnc`, running a graphical program, and then exposing it to the local network.

# Usage

For first-time setup, run `./init.sh`.
After that, run `./run.sh`.

First-time setup takes 1-2 minutes.

From the control node, run

```sh
vncviewer 192.168.2.234:5900
```

(Replace `192.168.2.234` with the correct IP address.)
