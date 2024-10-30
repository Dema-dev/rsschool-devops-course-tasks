#!/bin/bash

hostnamectl set-hostname "${hostname}" # Set hostname
# hostnamectl set-hostname "master-node"
apt-get update
apt install docker.io # install docker

touch .ssh/aws.pem
chmod 600 .ssh/aws.pem

curl -sfL https://get.k3s.io | sh - # Install k3s and auto creating cluster

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
helm repo add jenkinsci https://charts.jenkins.io
helm repo update


#create folder for Jenkins volume
mkdir /home/ubuntu/jenkins-volume