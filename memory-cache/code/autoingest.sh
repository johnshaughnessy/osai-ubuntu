# Function to perform rsync
sync_directories() {
    rsync -avz --delete "$LOCAL_DIR" "$REMOTE_DIR"
}

# Monitor directory for new files and sync when changes are detected
inotifywait -m -e create --format '%w%f' "source_documents" | while read file; do
    echo "Detected new file: $file"
    python ingest.py
done
