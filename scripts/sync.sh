#!/bin/bash -l

source ./scripts/env.sh


echo "Syncing rom sources..."
rom_name=$ROM_LAUNCH_PREFIX
repo_url=$REPO_URL
repo_branch=$REPO_BRANCH
current_directory="$(pwd)"
rom_dir="$current_directory/$rom_name"
mkdir -p $rom_dir
cd $rom_dir
echo "Working directory:"
pwd

function repo_init() {
    echo "Init repository... becouse we don't have it"
    repo init -u "$REPO_URL" -b "$REPO_BRANCH" "$REPO_PARAMS"
}

function repo_sync() {
    echo "Repo syncing..."
    repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
}

function cloning_local_manifest() {
#    mkdir -p $rom_dir/.repo/local_manifests
    if [ -d $rom_dir/.repo/local_manifests ]; then
        echo "Local manifests repo exists try to sync"
        git pull
    else
        echo "Creating local manifests repo and cloning"
        git clone "$LOCAL_MANIFEST_URL" -b "$LOCAL_MANIFEST_BRANCH" $rom_dir/.repo/local_manifests
    fi
}

function run_other_script() {
    echo "Runing other user script..."
    bash ../scripts/other.sh
}

if [ -d ".repo" ]; then
    echo "Repo already exists..."
    echo "Try to re sync now..."
    cloning_local_manifest
    repo_sync
    run_other_script
    if [ $? -eq 0 ]; then
            echo "Repo re-sync successfully."
            exit 0
    else
            echo "Error: Unable to sync repo..."
            exit 1
    fi
else
    repo_init
    cloning_local_manifest
    repo_sync
    run_other_script
    if [ $? -eq 0 ]; then
            echo "Repo sync successfully."
            exit 0
    else
            echo "Error: Unable to sync repo..."
            exit 1
    fi
fi
