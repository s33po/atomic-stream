#!/bin/bash

set -xeuo pipefail

systemctl enable bootc-fetch-apply-updates.timer
systemctl enable firewalld
systemctl enable podman.socket
systemctl enable cockpit.socket
systemctl enable systemd-resolved.service
systemctl enable libvirtd.service

# Disable lastlog display 
authselect enable-feature with-silent-lastlog
