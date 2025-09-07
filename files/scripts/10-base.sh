#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb

dnf install -y system-reinstall-bootc powertop fuse steam-devices