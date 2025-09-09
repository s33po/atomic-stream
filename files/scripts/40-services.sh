#!/bin/bash

set -xeuo pipefail

systemctl enable dconf-update.service
systemctl enable bootc-fetch-apply-updates.service
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable firewalld
systemctl enable fwupd.service
systemctl enable rpm-ostree-countme.service
systemctl enable podman.socket
systemctl enable cockpit.socket
systemctl enable docker.socket
systemctl enable libvirtd.service

# Disable lastlog display 
authselect enable-feature with-silent-lastlog
