#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")
PATCHES="${PWD}/patches"

export RELEASE_STATUS=$(cat "${CONF}/release")
export USECLANG="nusantara-10"
export USEGCC=92
export KERNEL_NAME="Fusion"
export CODENAME=$(cat "${CONF}/$FOLDER/codename")
export KERNEL_VERSION=$(cat "${CONF}/$FOLDER/version")
export TYPE_KERNEL=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export JOBS=8
# export SEND_TO_HANA_CI=true

BRANCH=$(cat "${CONF}/$FOLDER/branch")

unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})

git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/${git_username2}/${git_repo2}.git saus
cd saus

RESET_COMMIT=$(git --no-pager log --pretty=format:'%h')

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/fusion_gcc.sh

# Build first Kernel

chmod +x .kernel.sh
# bash ./.kernel.sh

# reset kernel to HEAD
#
#make -C "${PWD}/.ToolBuild/AnyKernel3" clean &>/dev/null
#export CODENAME="$(cat "${CONF}/$FOLDER/codename")-Old_CAM"
#git am "${PATCHES}/01.patch"
#bash ./.kernel.sh
# detect wen compile failed
#if [ ! -f ".Output/arch/arm64/boot/Image.gz-dtb" ]; then
#    exit
#fi

# Build second kernel for camera patch
# git reset --hard $RESET_COMMIT
export CODENAME="$(cat "${CONF}/$FOLDER/codename")-New_CAM"
# make -C "${PWD}/.ToolBuild/AnyKernel3" clean &>/dev/null

# Patching kernel for new patch
# curl https://github.com/MiCode/Xiaomi_Kernel_OpenSource/commit/cf2a90f96348c6a3142d53ca209983da18c72410.patch | git am
git am "${PATCHES}/02.patch"
bash ./.kernel.sh
