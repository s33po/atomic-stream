#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y subscription-manager

# EXPERIMENTAL: install hyperscale kernel (From TunaOS)
dnf -y install centos-release-hyperscale-kernel
dnf config-manager --set-disabled "centos-hyperscale,centos-hyperscale-kernel"
dnf --enablerepo="centos-hyperscale" --enablerepo="centos-hyperscale-kernel" -y update kernel

dnf -y install 'dnf-command(versionlock)'
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt

dnf -y install 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb
dnf -y upgrade epel-release

dnf -y install system-reinstall-bootc powertop fuse steam-devices
