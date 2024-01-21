#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Need params: $0 <parametr1> <parametr2>"
    exit 1
fi

repo_url = "$1"
repo_branch = "$2"
echo "Syncing rem sources..."
rom_name = "derp"
current_directory="$(pwd)"
mkdir -p "${current_directory}/${rom_name}"
rom_dir = "${current_directory}/${rom_name}"
cd rom_dir    
if [ -d "$repo_directory/.git" ]; then
    echo "Repo already exists..."
    echo "Try to re sync now..."
    repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
    if [ $? -eq 0 ]; then
            echo "Repo re-sync successfully."
            exit 0
    else
            echo "Error: Unable to sync repo..."
            exit 1
    fi
else
    echo "Init repo for rom..."
    repo init -u "${repo_url}" -b "${repo_branch}"
    echo "Sync repo ..."
    repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
    if [ $? -eq 0 ]; then
            echo "Repo sync successfully."
            exit 0
    else
            echo "Error: Unable to sync repo..."
            exit 1
    fi
fi
