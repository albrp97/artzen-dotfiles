#!/bin/bash

# Configuration
DOTFILES_DIR="$HOME/code/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Dotfiles Installation...${NC}"
echo -e "${YELLOW}Backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

link_config() {
    local source_path="$1"
    local target_path="$2"
    local rel_path="${target_path#$HOME/}"

    # Check if source exists
    if [ ! -e "$source_path" ]; then
        # echo "Skipping $rel_path (Source not found)"
        return
    fi

    echo -e "Processing ${GREEN}$rel_path${NC}..."

    # Backup existing
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        # If it's already a link to our source, skip
        current_link=$(readlink -f "$target_path")
        if [ "$current_link" == "$source_path" ]; then
            echo -e "  ${GREEN}Already linked correctly.${NC}"
            return
        fi

        echo -e "  ${YELLOW}Backing up existing...${NC}"
        # Create directory structure in backup
        mkdir -p "$(dirname "$BACKUP_DIR/$rel_path")"
        mv "$target_path" "$BACKUP_DIR/$rel_path"
    fi

    # Ensure parent dir exists
    mkdir -p "$(dirname "$target_path")"
    
    # Create symlink
    echo -e "  Linking..."
    ln -s "$source_path" "$target_path"
}

# --- Directories ---
# Window Manager & Bar
link_config "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"
link_config "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"
link_config "$DOTFILES_DIR/omarchy" "$HOME/.config/omarchy"
link_config "$DOTFILES_DIR/walker" "$HOME/.config/walker"
link_config "$DOTFILES_DIR/mako" "$HOME/.config/mako"
link_config "$DOTFILES_DIR/swayosd" "$HOME/.config/swayosd"

# Terminal & Shell
link_config "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
link_config "$DOTFILES_DIR/yazi" "$HOME/.config/yazi"
link_config "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
link_config "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
link_config "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
link_config "$DOTFILES_DIR/fish" "$HOME/.config/fish"
link_config "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_config "$DOTFILES_DIR/btop" "$HOME/.config/btop"

# Files
link_config "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link_config "$DOTFILES_DIR/shell/bashrc" "$HOME/.bashrc"
link_config "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
link_config "$DOTFILES_DIR/shell/blerc" "$HOME/.blerc"
link_config "$DOTFILES_DIR/misc/mimeapps.list" "$HOME/.config/mimeapps.list"

# Other
link_config "$DOTFILES_DIR/spicetify" "$HOME/.config/spicetify"
link_config "$DOTFILES_DIR/fontconfig" "$HOME/.config/fontconfig"

# VS Code
# Note: config path might vary if using Flatpak or other distro versions. Assuming standard ~/.config/Code
VSCODE_USER_DIR="$HOME/.config/Code/User"
link_config "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
link_config "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
link_config "$DOTFILES_DIR/vscode/snippets" "$VSCODE_USER_DIR/snippets"

echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${BLUE}Backups stored in: $BACKUP_DIR${NC}"
