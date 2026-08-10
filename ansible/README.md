# Hydra Bootstrap

This repository contains IaC for installing [k3s](https://k3s.io) on multiple machines, configuring them to form a Kubernetes cluster, and bootstrapping Kubernetes manifests onto the cluster.
All of this is automated via [Ansible](https://ansible.com).

## Installation

After cloning this repository, you'll need to make sure you have Ansible installed.
A `requirements.txt` file has been provided so you can install everything you need by running:

```shell
pip install -r requirements.txt
```

You can install the packages globally, or into a virtual environment using [venv](https://docs.python.org/3/library/venv.html).

## Configuration

Before you can run the Ansible playbooks, you'll need to configure a new Ansible inventory by coping `example.inventory.yml` to `inventory.yml` and modifying it.

```shell
cp example.inventory.yml inventory.yml
```

The example inventory provides a relatively sane default configuration.
All you'll need to do is configure the host machines and replace any placeholder secrets with your own.
You'll also want to make sure you configure the bootstrap repository, this is where you'll store any Kubernetes manifests that you want to be applied when creating a cluster.

## Usage

Ansible playbooks can be run using the following command:

```shell
ansible-playbook <playbook.yml> --ask-become-password
```

The table below lists all the available playbooks and what they do.

| Playbook | Description |
| --- | --- |
| [`uninstall.yml`](/uninstall.yml) | Tears down the cluster and uninstalls k3s on all nodes. |
| [`setup.yml`](/setup.yml) | Creates the cluster config files before k3s is installed. |
| [`install.yml`](/install.yml) | Installs k3s on the nodes and configures a new Kubernetes cluster. |
| [`bootstrap.yml`](/bootstrap.yml) | Clones the bootstrap repository you configured and applies the manifests it contains to the Kubernetes cluster. |

## Special Notes

### Deploying on Raspberry Pi with SSDs

Additional setup is needed to deploy k3s to Raspberry Pis using SSD storage.
After flashing the OS onto the SSD drives, you should modify the `config.txt` file in the `bootfs` partition and add the following line:
```
usb_max_current_enable=1
```

When powered by a 3A supply (e.g. over PoE), the Raspberry Pi limits the current in USB ports to 600mA (aggregate).
This is not sufficient to power the SSD drives that each Pi boots from, so the OS refuses to boot.
However, by adding the above line to the boot config, the Pi will allow the USB ports to draw the full 1.6A that would be provided on a 5A supply.

This is a little risky, as it could starve the SoC of current if the USB ports draw too much.
To mitigate this, no other USB or unpowered devices should be connected to the Pi, and the CPU should not be overclocked. 