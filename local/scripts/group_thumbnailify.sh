#!/bin/bash
# This script will take a folder and call the 'thumbnailify' script on each video in the folder, optionally in every subfolder.
# Usage: group_thumbnailify.sh [-r] folder
# -r: Recursively process subfolders
# folder: The folder to process
# Example: group_thumbnailify.sh -r /home/user/Videos

# Set the recursive flag to 0
recursive=0

# Loop through all the arguments
for arg in "$@"; do
  # Check if argument is --help
  if [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
    echo "Usage: script_name [options]"
    echo "--help : Display this help message"
    exit 0
  elif [[ "$arg" == "-r" ]]; then
    # Set the recursive flag
    recursive=1
  else
    # If folder already set, throw error
    if [[ -n "$folder" ]]; then
      echo "Error: Too many arguments."
      exit 1
    fi
    folder="$arg"
  fi
done

# Check if folder is set
if [[ -z "$folder" ]]; then
  echo "Error: No folder specified."
  exit 1
fi

# Check if folder exists
if [[ ! -d "$folder" ]]; then
  echo "Error: Folder does not exist."
  exit 1
fi

# Call the thumbnailify script on each video in the folder
if [[ $recursive -eq 1 ]]; then
  # Process subfolders
  find "$folder" -type f -name "*.mp4" -exec thumbnailify.sh {} \;
else
  # Process only the current folder
  for file in "$folder"/*.mp4; do
    thumbnailify.sh "$file"
  done
fi
