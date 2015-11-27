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
import imp
import os
HOME = os.path.expanduser("~")
APT_VIM_DIR = os.path.abspath(os.path.join(HOME, 'apt-vim'))
SCRIPT_ROOT_DIR = os.path.abspath(os.path.join(HOME, '.vimpkg'))
BIN_DIR = os.path.abspath(os.path.join(SCRIPT_ROOT_DIR, 'bin'))
VIM_CONFIG_PATH = os.path.abspath(os.path.join(SCRIPT_ROOT_DIR, 'vim_config.json'))
os.environ['PATH'] += os.pathsep + BIN_DIR
os.chdir(APT_VIM_DIR)

aptvim = imp.load_source("aptvim", "./apt-vim")
global ASSUME_YES
ASSUME_YES = True

global VIM_CONFIG
json_file = open(VIM_CONFIG_PATH).read()
VIM_CONFIG = json.loads(json_file)
aptvim.handle_install(None, None, None)
EOF
cd $start_dir
