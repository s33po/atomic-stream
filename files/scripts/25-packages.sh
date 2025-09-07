#!/usr/bin/env bash

set -xeuo pipefail

# Remove firefox
dnf autoremove -y \
    firefox \

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
   python3-ramalama \
   jetbrains-mono-fonts-all \
   google-noto-sans-fonts \
   powerline-fonts \

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode --nogpgcheck  install code

# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

# Enable podman-socket
systemctl enable podman.socket


