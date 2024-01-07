#!/bin/bash -xv

# Directory containing the subdirectories
base_dir="./upstream"

# Destination base directory
dest_dir="./Sources"

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Iterate over each subdirectory in the base directory
for subdir in "$base_dir"/*; do
    # Check if the directory is a directory and not a file
    if [ -d "$subdir" ]; then
        # Extract the name of the subdirectory
        subdir_name=$(basename "$subdir")

        # Path to the Sources directory within the subdirectory
        sources_path="$subdir/Sources"

        # Check if the Sources directory exists
        if [ -d "$sources_path" ]; then
            # Copy only the directories from the Sources directory
            for item in "$sources_path"/*; do
                if [[ -d "$item" && $(basename "$item") =~ ^[A-Z] && ! $(basename "$item") == Benchmark* ]]; then
                    cp -r "$item" "$dest_dir/"
                fi
            done
        fi
    fi
done
