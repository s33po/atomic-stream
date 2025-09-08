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

# Remove older kernel and modules before installing new ones
dnf -y remove kernel kernel-core kernel-modules kernel-modules-extra kernel-devel || true

# Install new kernel from kmods
dnf --disablerepo=baseos,appstream --enablerepo="centos-kmods" -y install \
    kernel kernel-core kernel-modules kernel-modules-extra kernel-devel

echo
echo "===Installed Kernel Packages (dnf list installed kernel*) ==="
dnf list installed kernel\* || echo "Failed to list installed kernel packages"

echo
echo "===Installed Kernel Versions (rpm -q kernel) ==="
rpm -q kernel || echo "Failed to query installed kernel versions"

dnf -y install 'dnf-command(versionlock)'
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt

dnf -y install system-reinstall-bootc powertop fuse steam-devices
