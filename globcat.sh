#!/bin/bash

# Define the usage function to guide the user on how to utilize the script.
usage() {
    echo "Usage: $0 [-e globs] [-d directories] [-n not_paths]"
    echo "Example:"
    echo "  $0 -e '*.md' -d './my_directory' -n './my_directory/exclude'"
    echo "  Directories can be absolute paths or relative to the current directory."
    exit 1
}

# Variables to track whether the options were provided
globs_provided=false
dirs_provided=false
not_paths_provided=false

# Parse the provided options and arguments.
while getopts ":e:d:n:" opt; do
  case $opt in
    e) 
        # Split the provided globs and store them in an array.
        IFS=',' read -ra GLOBS <<< "$OPTARG"
        globs_provided=true
        ;;
    d) 
        # Split the provided directories and convert them to absolute paths.
        IFS=',' read -ra REL_DIRS <<< "$OPTARG"
        DIRS=()
        for dir in "${REL_DIRS[@]}"; do
            DIRS+=("$(readlink -f "$dir")")  # Convert to absolute path
        done
        dirs_provided=true
        ;;
    n)
        # Split the provided not paths and convert them to absolute paths.
        IFS=',' read -ra REL_NOT_PATHS <<< "$OPTARG"
        NOT_PATHS=()
        for path in "${REL_NOT_PATHS[@]}"; do
            NOT_PATHS+=("$(readlink -f "$path")")  # Convert to absolute path
        done
        not_paths_provided=true
        ;;
    \?) echo "Invalid option -$OPTARG" >&2; usage ;;
  esac
done

# Check if globs were provided; if not, exit with an error message.
if ! $globs_provided; then
    echo "Error: No globs specified."
    usage
fi

# If no directories were provided, default to current directory
if ! $dirs_provided; then
    # Default to the current directory as an absolute path
    DIRS=( "$(readlink -f ".")" )
fi

# Build the exclusion options for find
exclude_args=()
if $not_paths_provided; then
    for path in "${NOT_PATHS[@]}"; do
        exclude_args+=(-not -path "$path")
    done
fi

# Loop through each directory and search for files matching the specified globs.
for index in "${!DIRS[@]}"
do
    dir="${DIRS[$index]}"
    if [ -d "$dir" ]; then  # Check if directory exists
        for glob in "${GLOBS[@]}"
        do
            # Recursive file search and sort the results
            find "$dir" -type f -name "$glob" "${exclude_args[@]}" -print0 | sort -z | while IFS= read -r -d '' file; do
                echo "File: $file"
                echo "-------------------------------------"
                cat "$file"
                echo -e "\n=====================================\n"
            done
        done
    else
        # If the directory does not exist, print a warning.
        echo "Warning: Directory ${REL_DIRS[$index]} does not exist. Skipping..."
    fi
done
