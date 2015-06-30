#!/usr/bin/env bash
cp .vimrc ~/.vimrc
git clone https://github.com/egalpin/apt-vim.git
cp apt-vim/apt-vim /usr/local/bin
apt-vim init
cp vim_config.json ~/.vimpkg/vim_config.json
apt-vim install -y
