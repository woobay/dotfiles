# ~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~
eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~~~ Source ~~~~~~~~~~~~~~~~

echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc


# ~~~~~~~~~~~~~~~~~ Dir ~~~~~~~~~~~~~~~~~~~

export WORKSPACE="$HOME/workspace"
export GITUSER="woobay"
export GHREPOS="$WORKSPACE/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"

# ~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ws="cd $WORKSPACE"
alias dot="cd $DOTFILES"

alias e="exit"
alias t="tmux" XDG_CONFIG_HOME="$HOME"/.config
source /etc/profile.d/bash_completion.sh
