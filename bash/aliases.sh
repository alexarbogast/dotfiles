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

# latex with docker
alias latex='docker run --rm -it -v .:/workdir texlive/texlive latexmk \
  -quiet \
  -output-directory=build \
  -pdf'

