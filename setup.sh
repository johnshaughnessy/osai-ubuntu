#!/bin/bash
set -e

echo
echo "[OSAI] Starting setup."
echo "[OSAI] This script will install Docker, NVIDIA Container Toolkit, and NVIDIA Driver 545."
echo "[OSAI] Setup may take 10-20 minutes to complete."
echo

# Update apt cache
sudo apt-get update

# Upgrade all apt packages
sudo apt-get dist-upgrade -y

# Install nice-to-have packages
sudo apt-get install -y bat curl git htop iftop net-tools tree

# Install prerequisites for Docker GPG key
sudo apt-get install -y ca-certificates curl gnupg

echo
echo "[OSAI] Installing Docker."
echo

# Ensure /etc/apt/keyrings directory exists
sudo mkdir -p /etc/apt/keyrings
sudo chmod 0755 /etc/apt/keyrings

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set correct permissions for Docker GPG key
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

# Update Repositories
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce

# Add user to Docker group
sudo usermod -aG docker $USER

echo
echo "[OSAI] Your user account has been added to the docker group."
echo "[OSAI] You will need to logout and log back in for this change to take effect."
echo

echo
echo "[OSAI] Installing NVIDIA Container Toolkit."
echo

# Download the NVIDIA repository GPG key if it does not exist
if [ ! -f /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg ]; then
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
fi

# Add the NVIDIA repository
echo "deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/amd64 /" | sudo tee /etc/apt/sources.list.d/nvidia_github_io_libnvidia_container_stable_ubuntu22_04.list

# Update Repositories
sudo apt-get update

# Install nvidia-container-toolkit
sudo apt-get install -y nvidia-container-toolkit

# Configure NVIDIA Container Toolkit for Docker
nvidia-ctk runtime configure --runtime=docker

# Restart Docker
sudo systemctl restart docker

if [ -n "$(nvidia-smi)" ]; then
  echo
  echo "[OSAI] Skipping NVIDIA Driver 545 installation: an NVIDIA driver is already installed."
  echo "[OSAI] Installation complete."
  echo
  exit 0
fi

echo
echo "[OSAI] Installing NVIDIA Driver 545."
echo

# Get the running kernel version
kernel_version=$(uname -r)

# Install gcc and necessary kernel headers
sudo apt-get install -y build-essential linux-headers-$kernel_version

# Add Nvidia driver repository
sudo add-apt-repository ppa:graphics-drivers/ppa

# Install Nvidia Driver 545
sudo apt-get update
sudo apt-get install -y nvidia-driver-545

echo
echo "[OSAI] System reboot is required to complete installation."
echo
read -p "[OSAI] Reboot now? [y/N] " -n 1 -r REPLY
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "[OSAI] Rebooting."
  sudo reboot
fi
