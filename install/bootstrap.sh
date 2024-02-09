#!/usr/bin/env bash
#
# install dotfiles

SCRIPT_NAME="$0"
cd "$(dirname "$SCRIPT_NAME")/.."
DOTFILES_ROOT=$(pwd -P)

set -e
echo ''

batch_mode=false

#-----------------------------------------------------------
# Logging tools

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

usage() {
cat <<EOF
$SCRIPT_NAME:
A script for symbolically linking dotfiles to the appropriate directories.

USAGE: bootstrap.sh [option] ...
Options:
    -b            run bootstrap in batch mode (without manual intervention)
                  warning: overwrites all symbolic links by default.
    -h            print this help message and exit

EOF
}

#-----------------------------------------------------------
# Symbolic linking of dotfile directories

link_file () {
  local src=$1 dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      # ignoring exit 1 from readlink in case where file already exists
      # shellcheck disable=SC2155
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then
        skip=true;

      else
        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action  < /dev/tty

        case "$action" in
          o ) overwrite=true;;
          O ) overwrite_all=true;;
          b ) backup=true;;
          B ) backup_all=true;;
          s ) skip=true;;
          S ) skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'
  
  local overwrite_all=false backup_all=false skip_all=false

  if $batch_mode; then
    overwrite_all=true
  fi

  find -H "$DOTFILES_ROOT" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read linkfile
  do
    cat "$linkfile" | while read line
    do
        local src dst dir
        src=$(eval echo "$line" | cut -d '=' -f 1)
        dst=$(eval echo "$line" | cut -d '=' -f 2)
        dir=$(dirname $dst)

        mkdir -p "$dir"
        link_file "$src" "$dst"
    done
  done
}

create_env_file () {
    if test -f "$HOME/.env.sh"
    then
        success "$HOME/.env.sh file already exists, skipping"
    else
        echo "export DOTFILES_ROOT=$DOTFILES_ROOT" > $HOME/.env.sh
        success 'created ~/.env.sh'
    fi
}

#-----------------------------------------------------------
# Parse options and make links

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

install_dotfiles
create_env_file

echo ''
success 'Bootstrap completed successfully!'
exit 0

