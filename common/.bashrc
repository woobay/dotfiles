# ~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~
eval "$(fzf --bash)"
eval "$(/opt/homebrew/bin/brew shellenv)"
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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -h --color=auto'

alias ws="cd $WORKSPACE"
alias ff="cd $WORKSPACE/gitlab.com/fennech/"
alias dot="cd $DOTFILES"
alias wo="cd $GHREPOS"
alias hl="cd $GHREPOS/homelab"


alias e="exit"
alias t="tmux" XDG_CONFIG_HOME="$HOME"/.config

alias tf="terraform"
alias k="kubectl"

alias gctx="gcloud-ctx"
alias cmr="check_merge_requests"

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~

update-go() {
#    curl -OL https://golang.org/dl/go$1.linux-amd64.tar.gz
    curl -OL https://golang.org/dl/go$1.darwin-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go$1.darwin-amd64.tar.gz
    go version
}

gcloud-ctx() {
projects=$(gcloud projects list --format="value(projectId)" | grep -v '^sys-')
selected_project=$(echo "$projects" | fzf)

if [[ -n "$selected_project" ]]; then
        # Set the selected project as the active project
        gcloud config set project "$selected_project"
        echo "Switched to project: $selected_project"
else
        echo "No project selected."
fi

}
