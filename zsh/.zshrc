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

# 註：此設定未載入 Oh-My-Zsh 框架，p10k 主題是在下方手動 source，
# 因此 ZSH_THEME / ZSH_DISABLE_COMPFIX 這類 OMZ 專用變數不適用、已移除。
setopt prompt_subst
setopt auto_cd               # 輸入目錄名稱直接切換目錄
setopt auto_pushd            # cd 自動將目錄加入堆疊
setopt pushd_ignore_dups     # 目錄堆疊忽略重複項目
setopt pushd_silent          # pushd/popd 不輸出堆疊內容
setopt no_beep               # 關閉終端機嗶嗶聲
setopt interactive_comments  # 允許在互動式 shell 中使用 # 註解
setopt complete_in_word      # 游標在單詞中間也能進行補全

# Terminal Settings
set -o emacs

# ============================================================================
# HISTORY
# ============================================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000               # 記憶體內保留的行數
SAVEHIST=50000               # 寫入 HISTFILE 的行數
setopt SHARE_HISTORY         # 多個 session 即時共享 history
setopt EXTENDED_HISTORY      # 記錄指令執行時間戳與耗時
setopt HIST_EXPIRE_DUPS_FIRST # 歷史記錄滿時優先刪除最舊的重複項
setopt HIST_IGNORE_DUPS      # 不記錄與前一筆相同的指令
setopt HIST_IGNORE_ALL_DUPS  # 新指令重複時刪除舊的同名項
setopt HIST_FIND_NO_DUPS     # 歷史搜尋時不顯示重複項目
setopt HIST_IGNORE_SPACE     # 以空白開頭的指令不入 history（敏感操作用）
setopt HIST_SAVE_NO_DUPS     # 寫入歷史檔案時忽略重複項目
setopt HIST_REDUCE_BLANKS    # 寫入前壓掉多餘空白
setopt HIST_VERIFY           # 展開 history 後先顯示、不直接執行
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

# Configuration & Maintenance
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'
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

# Herdr
alias  hr="herdr"
alias  hrls="herdr session list"
alias  hrst="herdr status"
alias  hrwt="herdr worktree create"
alias  hrremote="herdr --remote"


# Oh My Pi (omp)
alias  ompc="omp --continue"
alias  ompp="omp -p"
alias  ompy="omp --approval-mode=yolo"
alias  ompu="omp usage"
alias  omps="omp stats"
alias  ompm-list="omp models"
alias  ompm='cd "$OBSIDIAN_HOME/max-agent" && omp'
alias  ompw='cd "$OBSIDIAN_HOME/max-wiki" && omp'

# Google Antigravity CLI (agy)
alias  agyc="agy -c"
alias  agyp="agy -p"
alias  agyy="agy --dangerously-skip-permissions"
alias  agym='cd "$OBSIDIAN_HOME/max-agent" && agy'
alias  agyw='cd "$OBSIDIAN_HOME/max-wiki" && agy'
# ═══════════════════════════════════════════════════════════════
# 安全刪除 - rm 改用垃圾桶（可還原）
# ═══════════════════════════════════════════════════════════════
alias rm='trash'
# 真的要永久刪除時用 rm! 或 /bin/rm
alias rm!='/bin/rm'

# ============================================================================
# FZF CONFIGURATION
# ============================================================================

# 產生並載入 CLI 補全快取，避免每次啟動都 fork 子行程重新產生。
# 在函式內宣告 local 才會真正生效（頂層的 local 不會 scope，會洩漏成全域變數）。
# 用法: _load_completion_cache <指令> <快取檔名> <產生補全所需的參數...>
_load_completion_cache() {
    local cmd=$1 name=$2
    shift 2
    command -v "$cmd" >/dev/null 2>&1 || return 0

    local cache="${HOME}/.cache/${name}"
    if [[ ! -f $cache || $(command -v "$cmd") -nt $cache ]]; then
        mkdir -p "${HOME}/.cache"
        "$cmd" "$@" > "$cache" 2>/dev/null
    fi
    source "$cache"
}

# Load FZF (key-bindings + 補全)
_load_completion_cache fzf fzf_completion.zsh --zsh

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
# COMPLETION SYSTEM SETUP (必須在 zplug 之前，zplug 內部會強制執行一次 compinit)
# ============================================================================

