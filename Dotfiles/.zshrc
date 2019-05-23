# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="lambdax"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

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


# added by Anaconda3 installer
# export PATH="$PATH"

#################### my settings #############################
# vi-mode support
VIMODE='- I -'
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/- N -}/(main|viins)/- I -}"
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

RPROMPT='%{$fg[green]%}${VIMODE}%{$reset_color%}'

# my proxy settings
alias proxy='export all_proxy=socks5://127.0.0.1:1080; export http_proxy=http://127.0.0.1:1080; export https_proxy=http://127.0.0.1:1080 '
alias unproxy='unset all_proxy; unset http_proxy; unset https_proxy'

export CLASSPATH=$CLASSPATH:~/algs4/algs4.jar
alias jalgs4c=javac-algs4
alias jalgs4=java-algs4
alias jalgs4r='run() {javac-algs4 $1.java; java-algs4 $1 $2}; run'

alias javar='javaRun() {javac $1.java; java $1 $2}; javaRun'
alias youtube='youtube-dl --proxy socks5://127.0.0.1:1080/'
export GOPATH=/home/ash/Codes/gocode
export PATH=$PATH:$GOPATH/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# thefuck configuration
eval $(thefuck --alias)

# add my tool scripts
export PATH=/home/ash/Codes/Scripts/etc:/home/ash/Codes/Scripts/AcrossGFW:$PATH
alias vpsclone="vpsclone.sh 120.79.37.96 ash wemustknow"
alias vpsget="vpsget.sh 120.79.37.96 ash wemustknow"

# pipenv settings
export PIPENV_VENV_IN_PROJECT=1

# exa settings
alias ea="exa -la"
alias el="exa -l"
alias pc="proxychains4"
# hub settings
eval "$(hub alias -s)"
# nvim alias
alias nv="nvim"
