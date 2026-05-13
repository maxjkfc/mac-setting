# `flan` Apple Device Finder Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 新增 zsh 函式 `flan`，主動掃描區網 ARP，列出 Apple 製造裝置的 IP / MAC / Bonjour hostname / SSH / VNC 狀態，方便重啟後快速定位 Mac mini。

**Architecture:** 一個 zsh 函式加進 `zsh/.zshshell`；底層用 `arp-scan` 做 ARP 掃描＋OUI vendor lookup，再以並行 subshell 對每台 host 做 `dig`（mDNS 反查）和 `nc` (TCP probe)。`setup.sh` 加一行裝 `arp-scan`，`fzf_help` 加一行說明。沒有測試框架，每個 Task 用「source 後執行並比對輸出」做手動驗證。

**Tech Stack:** Zsh、`arp-scan` (Homebrew)、`dig`、`nc`、`column`、`sort`、`awk`

**Reference spec:** `docs/superpowers/specs/2026-05-13-apple-device-finder-design.md`

---

## File Structure

| 檔案 | 動作 | 責任 |
|------|------|------|
| `setup.sh` | Modify | 在 `setup_zsh()` 工具清單加入 `arp-scan` |
| `zsh/.zshshell` | Modify | 新增 `flan` 函式；在 `fzf_help` 加一行說明 |

---

### Task 1: 把 `arp-scan` 加進 setup.sh 並安裝

**Files:**
- Modify: `setup.sh`（`setup_zsh()` 函式中的工具陣列）

- [ ] **Step 1: 確認 `arp-scan` 目前未安裝**

Run: `command -v arp-scan && echo INSTALLED || echo MISSING`
Expected: `MISSING`（若已安裝可跳過 Step 3 的實際安裝動作，但仍需修改 setup.sh）

- [ ] **Step 2: 找到 `setup_zsh()` 的工具陣列**

Run: `grep -n "setup_zsh" setup.sh | head -5`

找出函式起始行，並用 Read 工具看 `setup_zsh()` 內定義工具的陣列（通常是 `local tools=(...)` 或類似結構）。確認既有條目格式為 `"tool_name:description"`。

- [ ] **Step 3: 在工具陣列中加入 `arp-scan`**

在 `setup_zsh()` 的工具陣列裡，於 `nmap` 或其他網路工具相鄰位置加入：

```bash
"arp-scan:Active ARP scanner with OUI vendor lookup"
```

若 `setup_zsh()` 沒有 `nmap`，就放在陣列尾端、最後一個現有項目之後。

- [ ] **Step 4: 跑 setup.sh 安裝**

Run: `./setup.sh zsh`
Expected: 看到「安裝 arp-scan」相關訊息（或 brew 進度），最後 exit code 為 0。

- [ ] **Step 5: 驗證 arp-scan 已安裝**

Run: `command -v arp-scan && arp-scan --version 2>&1 | head -2`
Expected: 印出 `/opt/homebrew/bin/arp-scan`（或類似路徑）和版本字串。

- [ ] **Step 6: Commit**

```bash
git add setup.sh
git commit -m "feat(setup): 新增 arp-scan 至 zsh 工具清單"
```

---

### Task 2: 加入最小可用的 `flan` 函式（只做掃描＋過濾＋原始輸出）

**Files:**
- Modify: `zsh/.zshshell`

目標：先讓 `flan` 跑得起來、能掃到 Apple 裝置，輸出原始 `IP MAC Vendor` 三欄即可。後續 task 再加 hostname / SSH / VNC / 排版。

- [ ] **Step 1: 在 `.zshshell` 適當位置插入 `flan` 函式骨架**

位置：放在 `myip` 函式附近（同屬網路類工具）。Read `.zshshell` 找到 `myip` 的位置，把以下函式放在 `myip` 之後：

