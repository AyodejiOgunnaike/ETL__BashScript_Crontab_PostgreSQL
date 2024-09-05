#!/bin/bash

# Source and Destination Directories 
source_dir="/mnt/c/Users/Administrator/Documents/Projects/file_to_move"
dest_dir="/mnt/c/Users/Administrator/Documents/Projects/json_and_CSV"

# Create destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Move CSV and JSON files
mv "$source_dir"/*.csv "$source_dir"/*.json "$dest_dir/"

# Check if the move was successful
if [ $? -eq 0 ]; then
    echo "Files moved successfully to $dest_dir."
else
    echo "File move failed."
fi