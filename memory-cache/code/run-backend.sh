#!/bin/bash

# Copy the .env config
cp ../.env .env

# Start autoingest.sh as a background process
(../autoingest.sh &)

# Run privateGPT interactively
poetry run bash -c "python privateGPT.py"
