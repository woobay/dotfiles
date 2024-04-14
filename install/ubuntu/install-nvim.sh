#!/bin/bash

curl -O "https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage" 
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

