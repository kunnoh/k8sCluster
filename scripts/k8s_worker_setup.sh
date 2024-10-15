#!/bin/bash
# Update and install necessary packages
# sudo dnf update -y

# Disable SELinux
# sudo setenforce 0
# sudo sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Disable Swap
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

# Enable br_netfilter module for Kubernetes networking
sudo modprobe br_netfilter
echo '1' | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables

# Add Kubernetes repository
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl
EOF

# install kubernetes components
sudo dnf install -y kubeadm kubelet kubectl

# Enable and start kubelet
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Join the Kubernetes cluster
# Note: Replace <token> and <master-ip>:<port> with actual values from `kubeadm init` output
sudo kubeadm join 172.16.16.50:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
