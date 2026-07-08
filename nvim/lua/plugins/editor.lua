return {
  -- 先暫時移除，後續再考慮要不要加回來
  -- {
  --   "mg979/vim-visual-multi",
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        proto = { "buf_lint" },
      },
    },
  },
}
