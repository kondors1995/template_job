#!/bin/bash


# Template git repository  
# if you provide changes you need to change this value
TEMPLATE_URL=https://github.com/SwitchBuildServer/template_job
TEMPLATE_BRANCH=dev

REPO_URL=https://github.com/DerpFest-AOSP/manifest.git
REPO_BRANCH=14
#REPO_PARAMS=

LOCAL_MANIFEST_URL=https://github.com/SwitchBuildServer/local_manifests
LOCAL_MANIFEST_BRANCH=dev

DEVICE_NAME=raphael
ROM_LAUNCH_PREFIX=derp
BUILD_TYPE=userdebug

# config git becouse is needed
git config --global user.name "customrom"
git config --global user.email "customrom@customrom.com"

