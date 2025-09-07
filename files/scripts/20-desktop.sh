#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y \
    @"Workstation" \
    @"Virtualization Host" 
    
systemctl enable gdm
systemctl set-default graphical.target

dnf -y remove \
    setroubleshoot