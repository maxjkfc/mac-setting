#!/bin/bash
# Mac 開發環境自動化設置腳本
# 支援 tmux, zsh, nvim, backend 等配置
set -e

# 顏色定義，用於美化輸出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 輸出帶顏色的訊息
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
    echo -e "${RED}[ERROR]${NC} $1"
}

# 檢查是否安裝 Homebrew
check_homebrew() {
    if ! command -v brew &>/dev/null; then
        print_error "Homebrew 未安裝，請先安裝 Homebrew"
        echo "安裝指令: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    print_info "Homebrew 已安裝"
}

# 安裝基礎依賴工具
setup_install_depend() {
    print_info "開始安裝基礎開發工具..."

    # Shell 增強工具
    print_info "安裝 Shell 增強工具..."
    if ! command -v zplug &>/dev/null; then
        brew install zplug
    fi
    brew install eza              # 現代化的 ls 替代品
    brew install bat              # 現代化的 cat 替代品，支援語法高亮
    brew install powerlevel10k    # Zsh 主題
    brew install ripgrep          # 快速文字搜尋工具
    brew install fzf              # 模糊搜尋工具
    brew install fd               # 現代化的 find 替代品
    
    # 基礎系統工具
    print_info "安裝基礎系統工具..."
    brew install wget             # 下載工具
    brew install gnu-sed          # GNU sed (macOS 預設是 BSD sed)
    brew install git              # 版本控制
    brew install tmux             # 終端多工器
    brew install curl             # HTTP 客戶端
    brew install reattach-to-user-namespace  # tmux 剪貼簿支援
    
    print_success "基礎開發工具安裝完成"
}

# 安裝後端開發專用工具
setup_backend_tools() {
    print_info "開始安裝後端開發工具..."

    # 容器化和 Kubernetes 工具
    print_info "安裝容器化工具..."
    brew install orbstack --cask # OrbStack
    brew install docker-compose  # Docker Compose
    brew install k9s             # Kubernetes 叢集管理 TUI
    brew install helm            # Kubernetes 套件管理
    brew install kubectx         # Kubernetes context 切換工具
    brew install kubens          # Kubernetes namespace 切換工具
    
    # 雲端平台工具
    print_info "安裝雲端平台工具..."
    brew install --cask google-cloud-sdk  # Google Cloud SDK (gcloud CLI)
    
    # API 開發和測試工具
    print_info "安裝 API 開發工具..."
    brew install httpie          # 現代化的 HTTP 客戶端
    brew install jq              # JSON 處理工具
    brew install yq              # YAML 處理工具
    brew install grpcurl         # gRPC 測試
    
    # 版本管理工具
    print_info "安裝版本管理工具..."
    brew install gh              # GitHub CLI
    brew install git-delta       # 更好的 git diff 顯示
    brew install lazygit         # Git TUI
    
    # 系統監控工具
    print_info "安裝系統監控工具..."
    brew install gtop
    brew install ctop
    brew install duf             # 磁碟使用量查看

    print_info "安裝網路除錯工具..."
    brew install nmap            # 網路掃描工具
    
    # Node.js 和 npm 開發環境
    print_info "安裝 Node.js 版本管理工具..."
    brew install fnm             # 快速的 Node.js 版本管理器
    brew install oven-sh/bun/bun # 現代化的 JavaScript 運行時和套件管理器
    
    # 設置 fnm 環境
    print_info "設置 fnm 環境變數..."
    if ! grep -q "fnm env" "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(fnm env --use-on-cd)"' >> "$HOME/.zshrc"
        print_info "已添加 fnm 環境變數到 .zshrc"
    fi
    
    # 使用 fnm 安裝 LTS 版本
    print_info "使用 fnm 安裝 Node.js LTS 版本..."
    if command -v fnm &>/dev/null; then
        fnm install --lts
        fnm use lts-latest
        fnm default lts-latest
        print_success "已安裝並設置 Node.js LTS 為預設版本"
    fi
    
    # 環境管理工具
    print_info "安裝環境管理工具..."
    brew install direnv          # 目錄環境變數管理
    
    # 自動化和 CI/CD 工具
    print_info "安裝自動化工具..."
    brew install act             # 本地執行 GitHub Actions
    brew install pre-commit      # Git hooks 管理
    
    # 文檔和安全工具
    print_info "安裝文檔和安全工具..."
    brew install pandoc          # 文檔轉換工具
    brew install gpg             # 加密工具
    
    print_success "後端開發工具安裝完成"
}

