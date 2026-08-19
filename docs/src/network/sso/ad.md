# Active Directory

Active Directory replaces the old [LLDAP](https://github.com/lldap/lldap) that the project used to manage users and groups since SSO was first introduced.
While LLDAP was a great tool that made learning LDAP much easier, it did not have the full capabilities needed to authenticate SMB users - [and likely never will](https://github.com/lldap/lldap/issues/599).

After coming across the free Windows Server licences provided by [Azure for Students](https://azure.microsoft.com/en-us/free/students), I decided to migrate to Active Directory.

## Windows Server Setup

Active Directory is running on a Windows Server 2025 Standard virtual machine on Sagittarius.
Version 0.1.285 of the Windows VirtIO Drivers have been installed following [this guide](https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers) on the Proxmox wiki.

### Directory Structure

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

### Group Policy Objects

| GPO Name               | Links               | Description                                                                                                                           |
|------------------------|---------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| Service Accounts       | OU=Service Accounts | Denies local and remote login to Service Accounts group.                                                                              |
| Baseline User Security | OU=Users            | Dangerous changes prompt for admin approval, Sets minimum password length to 12. Locks accounts for 10 minutes after 5 failed logins. |