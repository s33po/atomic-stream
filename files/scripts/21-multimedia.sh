#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
dnf -y install \
    @multimedia \
    ffmpegthumbnailer \
    gstreamer1-plugins-{base,bad-free-libs} \
    lame{,-libs} \
    libjxl
