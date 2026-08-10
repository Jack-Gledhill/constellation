<div align="center">

<img src="assets/logo/logo.png" alt="Constellation" width="128" height="128" />

# Constellation

This is my home production environment that I use to self-host various open-source services and experiment with enterprise technologies at a more manageable scale.
Constellation provides both useful resources and gives me the tools to learn and solve real-world engineering problems.

This repository is an amalgamation of the various individual repositories and subprojects that make up Constellation; hopefully you find it easier to navigate.
</div>

---

## Repository Structure

This is a **monorepo** which means everything relating to Constellation is all kept within this one repository.
From a DevOps perspective, this tends to add extra unnecessary complexity (though in some cases it also simplifies things!).
That said, having everything in one repository makes management a lot easier, and also makes for a prettier repository 😛

```
constellation
├── ansible/          # Ansible Playbooks for automating tasks
│   ├── files/
│   ├── templates/
│   └── inventory.yml
├── assets            # Source and rastor files for Constellation's branding
│   └── logo/
├── docs/             # MkDocs project files for Constellation's website
│   ├── src/
│   ├── includes/
│   ├── overrides/
│   └── mkdocs.yml
├── kubernetes        # Kubernetes manifests managed by ArgoCD
│   ├── apps/
│   └── argocd/
└── proxmox           # Resources for Proxmox LXCs and VMs
    ├── scripts/
    └── stacks/
```

---

## Acknowledgements

Constellation is the result of years of learning, researching and tearing the whole thing down to start again.
The past works of many people have inspired Constellation as it is today.
I can't list everyone whose work has contributed to this project, but here are those that have made the most important contributions:

- [mortennordbye](https://github.com/mortennordbye) whose own [homelab monorepo](https://github.com/mortennordbye/homelab) inspired this one