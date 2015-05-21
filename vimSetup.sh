#/bin/sh
#TODO automate phpctags, YouCompleteMe, jsctags
which tput >/dev/null 2>&1
if [ $? -eq 0 ]; then
    info=$( tput setaf 3 )
    warn=$( tput setaf 1 )
    end_str=$( tput sgr0 )
else
    info=''
    warn=''
    end_str=''
fi 

win_chk=$( env | grep -i 'windows' )
if [ "$(pwd)" != "$HOME" ]; then
    echo "${info}Saving ~/.vim, ~/.vimrc, and ~/fonts to .bkp${end_str}"
    # Save any existing vim configs
    [ -d ~/.vim ] && mv ~/.vim ~/.vim.bkp
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bkp
    [ -d ~/fonts ] && mv ~/fonts ~/fonts.bkp
fi

if [ "$(pwd)" != "$HOME" ]; then
    echo "${info}Copying .vim, .vimrc, and fonts to ~${end_str}"
    # Copy new Vim configs
    cp -rf .vim ~/.vim
    cp -f .vimrc ~/.vimrc
    cp -rf fonts ~/fonts
fi

echo "${info}Configuring and installing ~/.vim/ctags-5.8 for Tagbar (requires root privileges)${end_str}"
cd ~/.vim/ctags_src
tar xzf ctags-5.8.tar.gz
cd ctags-5.8
if [ -n "$win_chk" ]; then
    ./configure > /dev/null
else
    sudo ./configure > /dev/null
fi
if [ $? -eq 0 ]; then
    echo "${info}Ctags configured successfully, attempting to install...${end_str}"
    sleep 2
    if [ -n "$win_chk" ]; then
        make > /dev/null 2>&1 && make install > /dev/null
    else
        sudo make > /dev/null 2>&1 && sudo make install > /dev/null
    fi
    if [ $? -eq 0 ]; then
        echo "${info}Ctags installed successfully installed to $( which ctags )${end_str}"
    else
        echo "${warn}Ctags failed to install"
        echo -n "Continue with setup? [y|n]:  "
        read pass
        if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
            continue
        else
            exit 1
        fi
    fi
else
    echo "${warn}Ctags failed to configure. Tagbar will not work until ctags is configured correctly${end_str}"
    echo -n "Continue with setup? [y|n]:  "
    read pass
    if [ "$pass" = 'y' -o "$pass" = 'Y' ]; then
        continue
    else
        exit 2
    fi
fi

echo "${info}Next steps: set the terminal font to a powerline font${end_str}"
echo "${warn}Done!${end_str}"

exit 0
