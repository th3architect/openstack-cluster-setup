#!/bin/sh

# Install latest Docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker ubuntu

git clone https://github.com/open-cloud/xos.git
cd xos; docker build -t xos .
