#!/usr/bin/env bash

# Helper function loading various enable-able files
function load_bash_it_files() {
  subdirectory="$1"
  enable_files="$2"
  if [[ $1 = "plugins" ]]; then
    ext="plugin"
  else
    ext="$1"
  fi
  if [ ! -d "${BASH_IT}/${subdirectory}/available" ]
  then
    return
  fi
  for enable_file in ${enable_files}
  do
    config_file="${BASH_IT}/${subdirectory}/available/${enable_file}.${ext}.bash"
    if [ -e "${config_file}" ]; then
      source $config_file
    fi
  done
}


# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export LANG=zh_CN.UTF-8

# Add rvm gems and nginx to the path
export PATH=$PATH:~/.gem/ruby/1.8/bin:/opt/nginx/sbin:~/node_modules/.bin:~/.linuxbrew/bin
export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='duru'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Set my editor and git editor
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

# Set the path nginx
export NGINX_PATH='/opt/nginx'

# Don't check mail when opening terminal.
unset MAILCHECK


# Change this to your console based IRC client of choice.

export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli

export TODO="t"

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

CONF_PLUGINS="base dirs hg ssh tmux todo"
CONF_ALIASES="general git gitsvn hg"
CONF_COMPLETION="bash-it defaults git git_flow ssh tmux"

# Load Bash It
source $BASH_IT/bash_it.sh

# Load configured aliases, completion, plugins
load_bash_it_files "aliases" "${CONF_ALIASES}"
load_bash_it_files "completion" "${CONF_COMPLETION}"
load_bash_it_files "plugins" "${CONF_PLUGINS}"

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh

which dircolors >&- && eval `dircolors ~/.vim/dircolors.256dark`

export PATH="$HOME/.cargo/bin:$PATH"
