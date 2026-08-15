# Databases

Database servers like PostgreSQL, Redis and MongoDB are managed within an LXC on Sagittarius, aptly named `databases`.
Only one centralised instance of each database server exists, this is to make management and security simpler.

## Servers

| Name           | Version | URL                                |
|----------------|---------|------------------------------------|
| PostgreSQL[^1] | 18      | db.sagittarius.starsystem.dev:5432 |

## Management

[pgAdmin 4](https://www.pgadmin.org) has been installed on the database container and configured with credentials for the PostgreSQL server.
It can be used to manage databases and users.

[Login to pgAdmin :simple-wireguard:{ title="VPN required" }](http://10.3.1.102/pgadmin4){ .md-button }

## Backups & Data Integrity

The database LXC is backed up to Scorpio hourly and retained for up to a week. 
Backups are encrypted and their integrity is verified regularly.
Thanks to this, native database server backup solutions are not needed.

All the data is kept on Sagittarius' ZFS array when hot.
Many database servers use small page sizes so they can take advantage of the SSD-backed SPECIAL vDev, improving query times.

[^1]: Includes [pgvector](https://github.com/pgvector/pgvector) extension