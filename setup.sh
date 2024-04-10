# setup.sh

DIR=$HOME/workspace/github.com/woobay/dotfiles

DOTFILES=(
	".bashrc"
	".alacritty.toml"
	".tmux.conf"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
