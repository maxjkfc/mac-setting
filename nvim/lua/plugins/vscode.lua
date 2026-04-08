return {
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    -- 關鍵設定：只有在 VS Code / Antigravity 環境下才啟用
    cond = not not vim.g.vscode,
    -- 這會自動呼叫 require("vscode-multi-cursor").setup({})
    opts = {}, 
  },
}