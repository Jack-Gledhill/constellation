#!/usr/bin/env bash
# --------------------------------------------------------------------------------
# NVIDIA DRIVER & CONTAINER TOOLKIT INSTALLER
# --------------------------------------------------------------------------------
# Copyright (c) 2026 Jack Gledhill
# Author: Jack Gledhill
# License: GPLv3 | https://github.com/Jack-Gledhill/constellation/raw/main/LICENSE
# --------------------------------------------------------------------------------

set -eo pipefail # Stops execution if any command fails

usage() {
    cat << EOF
usage: $0 [-d VERSION] [-n VERSION] [-h]

This script assumes that the container is running a 64-bit x86 Linux distribution.

This script downloads and installs the userspace libraries of the NVIDIA proprietary drivers.
The driver version to download must be configured by using the -d flag.

Once the driver has been installed, this script can also be used to install the NVIDIA Container Toolkit,
which is necessary for using your GPU in nested container workloads (e.g. Docker).
The version to download must be given via the -n flag, otherwise this step is skipped.
As part of the installation, the NVIDIA Container Toolkit APT repository is also installed.
Once installed, the NVIDIA Container Toolkit is automatically configured for the Docker runtime.

OPTIONS:
   -d, --driver-version VERSION  The NVIDIA driver version to install. If no version is given, this step is skipped.
   -n, --nct-version    VERSION  The NVIDIA Container Toolkit version to install. This step is skipped if no version is given.
   -h, --help                    Shows this message and exits.
EOF
}

DRIVER_VERSION=""
NCT_VERSION=""

PARAMS=""
while (( "$#" )); do
    case "$1" in
        -d|--driver-version)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                DRIVER_VERSION=$2
                shift 2
            else
                echo "[ERROR] Argument for $1 is missing"
                exit 1
            fi
            ;;
        -n|--nct-version)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                NCT_VERSION=$2
                shift 2
            else
                echo "[ERROR] Argument for $1 is missing"
                exit 1
            fi
            ;;
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

install_prerequisites() {
    apt-get install -qq -y \
        curl \
        gnupg2 \
        ca-certificates
}

install_driver() {
    local filename="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
    local filepath="$PWD/${filename}"

    echo "[INFO] Downloading NVIDIA driver version ${DRIVER_VERSION}..."
    curl -fsSL https://us.download.nvidia.com/XFree86/Linux-x86_64/"${DRIVER_VERSION}"/"${filename}" -o "${filepath}"
    chmod +x "${filepath}"
    echo "[INFO] Downloaded NVIDIA driver version ${DRIVER_VERSION} and saved to ${filepath}"

    echo "[INFO] Running NVIDIA driver installer, this may take a while..."
    bash "${filepath}" --no-kernel-modules -q --ui=none
    echo "[INFO] Driver installer finished"

    rm "${filepath}"
    echo "[INFO] Cleaned up driver installation"
}

install_nct_repo() {
    echo "[INFO] Configuring NVIDIA Container Toolkit deb repository..."
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --yes --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    cat > /etc/apt/sources.list.d/nvidia.sources <<EOF
Types: deb
URIs: https://nvidia.github.io/libnvidia-container/stable/deb/amd64
Suites: /
Components:
Signed-By: /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
EOF
    echo "[INFO] Container Toolkit repository ready"
}

install_nct() {
    echo "[INFO] Installing NVIDIA Container Toolkit version ${NCT_VERSION}..."
    apt-get update -qq
    apt-get install -qq -y \
        nvidia-container-toolkit="${NCT_VERSION}" \
        nvidia-container-toolkit-base="${NCT_VERSION}" \
        libnvidia-container-tools="${NCT_VERSION}" \
        libnvidia-container1="${NCT_VERSION}"

    nvidia-ctk runtime configure --runtime=docker
    nvidia-ctk config --set nvidia-container-cli.no-cgroups --in-place
    systemctl restart docker
    echo "[INFO] Successfully installed NVIDIA Container Toolkit version ${NCT_VERSION}"
}

install_prerequisites

if [ -z "${DRIVER_VERSION}" ]; then
    echo "[WARN] No driver version given, installation will be skipped"
else
    install_driver
fi

if [ -z "${NCT_VERSION}" ]; then
    echo "[WARN] No NVIDIA Container Toolkit version given, installation will be skipped"
else
    install_nct_repo
    install_nct
fi