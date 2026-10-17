# NVIDIA GPU Passthrough

> [!WARNING]
> When using identical GPUs, we cannot use vendor/device IDs for VFIO because it would grab both GPUs. Instead, we must
use PCI slot numbers, which can change if the hardware is rearranged or changed.

## 1. Enable IOMMU in GRUB

The `/etc/default/grub` file should contain the following line:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet,nvidia-drm.modeset=1,iommu=pt"
```

If the file needs to be changed, run `update-grub` to persist the changes.

## 2. Load VFIO Kernel Modules

Create the file `/etc/modules-load.d/vfio.conf` and add the following lines:

```
vfio
vfio_iommu_type1
vfio_pci
```

## 3. Find PCI Slot Numbers

Find the PCI slot numbers of the GPU you want to passthrough by running `lspci -nn | grep -E "VGA|Audio"` which should
give an output that looks something like:

```
05:00.0 VGA compatible controller: NVIDIA Corporation GP106GL [Quadro P2000] [10de:1c30]
05:00.1 Audio device: NVIDIA Corporation GP106 High Definition Audio Controller [10de:10f1]
0a:00.0 VGA compatible controller: NVIDIA Corporation GP106GL [Quadro P2000] [10de:1c30]
0a:00.1 Audio device: NVIDIA Corporation GP106 High Definition Audio Controller [10de:10f1]
```

Each GPU has a slot number for both its VGA controller (e.g. `0a:00.0`) and its audio controller (e.g. `0a:00.1`).

## 4. Bind GPU to VFIO

Use an initramfs script to bind the GPU to VFIO before the NVIDIA driver has a chance to load and bind to it. The script
should be located at `/etc/initramfs-tools/scripts/init-top/bind_vfio.sh` and have the following content:

```shell
#!/bin/sh
# Space-separated list of PCI addresses, where xx:xx.x is a PCI slot number
DEVS="0000:xx:xx.x 0000:xx:xx.x"

for DEV in $DEVS; do
    if [ -d "/sys/bus/pci/devices/$DEV" ]; then
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    fi
done

modprobe -i vfio-pci
```

For the script to work, you'll need to mark it as executable, update the Proxmox bootloader and reboot:

```shell
chmod +x /etc/initramfs-tools/scripts/init-top/bind_vfio.sh
update-initramfs -u -k all
reboot
```

## 5. Verify the Binding

Run the following command to check whether VFIO successfully bound to the GPU. You can run the command for both GPUs to
ensure the other GPU was not affected too:

```shell
lspci -nnk -s xx:xx.x
```