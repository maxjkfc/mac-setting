# ============================================================================
# ZSH ENVIRONMENT VARIABLES (.zshenv)
# ============================================================================
# 此檔案在所有 zsh 實例中都會載入（包括非互動式和腳本執行）
# 適合放置：環境變數、PATH 設定、基本系統配置
# 不適合放置：別名、函數、插件、主題等互動式功能

# ============================================================================
# BASIC SYSTEM ENVIRONMENT
# ============================================================================

# Language and Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default Editor and Browser
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='open'

# ============================================================================
# HOMEBREW CONFIGURATION
# ============================================================================

export HOMEBREWOPT="/opt/homebrew"

# ============================================================================
# DEVELOPMENT TOOLS PATHS
# ============================================================================

# Go Development
export GOROOT="$HOMEBREWOPT/opt/go/libexec"
export GOPATH="$HOME/go"
export GOPROXY=https://proxy.golang.org

# Java Development
export OPENJAVA_PATH="$HOMEBREWOPT/opt/openjdk/bin"

# Core Utilities
export COREPATH="$HOMEBREWOPT/opt/coreutils/libexec/gnubin"
export MANPATH="$HOMEBREWOPT/opt/coreutils/libexec/gnuman"

# ============================================================================
# CLOUD AND DEVOPS TOOLS
# ============================================================================

# Google Cloud SDK
export GCLOUD_HOME="$HOME/code/google-cloud-sdk"
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"

# Linkerd Service Mesh
export LINKERD_HOME="$HOME/.linkerd2"

# ============================================================================
# JAVASCRIPT/NODE.JS TOOLS
# ============================================================================

# Bun JavaScript Runtime
export BUN_INSTALL="$HOME/.bun"

# ============================================================================
# PLUGIN MANAGERS
# ============================================================================

# Zplug Plugin Manager
export ZPLUG_HOME="$HOMEBREWOPT/opt/zplug"

# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# 初始化 PATH，確保沒有重複項目
typeset -U path

# 條件式添加路徑到 PATH 的函數
add_to_path() {
    [[ -d "$1" ]] && path=("$1" $path)
}

# 按優先級順序添加路徑
add_to_path "$HOME/.local/bin"
add_to_path "$OPENJAVA_PATH"
add_to_path "$COREPATH"
add_to_path "$GOROOT/bin"
add_to_path "$GOPATH/bin"
add_to_path "$LINKERD_HOME/bin"
add_to_path "$BUN_INSTALL/bin"
add_to_path "$GCLOUD_HOME/bin"

# ============================================================================
# FZF CONFIGURATION
# ============================================================================

# FZF Default Command and Options
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=" \
    --height 40% --layout=reverse --border --ansi \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# FZF Control Options
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (bat --style=numbers --color=always {} ||
    highlight -O ansi -l {} ||
    coderay {} ||
    rougify {} ||
    cat {}) 2> /dev/null | head -500"'

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# FZF TMUX Integration
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=40

# ============================================================================
# TERMINAL CONFIGURATION
# ============================================================================

# Terminal Type (只在非 TMUX 環境下設置)
[[ $TMUX = "" ]] && export TERM="xterm-256color"
