# Welcome to Constellation

Constellation is [Jack Gledhill](https://jackgledhill.com)'s homelab environment.
The project's main goals are to provide an environment for learning about, and experimenting with, enterprise-level networking, software and software practices.
To that end, it also hosts numerous open-source services to solve everyday problems.

## Purpose of this Website

There came a point during development where managing knowledge about the project became difficult to do without a platform to document it.
This website exists primarily to document the specifics around how software is configured and how the individual components interact with one another within the project.
As a secondary benefit, this website serves as a record of Jack's work and the knowledge gained from it.

## Project Repository

Almost everything that went into this project is open-source on GitHub at [Jack-Gledhill/constellation](https://github.com/Jack-Gledhill/constellation).
In the repository, you'll find:

- The source for this website
- Diagrams explaining the project's internals
- Bash scripts for managing Proxmox LXCs and VMs[^1]
- [Ansible](https://docs.ansible.com) Playbooks and Roles for automating arduous tasks
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) resources and Kubernetes manifests
- [Docker Compose](https://docs.docker.com/compose/) stacks automatically deployed via GitOps

## License & Support

The [repository](https://github.com/Jack-Gledhill/constellation) is released under the [GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/).
Homelab enthusiasts are encouraged to take as much inspiration as they want from this project; it's only through the generosity of others that this project came to be in the first place.

This project is constantly being expanded on, reiterated and rewritten.
No guarantees are made that this project will be fit for your needs, and no support can be given should you face difficulty in using the project's code.

[^1]: These scripts are to supplement the fantastic work of the [Proxmox VE Helper-Scripts community](https://community-scripts.org)