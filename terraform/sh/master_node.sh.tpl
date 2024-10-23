#!/bin/bash

hostnamectl set-hostname "${hostname}" # Set hostname
# hostnamectl set-hostname "master-node"
apt-get update
apt install docker.io

curl -sfL https://get.k3s.io | sh - # Install k3s