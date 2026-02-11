# Omarchy Rice Dotfiles

This repository contains personal configuration files (dotfiles) for my Arch Linux setup ("Omarchy Rice").

## Contents

- **Window Manager**: 
  - Hyprland (`.config/hypr`)
  - Omarchy Rice Configs (`.config/omarchy`) including **Themes and Wallpapers**
- **Bar**: Waybar (`.config/waybar`)
- **Launcher**: Walker (`.config/walker`)
- **Notifications**: Mako (`.config/mako`)
- **OSD**: SwayOSD (`.config/swayosd`)
- **Terminal Configs**:
  - Kitty
  - Alacritty
  - Ghostty
  - Btop (`.config/btop`)
- **Shell**: 
  - Fish (`.config/fish`)
  - Bash (`.bashrc`, `.blerc`)
  - Zsh (`.zshrc`)
  - Starship Prompt (`starship.toml`)
- **Editor**: 
  - Neovim (`.config/nvim`)
  - VS Code (`settings.json`, `keybindings.json`, `snippets`)
- **Tools**:
  - Fastfetch (`.config/fastfetch`)
  - Yazi (`.config/yazi`)
  - Spicetify (`.config/spicetify`)
- **Misc**:
  - Fontconfig (`.config/fontconfig`)
  - Default Apps (`mimeapps.list`)

## Installation

An automated installation script is included to symlink these files to their appropriate locations in `~/.config` and `~/`.

**Usage:**

```bash
./install.sh
```

**Note:** The script will automatically backup any existing configuration files that would be overwritten to `~/dotfiles_backup_<timestamp>/`.

## Manual Installation

If you prefer to install manually, you can symlink specific directories. For example:

```bash
ln -s ~/code/dotfiles/hypr ~/.config/hypr
ln -s ~/code/dotfiles/waybar ~/.config/waybar
# ... and so on
```
