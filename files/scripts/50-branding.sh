#!/usr/bin/env bash

set -xeuo pipefail

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
clock-format='24h'
clock-show-weekday=true


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

[org/gnome/nautilus/preferences]
sort-directories-first=true
default-folder-viewer='list-view'

[org/gnome/desktop/calendar]
show-weekdate=true
EOF

# Apply settings
dconf update

# Search for the latest installed kernel version:
KERNEL_SUFFIX=""
QUALIFIED_KERNEL=$(rpm -qa | \
  grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | \
  sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//' | \
  sort -V | tail -n 1)

# Generate initramfs for the newest kernel:
usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
