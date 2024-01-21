#!/bin/bash

# Check if we have more than 500 GB free space 

current_directory="$(pwd)"
limit_gb=500
available_space_gb=$(df -BG "$directory_path" | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "$available_space_gb" -gt "$limit_gb" ]; then
    echo "There is more than $limit_gb GB of available space ($available_space_gb GB)."
    exit 0  # Exit status 0 - success
else
    echo "There is not more than $limit_gb GB of available space ($available_space_gb GB)."
    exit 1  # Exit status 1 - error
fi

# config git becouse is needed
git config --global user.name "customrom"
git config --global user.email "customrom@customrom.com"