# Completion paths
fpath=(
    ~/.zsh/completion
    $HOMEBREWOPT/share/zsh/site-functions
    $fpath
)

# Completion System Styles (zstyle 優化)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # 大小寫不敏感 + 模糊比對
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"                                      # 彩色補全列表（fzf-tab 靠這個上色）
zstyle ':completion:*' menu no                                                               # 關閉原生選單，交給 fzf-tab 接手
zstyle ':completion:*:descriptions' format '[%d]'                                            # fzf-tab 群組標題（不可用色碼，否則會被忽略）
zstyle ':completion:*:messages' format '[%d]'
zstyle ':completion:*:warnings' format '[無匹配項目]'
zstyle ':completion:*' use-cache on                                                          # 啟用補全快取
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*:git-checkout:*' sort false                                             # git 分支依時間排序，不要字母排序

# fzf-tab 專屬設定
zstyle ':fzf-tab:*' use-fzf-default-opts yes                                                 # 沿用 .zshenv 的 Catppuccin 配色
zstyle ':fzf-tab:*' switch-group '<' '>'                                                     # 用 < > 切換補全群組
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'                # cd 補全時預覽目錄內容
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'        # zoxide z 同上

# ============================================================================
# ZPLUG PLUGIN MANAGER
# ============================================================================

if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
    source "$ZPLUG_HOME/init.zsh"

    # Essential Plugins
    zplug "wfxr/forgit"
    # fzf-tab 必須在 compinit 之後、且在會 wrap widget 的 syntax-highlighting 之前載入。
    # zplug 的載入順序固定為 defer_1 → compinit → defer_2 → defer_3，
    # 故 fzf-tab 掛 defer:2、syntax-highlighting 降到 defer:3 才能滿足官方要求。
    zplug "Aloxaf/fzf-tab", defer:2
    zplug "zsh-users/zsh-syntax-highlighting", defer:3
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"

    # Optional Plugins (可根據需要啟用)
    # zplug "b4b4r07/emoji-cli"

    # Install plugins if missing (only run install if plugin directory doesn't exist to speed up shell startup)
    if [[ ! -d "$ZPLUG_HOME/repos" ]] || [[ -z "$(ls -A "$ZPLUG_HOME/repos" 2>/dev/null)" ]]; then
        if ! zplug check; then
            zplug install
        fi
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

# Autosuggestions 快捷鍵：Ctrl-Space 接受建議
bindkey '^ ' autosuggest-accept

# macOS 慣用單詞跳轉與編輯快捷鍵
bindkey '^[f'  forward-word                         # Option + Right (前進一個單詞)
bindkey '^[b'  backward-word                        # Option + Left (後退一個單詞)
bindkey '^[^?' backward-kill-word                   # Option + Backspace (刪除前一個單詞)
bindkey '^W'   backward-kill-word                   # Ctrl + W (刪除前一個單詞)
bindkey '^A'   beginning-of-line                    # Ctrl + A (行首)
bindkey '^E'   end-of-line                          # Ctrl + E (行尾)

# ============================================================================
# SYNTAX HIGHLIGHTING THEME
# ============================================================================

if [[ -f ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
fi

# ============================================================================
# COMPLETION SYSTEM INIT
# ============================================================================
# zplug load 內部已經對其自身的 zcompdump 強制跑過一次完整 compinit
# （見 base/core/load.zsh 的 __zplug::core::load::from_cache，defer 機制寫死、無法關閉）。
# 這裡只在 zplug 尚未初始化完成時（compdef 未定義）才補跑一次，避免同一個 session 重複掃描 fpath。
autoload -Uz compinit
if (( ! $+functions[compdef] )); then
    if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit -i
    else
        compinit -C -i
    fi
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

# Herdr (AI coding agent 終端機管理工具)
_load_completion_cache herdr herdr_completion.zsh completion zsh

# Oh My Pi (omp)
_load_completion_cache omp omp_completion.zsh completions zsh

# iTerm2 Integration
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# Custom Shell Functions
[[ -f "$HOME/.zshshell" ]] && source "$HOME/.zshshell"

# Bun completions
[[ -s "${BUN_INSTALL:-$HOME/.bun}/_bun" ]] && source "${BUN_INSTALL:-$HOME/.bun}/_bun"

# Kubectl
_load_completion_cache kubectl kubectl_completion.zsh completion zsh

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

