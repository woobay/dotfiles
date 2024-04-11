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
alias ls='ls -h --color=auto'

alias nvim='NVIM_APPNAME="nvim-kickstart" nvim'

alias ws="cd $WORKSPACE"
alias dot="cd $DOTFILES"

alias e="exit"
alias t="tmux" XDG_CONFIG_HOME="$HOME"/.config
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/bash_completion.sh

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
source /etc/profile.d/bash_completion.sh
