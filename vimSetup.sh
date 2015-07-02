#!/usr/bin/env bash
cp .vimrc ~/.vimrc
git clone https://github.com/egalpin/apt-vim.git
apt-vim init
# Overwrite the default vim_config
cp vim_config.json ~/.vimpkg/vim_config.json
apt-vim install -y
