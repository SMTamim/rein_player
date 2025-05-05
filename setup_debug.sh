#!/bin/bash

# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create desktop entry
cat > ~/.local/share/applications/test_reinplayer.desktop <<EOL
[Desktop Entry]
Name=ReinPlayer (Debug)
Exec=${SCRIPT_DIR}/build/linux/x64/release/bundle/rein_player %F
Icon=${SCRIPT_DIR}/assets/images/reinplayer.png
Type=Application
Terminal=true
Categories=AudioVideo;Video;Player;
Comment=A modern video player for Linux (Debug Build)
GenericName=Video Player
MimeType=video/x-msvideo;video/x-matroska;video/webm;video/x-ogm+ogg;video/x-theora+ogg;video/mp4;video/mpeg;video/ogg;video/quicktime;video/x-flv;video/x-ms-wmv;video/x-msvideo;video/x-ms-asf;video/x-ms-wmv;video/x-xvid;video/x-avi;video/3gpp;video/3gpp2;video/divx;video/mp2t;video/x-m4v;
EOL

# Make the desktop entry executable
chmod +x ~/.local/share/applications/test_reinplayer.desktop

# Update desktop database
update-desktop-database ~/.local/share/applications

# Associate with video files
xdg-mime default test_reinplayer.desktop video/x-msvideo video/x-matroska video/webm video/mp4

echo "Debug setup complete. ReinPlayer debug build is now integrated with your system."