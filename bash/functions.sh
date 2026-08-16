hm-switch() {
  case "$USER" in
    alex)
      home-manager switch --flake "$HOME/.dotfiles#alex-home" "$@"
      ;;
    owa)
      home-manager switch --flake "$HOME/.dotfiles#owa-home" "$@"
      ;;
    *)
      echo "No Home Manager configuration for user '$USER'" >&2
      return 1
      ;;
  esac
}

local_aliases() {
  local file="$HOME/.config/bash/local_aliases.sh"

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

build_compile_commands() {
    cmake -B build . --fresh -DCMAKE_EXPORT_COMPIPLE_COMMANDS=1
    cp ./compile_commands.json .
}
alias bcc=build_compile_commands