# 設置 Tmux 配置
setup_tmux() {
	print_info "開始設置 [tmux] 配置..."
	
	# 檢查並安裝 TPM (Tmux Plugin Manager)
	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		print_info "安裝 Tmux Plugin Manager (TPM)..."
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	else
		print_warning "TPM 已存在，跳過安裝"
	fi

	# 備份現有的 tmux 配置檔（如果存在）
	if [ -f "$HOME/.tmux.conf" ]; then
		print_warning "發現現有的 .tmux.conf，將其備份為 .tmux.conf.backup"
		mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
	fi

	# 建立符號連結到我們的 tmux 配置檔
	print_info "建立 tmux 配置檔符號連結..."
	ln -s "$PWD"/tmux/.tmux.conf "$HOME"/.tmux.conf

	print_success "Tmux 配置設置完成"
	print_info "請重新啟動 tmux 或執行 'tmux source ~/.tmux.conf' 來載入新配置"
	print_info "按 Prefix + I (預設是 Ctrl-a + I) 來安裝 tmux 插件"
}

setup_ai_tools() {
	print_info "開始設置 [ai tools] 配置..."
    
    # 安裝 Claude CLI
    brew install claude-code
    # 安裝 Gemini CLI
    brew install gemini-cli
}

# 設置 Zsh 配置
setup_zsh() {
	print_info "開始設置 [zsh] 配置..."
	
	# 檢查 Homebrew 是否已安裝
	check_homebrew

	# 備份並設置 .zshrc
	if [ -f "$HOME/.zshrc" ]; then
		print_warning "發現現有的 .zshrc，將其備份為 .zshrc.backup"
		mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
	fi
	print_info "建立 .zshrc 符號連結..."
	ln -s "$PWD"/zsh/.zshrc "$HOME"/.zshrc

	# 備份並設置 .zshshell
	if [ -f "$HOME/.zshshell" ]; then
		print_warning "發現現有的 .zshshell，將其備份為 .zshshell.backup"
		mv "$HOME/.zshshell" "$HOME/.zshshell.backup"
	fi
	print_info "建立 .zshshell 符號連結..."
	ln -s "$PWD"/zsh/.zshshell "$HOME"/.zshshell

	# 備份並設置 .zprofile
	if [ -f "$HOME/.zprofile" ]; then
		print_warning "發現現有的 .zprofile，將其備份為 .zprofile.backup"
		mv "$HOME/.zprofile" "$HOME/.zprofile.backup"
	fi
	print_info "建立 .zprofile 符號連結..."
	ln -s "$PWD"/zsh/.zprofile "$HOME"/.zprofile

	# 安裝基礎依賴工具
	setup_install_depend

	print_success "Zsh 配置設置完成"
	print_info "請重新啟動終端或執行 'source ~/.zshrc' 來載入新配置"
	print_info "首次啟動可能需要配置 Powerlevel10k 主題，請按照提示進行設置"
}

# 設置 Neovim 配置
setup_nvim() {
	print_info "開始設置 [nvim] 配置..."
	NVIM_PATH="$HOME/.config"

	# 確保 .config 目錄存在
	if [ ! -d "$NVIM_PATH" ]; then
		print_info "建立 .config 目錄..."
		mkdir -p "$NVIM_PATH"
	fi

	# 備份現有的 nvim 配置（如果存在）
	if [ -d "$NVIM_PATH/nvim" ]; then
		print_warning "發現現有的 nvim 配置，將其備份為 nvim.backup"
		mv "$NVIM_PATH/nvim" "$NVIM_PATH/nvim.backup"
	fi

	# 建立符號連結到我們的 nvim 配置
	print_info "建立 nvim 配置符號連結..."
	ln -s "$PWD"/nvim "$NVIM_PATH"/nvim

	# 檢查是否安裝 Neovim
	if ! command -v nvim &>/dev/null; then
		print_info "安裝 Neovim..."
		brew install neovim
	fi

	print_success "Neovim 配置設置完成"
	print_info "首次啟動 nvim 時，LazyVim 會自動安裝所需的插件"
	print_info "請耐心等待插件安裝完成"
}

