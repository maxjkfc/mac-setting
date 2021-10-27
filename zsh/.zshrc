# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Defualt Setting Part
	ZSH_DISABLE_COMPFIX="true"
	# tmux color
	[[ $TMUX = "" ]] && export TERM="xterm-256color"
	# zsh theme
	ZSH_THEME="powerlevel10k"
	# You may need to manually set your language environment
	export LANG=en_US.UTF-8
	# default editor  
	export EDITOR='nvim'
	# set the default shell  options
	set -o emacs
	# set Title 
	echo $fg[blue]
	echo    '  ███████╗██╗   ██╗██████╗    ███╗   ███╗ █████╗ ██╗  ██╗  '
	echo    '  ══██╔══╝╚██╗ ██╔╝██╔══██╗   ████╗ ████║██╔══██╗╚██╗██╔╝  '
	echo    '    ██║    ╚████╔╝ ██████╔╝   ██╔████╔██║███████║ ╚███╔╝   '
	echo    '    ██║     ╚██╔╝  ██╔══██╗   ██║╚██╔╝██║██╔══██║ ██╔██╗   '
	echo    '    ██║      ██║   ██║  ██║██╗██║ ╚═╝ ██║██║  ██║██╔╝ ██╗  '
	echo    '     ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ '


# Path Part
	# Golang setting
	export GOROOT="/usr/local/opt/go/libexec"
	export GOPATH="$HOME/go"

	# export coreutils path
	export COREPATH="/usr/local/opt/coreutils/libexec/gnubin"
	# export MANPATH="/usr/local/man:$MANPATH"
	export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	export ZPLUGHOME="/usr/local/opt/zplug"
	export RUBYPATH="/usr/local/opt/ruby/bin"
	export SEDPATH="/opt/homebrew/opt/gnu-sed/libexec/gunbin"
	export PATH="$PATH:$GOROOT/bin:$GOPATH/bin:$COREPATH:$RUBYPATH:$SEDPATH"



# Alias Part
	alias zshconfig="nvim ~/.zshrc"
	# Enhance ls tools
	alias l='exa -lbF --git'
	alias ls='exa'
	alias la='exa -lbhHigUmuSa --git --color-scale --icons'
	alias lx='exa -lbhHigUmuSa@ --git --color-scale --icons'
	alias lt='exa --tree --level=5 --color-scale --icons'
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

	# zsh part 
	alias -s sh="sh "
	alias -s go="go run "
	alias -s zip="unzip"
	alias -s gz="tar -xzvf"
	alias -s tgz="tar -xzvf"
	alias -s bz2="tar -xjvf"


# Thirdly Tools
	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '/Users/maxjkfc/Downloads/google-cloud-sdk/path.zsh.inc' ]; then 
		. '/Users/maxjkfc/Downloads/google-cloud-sdk/path.zsh.inc'; 
	fi

	# The next line enables shell command completion for gcloud.
	if [ -f '/Users/maxjkfc/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then 
		. '/Users/maxjkfc/Downloads/google-cloud-sdk/completion.zsh.inc'; 
	fi
# Theme P10K
	source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
