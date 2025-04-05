#!/bin/bash

uninstallReinPlayer() {
    if [ -f /opt/reinplayer.appimage ]; then
        echo "Uninstalling ReinPlayer..."

        # Remove AppImage and icon
        sudo rm -f /opt/reinplayer.appimage
        sudo rm -f /opt/reinplayer.png

        # Remove desktop entry
        sudo rm -f /usr/share/applications/reinplayer.desktop

        # Update system cache
        sudo update-desktop-database

        echo "ReinPlayer has been uninstalled successfully."
    else
        echo "ReinPlayer is not installed."
    fi
}

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Confirm before uninstalling
read -p "Are you sure you want to uninstall ReinPlayer? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    uninstallReinPlayer
else
    echo "Uninstall cancelled."
fi 