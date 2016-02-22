#!/bin/sh

if ! git version > /dev/null 2>&1
then
	echo "git version control does not exsit"
	exit 1
fi

if [ ! -d bundle ]; then
	mkdir bundle
fi

if [ ! -d bundle/vundle/ ]; then
	cd bundle && git clone https://github.com/gmarik/vundle.git
fi

cd

if [ ! -d ~/.bash_it ]; then
	while [[ true ]]; do
		read -p "Do you use bash(bash_it)?[Y/N]"
		case $REPLY in
		[yY])
			git clone https://github.com/hawkbee/bash-it.git ~/.bash_it
			~/.bash_it/install.sh
			break
			;;
		[nN])
			break
			;;
		*)
			echo "Please enter Y or N"
		esac
	done
fi

if [ ! -d ~/.oh-my-zsh ]; then
	while [[ true ]]; do
		read -p "Do you use zsh(oh-my-zsh)?[Y/N]"
		case $REPLY in
			[Yy])
				git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
				break
				;;
			[Nn])
				break
				;;
			*)
				echo "Please enter Y or N"
		esac
	done
fi

if [ ! -d ~/.emacs.d ]; then
	while [[ true ]]; do
		read -p "Do you use spacemacs?[Y/N]"
		case $REPLY in
			[Yy])
				git clone https://github.com/syl20bnr/spacemacs.git  ~/.emacs.d
				break
				;;
			[Nn])
				break
				;;
			*)
				echo "Please enter Y or N"
		esac
	done
fi
# link config file
cd

[ ! -f .quiltrc ] && ln -s .vim/quiltrc .quiltrc
[ ! -f .ctags ] && ln -s .vim/ctags .ctags
[ ! -f .hgrc ]  && ln -s .vim/hgrc .hgrc
[ ! -f .gitconfig ] && ln -s .vim/gitconfig .gitconfig
[ ! -f .tmux.conf ] && ln -s .vim/tmux.conf .tmux.conf
[ ! -f .dircolors ] && ln -s .vim/dircolors.256dark .dircolors
[ ! -f .bash_profile ] && ln -s .vim/bash_profile .bash_profile
[ ! -f .zshrc ] && ln -s .vim/zshrc .zshrc
[ ! -f .spacemacs ] && ln -s .vim/spacemacs .spacemacs
[ ! -f .tern-config ] && ln -s .vim/tern-config .tern-config
[ ! -f .ycm_extra_conf.py  ] && ln -s .vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py .ycm_extra_conf.py

echo "Setup development environment success"
