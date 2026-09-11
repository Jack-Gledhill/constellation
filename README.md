<div align="center">

<img src="assets/logo/primary.png" alt="Constellation" width="128" height="128" />

# Constellation

This is my home production environment that I use to self-host various open-source services and experiment with
enterprise technologies at a more manageable scale. Constellation provides both useful resources and gives me the tools
to learn and solve real-world engineering problems.

This repository is an amalgamation of the various individual repositories and subprojects that make up Constellation;
hopefully you find it easier to navigate.
</div>

---

## Repository Structure

This is a **monorepo** which means everything relating to Constellation is all kept within this one repository. From a
DevOps perspective, this tends to add extra unnecessary complexity (though in some cases it also simplifies things!).
That said, having everything in one repository makes management a lot easier, and also makes for a prettier repository
😛

```
constellation
├── ansible/          # Ansible Playbooks for automating tasks
│   ├── group_vars/
│   ├── host_vars/
│   ├── roles/
│   └── inventory.yml
├── assets            # Source and rastor files for Constellation's branding
│   └── logo/
├── docs/             # MkDocs project files for Constellation's website
│   ├── includes/
│   ├── overrides/
│   ├── src/
│   └── mkdocs.yml
└── kubernetes        # Kubernetes manifests managed by ArgoCD
    ├── apps/
    ├── argocd/
    └── bootstrap/
```

---

## Acknowledgements

Constellation is the result of years of learning, researching and tearing the whole thing down to start again. The past
works of many people have inspired Constellation as it is today. I can't list everyone whose work has contributed to
this project, but here are those that have made the most important contributions:

- [mortennordbye](https://github.com/mortennordbye) whose
  own [homelab monorepo](https://github.com/mortennordbye/homelab) inspired this one
- Soumya Dahal for their [guide on setting up samba as a member server](https://soumyadahal.com.np/file-server-AD-lab/)

---

## License

Unless otherwise specified, all original materials in this repository are licensed under
the [GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/).

The Constellation logo and wordmark are licensed under
the [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/) license and may not be reproduced without
proper attribution or for commercial purposes.