# Sway + Waybar Configuration

Modern Wayland desktop setup with comprehensive system management and beautiful status bar.

## Features

- **Sway** tiling window manager with Wayland support
- **Waybar** status bar with system monitoring
- **PipeWire** audio with volume/mute controls
- **Brightness** control with notifications
- **Power management** profiles and battery monitoring
- **Workspace management** with auto-empty workspace creation
- **Screenshot** tools with blur effects
- **Notifications** via dunst
- **Lock screen** with blur effects

## Installation

```bash
# Install required packages
sudo pacman -S $(cat requirements-pacman.txt | tr '\n' ' ')

# Copy configuration files
cp -r .config/sway ~/.config/
cp -r .config/waybar ~/.config/

# Make scripts executable
chmod +x ~/.config/sway/scripts/*
chmod +x ~/.config/waybar/scripts/*

# Enable services
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# use ngw-displays to configure display position (optional)
ngw-displays -o ~/.screenlayout.sway
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Super + Enter` | Open terminal |
| `Super + D` | App launcher (wofi) |
| `Super + Q` | Close focused window |
| `Super + W` | Open browser |
| `Super + N` | Open file browser |
| `Super + Shift + N` | New empty workspace |
| `Super + Shift + E` | Power menu |
| `Super + L` | Lock screen |
| `Print` | Screenshot |
| `F1` | Keybinding help |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move to workspace |

## Volume & Brightness

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |

## Waybar Modules

- **Workspaces** - Click to switch, scroll to navigate
- **CPU/Memory** - System monitoring with htop on click
- **Disk** - Free space with df on click
- **Audio** - Volume control with pavucontrol on click
- **Battery** - Charge status (Pinebook Pro compatible)
- **Network** - Connection status with nmtui on click
- **Power** - Profile switching and power menu
- **Clock** - Date/time with calendar
- **Tray** - System tray applications

## Power Management

Three power profiles available (click waybar power icon to cycle):
- **Power Saver** - Maximum battery life
- **Balanced** - Default performance
- **Performance** - Maximum performance

## Scripts

- `volume_brightness.sh` - Audio/brightness control with notifications
- `empty_workspace` - Find and switch to empty workspace
- `powermenu` - System power options
- `blur-lock` - Screenshot + blur lock screen
- Various waybar status scripts in `~/.config/waybar/scripts/`

## Dependencies

See `requirements-pacman.txt` for complete package list. Main components:
- sway, waybar, foot, wofi
- pipewire audio stack
- brightnessctl, grim, dunst
- Font Awesome icons, JetBrains Mono font
