# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
# 注意：環境變數已移至 ~/.zshenv 以符合 zsh 最佳實踐
# ~/.zshenv 會在所有 zsh 實例中載入，包括非互動式和腳本執行

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

# Default Settings
ZSH_DISABLE_COMPFIX="true"
ZSH_THEME="powerlevel10k"
setopt prompt_subst

# Terminal Settings
set -o emacs

# ============================================================================
# POWERLEVEL10K THEME
# ============================================================================

# Load theme
if [[ -f "$HOMEBREWOPT/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source "$HOMEBREWOPT/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Load P10K configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# P10K Settings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens'

# ============================================================================
# ALIASES
# ============================================================================

# Configuration
alias zshconfig="nvim ~/.zshrc"

# Enhanced ls (eza)
alias l='eza -lbF --git'
alias ls='eza'
alias la='eza -lbhHigUmuSa --git --color-scale --icons'
alias lx='eza -lbhHigUmuSa@ --git --color-scale --icons'
alias lt='eza --tree --level=5 --color-scale --icons'
alias ll='eza -lbF --git'

# File Operations
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# Editor
alias v='nvim'
alias vdiff='nvim -d'

# Search
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Tools
alias cat='bat'
alias mtr='sudo mtr'
alias git='$HOMEBREWOPT/bin/git'
alias curl='$HOMEBREWOPT/opt/curl/bin/curl'
alias sed="gsed"

# File Extensions
alias -s sh="sh"
alias -s go="go run"
alias -s zip="unzip"
alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s bz2="tar -xjvf"

# ============================================================================
# FZF CONFIGURATION
# ============================================================================

# Load FZF
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# FZF Settings
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git'
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

# FZF Functions
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

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

# ============================================================================
# ZPLUG PLUGIN MANAGER
# ============================================================================

if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
    source "$ZPLUG_HOME/init.zsh"

    # Essential Plugins
    zplug "b4b4r07/enhancd", use:init.sh
    zplug "wfxr/forgit"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-autosuggestions"
    zplug "chitoku-k/fzf-zsh-completions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "supercrabtree/k"

    # Optional Plugins (可根據需要啟用)
    # zplug "b4b4r07/emoji-cli"

    # Install plugins if not installed
    if ! zplug check; then
        zplug install
    fi

    # Load plugins
    zplug load

    # Plugin Settings
    if zplug check b4b4r07/enhancd; then
        export ENHANCD_FILTER=fzf-tmux
    fi
fi

# ============================================================================
# SYNTAX HIGHLIGHTING THEME
# ============================================================================

if [[ -f ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
fi

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================

# Completion paths
fpath=(
    ~/.zsh/completion
    $HOMEBREWOPT/share/zsh/site-functions
    $fpath
)

# Initialize completion system
autoload -Uz compinit && compinit -i

# ============================================================================
# VERSION MANAGERS
# ============================================================================

# Node.js Version Manager (fnm)
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# ============================================================================
# INTEGRATIONS
# ============================================================================

# iTerm2 Integration
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# Custom Shell Functions
[[ -f "$HOME/.zshshell" ]] && source "$HOME/.zshshell"

# Google Cloud SDK
[[ -f '/Users/maxjkfc/google-cloud-sdk/path.zsh.inc' ]] && source '/Users/maxjkfc/google-cloud-sdk/path.zsh.inc'
[[ -f '/Users/maxjkfc/google-cloud-sdk/completion.zsh.inc' ]] && source '/Users/maxjkfc/google-cloud-sdk/completion.zsh.inc'

# Bun completions
[[ -s "/Users/maxjkfc/.bun/_bun" ]] && source "/Users/maxjkfc/.bun/_bun"

# Kubectl completion (可根據需要啟用)
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

# ============================================================================
# WELCOME MESSAGE (可選，建議移除以提升啟動速度)
# ============================================================================

# 如果您想保留歡迎訊息，可以取消註解以下內容
# show_welcome() {
#     echo $fg[blue]
#     echo    ' ███╗   ███╗ █████╗ ██╗  ██╗  '
#     echo    ' ████╗ ████║██╔══██╗╚██╗██╔╝  '
#     echo    ' ██╔████╔██║███████║ ╚███╔╝   '
#     echo    ' ██║╚██╔╝██║██╔══██║ ██╔██╗   '
#     echo    ' ██║ ╚═╝ ██║██║  ██║██╔╝ ██╗  '
#     echo    ' ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  '
# }
# show_welcome
