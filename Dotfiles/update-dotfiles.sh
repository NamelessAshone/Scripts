#!/usr/bin/env bash
REMOTE_VIMRC=/home/ash/Codes/Scripts/Dotfiles/init.vim
REMOTE_ZSHRC=/home/ash/Codes/Scripts/Dotfiles/zshrc

if [ -L ~/.zshrc ] || [ -L ~/.config/nvim/init.vim ]
then
    echo "Do nothing, beacause .zhsrc and init.vim are symbol links"
else
    printf '%s\n' "$(tput setaf 1)Changes on $(tput sgr0).zshrc: "
    git diff $REMOTE_ZSHRC ~/.zshrc
    printf '%s\n' "$(tput setaf 1)Changes on $(tput sgr0).init.vim: "
    git diff $REMOTE_VIMRC ~/.config/nvim/init.vim
    cp $REMOTE_ZSHRC ~/.zshrc
    cp $REMOTE_VIMRC ~/.config/nvim/init.vim
fi
