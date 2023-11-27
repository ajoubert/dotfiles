#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!"
    exit 1
fi

# Check if the SUDO_USER environment variable is set
if [ -z "$SUDO_USER" ]; then
    echo "The SUDO_USER environment variable is not set. Set the username of the non-root user meant to build the package"
    exit 1
fi

# Check if the SUDO_USER exists on the system
if ! id "$SUDO_USER" &>/dev/null; then
    echo "The user specified in SUDO_USER does not exist."
    exit 1
fi

# Update the system and install necessary packages
pacman -Syu --noconfirm
pacman -S --needed --noconfirm git base-devel

# Create a temporary directory for building yay
mkdir /tmp/yay_install
cd /tmp/yay_install

# Clone the yay repository
git clone https://aur.archlinux.org/yay.git

# Change ownership of the yay folder to the non-root user
chown -R $SUDO_USER:$SUDO_USER yay

# Build and install yay
cd yay
sudo -u $SUDO_USER makepkg -si --noconfirm

# Cleanup
cd ..
rm -rf /tmp/yay_install

echo "yay has been successfully installed."

