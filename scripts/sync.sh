#!/bin/bash

source ./scripts/env.sh

repo_url=$REPO_URL
repo_branch=$REPO_BRANCH
echo "Syncing rem sources..."
rom_name=$ROM_LAUNCH_PREFIX
current_directory="$(pwd)"
mkdir -p "${current_directory}/${rom_name}"
rom_dir="${current_directory}/${rom_name}"
cd rom_dir    
if [ -d "./.repo" ]; then
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
