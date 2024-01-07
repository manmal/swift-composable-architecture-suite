#!/bin/bash

# Define the parent directory
PARENT_DIR="./Sources"

# Compiling list of folder names within PARENT_DIR to be prefixed
FOLDERS_TO_PREFIX=($(find "$PARENT_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

# Iterate over each folder name to be prefixed
for FOLDER_NAME in "${FOLDERS_TO_PREFIX[@]}"; do
    # Find all .swift files in the current folder that are not in a *.docc subfolder
    find "$PARENT_DIR" -type f -name '*.swift' ! -path '*/.docc/*' | while read -r FILE; do
        # Perform the import replacement
        sed -i '' "s/import ${FOLDER_NAME}/import _${FOLDER_NAME}/g" "$FILE"
        # Perform the pattern replacement, ensuring there is no alphabetic character before or after
        sed -i '' "s/\([^a-zA-Z]\)${FOLDER_NAME}\([^a-zA-Z]\)/\1_${FOLDER_NAME}\2/g" "$FILE"
        # Handle the case where ${FOLDER_NAME} occurs at the start of a line
        sed -i '' "s/^${FOLDER_NAME}\([^a-zA-Z]\)/_${FOLDER_NAME}\1/g" "$FILE"
    done
done
