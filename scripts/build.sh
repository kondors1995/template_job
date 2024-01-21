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
#export CCACHE_EXEC=/usr/bin/ccache
#export CCACHE_DIR=~/tmp_ccache
ccache -M 70G

source build/envsetup.sh
lunch "$ROM_LAUNCH_PREFIX"_"$DEVICE_NAME"-"$BUILD_TYPE"
mka bacon
