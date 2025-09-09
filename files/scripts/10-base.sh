#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y subscription-manager

dnf -y install 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb

dnf -y install 'dnf-command(versionlock)'
dnf versionlock clear

### EXPERIMENTAL: newer kernel from Kmods SIG. Script below is FROM Bluefin-LTS: https://github.com/ublue-os/bluefin-lts ###
## I don’t plan to use the pinned mainline kernel long-term and I’ll switch to the next LTS kernel (most likely 6.18) when it is available from kmods
#dnf -y install centos-release-kmods-kernel-6.18

dnf -y install centos-release-kmods-kernel

ARCH=$(uname -m)
TARGET_MAJOR_MINOR="6.15"
echo "--- Pinning Kernel to ${TARGET_MAJOR_MINOR}.x ---"

rpm -q python3-dnf-plugin-versionlock &> /dev/null || \
    { echo "Installing dnf-plugin-versionlock..."; dnf install -y python3-dnf-plugin-versionlock || { echo "Error: Failed to install versionlock plugin."; exit 1; } }

# Find the newest target kernel version
TARGET_KERNEL_FULL_VERSION=$(dnf list available kernel --showduplicates | \
    grep "^kernel.${ARCH}.*${TARGET_MAJOR_MINOR}\." | \
    awk '{print $2}' | sort -V | tail -n 1)

if [ -z "$TARGET_KERNEL_FULL_VERSION" ]; then
    echo "Error: No ${TARGET_MAJOR_MINOR}.x kernel found. Exiting."
    exit 1
fi

KERNEL_VERSION_ONLY=$(echo "$TARGET_KERNEL_FULL_VERSION" | sed "s/\.${ARCH}$//")
echo "Targeting kernel: ${KERNEL_VERSION_ONLY}"

# Install kernel packages
INSTALL_PKGS=(
    "kernel-${KERNEL_VERSION_ONLY}"
    "kernel-core-${KERNEL_VERSION_ONLY}"
    "kernel-modules-${KERNEL_VERSION_ONLY}"
)
dnf install --allowerasing -y "${INSTALL_PKGS[@]/%/.${ARCH}}" || { echo "Error: Failed to install kernel packages."; exit 1; }
echo "Installing kernel packages: ${INSTALL_PKGS[@]/%/.${ARCH}}"

# Add versionlocks
for pkg in "${INSTALL_PKGS[@]}"; do
    echo "Locking package: ${pkg}.${ARCH}"
    dnf versionlock add "${pkg}.${ARCH}" || { echo "Error: Failed to lock ${pkg}.${ARCH}."; exit 1; }
done

#Run depmod
depmod -a "${TARGET_KERNEL_FULL_VERSION}.${ARCH}"

echo "Kernel ${KERNEL_VERSION_ONLY} installed, set as default, and locked."

#dnf config-manager --set-disabled "centos-kmods-kernel"

### KERNEL SWAP ENDS ###

# Install other stuff
dnf -y install system-reinstall-bootc powertop fuse steam-devices
