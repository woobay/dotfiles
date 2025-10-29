#!/bin/bash
DIR=$HOME/workspace/github.com/woobay/dotfiles
OS="$(uname -s)"

HOME_DOTFILES=(
    ".bashrc"
    ".bash_exports"
    ".bash_inits"
    ".bash_functions"
    ".bash_aliases"
    ".alacritty.toml"
    ".tmux.conf"
    ".gitconfig"
    ".inputrc"
)

get_relative_path() {
    local source="$1"
    local base="$2"
    echo "${source#$base/}"
}

link_configs() {
    local source_dir="$1"
    
    # Link home dotfiles
    for dotfile in "${HOME_DOTFILES[@]}"; do
        if [ -f "${source_dir}/${dotfile}" ]; then
            rm -rf "${HOME}/${dotfile}"
            ln -sf "${source_dir}/${dotfile}" "${HOME}/${dotfile}"
        fi
    done

    mkdir -p "${HOME}/.config"
    
    if [ -d "${source_dir}/.config" ]; then
        for config_dir in $(find "${source_dir}/.config" -mindepth 1 -maxdepth 1 -type d); do
            dir_name=$(basename "$config_dir")
            mkdir -p "${HOME}/.config/${dir_name}"
            find "$config_dir" -type f | while read item; do
                rel_path=$(get_relative_path "$item" "${source_dir}/.config")
                parent_dir=$(dirname "${HOME}/.config/${rel_path}")
                mkdir -p "$parent_dir"
                rm -rf "${HOME}/.config/${rel_path}"
                ln -sf "$item" "${HOME}/.config/${rel_path}"
            done
            find "$config_dir" -type d | while read dir_item; do
                if [ "$dir_item" != "$config_dir" ]; then
                    rel_dir=$(get_relative_path "$dir_item" "${source_dir}/.config")
                    mkdir -p "${HOME}/.config/${rel_dir}"
                fi
            done
        done
        
        find "${source_dir}/.config" -maxdepth 1 -type f | while read config_file; do
            file_name=$(basename "$config_file")
            rm -rf "${HOME}/.config/${file_name}"
            ln -sf "$config_file" "${HOME}/.config/${file_name}"
        done
    fi
}

link_configs "${DIR}/common"

case "$OS" in
    "Darwin")
        link_configs "${DIR}/macos"
        ;;
    "Linux")
        link_configs "${DIR}/linux"
        ;;
esac

echo "Setup complete! All configuration files have been linked."
