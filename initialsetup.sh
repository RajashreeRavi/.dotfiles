#!/bin/bash

# install system utilities
sudo apt install -y \
    curl \
    git \
    git-lfs \
    htop \
    make \
    net-tools \
    openssh-server \
    iputils-ping \
    tmux

# nvidia-docker2
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=ubuntu20.04 # needs to be LTS release
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update -y
sudo apt install -y nvidia-docker2

# Make docker usable without sudo
sudo groupadd docker; sudo usermod -aG docker $USER
sudo systemctl daemon-reload
sudo systemctl restart docker

# install docker-compose
sudo rm /usr/local/bin/docker-compose
DOCKER_COMPOSE_VERSION=1.27.4
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin
docker login -u bowerybot -p CTfm87YT7K

# install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update -y
sudo apt install -y neovim
sudo mv $(which nvim) $(which vim)

# some convenient configs
cp ./tmux/.tmux.conf ~/
cp ./git/.gitconfig ~/
cp ./git/.githelpers ~/
cp ./bash/.bashrc ~/

sudo dpkg --install ros-noetic-rviz_1.14.11-0focal_amd64.deb

echo ""
echo "You must restart the machine now (nvidia driver, docker permissions)."
