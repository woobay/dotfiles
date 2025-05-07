# ~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~
eval "$(fzf --bash)"
eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~~~ Modes ~~~~~~~~~~~~~~~~~~~
set -o vi

# ~~~~~~~~~~~~~~~~~ Dir ~~~~~~~~~~~~~~~~~~~

export WORKSPACE="$HOME/workspace"
export GITUSER="woobay"
export GHREPOS="$WORKSPACE/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"


# ~~~~~~~~~~~~~~~ Export ~~~~~~~~~~~~~~~~~
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/woobay/.local/go/bin"
export PATH="$PATH:/Users/gabriellafrance/.local/go/bin"
export GOBIN="$HOME/.local/bin/"

export EDITOR=nvim
export VISUAL=nvim


PATH="~/.local/bin:~/.local/bin/go/bin:$PATH"
GOOS=linux
GOARCH=amd64
GOPATH="~/.local/go"
GOBIN="~/.local/go/bin"


# ~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -h --color=auto'

# alias vim='NVIM_APPNAME="nvim-kickstart" nvim'

alias ws="cd $WORKSPACE"
alias ff="cd $WORKSPACE/gitlab.com/fennech/"
alias dot="cd $DOTFILES"
alias wo="cd $GHREPOS"
alias hl="cd $GHREPOS/homelab"
alias aa="cd $DOTFILES/arch"


alias e="exit"
alias t="tmux" XDG_CONFIG_HOME="$HOME"/.config

alias tf="terraform"
alias k="kubectl"


# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~

update-go() {
#    curl -OL https://golang.org/dl/go$1.linux-amd64.tar.gz
    curl -OL https://golang.org/dl/go$1.darwin-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go$1.darwin-amd64.tar.gz
    go version
}

