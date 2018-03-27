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
#ZSH_THEME="norm"
#ZSH_THEME="essembeh"
ZSH_THEME="suvash"

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
plugins=(virtualenvwrapper sudo extract z tmux git git-extras gitignore osx brew brew-cask nvm emacs)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

which dircolors >&- && eval `dircolors ~/.vim/dircolors.256dark`
# alias ls="ls -F --color=auto"
# alias emacs="emacs -nw"
