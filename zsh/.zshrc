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
#
# 快取寫入流程：先寫暫存檔 → 確認 exit code 為 0 → 確認非空 → 確認語法可解析
# → 才 mv 覆蓋正式快取。三道檢查缺一不可：
#   - 不檢查 exit code：失敗會留下 0-byte 檔，且其 mtime 恆新於 binary，
#     導致下方判斷永遠不成立、壞掉的快取被永久鎖住。
#   - 只檢查非空：輸出被截斷時（exit 0 但內容不完整）仍會寫入，
#     之後每次啟動 source 都噴 parse error。故需 zsh -n 驗證。
# 失敗時保留舊快取並輸出實際錯誤到 stderr，不靜默吞掉。
#
# 過期判斷同時比對 binary mtime 與「解析後的實際路徑」。只看 mtime 不夠：
# 例如 /usr/local/bin/kubectl 指向 Google Cloud SDK 的 binary，其 mtime 固定為 1980，
# 恆早於快取，SDK 升級後永遠不會重新產生。記錄實際路徑可在 symlink 改指向時觸發更新。
#
# 用法: _load_completion_cache <指令> <快取檔名> <產生補全所需的參數...>
_load_completion_cache() {
    local cmd=$1 name=$2
    shift 2

    local bin
    bin=$(command -v "$cmd" 2>/dev/null) || return 0

    local cache="${HOME}/.cache/${name}"
    local src="${cache}.src"
    local resolved="${bin:A}"

    if [[ ! -s $cache || $bin -nt $cache || ! -r $src || "$(<$src)" != "$resolved" ]]; then
        mkdir -p "${HOME}/.cache"
        local tmp="${cache}.tmp.$$" err="${cache}.err.$$"
        if "$cmd" "$@" > "$tmp" 2>"$err" && [[ -s $tmp ]] && zsh -n "$tmp" 2>>"$err"; then
            command mv -f "$tmp" "$cache"
            print -r -- "$resolved" > "$src"
        else
            print -u2 "warn: 產生 $name 補全失敗，沿用既有快取"
            [[ -s $err ]] && print -u2 "  $(head -n 3 "$err")"
            command rm -f "$tmp"
        fi
        command rm -f "$err"
    fi
    [[ -s $cache ]] && source "$cache"
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
# 註：未設定 list-colors。本機無 GNU dircolors，LS_COLORS 始終為空，
# 寫了也不會上色，故不留這行以免誤導。
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

    # 只在「宣告的外掛清單有變動」時才跑 zplug check / install。
    # 每次啟動都跑 zplug check 要多花約 40-70ms；
    # 但原本僅判斷 repos 目錄是否為空，會導致既有機器在新增外掛後
    # 永遠不會安裝它（靜默缺件，如本次新增的 fzf-tab）。
    # 這裡以 zplug 自身註冊的 $zplugs 鍵值排序後當作指紋，比對成本僅一次讀檔。
    # 註：${(k)zplugs} 直接內嵌到巢狀展開會被壓成 scalar，導致 (o) 與 (j) 都失效，
    # 必須先指派給真正的陣列再排序，否則指紋會退化成依賴 hash 走訪順序。
    _zplug_marker="${HOME}/.cache/zplug_declared.list"
    typeset -a _zplug_keys
    _zplug_keys=("${(@k)zplugs}")
    _zplug_now="${(j.:.)${(@o)_zplug_keys}}"
    if [[ ! -r $_zplug_marker || "$_zplug_now" != "$(<$_zplug_marker)" ]]; then
        zplug check || zplug install
        # 僅在確認全部安裝完成後才寫入指紋，避免安裝失敗被記成已完成
        if zplug check; then
            mkdir -p "${HOME}/.cache"
            print -r -- "$_zplug_now" > "$_zplug_marker"
        fi
    fi
    unset _zplug_marker _zplug_now _zplug_keys

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

# 註：^[f / ^[b / ^[^? / ^W / ^A / ^E 不需綁定，
# 上方已 set -o emacs，這些正是 zsh emacs keymap 的預設值。

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
