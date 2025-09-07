#!/usr/bin/env bash

# DO NOT MODIFY THIS FILE UNLESS YOU KNOW WHAT YOU ARE DOING

set -xeuo pipefail

VERSION_ID="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
IMAGE_PRETTY_NAME="Atomic Kitten"

# Add our image name as VARIANT_ID.
# This may help us get some usage stats through countme data.
sed -i -f - /usr/lib/os-release <<EOF
s/^NAME=.*/NAME=\"${IMAGE_PRETTY_NAME}\"/
s/^PRETTY_NAME=.*/PRETTY_NAME=\"${IMAGE_PRETTY_NAME} ${VERSION_ID}\"/
s/^VARIANT_ID=.*/VARIANT_ID=\"${IMAGE_NAME}\"/
EOF
