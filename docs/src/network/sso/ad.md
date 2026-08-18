# Active Directory

## Windows Server Setup

Active Directory is running on a Windows Server 2025 Standard virtual machine on Sagittarius.
Version 0.1.285 of the Windows VirtIO Drivers have been installed following [this guide](https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers) on the Proxmox wiki.

## Directory Structure

```
adds.starsystem.dev
└── Constellation
    ├── File Servers         # Samba servers join as a new computer in this OU
    ├── Groups               # Keeps all groups here for easier management
    │   ├── Media Managers   # Gives accounts read-write access to the media storage
    │   ├── Service Accounts # Assigned to all accounts in OU=Service Accounts - used to assign policies to all service accounts
    │   ├── Storage Users    # Gives accounts access to a private network share
    │   └── Time Machines    # Provisions a private network share for each user to be used as a Time Machine destination
    ├── Service Accounts     # Accounts for software that needs access to the directory
    │   ├── svc_authelia
    └── Users                # Accounts for people that login to the network
```

## Group Policy Objects

| GPO Name               | Links               | Description                                                                                                                           |
|------------------------|---------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| Service Accounts       | OU=Service Accounts | Denies local and remote login to Service Accounts group.                                                                              |
| Baseline User Security | OU=Users            | Dangerous changes prompt for admin approval, Sets minimum password length to 12. Locks accounts for 10 minutes after 5 failed logins. |