# 顯示使用說明
show_usage() {
    echo "Mac 開發環境自動化設置腳本"
    echo ""
    echo "使用方式:"
    echo "  $0 [選項]"
    echo ""
    echo "選項:"
    echo "  tmux      - 設置 Tmux 配置"
    echo "  zsh       - 設置 Zsh 配置（包含基礎工具安裝）"
    echo "  nvim      - 設置 Neovim 配置"
    echo "  backend   - 安裝後端開發工具"
    echo "  all       - 安裝所有配置和工具"
    echo "  health    - 檢查開發環境狀態"
    echo "  help      - 顯示此說明"
    echo ""
    echo "範例:"
    echo "  $0 zsh        # 只設置 zsh 配置"
    echo "  $0 all        # 安裝所有配置"
    echo "  $0 backend    # 只安裝後端開發工具"
}

# 安裝所有配置
setup_all() {
    print_info "開始安裝所有配置和工具..."
    
    # 檢查 Homebrew
    check_homebrew
    
    # 依序安裝所有配置
    setup_zsh
    echo ""
    setup_tmux
    echo ""
    setup_nvim
    echo ""
    setup_backend_tools
    
    print_success "🎉 所有配置安裝完成！"
    print_info "建議重新啟動終端以確保所有配置生效"
}

# 健康檢查功能
health_check() {
    print_info "🔍 檢查開發環境狀態..."
    echo ""
    
    # 檢查基礎工具
    print_info "檢查基礎工具:"
    tools=("brew" "git" "nvim" "tmux" "zsh" "fzf" "ripgrep" "node" "npm" "bun" "fnm")
    for tool in "${tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            print_success "✓ $tool 已安裝"
        else
            print_error "✗ $tool 未安裝"
        fi
    done
    
    echo ""
    print_info "檢查配置檔:"
    configs=("$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.config/nvim")
    for config in "${configs[@]}"; do
        if [ -e "$config" ]; then
            print_success "✓ $config 存在"
        else
            print_error "✗ $config 不存在"
        fi
    done
    
    echo ""
    print_info "檢查服務狀態:"
    if command -v brew &>/dev/null; then
        brew services list | grep started | while read line; do
            print_success "✓ $line"
        done
    fi
    
    echo ""
    print_info "檢查 Docker 狀態:"
    if command -v docker &>/dev/null; then
        if docker ps &>/dev/null; then
            print_success "✓ Docker 運行中"
            docker ps --format "table {{.Names}}\t{{.Status}}" | head -5
        else
            print_warning "⚠ Docker 未運行或無權限"
        fi
    else
        print_error "✗ Docker 未安裝"
    fi
}

setup_vim_mode_repeating() {
    print_info "開始設置 [vim-mode-repeating] 配置..."
    # 禁用按鍵長按
    defaults write -g ApplePressAndHoldEnabled -bool false
}

install_gui_tools() {
    print_info "開始安裝 GUI 工具..."
    brew install --cask raycast # 生產力工具
    brew install --cask stats      # 系統監控
    brew install --cask warp
    brew install --cask appcleaner
}

# 主程式邏輯
case $1 in
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
"all")
    setup_all
    ;;
"health")
    health_check
    ;;
"help"|"-h"|"--help")
    show_usage
    ;;
"")
    print_error "請指定要執行的操作"
    echo ""
    show_usage
    exit 1
    ;;
*)
    print_error "未知的選項: $1"
    echo ""
    show_usage
    exit 1
    ;;
esac
