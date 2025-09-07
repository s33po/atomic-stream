#!/usr/bin/env bash

set -xeuo pipefail

dnf remove -y subscription-manager

dnf install -y 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb
dnf upgrade -y epel-release

dnf install -y system-reinstall-bootc powertop fuse steam-devices