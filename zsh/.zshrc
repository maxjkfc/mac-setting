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
# HISTORY
# ============================================================================
# 明確版控 history 設定（先前值來自 plugin/系統預設，過小且不可控）
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000          # 記憶體內保留的行數
SAVEHIST=50000          # 寫入 HISTFILE 的行數
setopt SHARE_HISTORY        # 多個 session 即時共享 history
setopt HIST_IGNORE_DUPS     # 不記錄與前一筆相同的指令
setopt HIST_IGNORE_ALL_DUPS # 新指令重複時刪除舊的同名項
setopt HIST_IGNORE_SPACE    # 以空白開頭的指令不入 history（敏感操作用）
setopt HIST_REDUCE_BLANKS   # 寫入前壓掉多餘空白
setopt HIST_VERIFY          # 展開 history 後先顯示、不直接執行

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

# 開發環境優化設定
# 顯示 Git 狀態和分支資訊（對開發很重要）
typeset -g POWERLEVEL9K_VCS_SHOW_SUBMODULES=false
typeset -g POWERLEVEL9K_VCS_HIDE_TAGS=false

# 目錄顯示優化（對 GOPATH 導航有幫助）
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=''

# 命令執行時間顯示（對性能調優有幫助）
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3

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
alias ll='eza -lbhHigUmua --git'

# File Operations
alias mv='mv -i'
alias cp='cp -i'
# rm 的定義集中在下方「安全刪除」區塊（trash），此處不重複

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
alias sed="gsed"
# 註：git / curl 改由 PATH 解析（見 .zshenv 的 add_to_path），不再用絕對路徑 alias

# File Extensions
alias -s sh="sh"
alias -s go="go run"
alias -s zip="unzip"
alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s bz2="tar -xjvf"

# Claude code
alias  cc="CLAUDE_CODE_NO_FLICKER=1 claude"
alias  ccr="CLAUDE_CODE_NO_FLICKER=1 claude remote-control"
alias  ccm='cd "$OBSIDIAN_HOME/max-agent" && CLAUDE_CODE_NO_FLICKER=1 claude'
alias  ccw='cd "$OBSIDIAN_HOME/max-wiki" && CLAUDE_CODE_NO_FLICKER=1 claude'

# ═══════════════════════════════════════════════════════════════
# 安全刪除 - rm 改用垃圾桶（可還原）
# ═══════════════════════════════════════════════════════════════
alias rm='trash'
# 真的要永久刪除時用 rm! 或 /bin/rm
alias rm!='/bin/rm'

# ============================================================================
# FZF CONFIGURATION
# ============================================================================

# Load FZF
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# FZF Settings (環境變數已移至 ~/.zshenv)

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

fi

# ============================================================================
# HISTORY SUBSTRING SEARCH KEYBINDINGS
# ============================================================================
# 必須在 zplug load 之後綁定，否則 widget 尚未定義（先前載入但未綁鍵 = 無作用）
if (( $+widgets[history-substring-search-up] )); then
    bindkey '^[[A' history-substring-search-up      # ↑
    bindkey '^[[B' history-substring-search-down    # ↓
    bindkey '^P'   history-substring-search-up      # emacs 慣用
    bindkey '^N'   history-substring-search-down
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

# Initialize completion system (with 24h cache to speed up startup)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
else
    compinit -C -i
fi

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

# Zoxide (智能目錄跳轉)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# iTerm2 Integration
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# Custom Shell Functions
[[ -f "$HOME/.zshshell" ]] && source "$HOME/.zshshell"

# Bun completions
[[ -s "/Users/maxjkfc/.bun/_bun" ]] && source "/Users/maxjkfc/.bun/_bun"

# Kubectl completion (cached to avoid slow startup)
if command -v kubectl >/dev/null 2>&1; then
    local _kube_cache="${HOME}/.cache/kubectl_completion.zsh"
    if [[ ! -f $_kube_cache || $(command -v kubectl) -nt $_kube_cache ]]; then
        mkdir -p "${HOME}/.cache"
        kubectl completion zsh > $_kube_cache
    fi
    source $_kube_cache
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

# ============================================================================
# LOCAL CONFIGURATION
# ============================================================================

# Load local configuration if it exists
# 用於存放敏感資訊如 API keys、個人設定等，不會同步到 GitHub
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
