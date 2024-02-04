# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alex/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alex/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/alex/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/alex/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Conda bash completion
CONDA_ROOT=~/miniconda   # <- set to your Anaconda/Miniconda installation directory
if [[ -r $CONDA_ROOT/etc/profile.d/bash_completion.sh ]]; then
    source $CONDA_ROOT/etc/profile.d/bash_completion.sh
fi

