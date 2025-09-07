#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
#dnf -y install \
#    @multimedia \
#    ffmpegthumbnailer \
#    gstreamer1-plugins-{base,bad-free-libs} \
#    lame{,-libs} \
#    libjxl

# Multimedia (from Bluefin LTS)
dnf config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
dnf config-manager --set-disabled epel-multimedia
dnf -y install --enablerepo=epel-multimedia \
	ffmpeg libavcodec @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl ffmpegthumbnailer