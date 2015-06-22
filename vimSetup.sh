#/bin/bash
#TODO automate phpctags, YouCompleteMe, jsctags, tern
declare -r RED='\033[0;31m'
declare -r GREEN='\033[0;32m'
declare -r CYAN='\033[0;36m'
declare -r NC='\033[0m'

OS_NAME=$( uname -s )
OS_CHK=false
if [[ $OS_NAME == *"Linux"* ]] || [[ $OS_NAME == *"Darwin"* ]]; then
    OS_CHK=true
fi

reportStatus ()
{
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Success!${NC}"
    else
        echo -e "${RED}Failed!${NC}"
    fi
}

installCtags ()
{
    if [ ! -z "$(which ctags)" ]; then
        echo -e "${CYAN}Ctags already installed${NC}"
    else
        cwd=$( pwd )
        echo -e "${CYAN}Configuring and installing ~/.vim/ctags-5.8 for Tagbar (requires root privileges)${NC}"
        cd ~/.vim/ctags_src
        tar xzf ctags-5.8.tar.gz
        cd ctags-5.8
        if [ "$OS_CHK" = true ]; then
            ./configure > /dev/null
        else
            sudo ./configure > /dev/null
        fi
        if [ $? -eq 0 ]; then
            echo -e "${CYAN}Ctags configured successfully, attempting to install...${NC}"
            sleep 2
            if [ OS_CHK ]; then
                make > /dev/null 2>&1 && make install > /dev/null
            else
                sudo make > /dev/null 2>&1 && sudo make install > /dev/null
            fi
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Ctags successfully installed to $( which ctags )${NC}"
            else
                echo -e "${RED}Ctags failed to install"
                echo -e -n "Continue with setup? [y|n]:  ${NC}"
                read pass
                if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
                    continue
                else
                    exit 1
                fi
            fi
        else
            echo -e "${RED}Ctags failed to configure. Tagbar will not work until ctags is configured correctly${NC}"
            echo -e -n "Continue with setup? [y|n]:  "
            read pass
            if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
                continue
            else
                exit 2
            fi
        fi
    fi
    eval cd $cwd
}

installYCM ()
{
    echo -e "${CYAN}Configuring and installing YouCompleteMe. This could take a while...${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/YouCompleteMe
    bash install.sh --clang-completer
    reportStatus
    eval cd $cwd
}

installJsctags ()
{
    echo -e "${CYAN}Configuring and installing JSctags${NC}"
    sudo npm install -g git+https://github.com/ramitos/jsctags.git
    reportStatus
}

installPhpctags ()
{
    echo -e "${CYAN}Configuring and installing tagbar-phpctags${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/tagbar-phpctags.vim
    make
    reportStatus
    eval cd $cwd
}

installTernForVim ()
{
    echo -e "${CYAN}Configuring and installing tern_for_vim${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/tern_for_vim
    npm install
    reportStatus
    eval cd $cwd
}

installVimProc ()
{
    cwd=$( pwd )
    echo -e "${CYAN}Configuring and installing vimproc${NC}"
    cd ~/.vim/bundle/vimproc.vim
    make
    reportStatus
    eval cd $cwd
}

installNode ()
{
    if [ ! -z "$(which node)" -a ! -z "$(which npm)" ]; then
        echo -e "${CYAN}Node and NPM already installed${NC}"
    else
        echo -e "${CYAN}Configuring and installing Node and NPM${NC}"
        if [[ "$OS_CHK" = true ]] && [[ "$OS_NAME" == "Darwin" ]]; then
            # handle Mac brew, node, and npm install
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install node
            reportStatus
        elif [[ "$OS_CHK" = true ]] && [[ "$OS_NAME" == "Linux" ]]; then
            # handle Linux  node and npm install
            sudo apt-get -y install python-dev php5 cmake node npm
            reportStatus
        else
            echo -e "${RED}Your OS is not explicitly supported${NC}"
            echo -e "${RED}Try install anyways? [y|n]:  ${NC}"
                read pass
                if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
                    continue
                else
                    exit 1
                fi
        fi
    fi
}

# First things first, is vim actually installed?
if [ -z "$(which vim)" ]; then
    echo -e "${RED}You don't appear to have vim installed. Please the most recent VIM for your OS${NC}"
    exit 1
fi

# First, ensure all submodules are correctly cloned
git submodule update --init --recursive

if [ "$(pwd)" != "$HOME" ]; then
    echo -e "${CYAN}Saving ~/.vim, ~/.vimrc, and ~/fonts to .bkp${NC}"
    # Save any existing vim configs
    [ -d ~/.vim ] && mv ~/.vim ~/.vim.bkp
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bkp
    [ -d ~/fonts ] && mv ~/fonts ~/fonts.bkp
fi

if [ "$(pwd)" != "$HOME" ]; then
    echo -e "${CYAN}Copying .vim, .vimrc, and fonts to ~${NC}"
    # Copy new Vim configs
    cp -rf .vim ~/.vim
    cp -f .vimrc ~/.vimrc
    cp -rf fonts ~/fonts
fi

installNode
installCtags
installYCM
installJsctags
installPhpctags
installTernForVim
installVimProc

echo -e "${GREEN}Done!${NC}"
exit 0
