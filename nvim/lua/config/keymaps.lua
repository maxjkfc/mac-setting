-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- 確保只在 VSCode / Google Antigravity 環境下執行
if vim.g.vscode then
  -- 1. 定義輔助函式：簡化 VSCodeNotify 呼叫
  local function notify(cmd)
    return function()
      vim.fn.VSCodeNotify(cmd)
    end
  end

  -- === 視窗移動 (Window Navigation) ===
  -- 使用 Ctrl + hjkl 在分割視窗間快速切換，無需使用滑鼠
  vim.keymap.set("n", "<C-j>", notify("workbench.action.navigateDown"))
  vim.keymap.set("n", "<C-k>", notify("workbench.action.navigateUp"))
  vim.keymap.set("n", "<C-h>", notify("workbench.action.navigateLeft"))
  vim.keymap.set("n", "<C-l>", notify("workbench.action.navigateRight"))

  -- === 程式碼導航 (LSP / Go Navigation) ===
  -- gr: 查看引用 (References)
  vim.keymap.set("n", "gr", notify("editor.action.referenceSearch.trigger"))
  -- gi: 跳轉到實作 (Implementation) - Go Interface 必備
  vim.keymap.set("n", "gi", notify("editor.action.goToImplementation"))
  -- gd: 跳轉到定義 (Definition)
  vim.keymap.set("n", "gd", notify("editor.action.revealDefinition"))
  -- gD: 預覽定義 (Peek Definition) - 不離開當前檔案，直接查看定義
  vim.keymap.set("n", "gD", notify("editor.action.peekDefinition"))
  -- <leader>rn: 重新命名 (Rename)
  vim.keymap.set("n", "<leader>rn", notify("editor.action.rename"))

  -- === 檔案與搜尋 (Files & Search) ===
  -- <leader>e: 開啟/關閉檔案總管
  vim.keymap.set("n", "<leader>e", notify("workbench.view.explorer"))
  -- <leader>ff: 快速開啟檔案 (Quick Open)
  vim.keymap.set("n", "<leader>ff", notify("workbench.action.quickOpen"))
  -- <leader>fw: 全域搜尋文字 (Find in Files)
  vim.keymap.set("n", "<leader>fw", notify("workbench.action.findInFiles"))

  -- === 編輯與工具 (Edit & Tools) ===
  -- <leader>/ : 註解切換 (支援一般模式與選取模式)
  vim.keymap.set({ "n", "v" }, "<leader>/", notify("editor.action.commentLine"))
  -- <leader>cf: 格式化文件 (Format)
  vim.keymap.set("n", "<leader>cf", notify("editor.action.formatDocument"))
  
  -- === 診斷跳轉 (Diagnostics) ===
  -- [d: 上一個錯誤
  vim.keymap.set("n", "[d", notify("editor.action.marker.prev"))
  -- ]d: 下一個錯誤
  vim.keymap.set("n", "]d", notify("editor.action.marker.next"))

  -- === Antigravity AI 功能 ===
  -- <leader>a: 開啟 AI Chat
  vim.keymap.set({ "n", "v" }, "<leader>a", notify("antigravity.prioritized.chat.open"))
  -- <leader>i: 開啟行內 AI編輯 (Inline Chat)
  vim.keymap.set({ "n", "v" }, "<leader>i", notify("antigravity.prioritized.inlineChat.start"))

  -- === 多游標操作 (Multi-Cursor) ===
  -- Ctrl+d: 選取下一個相同的字
  -- 使用 pcall 保護，即使插件未載入也不會報錯，並會退回 VSCode 原生行為
  vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
    local status, mulcursor = pcall(require, "vscode-multi-cursor")
    if status then
      mulcursor.addSelectionToNextFindMatch()
    else
      vim.fn.VSCodeNotify("editor.action.addSelectionToNextFindMatch")
    end
  end)

end