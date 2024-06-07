# ~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~
eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~~~ Source ~~~~~~~~~~~~~~~~

echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc

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
export GOBIN="$HOME/.local/bin/"

export EDITOR=nvim
export VISUAL=nvim


PATH="~/.local/bin:~/.local/bin/go/bin:$PATH"
GOOS=linux
GOARCH=amd64
GOPATH="~/.local/go"
GOBIN="~/.local/go/bin"

export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

# ~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -h --color=auto'

# alias vim='NVIM_APPNAME="nvim-kickstart" nvim'

alias ws="cd $WORKSPACE"
alias dot="cd $DOTFILES"
alias wo="cd $GHREPOS"
alias hl="cd $GHREPOS/homelab"

alias e="exit"
alias t="tmux" XDG_CONFIG_HOME="$HOME"/.config

alias tf="terraform"
alias k="kubectl"

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~

clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone

update-go() {
    curl -OL https://golang.org/dl/go$1.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go$1.linux-amd64.tar.gz
    go version
}
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/bash_completion.sh
