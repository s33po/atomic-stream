#!/usr/bin/env bash

set -xeuo pipefail

# TESTING: GNOME 48 backport from Bluefin LTS / TunaOS
dnf -y copr enable jreilly1821/c10s-gnome
dnf -y install glib2

dnf group install --nobest -y \
    "Workstation" \
    "Virtualization Host" 
    
systemctl enable gdm
systemctl set-default graphical.target

dnf -y remove setroubleshoot console-login-helper-messages
