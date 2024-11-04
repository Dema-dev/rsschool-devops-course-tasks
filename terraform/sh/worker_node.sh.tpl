#!/bin/bash
hostnamectl set-hostname "${hostname}" # Set hostname

apt-get update
apt install docker.io