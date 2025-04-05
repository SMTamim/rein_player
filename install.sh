#!/bin/bash

installReinPlayer() {
    if ! [ -f /opt/reinplayer.appimage ]; then
        echo "Installing ReinPlayer..."

        # Check if AppImage path is provided
        if [ -z "$1" ]; then
            echo "Error: Please provide the path to ReinPlayer AppImage"
            echo "Usage: ./install.sh path/to/ReinPlayer-x86_64.AppImage"
            exit 1
        fi

        # Check if the file exists and is an AppImage
        if [ ! -f "$1" ] || [[ "$1" != *".AppImage" ]]; then
            echo "Error: The file provided is not a valid AppImage"
            exit 1
        fi

        # Save current directory
        CURRENT_DIR=$(pwd)

        # Paths for installation
        APPIMAGE_PATH="/opt/reinplayer.appimage"
        ICON_PATH="/opt/reinplayer.svg"
        DESKTOP_ENTRY_PATH="/usr/share/applications/reinplayer.desktop"

        # Copy AppImage and make it executable
        echo "Copying AppImage to $APPIMAGE_PATH..."
        sudo cp "$1" "$APPIMAGE_PATH"
        sudo chmod +x "$APPIMAGE_PATH"

        # Extract and copy icon from AppImage
        echo "Installing icon..."
        TEMP_DIR=$(mktemp -d)
        cp "$1" "$TEMP_DIR/"
        cd "$TEMP_DIR" || exit
        chmod +x "$(basename "$1")"
        "./$1" --appimage-extract reinplayer.svg >/dev/null
        sudo cp squashfs-root/reinplayer.svg "$ICON_PATH"
        cd "$CURRENT_DIR" || exit
        rm -rf "$TEMP_DIR"

        # Create desktop entry
        echo "Creating desktop entry..."
        sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=ReinPlayer
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Type=Application
Terminal=false
Categories=AudioVideo;Video;
EOL

        # Update system cache
        sudo update-desktop-database

        echo "Installation complete. ReinPlayer is now integrated with your system."
    else
        echo "ReinPlayer is already installed."
        echo "Please uninstall first if you want to install a new version."
    fi
}

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Run installation with provided AppImage path
installReinPlayer "$1" 