#!/bin/bash
# Update and install necessary packages
sudo dnf update -y
sudo dnf install -y kubeadm kubelet kubectl

# Enable and start kubelet
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Initialize Kubernetes master
sudo kubeadm init --apiserver-advertise-address=172.16.16.50 --pod-network-cidr=10.244.0.0/16

# Setup kubeconfig for root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install a pod network add-on, e.g., Flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Save join command for worker nodes
kubeadm token create --print-join-command > /vagrant/scripts/kubeadm_join.sh
