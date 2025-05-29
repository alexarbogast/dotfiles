# quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias dotfiles="cd $DOTFILES_ROOT"

# shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias doc="cd ~/Documents"

# neovim
alias vim="nvim"
alias nvim-custom="NVIM_APPNAME=nvim-custom nvim"

# latex with docker
alias latex='docker run --user $(id -u):$(id -g) --rm -it \
  -v .:/workdir texlive/texlive latexmk \
  -quiet \
  -output-directory=build \
  -aux-directory=build/aux \
  -pdf'

