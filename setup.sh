#!/bin/bash
# ============================================================================
# Mac 開發環境自動化設置腳本
# 支援 tmux, zsh, nvim, backend, ai-tools 等配置
# 版本: 2.0 (優化版)
# ============================================================================

set -euo pipefail  # 嚴格模式：遇到錯誤立即退出，未定義變數報錯，管道錯誤傳播

# ============================================================================
# 全域變數與常數
# ============================================================================

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
readonly CONFIG_DIR="$HOME/.config"

# 顏色定義，用於美化輸出
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# ============================================================================
# 日誌與輸出函數
# ============================================================================

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

print_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

print_separator() {
    echo -e "${CYAN}$(printf '=%.0s' {1..60})${NC}"
}

# 進度條函數
show_progress() {
    local current=$1
    local total=$2
    local desc=$3
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))
    
    printf "\r${CYAN}[%3d%%]${NC} [" "$percent"
    printf "%*s" $filled | tr ' ' '='
    printf "%*s" $empty | tr ' ' '-'
    printf "] %s" "$desc"
    
    if [ $current -eq $total ]; then
        echo ""
    fi
}

# ============================================================================
# 工具函數
# ============================================================================

# 檢查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 安全地安裝 Homebrew 套件
safe_brew_install() {
    local package="$1"
    local description="${2:-$package}"
    
    if command_exists "${package##*/}"; then
        print_info "$description 已安裝，跳過"
        return 0
    fi
    
    print_info "安裝 $description..."
    if brew install "$package"; then
        print_success "$description 安裝成功"
    else
        print_error "$description 安裝失敗"
        return 1
    fi
}

# 安全地安裝 Homebrew Cask
safe_brew_cask_install() {
    local package="$1"
    local description="${2:-$package}"
    
    print_info "安裝 $description..."
    if brew install --cask "$package"; then
        print_success "$description 安裝成功"
    else
        print_warning "$description 安裝失敗或已存在"
    fi
}

