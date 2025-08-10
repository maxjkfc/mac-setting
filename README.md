# 🚀 Mac Developer Environment Setup

一個專為後端開發者設計的 macOS 開發環境配置，包含現代化的 shell 配置、強大的 fzf 工具集合、以及完整的開發工具安裝腳本。

## ✨ 主要特色

- 🎯 **完整的 zsh 配置結構**：符合最佳實踐的檔案組織
- 🛠️ **15+ 個 fzf 增強工具**：大幅提升終端生產力
- 🔧 **現代化開發環境**：Node.js (fnm)、Go、Docker、Kubernetes 等
- 🎨 **美觀的登入體驗**：系統資訊顯示和開發工具狀態
- 🤖 **AI 工具整合**：Claude CLI、Gemini CLI
- 📦 **模組化設計**：易於維護和自訂

## 📁 專案結構

```
mac-setting/
├── setup.sh                 # 主要安裝腳本
├── zsh/                     # zsh 配置檔案
│   ├── .zshenv              # 環境變數和 PATH 配置
│   ├── .zprofile            # 登入時執行（Homebrew、OrbStack）
│   ├── .zshrc               # 互動式 shell 配置（主題、別名、插件）
│   ├── .zlogin              # 登入完成後執行（歡迎訊息、系統資訊）
│   └── .zshshell            # 自訂 fzf 工具函數集合
└── README.md                # 本檔案
```

## 🔄 zsh 配置檔案載入順序

```
登入 Shell:     .zshenv → .zprofile → .zshrc → .zlogin
非登入 Shell:   .zshenv → .zshrc
腳本執行:       .zshenv
```

### 📋 各檔案職責

| 檔案 | 職責 | 內容 |
|------|------|------|
| **`.zshenv`** | 環境變數管理 | PATH、開發工具路徑、FZF 配置 |
| **`.zprofile`** | 登入設置 | Homebrew 環境、OrbStack 整合 |
| **`.zshrc`** | 互動功能 | Powerlevel10k 主題、別名、插件、補全 |
| **`.zlogin`** | 登入後執行 | 歡迎訊息、系統資訊、開發工具狀態 |
| **`.zshshell`** | 自訂工具 | 15+ 個 fzf 增強函數 |

## 🚀 快速開始

### 1. 克隆專案

```bash
git clone <repository-url> ~/code/mac-setting
cd ~/code/mac-setting
```

### 2. 執行安裝腳本

```bash
# 查看所有可用選項
./setup.sh help

# 安裝所有工具
./setup.sh all

# 或分別安裝
./setup.sh backend-tools    # 後端開發工具
./setup.sh shell-tools      # Shell 增強工具
./setup.sh ai-tools         # AI 工具 (Claude CLI, Gemini CLI)
./setup.sh gui-tools        # GUI 應用程式
```

### 3. 健康檢查

```bash
./setup.sh health-check
```

## 🛠️ 強大的 fzf 工具集合

安裝完成後，您將擁有 15+ 個專業級的 fzf 增強工具：

### 📁 檔案與目錄操作

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `ff` | 智能檔案搜尋與開啟 | `ff config` |
| `fcd` | 智能目錄切換 | `fcd src` |
| `vg` | 內容搜尋與編輯 | `vg "function"` |

### 🖥️ TMUX 管理

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `ftm` | TMUX Session 管理 | `ftm work` |
| `fs` | 快速 Session 切換 | `fs` |

### 🔧 程序管理

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `fkill` | 智能程序終止（多選支援） | `fkill` |

### 🐳 Docker 工具

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `fdim` | Docker 映像管理 | `fdim` |
| `fdc` | Docker 容器管理 | `fdc logs` |

### 🌐 Git 工具

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `fgb` | Git 分支切換 | `fgb` |
| `fgl` | Git 日誌瀏覽 | `fgl` |

### 🌍 系統工具

| 命令 | 功能 | 使用範例 |
|------|------|----------|
| `myip` | IP 地址查詢（含地理位置） | `myip` |
| `sysinfo` | 系統資訊摘要 | `sysinfo` |
| `fzf_help` | 顯示所有可用工具 | `fzf_help` |

## 🎨 登入體驗

每次登入都會看到美觀的歡迎介面：

```
╭─────────────────────────────────────────────────────────────╮
│                    歡迎回來，username！                     │
├─────────────────────────────────────────────────────────────┤
│ 🖥️  主機名稱: MacBook-Pro
│ 🍎  系統版本: macOS 15.6
│ ⏰  運行時間: 1 day, 3:25
│ 📊  系統負載: 2.46 2.36 2.39
│ 💾  記憶體: 10.5GB / 16GB
│ 💿  磁碟使用: 100GB / 500GB (20%)
╰─────────────────────────────────────────────────────────────╯

🛠️  開發工具: Node.js v22.18.0 go1.24.6 Docker ✅ kubectl ✅

💡 輸入 fzf_help 查看所有可用的 fzf 工具
```

## 🔧 開發工具

### Node.js 環境
- **fnm**：快速的 Node.js 版本管理器
- **Bun**：現代化的 JavaScript 運行時
- 避免全域污染，完美的環境隔離

### 後端開發
- **Go**：完整的 Go 開發環境
- **Docker & Kubernetes**：容器化開發工具
- **Google Cloud SDK**：雲端開發支援

### AI 工具
- **Claude CLI**：Anthropic Claude 命令列工具
- **Gemini CLI**：Google Gemini 命令列工具

## ⚙️ 自訂配置

### 修改環境變數
編輯 `zsh/.zshenv` 檔案來調整環境變數和 PATH 設定。

### 添加自訂函數
在 `zsh/.zshshell` 檔案中添加您的自訂函數。

### 調整主題和別名
編輯 `zsh/.zshrc` 檔案來自訂主題、別名和插件。

### 自訂登入訊息
編輯 `zsh/.zlogin` 檔案來調整登入時顯示的資訊。

## 🔄 更新和維護

### 更新配置
```bash
cd ~/code/mac-setting
git pull origin main
```

### 重新載入配置
```bash
# 重新載入 shell
exec zsh

# 或開啟新的終端視窗
```

### 備份恢復
所有原始配置檔案都會自動備份為 `.backup` 檔案，可以隨時恢復。

## 🐛 故障排除

### 常見問題

1. **fzf 工具無法使用**
   ```bash
   # 檢查 fzf 是否安裝
   which fzf
   
   # 重新載入配置
   source ~/.zshrc
   ```

2. **環境變數未載入**
   ```bash
   # 檢查 .zshenv 是否正確連結
   ls -la ~/.zshenv
   
   # 手動載入
   source ~/.zshenv
   ```

3. **Node.js 版本問題**
   ```bash
   # 檢查 fnm 狀態
   fnm list
   
   # 安裝最新 LTS
   fnm install --lts
   fnm use lts-latest
   ```

### 健康檢查
```bash
./setup.sh health-check
```

## 📊 效能優化

- ✅ **條件式載入**：只載入存在的工具和路徑
- ✅ **模組化設計**：按需載入功能
- ✅ **環境變數優化**：避免重複設定
- ✅ **快取機制**：減少重複計算

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request 來改善這個專案！

## 📄 授權

MIT License

---

**享受您的高效開發環境！** 🎉

