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
dnf -y remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-modules-extra-matched || true

# Install new kernel and modules from kmods
dnf --disablerepo=baseos,appstream --enablerepo="centos-kmods" -y install kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-modules-extra-matched kernel-headers

# Get the newly installed kernel version and run run depmod
KERNEL_VERSION=$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel | head -n1)
depmod "$KERNEL_VERSION"

# Show installed kernel packages
echo "=== Installed Kernel Packages (dnf list installed kernel*) ==="
dnf list installed 'kernel*' || echo "Failed to list installed kernel packages"

# Show installed kernel versions
echo "=== Installed Kernel Versions (rpm -q kernel) ==="
rpm -q kernel

# Install versionlock and clear old locks before adding new ones
dnf -y install 'dnf-command(versionlock)'
dnf versionlock clear

# Lock only currently installed kernel packages
rpm -qa 'kernel*' | sort | while read -r pkg; do
    echo "Locking: $pkg"
    dnf versionlock add "$pkg"
done

# Install other stuff
dnf -y install system-reinstall-bootc powertop fuse steam-devices
