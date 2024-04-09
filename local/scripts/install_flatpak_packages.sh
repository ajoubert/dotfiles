#/bin/bash

FLATPAK_PACKAGES_FILE="$HOME/.config/flatpakpkglist.txt"

# Check if flatpak is installed
if ! command -v flatpak &> /dev/null
then
    echo "flatpak could not be found"
    exit
fi

# Check if flatpak packages file exists
if [ ! -f "$FLATPAK_PACKAGES_FILE" ]; then
    echo "$FLATPAK_PACKAGES_FILE not found"
    exit
fi

# Install flatpak packages
cat $FLATPAK_PACKAGES_FILE | xargs -L1 flatpak --user install flathub-verified -y
