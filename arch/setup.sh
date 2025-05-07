#!/bin/bash
DIR=$HOME/workspace/github.com/woobay/dotfiles/arch

HOME_DOTFILES=(
    ".bashrc"
    ".alacritty.toml"
    ".tmux.conf"
)

for dotfile in "${HOME_DOTFILES[@]}"; do
    rm -rf "${HOME}/${dotfile}"
    ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done

mkdir -p "${HOME}/.config"

get_relative_path() {
    local source="$1"
    local base="$2"
    echo "${source#$base/}"
}

if [ -d "${DIR}/.config" ]; then
    for config_dir in $(find "${DIR}/.config" -mindepth 1 -maxdepth 1 -type d); do
        dir_name=$(basename "$config_dir")
        mkdir -p "${HOME}/.config/${dir_name}"
        
        find "$config_dir" -type f | while read item; do
            rel_path=$(get_relative_path "$item" "${DIR}/.config")
            parent_dir=$(dirname "${HOME}/.config/${rel_path}")
            mkdir -p "$parent_dir"
            
            rm -rf "${HOME}/.config/${rel_path}"
            ln -sf "$item" "${HOME}/.config/${rel_path}"
        done
        
        find "$config_dir" -type d | while read dir_item; do
            if [ "$dir_item" != "$config_dir" ]; then
                rel_dir=$(get_relative_path "$dir_item" "${DIR}/.config")
                mkdir -p "${HOME}/.config/${rel_dir}"
            fi
        done
    done
    
    find "${DIR}/.config" -maxdepth 1 -type f | while read config_file; do
        file_name=$(basename "$config_file")
        rm -rf "${HOME}/.config/${file_name}"
        ln -sf "$config_file" "${HOME}/.config/${file_name}"
    done
fi

echo "Setup complete! All configuration files have been linked."
