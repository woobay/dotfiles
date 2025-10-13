# ~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~
eval "$(fzf --bash)"
#eval "$(/opt/homebrew/bin/brew shellenv)"
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

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias talosctl="HTTPS_PROXY=http://jump.mtl42.kmgmt.f0nz.int.bell.ca:3128 talosctl"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -h --color=auto'
alias vt="cd $WORKSPACE/gitlab.com/ga6122749/vtplatform/"

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
alias kctx="kube-ctx"

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

kube-ctx() {
    contexts=$(kubectl config get-contexts --output=name)
    selected_context=$(echo "$contexts" | fzf --prompt="Select Kubernetes context: ")
    
    if [[ -n "$selected_context" ]]; then
        kubectl config use-context "$selected_context"
        echo "Switched to context: $selected_context"
    else
        echo "No context selected."
    fi
}

. $(brew --prefix asdf)/libexec/asdf.sh

function set_http_proxy () {
  http_proxy_pac=$1
  if [ -z "$http_proxy_pac" ]; then
    http_proxy_pac=`scutil --proxy | awk '\
        /ProxyAutoConfigEnable/ { enabled = $3; } \
        /ProxyAutoConfigURLString/ { proxy = $3; } \
      END { if (enabled == "1") { print proxy; } }'`

    ## Force fastweb.int.bell.ca when proxy is enabled
    if [ ! -z "$http_proxy_pac" ]; then
      http_proxy_pac="http://fastweb.int.bell.ca:8083"
    fi
  fi
  http_proxy_pac_printable=$http_proxy_pac

  if [ -n "$http_proxy_pac" ] && [[ `curl --noproxy '*' -s $http_proxy_pac > /dev/null ; echo $?` -eq 0 ]]; then
      http_proxy=`echo ${http_proxy_pac} | sed 's/8083/80/'`
      http_proxy_printable=`echo ${http_proxy_pac_printable} | sed 's/8083/80/'`
      echo "proxy variables enabled on ${http_proxy_printable}"
      export http_proxy="${http_proxy}"
      export https_proxy="${http_proxy}"
      export HTTP_PROXY="${http_proxy}"
      export HTTPS_PROXY="${http_proxy}"
      export no_proxy="localhost,127.0.0.1,.v36.klab.f0ns3.ca,.v36.kprod.f0ns3.ca,.kargo-lab.int.bell.ca,.kargo.int.bell.ca,.vt-lab.int.bell.ca,.vt.int.bell.ca,.gitlab.int.bell.ca,.artifactory.int.bell.ca,.soc.int.bell.ca,.int.bell.ca,10.55.68.246,10.55.99.246,10.55.127.246,10.67.6.146,10.78.165.2,10.67.64.130,10.78.146.50"
      export NO_PROXY="${no_proxy}"
  else
     echo "proxy variables disabled"
  fi
}

function unset_http_proxy () {
  unset http_proxy
  unset https_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset no_proxy
  unset NO_PROXY
  echo "proxy variables disabled"
}
