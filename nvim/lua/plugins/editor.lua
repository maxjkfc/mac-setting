return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          always_show = {
            ".gitignore",
            ".dockerignore",
            ".github",
          },
          always_show_by_pattern = {
            ".env*",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["v"] = "open_vsplit",
        },
      },
    },
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
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
