#!/bin/bash
USER_NAME=$1
USER_HOME="/home/$USER_NAME"

if [ ! -e "$USER_HOME" ]; then
    mkdir -p "$USER_HOME"
    chown "$USER_NAME:storage users" "$USER_HOME"
    chmod 700 "$USER_HOME"
fi
exit 0