#!/usr/bin/env bash
if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
cp .vimrc ~/.vimrc

if [ -z $(which apt-vim) ]; then
    git clone https://github.com/egalpin/apt-vim.git
    cd apt-vim
    ./apt-vim init
    cd -
fi
# Backup the old vim_config
if [ -f ~/.vimpkg/vim_config.json ]; then
    mv ~/.vimpkg/vim_config.json ~/.vimpkg/vim_config.json.bak
fi
# Overwrite the default vim_config
cp ./vim_config.json ~/.vimpkg/vim_config.json
apt-vim install -y
