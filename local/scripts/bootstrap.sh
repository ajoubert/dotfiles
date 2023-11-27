#!/bin/bash

# Script to bootstrap my archlinux setup and install all needed packages

# Get the current username
CURRENT_USER=$(whoami)

# Path to the yay installation script
YAY_INSTALL_SCRIPT="./install_yay.sh"

# Check if the yay installation script exists
if [ ! -f "$YAY_INSTALL_SCRIPT" ]; then
    echo "Yay installation script not found at $YAY_INSTALL_SCRIPT"
    exit 1
fi

# Run the yay installation script with sudo and set SUDO_USER
sudo SUDO_USER=$CURRENT_USER bash "$YAY_INSTALL_SCRIPT"

# Path to the rest of the installation script
PACKAGES_INSTALL_SCRIPT="./install_packages.sh"

# Check if the packages installation script exists
if [ ! -f "$PACKAGES_INSTALL_SCRIPT" ]; then
    echo "Packages installation script not found at $PACKAGES_INSTALL_SCRIPT"
    exit 1
fi

bash $PACKAGES_INSTALL_SCRIPT
