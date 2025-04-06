# ReinPlayer 🎬

**A modern, intuitive video player for Linux inspired by PotPlayer.**

---

## 🚀 Introduction

### Why ReinPlayer?

As a developer transitioning fully to Linux, I faced a surprising barrier: my favorite tools weren’t available. Two of them kept me tied to Windows:

- Internet Download Manager (IDM)
- PotPlayer

I eventually found a good alternative to IDM, but PotPlayer remained unmatched. Tools like VLC and SMPlayer are powerful, yet they lack the seamless and intuitive experience PotPlayer offers, especially with playlist management.

#### Key Missing Features in Other Players:

- Playlists are saved as files and don’t persist between sessions.
- No automatic playlist continuation (e.g., playing next episode in a folder).
- Must manually open playlist files, unlike PotPlayer’s built-in view.
- Interfaces can feel clunky or unintuitive.
  
I decided to build only what I need — **ReinPlayer** is not a full PotPlayer clone, but it captures the essential experience I missed on Linux.

---

## 🛠️ Solutions I Explored

Before building ReinPlayer, I attempted a few alternatives:

- Searched for Linux players with similar playlist behavior.
- Tried installing PotPlayer with Wine.
- Attempted Steam-based installation (unsuccessful due to constant crashes).

---

## 💡 Why Flutter?

With a background in **Java** and **C#**, you might ask why I chose Flutter over something like Avalonia or JavaFX.

The answer is simple: I plan to build cross-platform mobile apps in the future, and Flutter is my tool of choice. ReinPlayer was a perfect opportunity to deepen my Flutter experience.

---

## 🧩 Architecture

ReinPlayer follows the **MVVM** architecture along with a hybrid **feature + layered** approach.

- `common` – Shared widgets, logic, helpers.
- `playback` – Playback screen, video/audio controls.
- `playlist` – Album and playlist management.
- `settings` – User preferences and configuration.
- `player_frame` – Window actions (minimize, maximize, fullscreen, etc.)

📚 Read more about the architecture here: [Flutter App Architecture Guide](https://docs.flutter.dev/app-architecture/guide)

---

## ⚙️ Features

### 🖥️ Player

- Modern, intuitive UI
- Supports all FFmpeg-compatible video formats ([see full list](https://www.ffmpeg.org/general.html#Video-Codecs))
- Responsive keyboard shortcuts:

| Key                 | Action                  |
| ------------------- | ----------------------- |
| Spacebar            | Pause / Play            |
| m                   | Mute / Unmute           |
| Ctrl + h            | Show / Hide Subtitles   |
| Esc                 | Exit Fullscreen         |
| Enter               | Maximize / Minimize     |
| Right Arrow         | Seek Forward            |
| Left Arrow          | Seek Backward           |
| Shift + Right Arrow | Big Seek Forward        |
| Shift + Left Arrow  | Big Seek Backward       |
| Up Arrow            | Volume Up               |
| Down Arrow          | Volume Down             |

- Window actions (Always-on-top, minimize, maximize, fullscreen, close)
- Player controls: Play, Pause, Stop, Open, Next, Previous
- Drag-and-drop support for files and folders
- Playlist panel
- Settings menu
- Adaptive seeking speed based on video length

---

### 🎵 Playlist

- Create and manage playlists
- Persistent playlists without needing to save/import manually
- Resume playback from the last played video
- Auto-load all videos in a dropped folder into a default album
- Auto-load all similar files in a folder when opening a video (e.g., play next episode automatically)

---

### 💬 Subtitles

- Auto-load subtitles from the same folder as the video
- Manual subtitle loading
- Enable / Disable subtitles

---

## 📦 Downloads

| Version | OS    | Download URL                                                                 |
| ------- | ----- | ---------------------------------------------------------------------------- |
| v1.0.0  | Linux | [Download from GitHub](https://github.com/Ahurein/rein_player/tree/main/assets) |

### ✅ Supported Platforms

| OS           | Supported | Notes                                                                                      |
| ------------ | --------- | ------------------------------------------------------------------------------------------ |
| **Linux**    | ✅         | Fully supported                                                                            |
| **Windows**  | ❌         | Use PotPlayer instead                                                                      |
| **macOS**    | ❌         | Currently not supported. Want to help? Reach out and let's build a macOS version together as I don't have a Mac 😅.|
| **Android**  | ❌         | Not supported – designed for desktop use                                                  |
| **iOS**      | ❌         | Not supported – designed for desktop use                                                  |

---

## 📥 Installation Guide

### 1. Portable Mode (No Installation)

```bash
chmod +x ReinPlayer-x86_64_v1-0-0.AppImage
./ReinPlayer-x86_64_v1-0-0.AppImage
```

### 2. Install to System

```bash
curl -O https://raw.githubusercontent.com/Ahurein/rein_player/blob/main/install.sh
chmod +x install.sh
sudo ./install.sh path_to_reinplayer_appimage_download

```

### 3. Uninstall
```sh
curl -O https://raw.githubusercontent.com/Ahurein/rein_player/blob/main/uninstall.sh
chmod +x uninstall.sh
sudo ./uninstall.sh
```
Note: If you're using the portable version, simply delete the AppImage file.


---

## 🤝 Contributing

Although this started as a personal project, contributions are welcome! Whether it's a macOS build, bug fix, or UI improvement — feel free to open a PR or issue.

---

## 📧 Contact

Have suggestions or want to collaborate? Reach out via on [linkedin](https://www.linkedin.com/in/ebenezer-ahurein/)