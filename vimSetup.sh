#!/usr/bin/env bash
start_dir=`pwd`
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

# Execute apt-vim init
cd ${HOME}/apt-vim
sudo python - <<EOF
import imp, os
av = imp.load_source("aptvim", "./apt-vim")
APT_VIM_DIR = os.path.abspath(os.path.join(av, 'apt-vim'))
os.environ['PATH'] += os.pathsep + av.BIN_DIR

from av import aptvim

os.chdir(APT_VIM_DIR)

apt_vim = aptvim(ASSUME_YES=True)
apt_vim.handle_install(None, None, None)
EOF
cd $start_dir
