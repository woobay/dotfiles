# setup.sh

DIR=$HOME/workspace/github.com/woobay/dotfiles

DOTFILES=(
	".bashrc"
	".alacritty.toml"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
