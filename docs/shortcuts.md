# Developer Environment Shortcuts 速查手冊

本手冊彙整了此 macOS 開發環境中所有的 **Shell Alias、FZF 增強函式、Neovim 鍵位、Herdr 與 Tmux 操作**。

---

## 目錄
1. [Zsh Aliases (常用命令簡寫)](#1-zsh-aliases-常用命令簡寫)
2. [FZF 互動函式 (Shell 增強)](#2-fzf-互動函式-shell-增強)
3. [AI Agent 工具鏈 (Claude / OMP / Antigravity / Herdr)](#3-ai-agent-工具鏈-claude--omp--antigravity--herdr)
4. [Git 操作與分支防護](#4-git-操作與分支防護)
5. [Neovim (LazyVim & Antigravity)](#5-neovim-lazyvim--antigravity)
6. [Tmux 快捷鍵](#6-tmux-快捷鍵)

---

## 1. Zsh Aliases (常用命令簡寫)

### 檔案與目錄瀏覽 (Eza / Bat)
| 指令 | 完整命令 | 說明 |
|---|---|---|
| `ls` | `eza` | 現代化檔案列表 |
| `l` | `eza -lbF --git` | 詳細列表（含 Git 狀態與類型指示符） |
| `ll` | `eza -lbhHigUmua --git` | 完整詳細資訊列表（含隱藏檔、Inode 等） |
| `la` | `eza -lbhHigUmuSa --git --color-scale --icons` | 圖示與色彩增強列表 |
| `lt` | `eza --tree --level=5 --color-scale --icons` | 樹狀目錄檢視（深度 5 層） |
| `cat` | `bat` | 語法高亮檢視檔案 |

### 編輯器與搜尋
| 指令 | 完整命令 | 說明 |
|---|---|---|
| `v` | `nvim` | 開啟 Neovim |
| `vdiff` | `nvim -d` | 使用 Neovim 進行檔案比對 (diff) |
| `zshconfig` | `nvim ~/.zshrc` | 快速編輯 zshrc 配置 |
| `grep` / `fgrep` / `egrep` | `... --color=auto` | 自動色彩高亮 |

### 安全刪除
| 指令 | 完整命令 | 說明 |
|---|---|---|
| `rm` | `trash` | 移至 macOS 垃圾桶（可還原，防誤刪） |
| `rm!` | `/bin/rm` | 強制永久刪除（不經垃圾桶） |

---

## 2. FZF 互動函式 (Shell 增強)

所有 FZF 工具均支援互動式搜尋、多選 (Tab) 及右側即時預覽。隨時輸入 `fzf_help` 可在終端機查看說明。

### 檔案與目錄導航
| 函式 | 範例 | 說明 |
|---|---|---|
| `ff [pattern]` | `ff config` | 透過 `fd` 搜尋檔案，按 Enter 直接以 `$EDITOR` 開啟 |
| `fcd [pattern]` | `fcd src` | 透過 `fd` 搜尋子目錄並 `cd` 進入 |
| `fcode [pattern]` | `fcode mac` | 快速搜尋 `~/code/` 下的專案目錄並 `cd` 進入 |
| `vg <pattern>` | `vg "func"` | 透過 `ripgrep` 搜尋程式碼，按 Enter 直接跳至該檔案指定行數 |

### 系統與程序管理
| 函式 | 範例 | 說明 |
|---|---|---|
| `fkill [signal]` | `fkill` | 互動式選擇程序並終止（預設 signal 9，支援 Tab 多選） |
| `flan [-i iface]` | `flan` | 掃描區域網路內所有上線設備（含 IP, MAC, Hostname, SSH/VNC 狀態） |
| `myip` | `myip` | 顯示本機 LAN IP、公網 WAN IP 及地理位置資訊 |
| `sysinfo` | `sysinfo` | 顯示 CPU、記憶體、負載與系統資訊摘要 |

### Docker 工具
| 函式 | 範例 | 說明 |
|---|---|---|
| `fdim` | `fdim` | 選擇並刪除 Docker 映像（支援 Tab 多選，右側顯示映像 Env） |
| `fdc [action]` | `fdc logs` | 管理 Docker 容器（start / stop / restart / rm / logs / exec） |

---

## 3. AI Agent 工具鏈 (Claude / OMP / Antigravity / Herdr)

### 常用 Alias

| 工具 | 指令 | 行為 |
|---|---|---|
| **Claude Code** | `cc` | 啟動 Claude Code（啟用防閃爍參數 `CLAUDE_CODE_NO_FLICKER=1`） |
| | `ccr` | 啟動 Claude Remote Control 模式 |
| | `ccm` | 跳轉至 `~/max-agent` 知識庫並啟動 Claude |
| | `ccw` | 跳轉至 `~/max-wiki` 知識庫並啟動 Claude |
| **Oh My Pi** | `ompc` | 延續上一次 session (`omp --continue`) |
| | `ompp` | 執行單次 prompt 即退出 (`omp -p`) |
| | `ompy` | 全自動執行模式 (`omp --approval-mode=yolo`) |
| | `ompu` | 查詢 API Token / Usage 額度 (`omp usage`) |
| | `omps` | 查看本機統計資訊 (`omp stats`) |
| | `ompm-list` | 列出目前所有可用模型 (`omp models`) |
| | `ompm` | 跳轉至 `~/max-agent` 知識庫並啟動 OMP |
| | `ompw` | 跳轉至 `~/max-wiki` 知識庫並啟動 OMP |
| **Antigravity CLI** | `agyc` | 延續上一次 session (`agy -c`) |
| | `agyp` | 執行單次 prompt 即退出 (`agy -p`) |
| | `agyy` | 跳過權限詢問全自動執行 (`agy --dangerously-skip-permissions`) |
| | `agym` | 跳轉至 `~/max-agent` 知識庫並啟動 agy |
| | `agyw` | 跳轉至 `~/max-wiki` 知識庫並啟動 agy |
| **Herdr** | `hr` | 啟動或連接 Herdr (`herdr`) |
| | `hrls` | 列出 Herdr sessions (`herdr session list`) |
| | `hrst` | 查看 Herdr 狀態 (`herdr status`) |
| | `hrwt` | 建立 Herdr worktree (`herdr worktree create`) |
| | `hrremote` | 遠端連線模式 (`herdr --remote`) |

### Herdr 互動管理函式
| 函式 | 說明 |
|---|---|
| `fherdr` | 透過 `fzf` 選擇並 attach 到 Herdr session |
| `fherdr-ws` | 透過 `fzf` 選擇並切換 Herdr workspace |
| `herdr-omp [dir]` | 在 Herdr 新分頁建立 tab 並啟動 `omp`（可指定目錄） |

---

## 4. Git 操作與分支防護

| 指令 / 函式 | 說明 |
|---|---|
| `gnew <branch>` | **安全開分支**：自動從遠端 `origin/main` 切出新分支，避免在 main 或舊分支上開發 |
| `fgb` | 透過 `fzf` 搜尋並切換本地／遠端 Git 分支（右側即時預覽最近 Commit） |
| `fgl` | 透過 `fzf` 瀏覽 Git Log，按 Enter 可直接查看該 Commit 的詳細 Diff |

---

## 5. Neovim (LazyVim & Antigravity)

### 常用檔案與導航 (Leader 預設為 Space)
| 快捷鍵 | 模式 | 功能 |
|---|---|---|
| `<leader>e` | Normal | 開啟 / 切換檔案瀏覽器 (Explorer) |
| `<leader>ff` | Normal | 尋找檔案 (Find Files) |
| `<leader>fw` | Normal | 專案全文字搜尋 (Find in Files / Live Grep) |
| `<leader>/` | Normal / Visual | 切換行註解 (Comment line) |
| `<leader>cf` | Normal | 格式化目前程式碼 (Format Document) |

### 程式碼與 LSP 導航
| 快捷鍵 | 模式 | 功能 |
|---|---|---|
| `gd` | Normal | 跳至定義 (Go to Definition) |
| `gD` | Normal | 預覽定義 (Peek Definition) |
| `gi` | Normal | 跳至實作 (Go to Implementation) |
| `gr` | Normal | 尋找所有引用 (References) |
| `<leader>rn` | Normal | 符號重新命名 (Rename Symbol) |
| `[d` / `]d` | Normal | 跳至上一個 / 下一個診斷錯誤 (Diagnostics) |

### Antigravity AI 快捷鍵 (VSCode / Antigravity 環境)
| 快捷鍵 | 模式 | 功能 |
|---|---|---|
| `<leader>a` | Normal / Visual | 開啟 Antigravity AI Chat 視窗 |
| `<leader>i` | Normal / Visual | 啟動 Inline Chat 行內對話 |
| `<C-d>` | Normal / Visual | 選取下一個相同詞彙（多游標 Multi-Cursor） |

### 終端與視窗切換
| 快捷鍵 | 模式 | 功能 |
|---|---|---|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal / Terminal | 直接往 左 / 下 / 上 / 右 切換分割視窗 |

---

## 6. Tmux 快捷鍵

> **Prefix 鍵**: `Ctrl + A` (即 `C-a`)

### 自訂與管理
| 快捷鍵 | 功能 |
|---|---|
| `prefix r` | 重新載入 `.tmux.conf` |
| `prefix X` | 關閉目前視窗 (Window) |
| `prefix C-b` | 切換所有 Pane 同步輸入模式 (Synchronize-panes) |
| `prefix C-f` | 開啟 `tmux-fzf` 選單 |
| `Ctrl + l` | 清除終端機畫面與 History buffer (不需按 Prefix) |

### 分割與 Pane 導航 (tmux-pain-control)
| 快捷鍵 | 功能 |
|---|---|
| `prefix \|` | 左右垂直分割 Pane |
| `prefix -` | 上下水平分割 Pane |
| `prefix h / j / k / l` | 切換 Pane（左 / 下 / 上 / 右） |
| `prefix H / J / K / L` | 調整 Pane 尺寸 |
| `prefix z` | 最大化 / 還原目前 Pane |
| `prefix {` / `}` | 與相鄰 Pane 交換位置 |

### 視窗 (Window) 與 Session
| 快捷鍵 | 功能 |
|---|---|
| `prefix c` | 新增 Window |
| `prefix n` / `p` | 切換至 下一個 / 上一個 Window |
| `prefix 1~9` | 切換至指定編號 Window |
| `prefix ,` | 重新命名 Window |
| `prefix g` | 互動式選擇並切換 Session |
| `prefix C` | 建立新 Session |
| `prefix d` | Detach 離開 Tmux（背景持續運行） |

### 複製模式 (Vi Copy Mode)
| 快捷鍵 | 功能 |
|---|---|
| `prefix [` | 進入 Copy 模式 |
| `v` | 開始選取文字 |
| `y` | 複製選取並離開 |
| `/` / `?` | 向下 / 向上搜尋文字 |
| `q` | 離開 Copy 模式 |
