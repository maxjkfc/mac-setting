# Example aliases
alias zshconfig="nvim ~/.zshrc"
#
#alias la='ls -laG '
#alias ll='ls -lahG '
#alias ls='ls -G '
#alias lz='ls -ZG '
alias l='exa -lbF --git'
alias ls='exa'
alias la='exa -lbhHigUmuSa --git --color-scale --icons'
alias lx='exa -lbhHigUmuSa@ --git --color-scale --icons'
alias lt='exa --tree --level=4 --color-scale --icons'
alias ll='exa -lbF --git'
alias mv='mv -i'
alias cp='cp -i'
alias v='nvim'
alias vdiff='nvim -d'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# tools path
alias mtr=' sudo /usr/local/sbin/mtr'
alias vim='/usr/local/bin/vim'
alias git='/usr/local/bin/git'
alias cat='ccat'
alias curl='/usr/local/opt/curl/bin/curl'
alias sqlite3='/usr/local/opt/sqlite3/bin/sqlite3'
alias sed="gsed"

# 
alias -s sh="sh "
alias -s go="go run "
alias -s zip="unzip"
alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s bz2="tar -xjvf"
