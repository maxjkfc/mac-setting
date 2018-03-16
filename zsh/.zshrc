# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mymuse"

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git golang docker docker-compose zsh-autosuggestions  zsh-syntax-highlighting zsh-completions)

# User configuration
#source ~/.bash_profile
# Golang setting
export GOROOT="/usr/local/opt/go/libexec"
export GOPATH="$HOME/go"


# export coreutils path
export COREPATH="/usr/local/opt/coreutils/libexec/gnubin"
# PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOROOT/bin:$GOPATH/bin:$COREPATH"
#export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOROOT/bin:$GOPATH/bin:~/git/shell"

# export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export IP=$( ifconfig en0 |grep "inet\ " | awk {'print $2'})


source $ZSH/oh-my-zsh.sh


# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export Jimmy_SSH_KEY_PATH="~/.ssh/jimmy"
export Max_SSH_KEY_PATH="~/.ssh/maxgit"
export HOMEBREW_GITHUB_API_TOKEN="e252a881985d37f3a046696bc782809d1bc2117b"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
#
#
#alias la='ls -laG --color'
#alias ll='ls -lahG --color'
#alias ls='ls -G --color'
#alias lz='ls -ZG --color'
#
alias la='ls -laG '
alias ll='ls -lahG '
alias ls='ls -G'
alias lz='ls -ZG '
alias mv='mv -i'
alias cp='cp -i'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mtr=' sudo /usr/local/sbin/mtr'
alias vim='/usr/local/bin/vim'
alias git='/usr/local/bin/git'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias go='colorgo'

alias curl='/usr/local/opt/curl/bin/curl'
alias sqlite3='/usr/local/opt/sqlite3/bin/sqlite3'
alias sed="/usr/local/Cellar/gnu-sed/4.4/bin/sed"

# Workplace
alias gow='cd ~'
alias gowg='cd ~/git'
alias gomax='cd ~/go/src/github.com/maxjkfc'
alias gopj='cd ~/go/src/gitlab.com/50master'

#
alias -s sh="sh "
alias -s go="go run "

# Cypress Workplace
alias cy='cd ~/go/src/Cypress'
alias cym='cd ~/go/src/CypressModule'
alias cys='cd ~/go/src/CypressSDK'
alias cyt='cd ~/go/src/CypressTools'
alias cyd='cd ~/go/src/CypressDeploy'
# docker-machine
alias dm='docker-machine'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
