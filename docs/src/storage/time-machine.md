# Time Machine

An SMB server runs on a Proxmox LXC providing access to a single share: a macOS Time Machine disk.
The share can be accessed with the URL below:

[smb://tm.sagittarius.starsystem.dev](smb://tm.sagittarius.starsystem.dev) :simple-wireguard:{ title="VPN required" }

## Credentials

| Share Path     | Username  |
|----------------|-----------|
| `/timemachine` | jgledhill |

## Configuring Clients

Each new Time Machine client **must** be assigned its own share on the server; client backups don't work properly when multiple devices use the same share.

!!! question "Should I encrypt my backups?"
    **Short answer:** no.

    **Long answer:** Time Machine has a built-in option to encrypt backups, but this induces filesystem changes every time a new backup is made, even if nothing new has actually been backed up.
    This interferes with the deduplication on Proxmox Backup Server, causing container backups to occupy more disk space than necessary.
    It's best to leave this option disabled.

## Backups

The Time Machine container is exempt from the usual backup regime.
Instead, the container is backed up to Scorpio on a **weekly basis**, and retained for up to 12 weeks.

All backups are encrypted and verified on a regular basis.