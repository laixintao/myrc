# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell_laixintao"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
 DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_CUSTOM=/Users/laixintao/Program/myrc/zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python virtualenv z osx sudo extract)


# User configuration

# export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/laixintao/bin/:/Users/laixintao/bin/FDK/Tools/osx"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

DEFAULT_USER="laixintao"

# laixintao setting
export PATH="$PATH:$HOME/bin"
# postgres path
export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
# Go-lang path
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# don't check for new mail
MAILCHECK=0

export PATH="$HOME/.yarn/bin:$PATH"

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.common_alias ]; then
    . ~/.common_alias
fi
# sensitive_alias
if [ -f ~/.sensitive_alias ]; then
    . ~/.sensitive_alias
fi

# sensitive url and token
# Do not track by git
if [ -f ~/.secret ]; then
    . ~/.secret
fi

# pyenv
export PATH="/Users/laixintao/.pyenv:$PATH"
export PYENV_ROOT=/usr/local/var/pyenv
eval "$(pyenv init -)"

# pipsi
# https://github.com/mitsuhiko/pipsi
export PATH=$HOME/.local/bin:/Users/laixintao/.local/venvs/pipsi/bin:$PATH
# press CTRL+X+E can open vim quickly
export EDITOR=vim

# brew install z.sh
# https://github.com/rupa/z
. /usr/local/etc/profile.d/z.sh


# fzf settings
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS='--height 40% --reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --------------------------------
# Install awesome tools!
# 1. brew install z
# 2. brew install fpp
# 3. brew install autojump *
# 4. brew install fd
# 5. brew install fzf

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# tmuxp
export DISABLE_AUTO_TITLE='true'

# vscode
# Then from Terminal you can type:

# code – opens Visual Studio Code
# code . – opens current directory in Visual Studio Code
# code somefile – opens somefile in Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}


#cargo
export PATH="/Users/laixintao/.cargo/bin:$PATH"

# opam configuration
test -r /Users/laixintao/.opam/opam-init/init.zsh && . /Users/laixintao/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# -------------------
# My own functions

# https://github.com/lf94/peek-for-tmux
peek() { tmux split-window -p 33 "$EDITOR" "$@" || exit; }
