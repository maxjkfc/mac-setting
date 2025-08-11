# ============================================================================
# ZSH LOGIN SCRIPT (.zlogin)
# ============================================================================
# 此檔案在登入 shell 完成後執行（在 .zshrc 之後）
# 適合放置：歡迎訊息、系統資訊顯示、登入後的一次性任務
# 載入順序：.zshenv → .zprofile → .zshrc → .zlogin

# ============================================================================
# SYSTEM INFORMATION DISPLAY
# ============================================================================

# 顏色定義
local RED='\033[0;31m'
local GREEN='\033[0;32m'
local YELLOW='\033[1;33m'
local BLUE='\033[0;34m'
local PURPLE='\033[0;35m'
local CYAN='\033[0;36m'
local WHITE='\033[1;37m'
local NC='\033[0m' # No Color

# 使用 macchina 顯示系統資訊（如果可用）
show_system_info() {
    if command -v macchina >/dev/null 2>&1; then
        echo ""
        echo -e "${CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${CYAN}│${WHITE}                    歡迎回來，$(whoami)！                     ${CYAN}│${NC}"
        echo -e "${CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        macchina
        echo ""
    else
        # Fallback 到原有的系統資訊顯示
        get_system_info
    fi
}

# 獲取系統資訊
get_system_info() {
    local hostname=$(hostname -s)
    local username=$(whoami)
    local os_version=$(sw_vers -productVersion)
    local uptime=$(uptime | awk -F'up ' '{print $2}' | awk -F', load' '{print $1}')
    local load_avg=$(uptime | awk -F'load averages: ' '{print $2}')
    local memory_usage=$(vm_stat | awk '
        /Pages free/ { free = $3 }
        /Pages active/ { active = $3 }
        /Pages inactive/ { inactive = $3 }
        /Pages speculative/ { speculative = $3 }
        /Pages wired/ { wired = $3 }
        END {
            total = (free + active + inactive + speculative + wired) * 4096 / 1024 / 1024 / 1024
            used = (active + inactive + speculative + wired) * 4096 / 1024 / 1024 / 1024
            printf "%.1fGB / %.1fGB", used, total
        }')
    local disk_usage=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
    
    # 顯示歡迎資訊
    echo ""
    echo -e "${CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${WHITE}                    歡迎回來，${username}！                     ${CYAN}│${NC}"
    echo -e "${CYAN}├─────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│${NC} ${BLUE}🖥️  主機名稱:${NC} ${hostname}"
    echo -e "${CYAN}│${NC} ${GREEN}🍎  系統版本:${NC} macOS ${os_version}"
    echo -e "${CYAN}│${NC} ${YELLOW}⏰  運行時間:${NC} ${uptime}"
    echo -e "${CYAN}│${NC} ${PURPLE}📊  系統負載:${NC} ${load_avg}"
    echo -e "${CYAN}│${NC} ${RED}💾  記憶體:${NC} ${memory_usage}"
    echo -e "${CYAN}│${NC} ${CYAN}💿  磁碟使用:${NC} ${disk_usage}"
    echo -e "${CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
    echo ""
}

# ============================================================================
# DEVELOPMENT ENVIRONMENT STATUS
# ============================================================================

# 檢查開發工具狀態
check_dev_tools() {
    local tools_status=""
    
    # 檢查重要的開發工具
    if command -v node >/dev/null 2>&1; then
        local node_version=$(node --version)
        tools_status+="${GREEN}Node.js${NC} ${node_version} "
    fi
    
    if command -v go >/dev/null 2>&1; then
        local go_version=$(go version | awk '{print $3}')
        tools_status+="${BLUE}${go_version}${NC} "
    fi
    
    if command -v docker >/dev/null 2>&1; then
        if docker info >/dev/null 2>&1; then
            tools_status+="${CYAN}Docker${NC} ✅ "
        else
            tools_status+="${YELLOW}Docker${NC} ⚠️  "
        fi
    fi
    
    if command -v kubectl >/dev/null 2>&1; then
        tools_status+="${PURPLE}kubectl${NC} ✅ "
    fi
    
    if [[ -n "$tools_status" ]]; then
        echo -e "${WHITE}🛠️  開發工具:${NC} ${tools_status}"
        echo ""
    fi
}

# ============================================================================
# GIT STATUS (如果在 Git 倉庫中)
# ============================================================================

# 顯示 Git 狀態（如果在 Git 倉庫中）
show_git_status() {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        local branch=$(git branch --show-current 2>/dev/null)
        local git_status=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
        local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        
        if [[ -n "$branch" ]]; then
            echo -e "${WHITE}📁 Git 倉庫:${NC} ${repo_name}"
            echo -e "${WHITE}🌿 當前分支:${NC} ${GREEN}${branch}${NC}"
            if [[ "$git_status" -gt 0 ]]; then
                echo -e "${WHITE}📝 未提交變更:${NC} ${YELLOW}${git_status} 個檔案${NC}"
            else
                echo -e "${WHITE}✅ 工作目錄:${NC} ${GREEN}乾淨${NC}"
            fi
            echo ""
        fi
    fi
}

# ============================================================================
# HELPFUL TIPS
# ============================================================================

# 顯示有用的提示
show_tips() {
    local tips=(
        "💡 輸入 ${CYAN}fzf_help${NC} 查看所有可用的 fzf 工具"
        "🚀 使用 ${CYAN}ftm${NC} 管理 TMUX sessions"
        "🔍 使用 ${CYAN}ff${NC} 快速搜尋和開啟檔案"
        "🐳 使用 ${CYAN}fdc${NC} 管理 Docker 容器"
        "📊 輸入 ${CYAN}sysinfo${NC} 查看詳細系統資訊"
    )
    
    # 隨機選擇一個提示
    local random_tip=${tips[$((RANDOM % ${#tips[@]} + 1))]}
    echo -e "${random_tip}"
    echo ""
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

# 只在互動式登入 shell 中顯示資訊
if [[ -o interactive && -o login ]]; then
    # 顯示系統資訊（優先使用 macchina）
    show_system_info
    
    # 顯示開發工具狀態
    check_dev_tools
    
    # 顯示 Git 狀態（如果在 Git 倉庫中）
    show_git_status
    
    # 顯示隨機提示
    show_tips
fi

# ============================================================================
# OPTIONAL: STARTUP TASKS
# ============================================================================

# 可選：執行登入後的一次性任務
# 例如：檢查更新、清理暫存檔案等

# 檢查 Homebrew 更新（每天一次）
check_brew_updates() {
    local last_check_file="$HOME/.cache/brew_last_check"
    local today=$(date +%Y-%m-%d)
    
    if [[ ! -f "$last_check_file" ]] || [[ "$(cat "$last_check_file" 2>/dev/null)" != "$today" ]]; then
        if command -v brew >/dev/null 2>&1; then
            echo -e "${YELLOW}🍺 檢查 Homebrew 更新...${NC}"
            brew update >/dev/null 2>&1 &
            echo "$today" > "$last_check_file"
        fi
    fi
}

# 創建快取目錄
[[ ! -d "$HOME/.cache" ]] && mkdir -p "$HOME/.cache"

# 執行更新檢查（背景執行，不阻塞登入）
# check_brew_updates
