# `flan` — 區網內 Apple 裝置查詢腳本

**Date**: 2026-05-13
**Status**: Approved, ready for implementation
**Target repo**: `mac-setting` (dotfiles)

## 目的

每次重啟 Mac mini 後找不到它在區網內的 IP。需要一個本地小工具，列出區網中所有 Apple 製造的裝置，以便辨認 Mac mini（以及其他 Apple 裝置）的位置。

## 範圍

- 一個 zsh 函式：`flan`
- 主動 ARP 掃描整個本地網段
- 過濾出 Apple OUI 裝置
- 對每個 Apple 裝置補上 Bonjour hostname、SSH/VNC port 可用性
- 把 `arp-scan` 加進 `setup.sh` 的工具安裝清單

不在範圍：
- 跨網段掃描
- 持續監控 / daemon
- 寫入歷史記錄或設定檔
- 自動 SSH 連線到找到的 Mac mini

## 位置與形式

新增一個 zsh 函式 `flan` 到 `zsh/.zshshell`，沿用既有 `f*` fzf-style 命名（與 `fkill`、`fgb`、`fdc` 一致）。在 `fzf_help` 函式末尾登錄一行說明。

**為什麼是 function 而不是 standalone 腳本**：
- 跟現有工具命名一致（`myip`、`fkill`、`fgb`、`fdc`、`ftm` 等皆為 function）
- 透過 `.zshrc` source 即可用，不需額外 PATH
- 已建立的依賴檢查模式（`command -v` + 缺工具時印安裝指令）可直接沿用

## 使用方式

```bash
flan          # 列出區網所有 Apple 裝置（預設）
flan -a       # 列出所有裝置，不僅 Apple
flan -i en1   # 指定網卡（預設 en0）
flan -h       # 顯示說明
```

## 依賴

| 工具 | 用途 | 取得方式 |
|------|------|----------|
| `arp-scan` | 主動 ARP 掃描 + 內建 OUI vendor lookup | `brew install arp-scan`（加進 `setup.sh`） |
| `nc` | TCP port 偵測 (SSH 22, VNC 5900) | macOS 內建 |
| `dig` | mDNS 反查 *.local hostname | macOS 內建（`bind` 工具） |
| `sudo` | `arp-scan` 需要 raw socket | 系統 |

`flan` 開頭做依賴檢查：缺 `arp-scan` 時印出 `brew install arp-scan` 並 return；缺 `nc` 或 `dig` 則為 fatal error（理論上不應發生，但提供清楚訊息以防 PATH 異常）。

## 執行流程

1. **解析 flags**：`-a` (all)、`-i <iface>` (interface)、`-h` (help)
2. **偵測網卡介面**：預設 `en0`；若 `-i` 提供則使用該值
3. **主動掃描**：執行 `sudo arp-scan -l -I <iface> --quiet`，輸出格式為每行 `IP\tMAC\tVENDOR...`
4. **過濾**：
   - 預設模式：以 `awk -F'\t'` 過濾 `$3 ~ /Apple/`
   - `-a` 模式：保留所有非空行
5. **補資料**（對每個 host 並行執行，使用 background subshell + wait）：
   - **Bonjour hostname**：`dig -x <IP> @224.0.0.251 -p 5353 +short +time=1 +tries=1`，去掉結尾 `.`；無回應顯示 `-`
   - **SSH**：`nc -z -G 1 <IP> 22 2>/dev/null && echo ✓ || echo -`
   - **VNC**：`nc -z -G 1 <IP> 5900 2>/dev/null && echo ✓ || echo -`
6. **排序與輸出**：依 IP 排序（`sort -t. -k1,1n -k2,2n -k3,3n -k4,4n`），中間欄位以 tab 分隔，最後用 `column -t -s $'\t'` 排版。**必須指定 tab 分隔符**，否則 `Apple, Inc.` 中間的空格會被當成欄位邊界
7. **摘要**：
   - 預設模式：「找到 N 台 Apple 裝置（共掃描 X.X 秒）」
   - `-a` 模式：「找到 N 台裝置（其中 M 台 Apple，共掃描 X.X 秒）」

並行的目的是把 hostname + SSH + VNC 三個 probe 同時對所有 host 跑，避免 N×3 個 1 秒 timeout 串行累積。

## 輸出格式

```
$ flan
🔍 掃描 192.168.1.0/24 ...

IP              MAC                VENDOR              HOSTNAME             SSH  VNC
192.168.1.10    a4:83:e7:1c:xx:xx  Apple, Inc.        mac-mini.local       ✓    ✓
192.168.1.15    3c:22:fb:9a:xx:xx  Apple, Inc.        Maxs-MacBook.local   ✓    -
192.168.1.42    f0:18:98:5e:xx:xx  Apple, Inc.        -                    -    -

找到 3 台 Apple 裝置（共掃描 2.3 秒）
```

**規則**：
- 偵測不到的欄位填 `-`，維持表格對齊
- SSH/VNC 用 `✓` / `-` 表開/關
- 顯示掃描網段（從 `arp-scan` 第一行或 `ifconfig` 取得）
- 結尾摘要含總數與耗時，方便判斷掃描是否成功

## 錯誤處理

| 情況 | 行為 |
|------|------|
| `arp-scan` 未安裝 | 印 `arp-scan 未安裝，請執行: brew install arp-scan`，return 1 |
| `sudo` 取消或失敗 | `arp-scan` 自會回非零；`flan` 捕捉並印 `掃描失敗（可能未授權 sudo）`，return 1 |
| 網卡不存在 | `arp-scan` 自會報錯，原樣輸出 stderr |
| 找不到任何 Apple 裝置 | 印 `未找到 Apple 裝置（共掃描 X.X 秒）`，return 0 |

## `setup.sh` 變更

在 `setup_zsh()` 的工具陣列加入：

```bash
"arp-scan:Active ARP scanner with OUI vendor lookup"
```

放在 `nmap`、`fzf` 等網路/搜尋工具附近，依現有排列習慣。

## `fzf_help` 變更

在 `.zshshell` 尾巴的 `fzf_help` function 加入：

```
  flan [-a] [-i iface]  - 列出區網內 Apple 裝置（-a 顯示全部）
```

位置：與 `myip`、`sysinfo` 等網路工具相鄰。

## 測試方式

手動驗證（沒有自動化測試框架）：

1. `./setup.sh zsh` 後重新開 shell，確認 `arp-scan` 已裝
2. 執行 `flan`，確認：
   - 表頭欄位齊全
   - 至少列出本機 MacBook（vendor = Apple）
   - 重啟 Mac mini 後 30 秒內能在輸出中看到它
3. 執行 `flan -a`，確認非 Apple 裝置（router、IoT）也出現
4. 執行 `flan -i bad0`，確認錯誤訊息可讀
5. 暫時 `brew uninstall arp-scan`，確認 `flan` 提示安裝指令

## YAGNI 排除項目

明確 **不做** 的事，避免 scope creep：

- 快取掃描結果到檔案
- 自動 SSH 連線到 Mac mini
- 整合 fzf 互動選單（可未來再加 `flan -f` 子模式，但本次不做）
- 自定 OUI 清單（信任 `arp-scan` 的內建資料庫）
- 多網卡同時掃描
- IPv6 鄰居發現