```bash
# flan — 區網內 Apple 裝置查詢
flan() {
    local show_all=false
    local iface="en0"

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -a) show_all=true; shift ;;
            -i) iface="$2"; shift 2 ;;
            -h|--help)
                echo "用法: flan [-a] [-i iface]"
                echo "  -a        列出所有裝置（不僅 Apple）"
                echo "  -i iface  指定網卡（預設 en0）"
                echo "  -h        顯示說明"
                return 0
                ;;
            *) echo "未知參數: $1" >&2; return 1 ;;
        esac
    done

    if ! command -v arp-scan >/dev/null 2>&1; then
        echo "❌ arp-scan 未安裝，請執行: brew install arp-scan" >&2
        return 1
    fi
    if ! command -v dig >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1; then
        echo "❌ 缺少 dig 或 nc，請檢查 PATH" >&2
        return 1
    fi

    echo "🔍 掃描中（介面 $iface）..."

    local raw
    raw=$(sudo arp-scan -l -I "$iface" 2>/dev/null)
    if [[ -z "$raw" ]]; then
        echo "❌ 掃描失敗（可能未授權 sudo 或網卡 $iface 不存在）" >&2
        return 1
    fi

    # arp-scan 輸出含 header/footer，過濾出以 IP 開頭的行
    local filtered
    if $show_all; then
        filtered=$(echo "$raw" | awk -F'\t' 'NF>=3 && $1 ~ /^[0-9]+\./')
    else
        filtered=$(echo "$raw" | awk -F'\t' 'NF>=3 && $1 ~ /^[0-9]+\./ && $3 ~ /Apple/')
    fi

    if [[ -z "$filtered" ]]; then
        if $show_all; then
            echo "未找到任何裝置"
        else
            echo "未找到 Apple 裝置"
        fi
        return 0
    fi

    echo "$filtered"
}
```

- [ ] **Step 2: 重新 source `.zshshell` 並驗證函式存在**

Run（在新 terminal 或同一個 shell）:
```bash
source ~/.zshshell  # 或實際對應的 path，視 setup.sh 的 symlink 而定
type flan
```
Expected: `flan is a shell function`

- [ ] **Step 3: 跑 `flan -h` 驗證 help**

Run: `flan -h`
Expected: 印出三行 help（用法、-a、-i、-h），exit code 0。

- [ ] **Step 4: 跑 `flan` 驗證實際掃描**

Run: `flan`
Expected:
- 系統會 prompt sudo 密碼（首次）
- 印出至少一行 `IP\tMAC\tVendor`，且 Vendor 欄位含 `Apple` 字樣
- 至少看得到本機 Mac 自己

若 Mac mini 此時是開機狀態，應該也會出現在列表中。

- [ ] **Step 5: 跑 `flan -a` 驗證全部模式**

Run: `flan -a`
Expected: 印出比 `flan` 更多的行（包含 router、其他非 Apple 裝置）。

- [ ] **Step 6: Commit**

```bash
git add zsh/.zshshell
git commit -m "feat(zsh): 新增 flan 函式骨架掃描區網 Apple 裝置"
```

---

### Task 3: 為每個裝置加上 Bonjour hostname 與 SSH/VNC 偵測（並行）

**Files:**
- Modify: `zsh/.zshshell`（同一個 `flan` 函式）

目標：把 Step 2 中「直接 `echo "$filtered"`」的最後一段替換成：對每個 host 並行做 mDNS 反查與 port probe，再彙整成五欄輸出。

- [ ] **Step 1: 替換 `flan` 函式中最後輸出區塊**

把 Task 2 末段的：

```bash
    if [[ -z "$filtered" ]]; then
        if $show_all; then
            echo "未找到任何裝置"
        else
            echo "未找到 Apple 裝置"
        fi
        return 0
    fi

    echo "$filtered"
}
```

替換為：

```bash
    if [[ -z "$filtered" ]]; then
        if $show_all; then
            echo "未找到任何裝置"
        else
            echo "未找到 Apple 裝置"
        fi
        return 0
    fi

    # 對每個 host 並行 probe（mDNS 反查 + SSH/VNC port 偵測）
    local tmpdir
    tmpdir=$(mktemp -d)
    local i=0
    while IFS=$'\t' read -r ip mac vendor _rest; do
        i=$((i + 1))
        (
            local hostname
            hostname=$(dig -x "$ip" @224.0.0.251 -p 5353 +short +time=1 +tries=1 2>/dev/null | head -n1 | sed 's/\.$//')
            [[ -z "$hostname" ]] && hostname="-"

            local ssh="-"
            nc -z -G 1 "$ip" 22 >/dev/null 2>&1 && ssh="✓"

            local vnc="-"
            nc -z -G 1 "$ip" 5900 >/dev/null 2>&1 && vnc="✓"

            printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$ip" "$mac" "$vendor" "$hostname" "$ssh" "$vnc" > "$tmpdir/$i"
        ) &
    done <<< "$filtered"
    wait

    cat "$tmpdir"/* 2>/dev/null
    rm -rf "$tmpdir"
}
```

