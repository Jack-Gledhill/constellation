# SMB Shares

The [SMB protocol](https://en.wikipedia.org/wiki/Server_Message_Block) is one of a few network file sharing protocols supported by most modern Operating Systems without third-party software[^1].
While typically seen in Windows Server environments, I've chosen to use [Samba](https://www.samba.org) as a Linux implementation of the protocol to make management easier and save on compute resources.

!!! info
    Samba is, rather confusingly, a suite of SMB and Active Directory tools rather than a simple SMB server implementation.
    It is capable of acting both as a file server, and an Active Directory Domain Member or Domain Controller.
    
    This page refers to Samba in the context of network file storage.
    See [Single Sign-On](/network/sso) for details of how Samba is used in the context of Active Directory.

## Network Access

While Microsoft's [SMB over QUIC](https://learn.microsoft.com/en-us/windows-server/storage/file-server/smb-over-quic?tabs=windows-admin-center%2Cpowershell2%2Cwindows-admin-center1) protocol made it safe for Windows 11 and newer clients to access SMB shares from an untrusted network (e.g. the internet), macOS and Linux do not natively support this.
As a result, Constellation runs the less secure SMB over TCP[^2] protocol.
This is not safe to expose to the internet, as demonstrated by [the WannaCry ransomware attack of 2017](https://en.wikipedia.org/wiki/WannaCry_ransomware_attack) that spread through a vulnerability in SMB servers exposed to the internet[^3].

To protect against these types of exploits, the SMB shares are only accessible to clients connected to the internal network (either through an ethernet cable or the VPN).

## File Servers

Constellation runs several instances of Samba inside Debian LXCs as file servers.
Each container is named `smbX`, where the X is a 1-indexed enumerator of Samba instances.

| Server Hostname | Connection String              | Description                                                                                                                                      |
|-----------------|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| `smb1`          | smb://smb1.adds.starsystem.dev | Hosts private shares for all users in the `Storage Users` group.                                                                                 |
| `smb2`          | smb://smb2.adds.starsystem.dev | Serves manually provisioned shares for macOS devices to use as a [Time Machine](https://en.wikipedia.org/wiki/Time_Machine_(macOS)) destination. |

!!! question "Why use multiple instances?"
    This is mostly a matter of vanity than technical strategy.
    I felt this made things cleaner, particularly when considering Time Machine shares.
    Having those on a separate server meant the user experience when accessing a home share is much cleaner.

    It may also become relevant in the future - perhaps a share needs to be locked down from the rest, or has to be hosted on a different machine entirely.
    Designing my network around that now would make that much easier in the future.

[^1]: The others being [NFS](https://en.wikipedia.org/wiki/Network_File_System) and [WebDAV](https://en.wikipedia.org/wiki/WebDAV).

[^2]: SMB over TCP is the traditional form of SMB that uses TCP rather than [QUIC](https://en.wikipedia.org/wiki/QUIC) as the underlying transport layer. 
It is often referred to simply as 'SMB'.

[^3]: While the original vulnerability that WannaCry exploited to spread itself was patched in March 2017, the consensus among cybersecurity analysts is that SMB over TCP should not be accessible from an untrusted network.