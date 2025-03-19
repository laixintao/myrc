# uncomment this line to perf, command is `zprof`
# zmodload zsh/zprof


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

ZSH_CUSTOM=~/Programs/myrc/zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python z)


# pyenv-virtualenv
# https://github.com/pyenv/pyenv-virtualenv
export VIRTUALENV_VERSION=20.0.8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export ZSH_PYENV_LAZY_VIRTUALENV=1

# load pyenv only when first time call pyenv
# code from:
# https://github.com/davidparsson/zsh-pyenv-lazy

# Try to find pyenv, if it's not on the path
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
if ! type pyenv > /dev/null && [ -f "${PYENV_ROOT}/bin/pyenv" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

# Lazy load pyenv
if type pyenv > /dev/null; then
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
        pyenv $@
    }
fi


# User configuration
source $ZSH/oh-my-zsh.sh

unalias "1"
unalias "2"
unalias "3"
unalias "4"
unalias "5"
unalias "6"
unalias "7"
unalias "8"
unalias "9"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi


# Compilation flags
export ARCHFLAGS="-arch x86_64"

DEFAULT_USER="laixintao"


export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
# GNU coreutils path
# opam configuration
test -r /Users/laixintao/.opam/opam-init/init.zsh && . /Users/laixintao/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# Wasmer
export WASMER_DIR="/Users/laixintao/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-15.0.2.jdk/Contents/Home/

# don't check for new mail
MAILCHECK=0

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
if [ -f ~/.my_alias ]; then
    . ~/.my_alias
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

# press CTRL+X+E can open vim quickly
export EDITOR=vim

# choose one from fzf, autin
# fzf settings
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS='--height 40% --reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autin shell history search
# eval "$(atuin init zsh)"

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
# bat conf
export BAT_CONFIG_PATH="~/.bat.conf"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

# for compilers
export ARCHFLAGS="-arch arm64"

export LDFLAGS="-L/usr/local/opt/readline/lib"
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/libpcap/bin"
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/sqlite/lib"
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/libpcap/lib"

export CPPFLAGS="-I/usr/local/opt/readline/include"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/sqlite/include"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/libpcap/include"

export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/sqlite/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/libpcap/lib/pkgconfig"

export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl@1.1/lib/pkgconfig

# -------------------
# My own functions

# https://github.com/lf94/peek-for-tmux
peek() { tmux split-window -p 33 "$EDITOR" "$@" || exit; }

# vscode
# Then from Terminal you can type:
#
# code – opens Visual Studio Code
# code . – opens current directory in Visual Studio Code
# code somefile – opens somefile in Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# ______     _   _     
# | ___ \   | | | |    
# | |_/ /_ _| |_| |__  
# |  __/ _` | __| '_ \ 
# | | | (_| | |_| | | |
# \_|  \__,_|\__|_| |_|
# See:
# https://superuser.com/a/598924/986660
# To test you $PATH:
# echo "$PATH" | tr ':' '\n'
typeset -U path  # keep path alwasy unique, tmux will reload zshrc

path=(
    $HOME/.local/bin                         # pipx
    /Users/xintao.lai/Library/Python/3.8/bin/ # in system
    /usr/local/var/pyenv/shims               # pyenv
    /usr/local/opt/sqlite/bin
    /usr/local/opt/openssl@1.1/bin
    /usr/local/opt/curl/bin                  # curl in brew
    /usr/local/opt/ruby/bin                  # ruby
    /usr/local/opt/coreutils/libexec/gnubin  # Gnu coreutils
    /usr/local/opt/libpcap/bin
    /opt/homebrew/opt/coreutils/libexec/gnubin
    /usr/local/Cellar/mysql/8.0.18/bin       # mysql bins
    /usr/local/opt/protobuf@3/bin
    /usr/local/opt/texinfo/bin
    /usr/local/opt/bison/bin
    /usr/local/opt/llvm/bin
    /opt/homebrew/bin
    $HOME/bin
    $HOME/shopee-bin
    $GOPATH/bin                              # golang
    $GOROOT/bin
    /Users/laixintao/.cargo/bin              # cargo
    /usr/local/texlive/2020basic/bin/x86_64-darwin/ #latex
    /usr/local/sbin                          # for sudo commands
    $path
  )
export PATH=":$PATH"


# Proxy
# export http_proxy="http://127.0.0.1:7890"
# export all_proxy="http://127.0.0.1:7890"

function replace(){
    gsed -i"" "s#$1#$2#g" $(rg --hidden $1 -l)
}

function delete-lines(){
    gsed -i"" "/$1/d" $(rg --hidden $1 -l)
}

unset __PYVENV_LAUNCHER__
export ANSIBLE_NOCOWS=1
export CC=gcc

# hook direnv
# https://github.com/direnv/direnv/blob/master/docs/hook.md
eval "$(direnv hook zsh)"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# settings for gpg key
# https://stackoverflow.com/questions/57591432/gpg-signing-failed-inappropriate-ioctl-for-device-on-macos-with-maven

GPG_TTY=$(tty)
export GPG_TTY

