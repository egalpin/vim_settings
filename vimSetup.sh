#/bin/sh
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
        echo "${GREEN}Success!${NC}"
    else
        echo "${RED}Failed!${NC}"
    fi
}

installCtags ()
{
    cwd=$( pwd )
    echo "${CYAN}Configuring and installing ~/.vim/ctags-5.8 for Tagbar (requires root privileges)${NC}"
    cd ~/.vim/ctags_src
    tar xzf ctags-5.8.tar.gz
    cd ctags-5.8
    if [ "$OS_CHK" = true ]; then
        ./configure > /dev/null
    else
        sudo ./configure > /dev/null
    fi
    if [ $? -eq 0 ]; then
        echo "${CYAN}Ctags configured successfully, attempting to install...${NC}"
        sleep 2
        if [ -n "$win_chk" ]; then
            make > /dev/null 2>&1 && make install > /dev/null
        else
            sudo make > /dev/null 2>&1 && sudo make install > /dev/null
        fi
        if [ $? -eq 0 ]; then
            echo "${GREEN}Ctags successfully installed to $( which ctags )${NC}"
        else
            echo "${RED}Ctags failed to install"
            echo -n "Continue with setup? [y|n]:  ${NC}"
            read pass
            if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
                continue
            else
                exit 1
            fi
        fi
    else
        echo "${RED}Ctags failed to configure. Tagbar will not work until ctags is configured correctly${NC}"
        echo -n "Continue with setup? [y|n]:  "
        read pass
        if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
            continue
        else
            exit 2
        fi
    fi
    eval cd $cwd
}

installYCM ()
{
    echo "${CYAN}Configuring and installing YouCompleteMe${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    bash install.sh --clang-completer
    reportStatus
    eval cd $cwd
}

installJsctags ()
{
    echo "${CYAN}Configuring and installing YouCompleteMe${NC}"
    sudo npm install -g git+https://github.com/ramitos/jsctags.git
    reportStatus
}

installPhpctags ()
{
    echo "${CYAN}Configuring and installing tagbar-phpctags${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/tagbar-phpctags
    make
    reportStatus
    eval cd $cwd
}

installTernForVim ()
{
    echo "${CYAN}Configuring and installing tern_for_vim${NC}"
    cwd=$( pwd )
    cd ~/.vim/bundle/tern_for_vim
    npm install
    reportStatus
    eval cd $cwd
}

installNode ()
{
    echo "${CYAN}Configuring and installing Node and NPM${NC}"
    if [[ "$OS_CHK" = true ]] && [ "$OS_NAME" -eq "Darwin" ]; then
        # handle Mac brew, node, and npm install
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install node
        reportStatus
    elif [[ "$OS_CHK" = true ]] && [ "$OS_NAME" -eq "Linux" ]; then
        # handle Linux  node and npm install
        sudo apt-get install nodejs
        sudo apt-get install npm
        reportStatus
    else
        echo "${RED}Your OS does not support node${NC}"
        echo "${RED}Install cannot be completed${NC}"
        exit 1
    fi
}

if [ "$(pwd)" != "$HOME" ]; then
    echo "${CYAN}Saving ~/.vim, ~/.vimrc, and ~/fonts to .bkp${NC}"
    # Save any existing vim configs
    [ -d ~/.vim ] && mv ~/.vim ~/.vim.bkp
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bkp
    [ -d ~/fonts ] && mv ~/fonts ~/fonts.bkp
fi

if [ "$(pwd)" != "$HOME" ]; then
    echo "${CYAN}Copying .vim, .vimrc, and fonts to ~${NC}"
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

echo "${CYAN}Next steps: set the terminal font to a powerline font; check YouCompleteMe, jsctags, phpctags on GitHub to verify installation${NC}"
echo "${GREEN}Done!${NC}"

exit 0
