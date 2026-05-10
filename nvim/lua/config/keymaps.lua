-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 確保只在 VSCode / Google Antigravity 環境下執行
if vim.g.vscode then
  -- 1. 定義輔助函式：簡化 VSCodeNotify 呼叫
  local function notify(cmd)
    return function()
      vim.fn.VSCodeNotify(cmd)
    end
  end

  -- === 視窗移動 (Window Navigation) ===
  vim.keymap.set("n", "<C-j>", notify("workbench.action.navigateDown"))
  vim.keymap.set("n", "<C-k>", notify("workbench.action.navigateUp"))
  vim.keymap.set("n", "<C-h>", notify("workbench.action.navigateLeft"))
  vim.keymap.set("n", "<C-l>", notify("workbench.action.navigateRight"))

  -- === 程式碼導航 (LSP / Go Navigation) ===
  vim.keymap.set("n", "gr", notify("editor.action.referenceSearch.trigger"))
  vim.keymap.set("n", "gi", notify("editor.action.goToImplementation"))
  vim.keymap.set("n", "gd", notify("editor.action.revealDefinition"))
  vim.keymap.set("n", "gD", notify("editor.action.peekDefinition"))
  vim.keymap.set("n", "<leader>rn", notify("editor.action.rename"))

  -- === 檔案與搜尋 (Files & Search) ===
  vim.keymap.set("n", "<leader>e", notify("workbench.view.explorer"))
  vim.keymap.set("n", "<leader>ff", notify("workbench.action.quickOpen"))
  vim.keymap.set("n", "<leader>fw", notify("workbench.action.findInFiles"))

  -- === 編輯與工具 (Edit & Tools) ===
  vim.keymap.set({ "n", "v" }, "<leader>/", notify("editor.action.commentLine"))
  vim.keymap.set("n", "<leader>cf", notify("editor.action.formatDocument"))

  -- === 診斷跳轉 (Diagnostics) ===
  vim.keymap.set("n", "[d", notify("editor.action.marker.prev"))
  vim.keymap.set("n", "]d", notify("editor.action.marker.next"))

  -- === Antigravity AI 功能 ===
  vim.keymap.set({ "n", "v" }, "<leader>a", notify("antigravity.prioritized.chat.open"))
  vim.keymap.set({ "n", "v" }, "<leader>i", notify("antigravity.prioritized.inlineChat.start"))

  -- === 多游標操作 (Multi-Cursor) ===
  vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
    local status, mulcursor = pcall(require, "vscode-multi-cursor")
    if status then
      mulcursor.addSelectionToNextFindMatch()
    else
      vim.fn.VSCodeNotify("editor.action.addSelectionToNextFindMatch")
    end
  end)
end
