#!/usr/bin/env bash

set -xeuo pipefail

# Install required tools and fonts
dnf -y install dconf fontconfig

# Set up dconf system profile
mkdir -p /etc/dconf/profile
cat <<EOF > /etc/dconf/profile/user
user-db:user
system-db:local
EOF

# Set GNOME system-wide defaults
mkdir -p /etc/dconf/db/local.d
cat <<EOF > /etc/dconf/db/local.d/00-gnome
[org/gnome/desktop/interface]
color-scheme='prefer-dark'
gtk-theme='Adwaita-dark'
font-name='Noto Sans Regular 11'
document-font-name='Noto Sans Regular 11'
monospace-font-name='JetBrains Mono Regular 12'
icon-theme='Adwaita'
cursor-theme='Adwaita'
accent-color='teal'

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'
center-new-windows=true

[org/gnome/desktop/peripherals/mouse]
accel-profile='flat'

[org/gnome/shell]
enable-hot-corners=false

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings]
custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0]
name='Launch Ptyxis'
command='ptyxis --new-window'
binding='<Super>Return'
EOF

# Apply settings
dconf update

dnf install -y \
    plymouth-theme-spinner

kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')
dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
