# Path to your oh-my-zsh configuration.
[[ "$TERM" == "dumb" ]] && unsetopt zle && PS1='$ ' && return

ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="rkj"
#ZSH_THEME="gallois"
#ZSH_THEME="apple"
#ZSH_THEME="random"
ZSH_THEME="norm"
#ZSH_THEME="essembeh"
# ZSH_THEME="suvash"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colored-man-pages git git-extras gitignore nvm z)

source $ZSH/oh-my-zsh.sh

# which -s bat &>/dev/null && alias cat="bat"
which -s dircolors 2>&1 1>/dev/null && eval `dircolors ~/.vim/dircolors.256dark`
if which -s exa 2>&1 1>/dev/null && which -s bat 2>&1 1>/dev/null; then
  unalias ls
  alias ls="/usr/bin/exa --color=always"
  if ! type tree 2>&1 1>/dev/null ; then
    # alias tree='ls -T'
    alias tree='ls --tree'
  fi
fi

# alias emacs="emacs -nw"
# [ "${TERM/rxvt}" != "${TERM}" ] && export BAT_THEME="Monokai Extended Light" && alias ssh="TERM=xterm-256color ssh"
[ "${TERM/rxvt}" != "${TERM}" ] && alias ssh="TERM=xterm-256color ssh"
proxyon() {
  export http_proxy=socks5://127.0.0.1:1080
  export https_proxy=socks5://127.0.0.1:1080
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
