local_aliases() {
  local file="$DOTFILES_ROOT/bash/local_aliases.sh"

  if [[ ! -f "$file" ]]; then
    mkdir -p "$(dirname "$file")"

    cat > "$file" <<'EOF'
# This script provides a method for sourcing local aliases that are not tracked
# by version control

# =========== Add local (machine dependent) aliases below ===========

EOF
  fi

  nvim "$file"
}

nvim-reset() {
    echo "WARNING: This will remove plugins and data."
    read -p "Continue? [y/N] " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        rm -rf ~/.cache/nvim
        rm -rf ~/.local/state/nvim
        rm -rf ~/.local/share/nvim
        echo "Neovim fully reset."
    else
        echo "Cancelled."
    fi
}
