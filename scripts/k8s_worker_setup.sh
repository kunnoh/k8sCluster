#!/bin/bash
# Update and install necessary packages
sudo dnf update -y
sudo dnf install -y kubeadm kubelet kubectl

# Enable and start kubelet
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Join the Kubernetes cluster
# Note: Replace <token> and <master-ip>:<port> with actual values from `kubeadm init` output
sudo kubeadm join 172.16.16.50:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
