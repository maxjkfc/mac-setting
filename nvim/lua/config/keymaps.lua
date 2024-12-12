-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
if vim.g.vscode then
  -- VSCode extension
  -- gr 跳轉到定義
  vim.api.nvim_set_keymap(
    "n",
    "gr",
    [[<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>]],
    { silent = true }
  )

  -- 跳轉到實作
  --  gi 跳轉到實作
  vim.api.nvim_set_keymap(
    "n",
    "gi",
    [[<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>]],
    { silent = true }
  )

  -- 註解
  -- <leader>/ 註解
  vim.api.nvim_set_keymap(
    "n",
    "<leader>/",
    [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]],
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "v",
    "<leader>/",
    [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]],
    { silent = true }
  )

  -- <leader>e 開啟檔案總管
  vim.api.nvim_set_keymap("n", "<space>e", [[<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>]], { silent = true })

  -- [d 跳轉到下一個錯誤提示
  vim.api.nvim_set_keymap(
    "n",
    "[d",
    [[<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>]],
    { silent = true }
  )

  -- ]d 跳轉到上一個錯誤提示
  vim.api.nvim_set_keymap(
    "n",
    "]d",
    [[<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>]],
    { silent = true }
  )

  -- 設定 vscode-multi-cursor
  -- 額外添加 Ctrl-d 映射
  vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
    require("vscode-multi-cursor").addSelectionToNextFindMatch()
  end)
end
