#!/bin/bash

LOCAL_DIR="/home/john/Downloads/MemoryCache/"
REMOTE_DIR="osai-redwood:/home/john/osai/memory-cache/docs/"

# Function to perform rsync
sync_directories() {
    rsync -avz --delete "$LOCAL_DIR" "$REMOTE_DIR"
}

# Monitor directory for new files and sync when changes are detected
inotifywait -m -e create --format '%w%f' "$LOCAL_DIR" | while read file; do
    echo "Detected new file: $file"
    sync_directories
done
