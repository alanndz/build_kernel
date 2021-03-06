#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")
PATCHES="${PWD}/patches"

export RELEASE_STATUS=$(cat "${CONF}/release")
export KERNEL_NAME="aLn"
export CODENAME=$(cat "${CONF}/$FOLDER/codename")
export RELEASE_VERSION=$(cat "${CONF}/$FOLDER/version")
export KERNEL_TYPE=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export COMPILER_IS_CLANG=true
export USECLANG="proton-11"
export USEGCC=93
export CHAT_ID="-1001251953845" #
# export CHAT_ID=$(openssl enc -base64 -d <<< LTEwMDEyMzAyMDQ5MjMK)
export DEVELOPER="alanndz"
export HOST="noob_lavender-dev"
export AK_BRANCH="lavender"
export JOBS=8
BRANCH=$(cat "${CONF}/$FOLDER/branch")

unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})
git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/${git_username}/${git_repo}.git saus

cd saus

RESET_COMMIT=$(git --no-pager log --pretty=format:'%h')

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/global.sh
chmod +x .kernel.sh
# export CODENAME="$(cat "${CONF}/$FOLDER/codename")-Old_CAM"
bash ./.kernel.sh

# detect wen compile failed
if [ ! -f ".Out/arch/arm64/boot/Image.gz-dtb" ]; then
    exit 1
fi

# New Camera Blobs
export CODENAME="$(cat "${CONF}/$FOLDER/codename")-New_CAM"
make -C "${PWD}/.ToolBuild/AnyKernel3" clean &>/dev/null
git am "${PATCHES}/02.patch"
bash ./.kernel.sh
