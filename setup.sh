#!/bin/bash

DIR=$HOME/workspace/github.com/woobay/dotfiles

DOTFILES=(
	".bashrc"
	".alacritty.toml"
	".tmux.conf"
	".gitconfig"
	".config/i3/config"
	".config/starship.toml"
	".config/nvim/init.lua"
	".config/nvim/lua/custom/plugins/init.lua"
	".config/nvim/lua/custom/plugins/lazy-lock.json"
	".config/nvim/lua/kickstart/plugins/autopairs.lua"
	".config/nvim/lua/kickstart/plugins/debug.lua"
	".config/nvim/lua/kickstart/plugins/gitsigns.lua"
	".config/nvim/lua/kickstart/plugins/indent_line.lua"
	".config/nvim/lua/kickstart/plugins/lint.lua"
	".config/nvim/lua/kickstart/plugins/neo-tree.lua"
	".config/nvim/lua/kickstart/health.lua"
	".inputrc"
)

mkdir -p ~/.config/nvim/lua/kickstart/plugins/
mkdir -p ~/.config/nvim/lua/custom/plugins/

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
