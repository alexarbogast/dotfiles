#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$0"
batch_mode=false
list_mode=false
EXCLUDE_LIST=()

#-----------------------------------------------------------
# Logging

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$*"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n\n" "$*"
  exit 1
}

usage() {
cat <<EOF
$SCRIPT_NAME
A script for installing common package groups.

USAGE: install.sh [option] ...
Options:
    -b                Run install in batch mode (no UI)
    --exclude <pkg>   Exclude packages
    --list            List available software packages
    -h                Show this help
EOF
}

# --------------------------------------------------
# Package Registry

declare -A PACKAGES=(
  ["ubuntu_base"]="Common utility packages"
  ["fonts"]="Nerd fonts"
  ["alacritty"]="Alacritty terminal emulator"
  ["starship"]="Starship shell prompt"
  ["tmux"]="Tmux terminal multiplexer"
  ["neovim"]="Neovim terminal editor"
  ["lazygit"]="Lazygit terminal git manager"
  ["miniconda"]="Miniconda environment manager"
)

# -----------------------------------------------------------------------
# Installers

install_ubuntu_base() {
  success "Installing Ubuntu base packages"
  sudo apt install -y \
   software-properties-common \
   build-essential \
   curl \
   wget \
   unzip \
   git \
   fontconfig \
   neofetch \
   python3 \
   python3-pip \
   python3-venv
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

install_alacritty() {
  success "Installing Alacritty"
  sudo add-apt-repository -y ppa:aslatter/ppa
  sudo apt update
  sudo apt install -y alacritty
}

install_starship() {
  success "Installing Starship"
  curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
}

install_tmux() {
  success  "Installing Tmux"
  sudo apt install -y tmux

  # install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_neovim() {
  success "Installing Neovim"
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install -y neovim

  # install npm for mason lsp installs
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs
}

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

install_miniconda() {
  success "Installing Miniconda"
  wget -O miniconda.sh \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

  bash miniconda.sh -b -u -p $HOME/miniconda

  eval "$($HOME/miniconda/bin/conda shell.bash hook)"
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
  conda config --set auto_activate_base false
  conda install -y -c conda-forge conda-bash-completion
}


# -----------------------------------------------------------------------
# CLI Parsing

while [[ $# -gt 0 ]]; do
  case "$1" in
    -b)
      batch_mode=true
      shift
      ;;
    --exclude)
      shift
      # Collect all following args that are not flags
      while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
        EXCLUDE_LIST+=("$1")
        shift
      done
      ;;
    --list)
      list_mode=true
      shift
      ;;
    -h)
      usage
      exit 0
      ;;
    *)
      usage
      fail "Unknown option: $1"
      ;;
  esac
done

# --------------------------------------------------
# List packages

if $list_mode; then
  echo "Available packages:"
  echo ""

  for pkg in "${!PACKAGES[@]}"; do
    printf "  %-15s %s\n" "$pkg" "${PACKAGES[$pkg]}"
  done

  echo ""
  exit 0
fi

# -----------------------------------------------------------------------
# Build install list

install_list=()

for pkg in "${!PACKAGES[@]}"; do
  skip=false
  for excluded in "${EXCLUDE_LIST[@]}"; do
    if [[ "$pkg" == "$excluded" ]]; then
      skip=true
      break
    fi
  done
  if ! $skip; then
    install_list+=("$pkg")
  fi
done

# --------------------------------------------------
# Interactive Mode

if ! $batch_mode; then
  if ! command -v whiptail &> /dev/null; then
    fail "whiptail is required for interactive mode.
      Install it with:
      sudo apt update && sudo apt install -y whiptail"
  fi

  options=()
  for pkg in "${install_list[@]}"; do
    options+=("$pkg" "${PACKAGES[$pkg]}" "ON")
  done

  selected=$(
    whiptail --checklist \
      --title "Package Selection" \
      "Choose packages to install" \
      20 80 10 \
      "${options[@]}" \
      3>&1 1>&2 2>&3
  )

  eval "install_list=($selected)"
fi

# --------------------------------------------------
# Installation

success "Updating apt"
sudo apt update
sudo apt upgrade -y

WORKDIR=$(mktemp -d)
cd "$WORKDIR"

for pkg in "${install_list[@]}"; do
  pkg="${pkg//\"/}"  # strip quotes from whiptail
  func="install_${pkg}"

  if declare -f "$func" > /dev/null; then
    $func
  else
    fail "No installer defined for $pkg"
  fi
done

success "Cleaning up"
sudo apt autoremove -y
sudo apt autoclean -y

cd ~
rm -rf "$WORKDIR"

success "All packages installed successfully!"
