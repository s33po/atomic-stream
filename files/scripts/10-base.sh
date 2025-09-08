#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y subscription-manager

### EXPERIMENTAL: newer kernel from Kmods SIG ###

dnf -y install centos-release-kmods
dnf config-manager --set-disabled "centos-kmods"
dnf --enablerepo="centos-kmods" -y install centos-release-kmods-kernel
## I don’t plan to use the mainline kernel long-term, so I’ll freeze the kernel at the next LTS release (most likely 6.18)
#dnf --enablerepo="centos-kmods" -y install centos-release-kmods-kernel-6.18

dnf -y install 'dnf-command(versionlock)'
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt

dnf -y install 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb
dnf -y upgrade epel-release

dnf -y install system-reinstall-bootc powertop fuse steam-devices
