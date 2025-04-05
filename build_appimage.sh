#!/bin/bash

# Exit on any error
set -e

FLUTTER_PATH=$(which flutter)
if [ -z "$FLUTTER_PATH" ]; then
    echo "❌ Flutter not found in PATH"
    exit 1
fi

echo "🚀 Starting AppImage build process..."

echo "📦 Building Flutter application..."
$FLUTTER_PATH build linux --release

if [ ! -d "./build/linux/x64/release/bundle" ]; then
    echo "❌ Build failed: bundle directory not found"
    exit 1
fi

echo "📁 Setting up AppDir..."
mkdir -p ReinPlayer.AppDir

echo "📋 Copying bundle to AppDir..."
cp -r build/linux/x64/release/bundle/* ReinPlayer.AppDir/

if ! command -v appimagetool &> /dev/null; then
    echo "❌ appimagetool not found. Please install it first."
    echo "💡 You can download it from: https://github.com/AppImage/AppImageKit/releases"
    exit 1
fi

# Create the AppImage
echo "🔨 Creating AppImage..."
appimagetool ReinPlayer.AppDir

echo "✅ AppImage creation complete!" 