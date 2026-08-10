#!/usr/bin/env bash
# ----------------------------------------------------------------------------
# HAWSER AGENT INSTALLER
# ----------------------------------------------------------------------------
# Copyright (c) 2026 Jack Gledhill
# Author: Jack Gledhill
# License: GPLv3 | https://github.com/Jack-Gledhill/constellation/raw/main/LICENSE
# ----------------------------------------------------------------------------

set -eo pipefail # Stops execution if any command fails

usage() {
    cat << EOF
usage: $0 -t TOKEN [-d DOMAIN] [-n NAME] [-h]

Installs the Hawser agent onto any Linux machine.
The agent runs as a systemd service, so Docker does not need to be installed/running for this script to work.

The agent can run in either Standard or Edge mode.
In the former, the agent listens for incoming connections from the Dockhand server.
In the latter, the agent connects to Dockhand directly over a websocket.

Which mode the agent runs in is determined by the presence of the -d flag.
When absent, the agent runs in Standard mode.
When a domain name (e.g. dockhand.example.com) or IP address is given, the agent runs in Edge mode.

Both modes require a token, if no token is provided then one is automatically generated.

OPTIONS:
   -t, --token      TOKEN      Sets the secret token used for authentication between the agent and Dockhand.
   -d, --domain     DOMAIN     Configures the domain of the Dockhand server. If set, runs Hawser in Edge mode.
   -n, --name       NAME       Sets the name of the agent, only used in Edge mode.
EOF
}

TOKEN=""
DOMAIN=""
AGENT_NAME=""
MODE="standard"
HAWSER_CONFIG_PATH="/etc/hawser/config"

PARAMS=""
while (( "$#" )); do
    case "$1" in
        -t|--token)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                TOKEN=$2
                shift 2
            fi
            ;;
        -d|--domain)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                DOMAIN=$2
                shift 2
            fi
            ;;
        -n|--name)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                AGENT_NAME=$2
                shift 2
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

install_hawser() {
    curl -fsSL https://raw.githubusercontent.com/Finsys/hawser/main/scripts/install.sh | bash

    # Configure Hawser for the correct mode
    if [ -n "${DOMAIN}" ]; then
        MODE="edge"

        cat > "${HAWSER_CONFIG_PATH}" <<EOF
# Hawser Configuration
# See https://github.com/Finsys/hawser for documentation
DOCKER_SOCKET=/var/run/docker.sock
BIND_ADDRESS=127.0.0.1
DOCKHAND_SERVER_URL=ws://${DOMAIN}/api/hawser/connect
TOKEN=${TOKEN}
AGENT_NAME=${AGENT_NAME}
EOF
    else
        cat > "${HAWSER_CONFIG_PATH}" <<EOF
# Hawser Configuration
# See https://github.com/Finsys/hawser for documentation
DOCKER_SOCKET=/var/run/docker.sock
PORT=2376
TOKEN=${TOKEN}
EOF
    fi
}

# Generate token if not already given
if [ -z "${TOKEN}" ]; then
    TOKEN=$(head -c 32 /dev/urandom | od -An -tx1 | tr -d ' \n' && echo)
    echo "[WARN] No token was provided, so one was generated automatically"
fi

install_hawser
systemctl enable --now hawser
echo "[INFO] Hawser agent is now running. You should configure Dockhand with this new agent:"
echo "       Connection type: Hawser agent (${MODE})"
echo "       Agent token:     ${TOKEN}"