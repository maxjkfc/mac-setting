# tmux Shortcuts

> Prefix: `C-a`（Ctrl + A）

## 自訂快捷鍵

| 快捷鍵 | 功能 |
|--------|------|
| `prefix r` | 重新載入 tmux.conf |
| `prefix X` | 關閉目前 window |
| `prefix C-b` | 切換 synchronize-panes（同步輸入所有 pane） |
| `C-l` | 清除畫面 + 清除 history buffer（不需 prefix） |
| `prefix C-f` | 開啟 tmux-fzf 選單 |

## Pane 操作（tmux-pain-control）

| 快捷鍵 | 功能 |
|--------|------|
| `prefix \|` | 左右分割 pane |
| `prefix -` | 上下分割 pane |
| `prefix h/j/k/l` | 切換 pane（左/下/上/右） |
| `prefix H/J/K/L` | 調整 pane 大小 |
| `prefix z` | 放大/縮小目前 pane |
| `prefix q` | 顯示 pane 編號 |
| `prefix {` / `}` | 和相鄰 pane 交換位置 |

## Window 操作

| 快捷鍵 | 功能 |
|--------|------|
| `prefix c` | 新增 window |
| `prefix n` / `p` | 下一個 / 上一個 window |
| `prefix 1~9` | 切換到指定 window |
| `prefix ,` | 重新命名 window |
| `prefix <` / `>` | 和相鄰 window 交換位置 |

## Session 操作（tmux-sessionist）

| 快捷鍵 | 功能 |
|--------|------|
| `prefix g` | 切換 session（互動選擇） |
| `prefix C` | 新建 session |
| `prefix $` | 重新命名 session |
| `prefix s` | 列出所有 session |
| `prefix d` | Detach（session 繼續在背景運行） |
| `prefix @` | 將目前 pane 提升為獨立 session |

## Copy Mode（vi）

| 快捷鍵 | 功能 |
|--------|------|
| `prefix [` | 進入 copy mode |
| `v` | 開始選取 |
| `y` | 複製並離開 |
| `/` | 向下搜尋 |
| `?` | 向上搜尋 |
| `q` | 離開 copy mode |
