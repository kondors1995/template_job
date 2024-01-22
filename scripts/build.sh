#!/bin/bash -l

source ./scripts/env.sh

echo "Building rom..."
rom_name=$ROM_LAUNCH_PREFIX
current_directory="$(pwd)"
rom_dir="$current_directory/$rom_name"
mkdir -p $rom_dir
cd $rom_dir
echo "Working directory:"
pwd

export USE_CCACHE=1

source build/envsetup.sh

export CCACHE_DIR=/var/lib/jenkins/TMPCCACHE
ccache -M 200G

lunch "$ROM_LAUNCH_PREFIX"_"$DEVICE_NAME"-"$BUILD_TYPE"
mka bacon