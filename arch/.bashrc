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

check-status() {
	ROUTER="192.168.0.1"  # Change to your router's IP address
	USER="admin"          # Change if your router uses a different username
	SSH_KEY="~/.ssh/router"  # Change to your SSH key path if different
	VPN_NUM=4             # Your active VPN client number

	echo "Checking VPN client ${VPN_NUM} status..."
	status=$(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_state")

	if [ "$status" == "2" ]; then
		echo "VPN is CONNECTED"
		echo "Server: $(ssh -i $SSH_KEY $USER@$ROUTER "nvram get vpn_client${VPN_NUM}_addr")"
		return 0
	else
		echo "VPN is DISCONNECTED"
		return 1
	fi
}
