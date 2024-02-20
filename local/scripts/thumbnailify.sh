#!/bin/bash

# Generate a thumbnail for a given video file
# Usage: thumbnailify.sh <input_video> -o <output_thumbnail> -t <time>

# Default values
# Image name is the video name with .jpg extension, regardless of video
# extension
time_in_seconds=00:00:10

# Check if ffmpeg is installed
if ! [ -x "$(command -v ffmpeg)" ]; then
  echo "Error: ffmpeg is not installed." >&2
  exit 1
fi

while getopts "ho:v" opt; do
    case "${opt}" in
        h)  # Show help message
            echo "Usage: $0 [-o <output_filename>] [-t <time-of-screenshot>] <input_video>" 
            exit 1
            ;;
        o)  # Specify output file
            output_file=${OPTARG}
            ;;
        t)  # Specify time for screenshot
            time_in_seconds=${OPTARG}
            ;;
        *)  # Handle error: unknown option or missing required option.
            echo "Usage: $0 [-o <output_filename>] [-t <time-of-screenshot>] <input_video>" >&2
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

# Check if argument for video file is passed
if [ -z $1 ]; then
  echo "Error: No input video file specified." >&2
  exit 1
fi

# Check if input video file exists on filesystem
if [ ! -f $1 ]; then
  echo "Error: $1 does not exist." >&2
  exit 1
fi

# Check if output file is specified
if [ -z $output_file ]; then
  output_file=$(dirname $1)"/"$(basename $1 .*)".jpg"
fi

# Generate the thumbnail
ffmpeg -i $1 -ss $time_in_seconds -vframes 1 $output_file
