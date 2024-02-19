#!/usr/bin/env bash

set -e
echo ''

SCRIPT_NAME="$0"

batch_mode=false

#-----------------------------------------------------------
# Logging tools

success () {
  local message="${@}"
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $message\n"
}

fail () {
  local message="${@}"
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $message\n"
  echo ''
  exit 1
}

usage() {
cat <<EOF
$SCRIPT_NAME
USAGE: install.sh [option] ...
Options:
    -b            run install in batch mode (without manual intervention)
    -h            print this help message and exit

EOF
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
  curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
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
 
  # install npm for mason lsp installs
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs
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

while getopts :bh flag; 
do
  case "${flag}" in
  b) batch_mode=true;;
  h) 
     usage
     exit 0
     ;;
  *)
     usage
     fail "Illegal option -$OPTARG"
     ;;
  esac
done

PACKAGE_LIST=(
  "Ubuntu Base" "Common utility packages"
  "Fonts" "Nerd fonts"
  "Alacritty" "Alacritty terminal emulator"
  "Starship" "Starhip shell prompt"
  "Tmux" "Tmux terminal multiplexer"
  "Neovim" "Neovim terminal editor"
  "Lazygit" "Laygit terminal git manager"
  "Miniconda" "Miniconda enivronment manager"
)

install_list=()
entry_options=()

for (( i = 0; i < ${#PACKAGE_LIST[@]}; i+=2 )); do
  install_list+=("${PACKAGE_LIST[i]}")
  entry_options+=("${PACKAGE_LIST[i]}" "${PACKAGE_LIST[i + 1]}" "ON")
done

# Prompt user in interactive mode
if ! $batch_mode; then
  if ! [ -x "$(command -v whiptail)" ]; then 
    fail "whiptail must be installed for interactive installation \n" \
         "sudo apt update && sudo apt install whiptail"
  fi

  eval install_list=(
    $(whiptail --checklist --title "Package Install Selection" \
      "Choose the packages to install" 0 80 0 \
      -- "${entry_options[@]}" \
      3>&2 2>&1 1>&3-)
  )
fi

# Install packages
mkdir -p temp && cd temp
sudo apt update && sudo apt upgrade -y

for pkg in "${install_list[@]}"; do
  case "$pkg" in
    "Ubuntu Base") install_ubuntu_base ;;
    "Fonts")       install_fonts ;;
    "Alacritty")   install_alacritty ;;
    "Starship")    install_starship ;;
    "Tmux")        install_tmux ;;
    "Neovim")      install_neovim ;;
    "Lazygit")     install_lazygit ;;
    "Miniconda")   install_miniconda ;; 
    *) 
      echo "Unsuported package $pkg!" >&2
      exit 1
      ;;
  esac
done

success "Cleaning install space"
sudo apt autoclean -y
sudo apt-get clean -y
sudo apt autoremove -y
cd ../ && rm -rf temp

success "All packages succeeded!"
exit 0

