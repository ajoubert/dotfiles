#!/bin/bash

# File containing the list of packages
FILE="$HOME/.config/pkglist.txt"

# Function to display usage
usage() {
    echo "Usage: $0 [--dry-run]"
    exit 1
}

# Check for --dry-run option
DRY_RUN=0
if [ "$1" == "--dry-run" ]; then
    DRY_RUN=1
elif [ -n "$1" ]; then
    usage
fi

# Check if packages.txt exists
if [ ! -f $FILE ]; then
    echo "Error: pkglist.txt not found."
    exit 1
fi

# Read all explicitly installed packages
explicit_packages=$(yay -Qe | awk '{print $1}')

# Initialize an empty string for unlisted packages
unlisted_packages=""

# Loop through each explicitly installed package
for pkg in $explicit_packages; do
    # Check if the package is in packages.txt
    if ! grep -qx "$pkg" $FILE; then
        # Append the package to the unlisted packages string
        unlisted_packages+="$pkg "
    fi
done

# Check if there are any unlisted packages
if [ -z "$unlisted_packages" ]; then
    echo "No packages to remove."
    exit 0
fi

# If dry run, just display the packages
if [ $DRY_RUN -eq 1 ]; then
    echo "Packages that would be removed:"
    echo $unlisted_packages
else
    # Uninstall all unlisted packages
    yay -Rns $unlisted_packages
fi
