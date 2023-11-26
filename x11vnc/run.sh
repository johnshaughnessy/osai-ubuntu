docker stop ubuntu-x11vnc || true
docker run --rm -it -p 5900:5900 --name ubuntu-x11vnc --privileged ubuntu-x11vnc
