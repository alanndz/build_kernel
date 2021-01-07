#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")
PATCHES="${PWD}/patches"

export RELEASE_STATUS=$(cat "${CONF}/release")
export RELEASE_VERSION=$(cat "${CONF}/$FOLDER/version")
export KERNEL_NAME="Fusion"
export CODENAME=$(cat "${CONF}/$FOLDER/codename")-4.19
export KERNEL_TYPE=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export COMPILER_IS_CLANG=true
export USECLANG="proton-11"
export USEGCC=93
#export CHAT_ID="-1001251953845" #
export CHAT_ID="-1001273145812" #
#export CHAT_ID=$(openssl enc -base64 -d <<< LTEwMDEyMzAyMDQ5MjMK)
export DEVELOPER="alanndz-nicklas373"
export HOST="fusion_lavender-dev"
export AK_BRANCH="fusion"
export JOBS=8
BRANCH=$(cat "${CONF}/$FOLDER/branch")
unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})
git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/HANA-CI-Build-Project/kernel_xiaomi_lavender-4.19.git saus

cd saus

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/perf3.sh

chmod +x .kernel.sh
bash ./.kernel.sh

