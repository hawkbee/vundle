#!/usr/bin/sh

if ! git version > /dev/null 2>&1
then
	echo "git version control does not exsit"
	exit 1
fi

if [ ! -d bundle ]; then
	mkdir bundle
fi

if [ ! -d bundle/vundle/ ]; then
	git clone https://github.com/gmarik/vundle.git
fi

if [ ! -d ~/.bash_it ]; then
	git clone https://github.com/revans/bash-it.git ~/.bash_it
	~/.bash_it/install.sh
fi

if [ ! -d ~/.oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi

cd

[ ! -f .vimrc ] && ln -s .vim/vimrc .vimrc
[ ! -f .ctags ] && ln -s .vim/ctags .ctags
[ ! -f .hgrc ]  && ln -s .vim/hgrc .hgrc
[ ! -f .gitconfig ] && ln -s .vim/gitconfig .gitconfig
[ ! -f .tmux.conf ] && ln -s .vim/tmux.conf .tmux.conf
[ ! -f .dircolors ] && ln -s .vim/dircolors.256dark .dircolors
[ ! -f .bash_profile ] && ln -s .vim/bash_profile .bash_profile

echo "Setup development environment success"
