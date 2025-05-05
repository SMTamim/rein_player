#!/bin/bash

ICON_URL="https://raw.githubusercontent.com/Ahurein/rein_player/main/assets/images/reinplayer.png"

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
        ICON_PATH="/opt/reinplayer.png"
        DESKTOP_ENTRY_PATH="/usr/share/applications/reinplayer.desktop"

        # Copy AppImage and make it executable
        echo "Copying AppImage to $APPIMAGE_PATH..."
        sudo cp "$1" "$APPIMAGE_PATH"
        sudo chmod +x "$APPIMAGE_PATH"

        # Download icon from GitHub
        echo "Downloading icon..."
        if command -v curl >/dev/null 2>&1; then
            sudo curl -L -o "$ICON_PATH" "$ICON_URL" >/dev/null 2>&1
            ICON_INSTALLED=$?
        elif command -v wget >/dev/null 2>&1; then
            sudo wget -q -O "$ICON_PATH" "$ICON_URL" >/dev/null 2>&1
            ICON_INSTALLED=$?
        else
            echo "Warning: Neither curl nor wget found. Skipping icon download."
            ICON_INSTALLED=1
        fi

        # Create desktop entry with MIME types
        echo "Creating desktop entry..."
        if [ "$ICON_INSTALLED" = 0 ]; then
            sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=ReinPlayer
Exec=$APPIMAGE_PATH %f
Icon=$ICON_PATH
Type=Application
Terminal=false
Categories=AudioVideo;Video;Player;
Comment=A modern video player for Linux
GenericName=Video Player
MimeType=video/x-msvideo;video/x-matroska;video/webm;video/x-ogm+ogg;video/x-theora+ogg;video/mp4;video/mpeg;video/ogg;video/quicktime;video/x-flv;video/x-ms-wmv;video/x-msvideo;video/x-ms-asf;video/x-ms-wmv;video/x-xvid;video/x-avi;video/3gpp;video/3gpp2;video/divx;video/mp2t;video/x-m4v;
EOL
        else
            sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=ReinPlayer
Exec=$APPIMAGE_PATH %f
Type=Application
Terminal=false
Categories=AudioVideo;Video;Player;
Comment=A modern video player for Linux
GenericName=Video Player
MimeType=video/x-msvideo;video/x-matroska;video/webm;video/x-ogm+ogg;video/x-theora+ogg;video/mp4;video/mpeg;video/ogg;video/quicktime;video/x-flv;video/x-ms-wmv;video/x-msvideo;video/x-ms-asf;video/x-ms-wmv;video/x-xvid;video/x-avi;video/3gpp;video/3gpp2;video/divx;video/mp2t;video/x-m4v;
EOL
        fi

        # Update MIME database
        echo "Updating MIME database..."
        sudo update-desktop-database
        sudo xdg-mime default reinplayer.desktop video/x-msvideo video/x-matroska video/webm video/mp4

        echo "Installation complete. ReinPlayer is now integrated with your system."
        echo "You can now set ReinPlayer as your default video player in your system settings."
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