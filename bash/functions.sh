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
