#!/usr/bin/env bash

set -e
echo ''

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit 1
}

# -----------------------------------------------------------------------
# Ubuntu base
install_ubuntu_base() {
  success "Installing Ubuntu base packages"
  sudo apt install -y software-properties-common
  sudo apt install -y build-essential
  sudo apt install -y curl
  sudo apt install -y wget
  sudo apt install -y git
  sudo apt install -y fontconfig
  sudo apt install -y neofetch
  sudo apt install -y python3
  sudo apt install -y python3-pip
  sudo apt install -y python3-venv
}

install_fonts() {
  success "Installing fonts"
  local fonts=(
    FiraCode
  ) 
  
  local fonts_dir="${HOME}/.local/share/fonts"
  echo $fonts_dir
  if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
  fi 

  for font in "${fonts[@]}"; do
    zip_file="${font}.tar.xz"
    curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${zip_file}"
    tar -xf "$zip_file" -C "$fonts_dir"
  done
}

# -----------------------------------------------------------------------
# Alacritty
install_alacritty() {
  success "Installing Alacritty"
  sudo add-apt-repository -y ppa:aslatter/ppa
  sudo apt update
  sudo apt install -y alacritty 
}

# -----------------------------------------------------------------------
# Starship
install_starship() {
  success "Installing Starship"
  curl -sS https://starship.rs/install.sh | sh -s -- -y
}

# -----------------------------------------------------------------------
# Tmux
install_tmux() {
  success  "Installing Tmux"
  sudo apt install -y tmux 
}

# -----------------------------------------------------------------------
# Neovim
install_neovim() {
  success "Installing Neovim"
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install -y neovim
}

# -----------------------------------------------------------------------
# Lazygit
install_lazygit() {
  success "Installing Lazygit"
  LAZYGIT_VERSION=$(curl -s \
    "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
    | grep -Po '"tag_name": "v\K[^"]*')
 
  local release_file="lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  curl -Lo lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/$release_file"

  tar -xf lazygit.tar.gz lazygit 
  sudo install lazygit /usr/local/bin
} 

# -----------------------------------------------------------------------
# Miniconda
install_miniconda() {
  success "Installing Miniconda"
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
  bash miniconda.sh -b -u -p $HOME/miniconda
  
  eval "$($HOME/miniconda/bin/conda shell.bash hook)"
  conda config --set auto_activate_base false
  conda install -y -c conda-forge conda-bash-completion
}

# -----------------------------------------------------------------------
# Install
mkdir temp && cd temp
sudo apt update && sudo apt upgrade

install_ubuntu_base
install_fonts
install_alacritty
install_starship
install_tmux
install_neovim
install_lazygit
install_miniconda

success "Cleaning install space"
sudo apt autoclean
sudo apt-get clean
sudo apt autoremove
cd ../ && rm -rf temp

success "All packages succeeded"
exit 0