注意：
- `_rest` 是 placeholder，吸收 `arp-scan` 可能有的第 4 欄以後內容（部分版本會有額外欄位）
- `nc -G 1` 是 macOS 專屬的 connect timeout，等同於「1 秒沒連上就放棄」
- mDNS 反查指向 multicast `224.0.0.251:5353`，這是標準 mDNS 群組

- [ ] **Step 2: 重新 source 並執行**

Run:
```bash
source ~/.zshshell
flan
```
Expected:
- 每行有六個欄位（用 tab 分隔，現在還沒排版所以看起來會錯位）
- 至少本機那行的 HOSTNAME 欄應為某個 `*.local`，SSH 視你機器設定，VNC 同
- 整體執行時間約 2~5 秒

- [ ] **Step 3: 驗證 mDNS 反查在某些裝置上有結果**

如果 Mac mini 開機且 Bonjour 正常，應該看到它的 hostname（例如 `mac-mini.local`）。若全都顯示 `-`，先手動驗證：

Run: `dig -x <某Apple裝置的IP> @224.0.0.251 -p 5353 +short +time=1 +tries=1`
Expected: 至少一個有回 hostname。若全部空，代表你的路由器/網路阻擋 mDNS multicast，這不是 bug。

- [ ] **Step 4: Commit**

```bash
git add zsh/.zshshell
git commit -m "feat(zsh): flan 加入 mDNS 反查與 SSH/VNC port 偵測"
```

---

### Task 4: 排版、排序、摘要訊息

**Files:**
- Modify: `zsh/.zshshell`（同一個 `flan` 函式）

目標：把 Task 3 結尾「直接 `cat tmpdir`」的部分改成完整格式（含 header、IP 排序、`column -t` 對齊、結尾摘要）。

- [ ] **Step 1: 替換結尾輸出區塊**

把 Task 3 替換進來的最後幾行：

```bash
    cat "$tmpdir"/* 2>/dev/null
    rm -rf "$tmpdir"
}
```

替換為（同時也要把函式開頭的 `start_ts` 變數加進去 — 見 Step 2）：

```bash
    {
        printf 'IP\tMAC\tVENDOR\tHOSTNAME\tSSH\tVNC\n'
        cat "$tmpdir"/* 2>/dev/null | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n
    } | column -t -s $'\t'
    rm -rf "$tmpdir"

    local elapsed=$(($(date +%s) - start_ts))
    echo ""
    local total_count apple_count
    total_count=$(echo "$raw" | awk -F'\t' 'NF>=3 && $1 ~ /^[0-9]+\./' | wc -l | tr -d ' ')
    apple_count=$(echo "$raw" | awk -F'\t' 'NF>=3 && $1 ~ /^[0-9]+\./ && $3 ~ /Apple/' | wc -l | tr -d ' ')
    if $show_all; then
        echo "找到 ${total_count} 台裝置（其中 ${apple_count} 台 Apple，共掃描 ${elapsed} 秒）"
    else
        echo "找到 ${apple_count} 台 Apple 裝置（共掃描 ${elapsed} 秒）"
    fi
}
```

- [ ] **Step 2: 在 `flan` 函式開頭（依賴檢查後、`echo "🔍 掃描中..."` 前）加入計時變數**

加入這一行：

```bash
    local start_ts=$(date +%s)
```

完整位置範例（在 `nc` 依賴檢查後）：

```bash
    if ! command -v dig >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1; then
        echo "❌ 缺少 dig 或 nc，請檢查 PATH" >&2
        return 1
    fi

    local start_ts=$(date +%s)

    echo "🔍 掃描中（介面 $iface）..."
```

- [ ] **Step 3: 同樣處理「找不到裝置」分支的摘要**

把：

```bash
    if [[ -z "$filtered" ]]; then
        if $show_all; then
            echo "未找到任何裝置"
        else
            echo "未找到 Apple 裝置"
        fi
        return 0
    fi
```

替換為：

```bash
    if [[ -z "$filtered" ]]; then
        local elapsed=$(($(date +%s) - start_ts))
        if $show_all; then
            echo "未找到任何裝置（共掃描 ${elapsed} 秒）"
        else
            echo "未找到 Apple 裝置（共掃描 ${elapsed} 秒）"
        fi
        return 0
    fi
```

- [ ] **Step 4: 重新 source 並執行**

