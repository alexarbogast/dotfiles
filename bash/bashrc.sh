if [ -f ~/.env.sh ]; then
    source ~/.env.sh;
fi

[ -n "$PS1" ] && source $DOTFILES_ROOT/bash/bash_profile.sh

