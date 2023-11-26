FROM ubuntu:22.04
#
# Set non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Preconfigure tzdata for New York City timezone
RUN echo 'tzdata tzdata/Areas select America' | debconf-set-selections
RUN echo 'tzdata tzdata/Zones/America select New_York' | debconf-set-selections

RUN apt-get update && apt-get install -y \
    sudo \
    xorg \
    xvfb \
    x11vnc \
    xterm

RUN apt-get update && apt-get install -y fluxbox


RUN useradd -ms /bin/bash john
RUN mkdir -p /etc/sudoers.d
RUN echo "john ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/john

# Set the display environment variable
ENV DISPLAY=:0

# Expose the VNC port
EXPOSE 5900

# Add Google Chrome to the repositories
RUN apt-get update && apt-get install -y wget gnupg
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable

USER john
WORKDIR /home/john

RUN mkdir ~/.vnc
# RUN x11vnc -storepasswd password ~/.vnc/passwd

CMD xvfb-run --server-args='-screen 0, 1920x1080x24' /bin/bash -c \
    "fluxbox & \
    x11vnc -forever -create"