# 安全地創建符號連結
safe_symlink() {
    local source="$1"
    local target="$2"
    local description="${3:-符號連結}"
    
    # 確保目標目錄存在
    mkdir -p "$(dirname "$target")"
    
    # 備份現有檔案
    if [[ -e "$target" && ! -L "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "備份現有檔案: $target -> $backup"
        mv "$target" "$backup"
    fi
    
    # 移除現有符號連結
    [[ -L "$target" ]] && rm "$target"
    
    # 創建新符號連結
    if ln -sf "$source" "$target"; then
        print_success "$description 創建成功: $target"
    else
        print_error "$description 創建失敗: $target"
        return 1
    fi
}

# 檢查並添加內容到檔案
add_to_file_if_missing() {
    local content="$1"
    local file="$2"
    local description="${3:-內容}"
    
    if [[ -f "$file" ]] && grep -Fq "$content" "$file"; then
        print_info "$description 已存在於 $file"
        return 0
    fi
    
    echo "$content" >> "$file"
    print_success "$description 已添加到 $file"
}

# ============================================================================
# 核心檢查函數
# ============================================================================

check_system() {
    print_step "檢查系統環境..."
    
    # 檢查 macOS 版本
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "此腳本僅支援 macOS 系統"
        exit 1
    fi
    
    local macos_version
    macos_version=$(sw_vers -productVersion)
    print_info "macOS 版本: $macos_version"
    
    # 檢查架構
    local arch
    arch=$(uname -m)
    print_info "系統架構: $arch"
    
    # 檢查 Xcode Command Line Tools
    if ! xcode-select -p >/dev/null 2>&1; then
        print_warning "Xcode Command Line Tools 未安裝"
        print_info "正在安裝 Xcode Command Line Tools..."
        xcode-select --install
        print_info "請完成 Xcode Command Line Tools 安裝後重新執行此腳本"
        exit 1
    fi
    
    print_success "系統環境檢查完成"
}

check_homebrew() {
    print_step "檢查 Homebrew..."
    
    if ! command_exists brew; then
        print_error "Homebrew 未安裝"
        print_info "請執行以下指令安裝 Homebrew:"
        echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        exit 1
    fi
    
    print_info "Homebrew 已安裝: $(brew --version | head -n1)"
    
    # 更新 Homebrew
    print_info "更新 Homebrew..."
    brew update >/dev/null 2>&1 || print_warning "Homebrew 更新失敗"
    
    print_success "Homebrew 檢查完成"
}

# ============================================================================
# 安裝函數
# ============================================================================

setup_install_depend() {
    print_step "安裝基礎依賴工具..."
    print_separator
    
    local tools=(
        "zplug:Zsh 插件管理器"
        "eza:現代化的 ls 替代品"
        "bat:現代化的 cat 替代品"
        "powerlevel10k:Zsh 主題"
        "ripgrep:快速文字搜尋工具"
        "fzf:模糊搜尋工具"
        "fd:現代化的 find 替代品"
        "wget:下載工具"
        "gnu-sed:GNU sed"
        "git:版本控制"
        "tmux:終端多工器"
        "curl:HTTP 客戶端"
        "reattach-to-user-namespace:tmux 剪貼簿支援"
        "macchina:Rust 製作的系統資訊顯示工具"
        "zoxide:智能目錄跳轉工具"
    )
    
    local total=${#tools[@]}
    local current=0
    
    for tool_desc in "${tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        ((current++))
        show_progress $current $total "安裝 $desc"
        safe_brew_install "$tool" "$desc"
    done
    
    print_success "基礎依賴工具安裝完成"
}

setup_backend_tools() {
    print_step "安裝後端開發工具..."
    print_separator
    
    # 容器化和 Kubernetes 工具
    print_info "安裝容器化工具..."
    local container_tools=(
        "orbstack --cask:OrbStack"
        "docker-compose:Docker Compose"
        "k9s:Kubernetes 叢集管理 TUI"
        "helm:Kubernetes 套件管理"
        "kubectx:Kubernetes context 切換工具"
        "kubens:Kubernetes namespace 切換工具"
    )
    
    for tool_desc in "${container_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        if [[ "$tool" == *"--cask"* ]]; then
            safe_brew_cask_install "${tool% --cask}" "$desc"
        else
            safe_brew_install "$tool" "$desc"
        fi
    done
    
    # 雲端平台工具
    print_info "安裝雲端平台工具..."
    safe_brew_cask_install "google-cloud-sdk" "Google Cloud SDK"
    
    # API 開發和測試工具
    print_info "安裝 API 開發工具..."
    local api_tools=(
        "httpie:現代化的 HTTP 客戶端"
        "jq:JSON 處理工具"
        "yq:YAML 處理工具"
        "grpcurl:gRPC 測試工具"
    )
    
    for tool_desc in "${api_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    # 版本管理工具
    print_info "安裝版本管理工具..."
    local vcs_tools=(
        "gh:GitHub CLI"
        "git-delta:更好的 git diff 顯示"
        "lazygit:Git TUI"
    )
    
    for tool_desc in "${vcs_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    # 系統監控工具
    print_info "安裝系統監控工具..."
    local monitor_tools=(
        "gtop:系統監控"
        "ctop:容器監控"
        "duf:磁碟使用量查看"
        "nmap:網路掃描工具"
    )
    
    for tool_desc in "${monitor_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    # Node.js 開發環境
    setup_nodejs_environment
    
    # 環境管理工具
    print_info "安裝環境管理工具..."
    safe_brew_install "direnv" "目錄環境變數管理"
    
    # 自動化和 CI/CD 工具
    print_info "安裝自動化工具..."
    local automation_tools=(
        "act:本地執行 GitHub Actions"
        "pre-commit:Git hooks 管理"
    )
    
    for tool_desc in "${automation_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    # 文檔和安全工具
    print_info "安裝文檔和安全工具..."
    local doc_tools=(
        "pandoc:文檔轉換工具"
        "gpg:加密工具"
    )
    
    for tool_desc in "${doc_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    print_success "後端開發工具安裝完成"
}

setup_nodejs_environment() {
    print_info "設置 Node.js 開發環境..."
    
    # 安裝 fnm 和 bun
    safe_brew_install "fnm" "Node.js 版本管理器"
    safe_brew_install "oven-sh/bun/bun" "Bun JavaScript 運行時"
    
    # 設置 fnm 環境變數
    local zshrc="$HOME/.zshrc"
    add_to_file_if_missing 'eval "$(fnm env --use-on-cd)"' "$zshrc" "fnm 環境變數"
    
    # 使用 fnm 安裝 LTS 版本
    if command_exists fnm; then
        print_info "使用 fnm 安裝 Node.js LTS 版本..."
        
        # 載入 fnm 環境
        eval "$(fnm env --use-on-cd)" 2>/dev/null || true
        
        # 安裝並設置 LTS 版本
        if fnm install --lts >/dev/null 2>&1; then
            fnm use lts-latest >/dev/null 2>&1
            fnm default lts-latest >/dev/null 2>&1
            print_success "Node.js LTS 版本安裝並設為預設"
        else
            print_warning "Node.js LTS 版本安裝失敗，請手動執行: fnm install --lts"
        fi
    fi
}

setup_ai_tools() {
    print_step "安裝 AI 開發工具..."
    print_separator
    
    local ai_tools=(
        "claude-code:Claude CLI"
        "gemini-cli:Gemini CLI"
    )
    
    for tool_desc in "${ai_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_install "$tool" "$desc"
    done
    
    print_success "AI 開發工具安裝完成"
}

setup_tmux() {
    print_step "設置 Tmux 配置..."
    print_separator
    
    # 安裝 TPM (Tmux Plugin Manager)
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        print_info "安裝 Tmux Plugin Manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        print_success "TPM 安裝完成"
    else
        print_info "TPM 已存在，跳過安裝"
    fi
    
    # 設置 tmux 配置檔
    safe_symlink "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf" "Tmux 配置檔"
    
    print_success "Tmux 配置設置完成"
    print_info "請重新啟動 tmux 或執行 'tmux source ~/.tmux.conf' 來載入新配置"
    print_info "按 Prefix + I (預設是 Ctrl-a + I) 來安裝 tmux 插件"
}

setup_zsh() {
    print_step "設置 Zsh 配置..."
    print_separator
    
    check_homebrew
    
    # 設置各種 zsh 配置檔
    local configs=(
        ".zshrc:Zsh 主配置檔"
        ".zshshell:Zsh 自定義函數"
        ".zprofile:Zsh 環境變數"
        ".zshenv:Zsh 環境設定"
        ".zlogin:Zsh 登入配置"
    )
    
    for config_desc in "${configs[@]}"; do
        IFS=':' read -r config desc <<< "$config_desc"
        if [[ -f "$SCRIPT_DIR/zsh/$config" ]]; then
            safe_symlink "$SCRIPT_DIR/zsh/$config" "$HOME/$config" "$desc"
        fi
    done
    
    # 安裝基礎依賴工具
    setup_install_depend
    
    print_success "Zsh 配置設置完成"
    print_info "請重新啟動終端或執行 'source ~/.zshrc' 來載入新配置"
    print_info "首次啟動可能需要配置 Powerlevel10k 主題，請按照提示進行設置"
}

setup_nvim() {
    print_step "設置 Neovim 配置..."
    print_separator
    
    # 確保 .config 目錄存在
    mkdir -p "$CONFIG_DIR"
    
    # 設置 nvim 配置
    safe_symlink "$SCRIPT_DIR/nvim" "$CONFIG_DIR/nvim" "Neovim 配置"
    
    # 安裝 Neovim
    safe_brew_install "neovim" "Neovim"
    
    print_success "Neovim 配置設置完成"
    print_info "首次啟動 nvim 時，LazyVim 會自動安裝所需的插件"
    print_info "請耐心等待插件安裝完成"
}

setup_vim_mode_repeating() {
    print_step "設置 Vim 模式按鍵重複..."
    
    # 禁用按鍵長按延遲
    defaults write -g ApplePressAndHoldEnabled -bool false
    print_success "Vim 模式按鍵重複設置完成"
    print_info "請重新啟動應用程式以生效"
}

install_gui_tools() {
    print_step "安裝 GUI 工具..."
    print_separator
    
    local gui_tools=(
        "raycast:生產力工具"
        "stats:系統監控"
        "warp:現代化終端"
        "appcleaner:應用程式清理工具"
    )
    
    for tool_desc in "${gui_tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_desc"
        safe_brew_cask_install "$tool" "$desc"
    done
    
    print_success "GUI 工具安裝完成"
}

# ============================================================================
# 組合安裝函數
# ============================================================================

setup_all() {
    print_step "開始安裝所有配置和工具..."
    print_separator
    
    local start_time
    start_time=$(date +%s)
    
    # 系統檢查
    check_system
    check_homebrew
    
    # 依序安裝所有配置
    local setup_functions=(
        "setup_zsh:Zsh 配置"
        "setup_tmux:Tmux 配置"
        "setup_nvim:Neovim 配置"
        "setup_backend_tools:後端開發工具"
        "setup_ai_tools:AI 開發工具"
        "setup_vim_mode_repeating:Vim 模式設置"
    )
    
    local total=${#setup_functions[@]}
    local current=0
    
    for func_desc in "${setup_functions[@]}"; do
        IFS=':' read -r func desc <<< "$func_desc"
        ((current++))
        echo ""
        print_separator
        show_progress $current $total "設置 $desc"
        $func
    done
    
    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    echo ""
    print_separator
    print_success "🎉 所有配置安裝完成！"
    print_info "總耗時: ${duration} 秒"
    print_info "建議重新啟動終端以確保所有配置生效"
    print_separator
}

# ============================================================================
# 健康檢查函數
# ============================================================================

health_check() {
    print_step "🔍 檢查開發環境狀態..."
    print_separator
    
    local all_good=true
    
    # 檢查基礎工具
    print_info "檢查基礎工具:"
    local tools=("brew" "git" "nvim" "tmux" "zsh" "fzf" "ripgrep" "node" "npm" "bun" "fnm")
    local missing_tools=()
    
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            local version
            case "$tool" in
                "node") version=$(node --version 2>/dev/null || echo "unknown") ;;
                "npm") version=$(npm --version 2>/dev/null || echo "unknown") ;;
                "git") version=$(git --version 2>/dev/null | cut -d' ' -f3 || echo "unknown") ;;
                *) version=$($tool --version 2>/dev/null | head -n1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' || echo "unknown") ;;
            esac
            print_success "✓ $tool ($version)"
        else
            print_error "✗ $tool 未安裝"
            missing_tools+=("$tool")
            all_good=false
        fi
    done
    
    echo ""
    print_info "檢查配置檔:"
    local configs=("$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.config/nvim")
    local missing_configs=()
    
    for config in "${configs[@]}"; do
        if [[ -e "$config" ]]; then
            if [[ -L "$config" ]]; then
                print_success "✓ $config (符號連結)"
            else
                print_success "✓ $config (檔案)"
            fi
        else
            print_error "✗ $config 不存在"
            missing_configs+=("$config")
            all_good=false
        fi
    done
    
    echo ""
    print_info "檢查 Homebrew 服務:"
    if command_exists brew; then
        local services
        services=$(brew services list 2>/dev/null | grep started || true)
        if [[ -n "$services" ]]; then
            while IFS= read -r line; do
                print_success "✓ $line"
            done <<< "$services"
        else
            print_info "沒有運行中的 Homebrew 服務"
        fi
    fi
    
    echo ""
    print_info "檢查 Docker 狀態:"
    if command_exists docker; then
        if docker ps >/dev/null 2>&1; then
            print_success "✓ Docker 運行中"
            local containers
            containers=$(docker ps --format "table {{.Names}}\t{{.Status}}" 2>/dev/null | tail -n +2 | head -5)
            if [[ -n "$containers" ]]; then
                echo "$containers"
            fi
        else
            print_warning "⚠ Docker 未運行或無權限"
        fi
    else
        print_warning "⚠ Docker 未安裝"
    fi
    
    echo ""
    print_info "檢查 Node.js 環境:"
    if command_exists fnm; then
        local node_versions
        node_versions=$(fnm list 2>/dev/null || echo "無版本")
        print_info "fnm 管理的 Node.js 版本:"
        echo "$node_versions"
    fi
    
    echo ""
    print_separator
    if $all_good; then
        print_success "🎉 開發環境健康檢查通過！"
    else
        print_warning "⚠ 開發環境存在一些問題"
        if [[ ${#missing_tools[@]} -gt 0 ]]; then
            print_info "缺少的工具: ${missing_tools[*]}"
        fi
        if [[ ${#missing_configs[@]} -gt 0 ]]; then
            print_info "缺少的配置: ${missing_configs[*]}"
        fi
        print_info "建議執行相應的安裝指令來修復問題"
    fi
    print_separator
}

# ============================================================================
# 使用說明
# ============================================================================

show_usage() {
    cat << EOF
$(print_info "Mac 開發環境自動化設置腳本 v2.0")

$(print_step "使用方式:")
  $0 [選項]

$(print_step "選項:")
  tmux          - 設置 Tmux 配置
  zsh           - 設置 Zsh 配置（包含基礎工具安裝）
  nvim          - 設置 Neovim 配置
  backend       - 安裝後端開發工具
  ai-tools      - 安裝 AI 開發工具
  gui-tools     - 安裝 GUI 工具
  vim-repeat    - 設置 Vim 模式按鍵重複
  all           - 安裝所有配置和工具
  health        - 檢查開發環境狀態
  help, -h      - 顯示此說明

$(print_step "範例:")
  $0 zsh        # 只設置 zsh 配置
  $0 all        # 安裝所有配置
  $0 backend    # 只安裝後端開發工具
  $0 health     # 檢查環境狀態

$(print_step "注意事項:")
  - 首次執行建議使用 'all' 選項進行完整安裝
  - 安裝過程中會自動備份現有配置檔
  - 建議在安裝完成後重新啟動終端
  - 使用 'health' 選項檢查安裝狀態

EOF
}

# ============================================================================
# 主程式邏輯
# ============================================================================

main() {
    # 檢查參數
    if [[ $# -eq 0 ]]; then
        print_error "請指定要執行的操作"
        echo ""
        show_usage
        exit 1
    fi
    
    # 顯示腳本資訊
    print_info "Mac 開發環境自動化設置腳本 v2.0"
    print_info "執行時間: $(date '+%Y-%m-%d %H:%M:%S')"
    print_separator
    
    # 處理命令
    case "$1" in
        "tmux")
            check_homebrew
            setup_tmux
            ;;
        "zsh")
            setup_zsh
            ;;
        "nvim")
            check_homebrew
            setup_nvim
            ;;
        "backend")
            check_homebrew
            setup_backend_tools
            ;;
        "ai-tools")
            check_homebrew
            setup_ai_tools
            ;;
        "gui-tools")
            check_homebrew
            install_gui_tools
            ;;
        "vim-repeat")
            setup_vim_mode_repeating
            ;;
        "all")
            setup_all
            ;;
        "health")
            health_check
            ;;
        "help"|"-h"|"--help")
            show_usage
            ;;
        *)
            print_error "未知的選項: $1"
            echo ""
            show_usage
            exit 1
            ;;
    esac
}

# 執行主程式
main "$@"
