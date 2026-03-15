#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dest="$2"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "Backup: $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -sf "$src" "$dest"
  echo "Linked: $dest -> $src"
}

link_dir() {
  local src="$1" dest="$2"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -d "$dest" ]; then
    echo "Backup: $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -sf "$src" "$dest"
  echo "Linked: $dest -> $src"
}

# --- Archivos en $HOME ---
link "$DOTFILES_DIR/zshrc"        "$HOME/.zshrc"
link "$DOTFILES_DIR/zprofile"     "$HOME/.zprofile"
link "$DOTFILES_DIR/bashrc"       "$HOME/.bashrc"
link "$DOTFILES_DIR/bash_profile" "$HOME/.bash_profile"
link "$DOTFILES_DIR/gitconfig"    "$HOME/.gitconfig"
link "$DOTFILES_DIR/ideavimrc"    "$HOME/.ideavimrc"

# --- Directorios en .config ---
mkdir -p "$HOME/.config"
link_dir "$DOTFILES_DIR/.config/nvim"      "$HOME/.config/nvim"
link_dir "$DOTFILES_DIR/.config/fish"      "$HOME/.config/fish"
link_dir "$DOTFILES_DIR/.config/karabiner" "$HOME/.config/karabiner"
link_dir "$DOTFILES_DIR/.config/opencode"  "$HOME/.config/opencode"

# --- Warp (vive en $HOME/.warp) ---
link_dir "$DOTFILES_DIR/.warp" "$HOME/.warp"

echo ""
echo "✅ Dotfiles instalados correctamente."
