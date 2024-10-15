#!/bin/bash
# Update and install necessary packages
# sudo dnf update -y

# Disable SELinux
sudo setenforce 0
sudo sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

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

# Install Kubernetes components
sudo yum install -y kubeadm kubelet kubectl --disableexcludes=kubernetes

# Enable and start kubelet
sudo systemctl enable --now kubelet

# Initialize Kubernetes master
sudo kubeadm init --apiserver-advertise-address=172.16.16.50 --pod-network-cidr=10.244.0.0/16

# open port 6443

# Setup kubeconfig for root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install a pod network add-on, e.g., Flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Save join command for worker nodes
kubeadm token create --print-join-command > /vagrant/scripts/kubeadm_join.sh