Run:
```bash
source ~/.zshshell
flan
```
Expected:
- 第一行 `🔍 掃描中（介面 en0）...`
- 表頭 `IP  MAC  VENDOR  HOSTNAME  SSH  VNC` 對齊
- 各行欄位對齊（即使 vendor 是 `Apple, Inc.` 含逗號空格也不會錯位）
- 依 IP 由小到大排序
- 結尾摘要含總數與耗時

- [ ] **Step 5: 跑 `flan -a` 確認 `-a` 模式摘要**

Run: `flan -a`
Expected: 結尾顯示「找到 N 台裝置（其中 M 台 Apple，共掃描 X 秒）」

- [ ] **Step 6: Commit**

```bash
git add zsh/.zshshell
git commit -m "feat(zsh): flan 加入表格排版、排序與耗時摘要"
```

---

### Task 5: 加入 `fzf_help` 條目，並做整體驗收

**Files:**
- Modify: `zsh/.zshshell`（`fzf_help` 函式）

- [ ] **Step 1: 找到 `fzf_help` 函式**

Run: `grep -n "fzf_help" zsh/.zshshell | head -5`

用 Read 工具看 `fzf_help` 函式的 echo 列表，確認既有條目格式（通常是 `echo "  fname [args]  - 說明"`）。

- [ ] **Step 2: 在 `fzf_help` 的 `myip` 或 `sysinfo` 相鄰位置加入新條目**

加入這一行（保持與既有條目相同的對齊風格）：

```bash
    echo "  flan [-a] [-i iface]    - 列出區網內 Apple 裝置（-a 顯示全部）"
```

- [ ] **Step 3: 重新 source 並驗證 `fzf_help` 含 `flan`**

Run:
```bash
source ~/.zshshell
fzf_help | grep flan
```
Expected: 印出剛剛新增的那一行。

- [ ] **Step 4: 整體驗收 — 對照 spec 例子**

Run: `flan`
Expected 輸出大致如下（裝置內容依實際區網而異）：

```
🔍 掃描中（介面 en0）...

IP              MAC                VENDOR              HOSTNAME             SSH  VNC
192.168.1.10    a4:83:e7:1c:xx:xx  Apple, Inc.        mac-mini.local       ✓    ✓
192.168.1.15    3c:22:fb:9a:xx:xx  Apple, Inc.        Maxs-MacBook.local   ✓    -

找到 2 台 Apple 裝置（共掃描 2.3 秒）
```

- [ ] **Step 5: 錯誤路徑驗收**

Run: `flan -i bad0`
Expected: 印出「❌ 掃描失敗（可能未授權 sudo 或網卡 bad0 不存在）」，exit code 1。

Run: `flan -x`
Expected: 印出「未知參數: -x」，exit code 1。

- [ ] **Step 6: Commit**

```bash
git add zsh/.zshshell
git commit -m "feat(zsh): fzf_help 加入 flan 條目"
```

---

## Self-Review 紀錄

對照 spec `docs/superpowers/specs/2026-05-13-apple-device-finder-design.md`：

- ✅ **位置與形式**：function 在 `.zshshell`（Task 2 Step 1）
- ✅ **`-a` / `-i` / `-h` flags**：Task 2 Step 1 的 arg parsing
- ✅ **依賴檢查**：Task 2 Step 1 檢查 `arp-scan` / `dig` / `nc`
- ✅ **主動 ARP 掃描**：Task 2 用 `sudo arp-scan -l -I "$iface"`
- ✅ **Apple OUI 過濾**：Task 2 awk 過濾 `$3 ~ /Apple/`
- ✅ **並行 mDNS 反查**：Task 3 subshell `&` + `wait`
- ✅ **SSH/VNC probe**：Task 3 `nc -z -G 1`
- ✅ **排序與 `column -t -s $'\t'`**：Task 4 Step 1（spec 明確強調 tab 分隔避免 `Apple, Inc.` 被切錯）
- ✅ **`-a` 模式專屬摘要**：Task 4 Step 1 if/else
- ✅ **錯誤處理**（sudo 失敗、無裝置）：Task 2 Step 1 + Task 4 Step 3
- ✅ **`setup.sh` 加 `arp-scan`**：Task 1
- ✅ **`fzf_help` 條目**：Task 5

無 placeholder / TBD。命名一致（`flan`、`show_all`、`iface`、`tmpdir` 都貫穿全 plan）。
