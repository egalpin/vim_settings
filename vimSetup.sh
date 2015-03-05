#/bin/sh
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
if [ `whoami` = 'root' ] || [ -n "$win_chk" ]; then
    if [ "$(pwd)" != "$HOME" ]; then
        # Save any existing vim configs
        [ -d ~/.vim ] && mv ~/.vim ~/.vim.bkp
        [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bkp
        [ -d ~/fonts ] && mv ~/fonts ~/fonts.bkp
    fi

    echo "${info}Obtaining git submodules for additional Vim plugins${end_str}"
    git submodule update --init --recursive
    if [ $? -eq 0 ]; then
        echo "${info}Submodules obtained successfully${end_str}"
        if [ "$(pwd)" != "$HOME" ]; then
            # Copy new Vim configs
            cp -rf .vim ~/.vim
            cp -f .vimrc ~/.vimrc
            cp -rf fonts ~/fonts
        fi
    else
        echo "${warn}Failed to obtain git submodules${end_str}"
        exit 3
    fi
    echo "${info}Configuring and installing ~/.vim/ctags-5.8 for Tagbar${end_str}"
    cd ~/.vim/ctags_src
    tar xzf ctags-5.8.tar.gz
    cd ctags-5.8
    ./configure > /dev/null
    if [ $? -eq 0 ]; then
        echo "${info}Ctags configured successfully, attempting to install...${end_str}"
        sleep 2
        make > /dev/null 2>&1 && make install > /dev/null
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
else
    echo "Must run as root: '${info}sudo sh vimSetup.sh'${end_str}"
    exit 4
fi

exit 0
