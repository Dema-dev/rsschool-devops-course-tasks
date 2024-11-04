#!/bin/bash

hostnamectl set-hostname "${hostname}" # Set hostname
# hostnamectl set-hostname "master-node"
apt-get update
apt install docker.io # install docker

touch /home/ubuntu/.ssh/aws.pem
chmod 600 /home/ubuntu/.ssh/aws.pem

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san $(curl -s 2ip.io)" sh - # Install k3s and auto creating cluster with public ip

sudo mkdir ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# install helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y

#add the Jenkins repo
sudo helm repo add jenkinsci https://charts.jenkins.io
sudo helm repo update

# add folder for jenkins persistent volume
mkdir /tmp/jenkins-volume/
chown -R 1000:1000 /tmp/jenkins-volume

# create namespace for jenkins resourses in helm/kubernetes
kubectl create namespace jenkins