#!/bin/bash

echo "Sleeping until receiving SIGTERM."

_term() {
    echo "Caught SIGTERM signal. Shutting down."
    exit 0
}

trap _term SIGTERM

# Keep alive
while true; do
    sleep 1 &
    wait $!
done
