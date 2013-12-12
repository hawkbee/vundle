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

cd

[ ! -f .vimrc ] && ln -s .vim/vimrc .vimrc
[ ! -f .ctags ] && ln -s .vim/ctags .ctags
[ ! -f .hgrc ]  && ln -s .vim/hgrc .hgrc
[ ! -f .gitconfig ] && ln -s .vim/gitconfig .gitconfig
[ ! -f .tmux.conf ] && ln -s .vim/tmux.conf .tmux.conf

echo "Setup vim environment success"
