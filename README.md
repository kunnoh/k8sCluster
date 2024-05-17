# k8sCluster
Creating nodes using `kvm` hypervisor and `libvirt` as the provider on `arch linux` as the host OS.

## Install required packages
```sh
sudo pacman -S qemu ebtables dnsmasq bridge-utils virt-manager libvirt
```

### Start libvirt service
```sh
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```
