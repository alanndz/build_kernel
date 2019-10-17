#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

export RELEASE_STATUS=0
export USECLANG=1
export USECACHE=0
export CODENAME="Quantum"
export KERNEL_VERSION="1.00"
export TYPE_KERNEL="EAS"

git clone --depth=1 -b eas-q https://github.com/zxc070/kernel_xiaomi_lavender .

wget --output-document=.kernel.sh https://raw.githubusercontent.com/zxc070/scripts/master/ci/lavender/kernel.sh

chmod +x .kernel.sh
bash ./.kernel.sh
