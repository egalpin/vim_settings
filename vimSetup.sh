#!/usr/bin/env bash
curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh|sh

if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
curl -sLo vimrc https://raw.githubusercontent.com/egalpin/vim_settings/master/vimrc
cp vimrc ~/.vimrc

# Backup the old vim_config
if [ -f ~/.vimpkg/vim_config.json ]; then
    mv ~/.vimpkg/vim_config.json ~/.vimpkg/vim_config.json.bak
fi
curl -sLo vim_config.json https://raw.githubusercontent.com/egalpin/vim_settings/master/vim_config.json
# Overwrite the default vim_config
cp ./vim_config.json ~/.vimpkg/vim_config.json

if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
elif [ -f /etc/profile ]; then
    . /etc/profile
fi

apt-vim install -y
