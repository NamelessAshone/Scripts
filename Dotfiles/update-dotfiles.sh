#!/usr/bin/env bash
REPO_PATH=$(find ~ -type d -name "Scripts")
REMOTE_VIMRC=$REPO_PATH/Dotfiles/init.vim
REMOTE_ZSHRC=$REPO_PATH/Dotfiles/zshrc
MY_THEME=$REPO_PATH/Dotfiles/lambdax.zsh-theme


if [ -L ~/.zshrc ] || [ -L ~/.config/nvim/init.vim ]
then
    echo "Do nothing, .zhsrc and init.vim are symbolic links"
else
	if [ ! -d ~/.config/nvim ]
	then
		mkdir -p ~/.config/nvim
	fi

    printf '%s\n' "$(tput setaf 1)Changes on $(tput sgr0).zshrc: "
    diff -u $REMOTE_ZSHRC ~/.zshrc

    printf '%s\n' "$(tput setaf 1)Changes on $(tput sgr0).init.vim: "
    diff -u $REMOTE_VIMRC ~/.config/nvim/init.vim

    cp $REMOTE_ZSHRC ~/.zshrc
    cp $REMOTE_VIMRC ~/.config/nvim/init.vim
fi

if [ ! -e ~/.oh-my-zsh/custom/lambdax.zsh ]
then
	printf '%s\n' "Theme 'lambdax.zsh' does not exit"
	printf '%s\n' "Coping theme file..."
	cp $MY_THEME ~/.oh-my-zsh/custom/themes/
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
then
	printf '%s\n' "Plugin 'zsh-syntax-highlighting' does not exit"
	printf '%s\n' "Install plugin..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
	printf '%s\n' "Plugin 'zsh-autosuggestions' does not exit"
	printf '%s\n' "Install plugin..."
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
