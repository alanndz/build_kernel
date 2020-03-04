#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")

export RELEASE_STATUS=$(cat "${CONF}/release")
export USECLANG=2
export USEGCC=3
export KERNEL_NAME=perf
export CODENAME=$(cat "${CONF}/$FOLDER/codename")
export KERNEL_VERSION=$(cat "${CONF}/$FOLDER/version")
export TYPE_KERNEL=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender-perf_defconfig"
export JOBS=8

BRANCH=$(cat "${CONF}/$FOLDER/branch")

unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})

# git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/${git_link_fourteen}.git saus
git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/Yasir-siddiqui/msm-4.14.git saus
cd saus

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/perf9.sh

chmod +x .kernel.sh
bash ./.kernel.sh
