# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/kenneth/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ken"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# From bashrc {{{
# Aliases {{{
alias cpu-temp='sensors | grep Core'
alias fuck='sudo $(history -p \!\!)'
alias local-server='python -m SimpleHTTPServer'
alias yor='rlwrap -c ~/Documents/phd/relocate/bin/yorick'
alias py='python3 -i <(echo "import numpy as np")'
alias sl='ls'
alias rr='ranger'
alias cd..='cd ..'

alias connectCollegeVPN='nmcli con up id College'
alias disconnectCollegeVPN='nmcli con down id College'
alias connectWorkVPN='nmcli con up id Work'
alias disconnectWorkVPN='nmcli con down id Work'

alias pingg='ping 8.8.8.8'
alias wifiOn='rfkill unblock wifi'
alias wifiOff='rfkill block wifi'
# Not worth movinf to function section
function toggleWifi {
    wifiOff
    sleep 1
    wifiOn
}

# Enable/disable touchpad tap functionality
alias tapOn='synclient TapButton1=1 && synclient TapButton2=3 && synclient TapButton3=2'
alias tapOff='synclient TapButton1=0 && synclient TapButton2=0 && synclient TapButton3=0'
alias midClick='synclient ClickFinger3=2'

# Look busy
alias busy="cat /dev/urandom | hexdump -C | grep \"ca fe\"" 

alias preview="fzf --preview 'bat --color \"always\" {}'"

alias settings="env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

	# Git Aliases {{{
	alias gclone="git clone"
	#}}}

#}}}
# Functions {{{
# Count words in pdf
PdfWordCount() {
    pdftotext $1 - | tr -d '.' | wc -w
}

# Solve anagrams
Countdown() {
    egrep "^[$1]{$2}$" /usr/share/dict/words | egrep -v "(.).*\1"
}

# mkdir && cd
mkcd() {
    mkdir "$1"
    cd "$1"
}

cdr() {
  cd "$(realpath $1)"
}
compdef _files cdr

cvim() {
	cp "$1" "$2"
	vim "$2"
}

bkp() { cp "$1"{,.bak};}

youtube_mp3() {
	youtube-dl --extract-audio --audio-format mp3 "$1"
}

codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax | set bt=nofile" "$@"
}
#}}}
# Path {{{
export PATH=/home/kenneth/bin:/home/kenneth/.local/bin:$PATH
# Intel compilers
#source /opt/intel/composer_xe_2015/bin/compilervars.sh intel64
#source /opt/intel/parallel_studio_xe_2016.3.067/psxevars.sh intel64 > /dev/null

# Go
#export PATH=/usr/local/go/bin:$PATH
export GOPATH=/home/kenneth/Documents/go
export PATH=$PATH:$GOPATH/bin

# Google appengine
#export PATH=$PATH:/home/kenneth/Documents/AppEngine/go_appengine

#Ruby
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

#Cuda
#export PATH=$PATH:/usr/local/cuda/bin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

# Jupyter
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

# Julia
#export PATH=$PATH:/home/kenneth/Documents/julia/julia-1.0.0/bin
#}}}

# Cling
#export PATH=$PATH:/home/kenneth/Documents/c++/cling/cling_2019-01-23_ubuntu18/bin

# Source Scripts {{{
# FZF
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

#. /home/kenneth/torch/install/bin/torch-activate
#}}}
#}}}

export DOTNET_CLI_TELEMETRY_OPTOUT=1

unsetopt share_history
stty -ixon

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kenneth/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kenneth/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kenneth/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kenneth/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
