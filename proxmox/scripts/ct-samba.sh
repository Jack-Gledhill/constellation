#!/usr/bin/env bash
# --------------------------------------------------------------------------------
# SAMBA MEMBER SERVER INSTALLER
# --------------------------------------------------------------------------------
# Copyright (c) 2026 Jack Gledhill
# Author: Jack Gledhill
# License: GPLv3 | https://github.com/Jack-Gledhill/constellation/raw/main/LICENSE
# --------------------------------------------------------------------------------

set -eo pipefail # Stops execution if any command fails

usage() {
    cat << EOF
usage: $0 -d DOMAIN -w WORKGROUP [-h]

Use this script to install samba and related packages onto a Debian machine and join it to an existing Active Directory domain.
The samba server will be configured as a member server, allowing it to use Active Directory for authentication and access control.
Winbind is used to map Windows users and groups to Unix equivalents.

OPTIONS:
   -d, --domain    ADDS.CORP.COM  The Active Directory domain to join. This is a required parameter.
   -w, --workgroup CORP           The shorthand name of the AD domain, also known as the netbios name. This parameter is required.
   --join-user     Administrator  The username to authenticate as when joining the Active Directory domain, defaults to Administrator.
   --join-ou       Computers      The organizational unit (OU) to place the server in when joining the domain, defaults to the builtin Computers OU.
   -h, --help                     Shows this message and exits.
EOF
}

DOMAIN=""
WORKGROUP=""
JOIN_USER="Administrator"
JOIN_OU="Computers"

PARAMS=""
while (( "$#" )); do
    case "$1" in
        -d|--domain)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                DOMAIN=$2
                shift 2
            fi
            ;;
        -w|--workgroup)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                WORKGROUP=$2
                shift 2
            fi
            ;;
        --join-user)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                JOIN_USER=$2
                shift 2
            fi
            ;;
        --join-ou)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                JOIN_OU=$2
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

install_apt_packages() {
    echo "[INFO] Installing required APT packages, this may take a few minutes..."
    apt-get update -qq
    apt-get install -qq -y \
        acl \
        attr \
        dnsutils \
        samba \
        samba-common-tools \
        winbind \
        libpam-winbind \
        libnss-winbind \
        krb5-user \
        krb5-config
    echo "[INFO] Finished installing APT packages"
}

configure_kerberos() {
    cat > /etc/krb5.conf <<EOF
[libdefaults]
    default_realm = ${DOMAIN}
    dns_lookup_realm = false
    dns_lookup_kdc = true
EOF
    echo "[INFO] Configured Kerberos to use ${DOMAIN} as the default realm"
}

configure_nsswitch() {
  cat > /etc/nsswitch.conf <<EOF
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the \`glibc-doc-reference' and \`info' packages installed, try:
# \`info libc "Name Service Switch"' for information about this file.

passwd:         files systemd winbind
group:          files systemd winbind
shadow:         files systemd
gshadow:        files systemd

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
EOF
  echo "[INFO] Configured NSS to use winbind for user and group lookups"
}

configure_pam() {
    pam-auth-update --enable mkhomedir
    echo "[INFO] Configured PAM to create new home directories for AD users on first login"
}

configure_samba() {
    echo "[INFO] Configuring Samba..."
    cat > /etc/samba/smb.conf <<EOF
[global]
    # --- Logging
    log file = /var/log/samba/log.%m
    logging = file
    max log size = 1000
    panic action = /usr/share/samba/panic-action %d

    # --- Active Directory
    workgroup = ${WORKGROUP}
    realm = ${DOMAIN}
    security = ADS
    winbind use default domain = yes
    winbind offline logon = no
    winbind enum users = yes
    winbind enum groups = yes
    winbind refresh tickets = yes

    # --- User defaults
    template shell = /usr/sbin/nologin
    template homedir = /home/%U

    # --- ID mapping between Unix and Windows
    idmap config * : backend = tdb
    idmap config * : range = 0-999999
    idmap config ${WORKGROUP} : backend = rid
    idmap config ${WORKGROUP} : range = 1000000-1999999

    # --- macOS and Time Machine settings
    vfs objects = catia fruit streams_xattr acl_xattr
    fruit:metadata = stream
    fruit:posix_rename = yes
    fruit:veto_appledouble = no
EOF
    testparm -s
    echo "[INFO] Samba config was successful"
}

join_domain() {
    echo "[INFO] Joining Active Directory domain: ${DOMAIN}"
    net ads join -U "${JOIN_USER}" createcomputer="${JOIN_OU}"
    net ads testjoin
    echo "[INFO] Domain join was successful"
}

apply_changes() {
    systemctl enable smbd nmbd winbind
    systemctl restart smbd nmbd winbind
}

if [ -z "${DOMAIN}" ]; then
    echo "[ERROR] No Active Directory domain specified, use the -d or --domain flag to specify one."
    exit 1
fi

if [ -z "${WORKGROUP}" ]; then
    echo "[ERROR] No NetBIOS name specified, use the -w or --workgroup flag to specify one."
    exit 1
fi

install_apt_packages
configure_kerberos
configure_samba
configure_pam
configure_nsswitch
join_domain
apply_changes