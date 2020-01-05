#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"

export RELEASE_STATUS=$(cat "${CONF}/conf-release")
export USECLANG=1
export USEGCC=3
export CODENAME="$(cat "${CONF}/conf-codename")"
export KERNEL_VERSION="$(cat "${CONF}/conf-version")"
export TYPE_KERNEL="$(cat "${CONF}/conf-type")"
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export JOBS=8
export CUSTOM_DTB=0
# export SEND_TO_HANA_CI=false
BRANCH="$(cat "${CONF}/conf-branch")"

unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})

git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/${git_username}/${git_repo}.git saus

cd saus

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/clang.sh

chmod +x .kernel.sh
bash ./.kernel.sh
