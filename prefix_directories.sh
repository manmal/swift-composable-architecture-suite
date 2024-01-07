#!/bin/bash

# Navigate to the Sources directory
cd ./Sources

# Loop through each item in the directory
for dir in */; do
    # Check if it's a directory
    if [ -d "$dir" ]; then
        # Rename the directory to prefix with an underscore
        mv "$dir" "_$dir"
    fi
done
