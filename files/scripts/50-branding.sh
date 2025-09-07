#!/usr/bin/env bash

set -xeuo pipefail

rm -rf /usr/share/wallpapers/Fedora
rm -rf /usr/share/wallpapers/F4*
rm -rf /usr/share/backgrounds/f4*

dnf remove -y \
    console-login-helper-messages

dnf install -y \
    plymouth-theme-spinner


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')
dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
