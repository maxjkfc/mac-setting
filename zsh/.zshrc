# Enabl Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
# Path Part
	export HOMEBREWOPT="/opt/homebrew"
# Golang setting
	export GOROOT="$HOMEBREWOPT/opt/go/libexec"
	export GOPATH="$HOME/go"
  export GOPROXY=https://proxy.golang.org
  export OPENJAVA_PATH="$HOMEBREWOPT/opt/openjdk/bin"
	# export coreutils path
	export COREPATH="$HOMEBREWOPT/opt/coreutils/libexec/gnubin"
	export MANPATH="$HOMEBREWOPT/opt/coreutils/libexec/gnuman"
	export ZPLUG_HOME="$HOMEBREWOPT/opt/zplug"
  export GCLOUD_HOME="$HOME/code/google-cloud-sdk"
	export PATH="$PATH:$GOROOT/bin:$GOPATH/bin:$COREPATH:$ZPLUG_HOME:$GCLOUD_HOME/bin:~/.local/bin:$OPENJAVA_PATH:$PODMAN_COMPOSE"

# set ulimit
  # sudo launchctl limit maxfiles 65536 200000

  # Theme P10K
	source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	# quiet warning message from p10k
	typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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
	echo    ' ███╗   ███╗ █████╗ ██╗  ██╗  '
	echo    ' ████╗ ████║██╔══██╗╚██╗██╔╝  '
	echo    ' ██╔████╔██║███████║ ╚███╔╝   '
	echo    ' ██║╚██╔╝██║██╔══██║ ██╔██╗   '
	echo    ' ██║ ╚═╝ ██║██║  ██║██╔╝ ██╗  '
	echo    ' ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  '

# Alias Part
	alias zshconfig="nvim ~/.zshrc"
	# Enhance ls tools
	alias l='eza -lbF --git'
	alias ls='eza'
	alias la='eza -lbhHigUmuSa --git --color-scale --icons'
	alias lx='eza -lbhHigUmuSa@ --git --color-scale --icons'
	alias lt='eza --tree --level=5 --color-scale --icons'
	alias ll='eza -lbF --git'

	alias mv='mv -i'
	alias cp='cp'
	alias v='nvim'
	alias vdiff='nvim -d'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

	# tools path
	alias mtr=' sudo mtr'
	alias git='$HOMEBREWOPT/bin/git'
	alias cat='bat' 
	alias curl='$HOMEBREWOPT/opt/curl/bin/curl'
	alias sed="gsed" 
    # alias kubectl='$GCLOUD_HOME/bin/kubectl'

	# zsh part 
	alias -s sh="sh "
	alias -s go="go run "
	alias -s zip="unzip"
	alias -s gz="tar -xzvf"
	alias -s tgz="tar -xzvf"
	alias -s bz2="tar -xjvf"

# Thirdly Tools
	# Google Cloud SDK
	# The next line updates PATH for the Google Cloud SDK.
	if [ -f "$HOME/code/google-cloud-sdk/path.zsh.inc" ]; then 
		. "$HOME/code/google-cloud-sdk/path.zsh.inc"; 
	fi

	# The next line enables shell command completion for gcloud.
	if [ -f "$HOME/code/google-cloud-sdk/completion.zsh.inc" ]; then 
		. "$HOME/code/google-cloud-sdk/completion.zsh.inc"; 
	fi
  export USE_GKE_GCLOUD_AUTH_PLUGIN=true


	# FZF
	# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  # Set up fzf key bindings and fuzzy completion
  source <(fzf --zsh)

	export FZF_DEFAULT_COMMAND='fd  --type file --hidden --follow  --exclude .git --layout=reversed --color=always'

  export FZF_DEFAULT_OPTS=" \
    --height 40% --layout=reverse --border --ansi \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


	export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
                  echo {} is a binary file ||
                  (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500"'

	export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

	export FZF_TMUX=1
	export FZF_TMUX_HEIGHT=40
	# Use fd (https://github.com/sharkdp/fd) instead of the default find
	# command for listing path candidates.
	# - The first argument to the function ($1) is the base path to start traversal
	# - See the source code (completion.{bash,zsh}) for the details.
	_fzf_compgen_path() {
	  fd --hidden --follow --exclude ".git" . "$1"
	}

	# Use fd to generate the list for directory completion
	_fzf_compgen_dir() {
	  fd --type d --hidden --follow --exclude ".git" . "$1"
	}

  _fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

	# Iterm2 Plugin
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Customer Shell
	# 	
	[[ ! -f $HOME/.zshshell ]] || source $HOME/.zshshell

# ZPlug 
    #   
	source "$ZPLUG_HOME/init.zsh"
	setopt prompt_subst # Make sure prompt is able to be generated properly.

	zplug "b4b4r07/enhancd", use:init.sh
	zplug "b4b4r07/emoji-cli"
	zplug "wfxr/forgit"
	zplug "zsh-users/zsh-syntax-highlighting", defer:2
	zplug "zsh-users/zsh-autosuggestions"
  	zplug "chitoku-k/fzf-zsh-completions"
	zplug "zsh-users/zsh-completions"
	zplug "zsh-users/zsh-history-substring-search"
	zplug "supercrabtree/k"

	# zplug check returns true if all packages are installed
	# Therefore, when it returns false, run zplug install
	if ! zplug check; then
	    zplug install
	fi

	# source plugins and add commands to the PATH
	zplug load

	# zplug check returns true if the given repository exists
	if zplug check b4b4r07/enhancd; then
	    # setting if enhancd is available
	    export ENHANCD_FILTER=fzf-tmux
	fi


# now load zsh-syntax-highlighting plugin
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Completion
 	
	fpath=(
		~/.zsh/completion 
		$HOMEBREWOPT/share/zsh/site-functions
		$fpath 
	)
	autoload -Uz compinit && compinit -i
	# Kubectl completion
	# source <(kubectl completion zsh)


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maxjkfc/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/maxjkfc/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/maxjkfc/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/maxjkfc/google-cloud-sdk/completion.zsh.inc'; fi
