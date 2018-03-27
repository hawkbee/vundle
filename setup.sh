#!/bin/sh

if ! git version >&-
then
  echo "git version control does not exsit"
  exit 1
fi

cd

if [ ! -d ~/.bash_it ]; then
  while [ true ]; do
    echo "Do you use bash(bash_it)?[Y/N]"
    read REPLY
    case $REPLY in
      [yY])
        git clone https://github.com/Bash-it/bash-it.git ~/.bash_it
        ~/.bash_it/install.sh
        break
        ;;
      [nN])
        break
        ;;
      *)
        echo "Please enter Y or N"
        ;;
    esac
  done
fi

if [ ! -d ~/.oh-my-zsh ]; then
  while [ true ]; do
    echo "Do you use bash(bash_it)?[Y/N]"
    read REPLY
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
  while [ true ]; do
    echo "Do you use bash(bash_it)?[Y/N]"
    read REPLY
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
mkdir -p .backups

F="bash_profile ctags gitconfig globalrc hgrc quiltrc spacemacs tern-config tmux.conf Xresources zshenv zshrc"
for f in $F
do
  if [ -f .$f ]; then
    mv -f .$f .backups/
  fi
  ln -sf .vim/$f .$f && echo "LINK .$f"
done
