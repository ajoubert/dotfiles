#!/bin/bash

# Function to display usage
usage() {
    echo "Uninstall all packages not explicitely defined in pkglist.txt"
    exit 1
}

if [ -n "$1" ]; then
    usage
fi

# File containing the list of packages
listed_packages="$HOME/.config/pkglist.txt"

# If file doesn't exist, exit with an error
if [ ! -f "$listed_packages" ]; then
  echo "Error: pkglist.txt not found."
  exit 1
fi

# Some packages are installed via groups, let's unpack them to get the
# actual packages
installed_groups="/tmp/installed_groups"
groups_to_keep="/tmp/groups_to_keep"
packages_installed_by_groups="/tmp/packages_installed_by_groups"
all_packages="/tmp/all_packages"

# List all groups from installed packages
pacman -Qg | awk '{print $1}' | sort -u > "$installed_groups"

# Find which groups are meant to be installed
grep -Fxf $installed_groups $listed_packages > $groups_to_keep

# Unpack groups into list of packages
while read group; do pacman -Qg "$group" | awk '{print $2}'; done < $groups_to_keep > $packages_installed_by_groups

# Merge initial list and packages installed by groups
cat "$listed_packages" "$packages_installed_by_groups" | sort | uniq > $all_packages

# Uninstall all unlisted packages
yay -Rnsu $(comm -23 <(yay -Qq | sort) <(sort $all_packages))

# Clean up
rm "$installed_groups" "$groups_to_keep" "$packages_installed_by_groups" "$all_packages"
