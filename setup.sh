#!/bin/bash

DIR=$HOME/workspace/github.com/woobay/dotfiles

DOTFILES=(
	".bashrc"
	".alacritty.toml"
	".tmux.conf"
	".gitconfig"
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

for dotfile in "${DOTFILES[@]}";do
	dirname=$(dirname "${HOME}/${dotfile}")
	mkdir -p "$dirname"
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
