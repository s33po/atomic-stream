#!/usr/bin/env bash

set -xeuo pipefail

# Remove firefox
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
   python3-ramalama \
   jetbrains-mono-fonts \
   google-noto-sans-fonts \
   powerline-fonts \

# Cockpit modules
dnf -y install \
   cockpit-machines \
   cockpit-podman \
   cockpit-networkmanager \
   cockpit-selinux \
   cockpit-sosreport


### External repos ###

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode --nogpgcheck  install code

# Docker setup (From TunaOS)
echo "Adding Docker repo and installing Docker components..."
dnf config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo" || echo "Docker repo already added or failed to add."
dnf config-manager --set-disabled docker-ce-stable || true # Disable if it's already enabled
dnf -y --enablerepo docker-ce-stable install \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin
