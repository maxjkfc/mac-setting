return {
  -- {
  --   -- Golang 擴充套件
  --   "ray-x/go.nvim",
  --   dependencies = "ray-x/guihua.lua",
  --   config = function()
  --     local opt = {
  --       -- cmd = { "gopls" },
  --       -- filetype = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
  --       lsp_document_formattings = false,
  --       disable_defaults = true,
  --       gopls_remote_auto = true, -- add -remote=auto to gopls
  --       textobjects = true, -- enable default text jobects through treesittter-text-objects
  --       test_runner = "richgo", -- richgo, go test, richgo, dlv, ginkgo
  --       lsp_inlay_hints = {
  --         enable = true,
  --         -- Only show inlay hints for the current line
  --         only_current_line = false,
  --         -- Event which triggers a refersh of the inlay hints.
  --         -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
  --         -- not that this may cause higher CPU usage.
  --         -- This option is only respected when only_current_line and
  --         -- autoSetHints both are true.
  --         only_current_line_autocmd = "CursorHold",
  --         -- whether to show variable name before type hints with the inlay hints or not
  --         -- default: false
  --         show_variable_name = true,
  --         -- prefix for parameter hints
  --         parameter_hints_prefix = " ",
  --         show_parameter_hints = true,
  --         -- prefix for all the other hints (type, chaining)
  --         other_hints_prefix = "=> ",
  --         -- whether to align to the lenght of the longest line in the file
  --         max_len_align = false,
  --         -- padding from the left if max_len_align is true
  --         max_len_align_padding = 1,
  --         -- whether to align to the extreme right or not
  --         right_align = false,
  --         -- padding from the right if right_align is true
  --         right_align_padding = 6,
  --         -- The color of the hints
  --         highlight = "Comment",
  --       },
  --       trouble = true,
  --       tag_options = "json=omitempty", -- sets options sent to gomodifytags, i.e., json=omitempty
  --       fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
  --     }
  --     require("go").setup(opt)
  --   end,
  -- },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
        },
      },
    },
  },
}
