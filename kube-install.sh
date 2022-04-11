#!/bin/bash
# Disable swap in the fstab
sudo sed -i s/\\/swap.img/#\\/swap.img/ /etc/fstab
# Disable active swap
sudo swapoff -a
# Add ip and hostname on the /etc/hosts file
echo $(ip addr | grep "scope global" | awk '{print $2}') $(hostnamectl --static) | sed s/\\/24// | sudo tee -a /etc/hosts
# Add netfilter access to bridge
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
# Install latest docker, containerd and runc, removing maintainers versions
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo sysctl net.bridge.bridge-nf-call-iptables=1
# Set docker to use systemd cgroup
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{ "exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts":
{ "max-size": "100m" },
"storage-driver": "overlay2"
}
EOF
sudo systemctl restart docker
# Install tools needed for kubernetes tools
sudo apt-get install  -y apt-transport-https ca-certificates curl
# Install kubelet, kubeadm and kubectl tools from kubernetes official site
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
# Hold the updates on kubernetes tools
sudo apt-mark hold kubelet kubeadm kubectl
# Set systemd cgroups for containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i s/systemd_cgroup\ =\ false/systemd_cgroup\ =\ true/ /etc/containerd/config.toml
sudo systemctl restart containerd

# Below is CRI-O
#export OS=xUbuntu_20.04
#export VERSION=1.23
#cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
#deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
#EOF
#cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
#deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /
#EOF
#
#curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
#curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers-cri-o.gpg add -
#
#sudo apt-get update
#sudo apt-get install cri-o cri-o-runc
# END if CRI-O
