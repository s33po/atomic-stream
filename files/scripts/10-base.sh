#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y subscription-manager

dnf -y install 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb

### EXPERIMENTAL: newer kernel from Kmods SIG ###

dnf -y install centos-release-kmods
dnf config-manager --set-disabled "centos-kmods"
dnf --enablerepo="centos-kmods" -y install centos-release-kmods-kernel

## I don’t plan to use the mainline kernel long-term, so I’ll freeze the kernel at the next LTS release (most likely 6.18)
#dnf --enablerepo="centos-kmods" -y install centos-release-kmods-kernel-6.18

REPO_OVERRIDE="--disablerepo=baseos,appstream --enablerepo=centos-kmods"

dnf $REPO_OVERRIDE -y install kernel kernel-core kernel-modules kernel-modules-extra kernel-headers || true

KVER=$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel | sort -V | tail -n1)
echo "New kernel version: $KVER"

depmod "$KVER"

rpm -q kernel | grep -v "$KVER" | xargs -r dnf -y remove || true

dnf -y install 'dnf-command(versionlock)'
dnf versionlock clear
rpm -qa 'kernel*' | grep "$KVER" | while read -r pkg; do
    echo "Locking $pkg"
    dnf versionlock add "$pkg"
done

# Install other stuff
dnf -y install system-reinstall-bootc powertop fuse steam-devices
