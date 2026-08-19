#!/usr/bin/env bash
# --------------------------------------------------------------------------------
# CHRONY INSTALLER
# --------------------------------------------------------------------------------
# Copyright (c) 2026 Jack Gledhill
# Author: Jack Gledhill
# License: GPLv3 | https://github.com/Jack-Gledhill/constellation/raw/main/LICENSE
# --------------------------------------------------------------------------------

set -eo pipefail # Stops execution if any command fails

usage() {
    cat << EOF
usage: $0 [ADDRESS] [-h]

This script installs the chrony NTP client onto a Debian machine and configures it to
synchronise with a specified NTP server at boot.

OPTIONS:
   -h, --help  Shows this message and exits.
EOF
}

ADDRESS="ntp.debian.org"

PARAMS=""
while (( "$#" )); do
    case "$1" in
        -h|--help)
            usage
            exit 1
            ;;
        -*|--*=)
            echo "[ERROR] Unrecognised flag $1"
            exit 1
            ;;
        *) # Preserve positional arguments
            PARAMS="$PARAMS $1"
            shift
            ;;
    esac
done
# Reset the positions of positional arguments
eval set -- "$PARAMS"

# Update the NTP address if one was provided as a positional argument
if [ -n "$1" ]; then
    ADDRESS=$1
fi

echo "[INFO] Installing chrony APT package"
apt-get update -qq
apt-get install -qq -y chrony

echo "[INFO] Configuring chrony to use $ADDRESS"
cat > /etc/chrony/chrony.conf <<EOF
server ${ADDRESS}
rtcsync
EOF

systemctl enable chronyd
echo "[INFO] Finished configuring chronyd and enabled service"