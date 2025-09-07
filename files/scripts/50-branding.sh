#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y \
    console-login-helper-messages

dnf install -y \
    plymouth-theme-spinner


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')
dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
