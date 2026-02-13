# Dotfiles

## Installation

Clone the repository into the user's home directory.

```shell
git clone git@github.com:alexarbogast/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

> [!NOTE]
> Ensure that the following scripts are run from the root of the dotfile's
> repository. WARNING: These scripts will overwrite any existing configuration
> so ensure you have made the necessary backups before continuing.

Run the [bootstrap.sh](./install/bootstrap.sh) script to create symbolic links
for the provided configuration files in your `~/.config` directory. The
`links.prop` file in each configuration provides the linked files, folders, and
their corresponding link paths in the `~/.config` directory.

```
./install/bootstrap.sh:
A script for symbolically linking dotfiles to the appropriate directories.

USAGE: bootstrap.sh [option] ...
Options:
    -b            run bootstrap in batch mode (without manual intervention)
                  warning: overwrites all symbolic links by default.
    -h            print this help message and exit
```

Run the [install.sh](./install/install.sh) script to install the applications
and programs used with the provided configuration. The installation script uses
Whiptail for an interactive dialog that allows the user to select the
applications for installation, or use the `-b` argument for batch installation
(this will install all applications by default).

```shell
sudo apt update
sudo apt install whiptail
```

```
./install/install.sh
A script for installing common package groups.

USAGE: install.sh [option] ...
Options:
    -b                Run install in batch mode (no UI)
    --exclude <pkg>   Exclude packages
    --list            List available software packages
    -h                Show this help
```

### Installed Applications

The installed applications include:

- Ubuntu Base
  - software-properties-common, build-essential, curl, wget, unzip, git,
  fontconfig, neofetch, python3, python3-pip, python3-venv
- Fonts
  - FiraCode [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [Alacritty](https://alacritty.org/) terminal emulator
- [Starship](https://starship.rs/) shell prompt
- [Tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer
- [Neovim](https://neovim.io/) terminal editor
- [Lazygit](https://github.com/jesseduffield/lazygit) terminal UI for git
- [Miniconda](https://docs.anaconda.com/miniconda/) minimal installer for conda

## Bash Shortcuts and Local Setup

The dotfile's directory is appended to the environment variables through the
`.env.sh` script added during installation. To navigate to the dotfiles
directory, simply type `dotfiles` in a terminal.

See [aliases.sh](./bash/aliases.sh) for the list of additional aliases. Custom
aliases and bash scripts can be added in a `bash/local_aliases.sh` script that
is ignored in the repo diff.

Custom executables and scripts can be added to the users `~/bin` directory that
is added to `PATH` if it exists.

## Docker

See the [README.md](./docker/README.md) in the `docker` folder for info on
testing the dotfiles in Docker.

## Regolith

The [regolith branch](https://github.com/alexarbogast/dotfiles/tree/regolith)
contains configuration files for the [Regolith](https://regolith-desktop.com/)
desktop environment. This branch is rebased on the master branch to maintain the
Regolith configuration on top of the existing base configuration.
