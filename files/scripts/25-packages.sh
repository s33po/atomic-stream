#!/usr/bin/env bash

set -xeuo pipefail

# Remove firefox and packagekit
dnf -y autoremove \
    firefox \
    PackageKit

# Install stuff
dnf -y install \
   distrobox \
   buildah \
   fastfetch \
   nvtop \
   btop \
   just \
   neovim \
   zsh \
   fzf \
   tmux \
   fpaste \
   uv \
   ramalama \
   jetbrains-mono-fonts \
   google-noto-sans-fonts \
   powerline-fonts \
   systemd-{resolved,container,oomd} \
   libcamera{,-{v4l2,gstreamer,tools}}

# Cockpit modules
dnf -y install \
   cockpit-machines \
   cockpit-podman \
   cockpit-networkmanager \
   cockpit-selinux \

### External repos ###

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode --nogpgcheck  install code
