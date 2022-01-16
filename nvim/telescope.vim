if isdirectory(expand('~/.vim/bundle/telescope.nvim'))

lua << EOF
  local actions = require('telescope.actions')
  local previewers = require('telescope.previewers')

  require('telescope').setup{
    defaults = {
      prompt_prefix = "🔭 ",
      selection_caret = " ",
      layout_config = {
          -- vertical = { width = 0.5 },
          horizontal = { prompt_position = "bottom", results_width = 0.6 },
          vertical = { mirror = false }
        },
      mappings = {
          i = {
              ["<esc>"] = actions.close
            },
      },
      file_ignore_patterns = {},
      path_display = {"absolute"},
      winblend = 0,
      border = {},
      borderchars = {
          "─", "│", "─", "│", "╭", "╮", "╯", "╰"
      },
      color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}
    },
    pickers = {
        find_files = {
          prompt = "Find Files: ",
          theme = "dropdown",
        },
        live_grep = {
          prompt = "Grep: ",
          theme = "dropdown",
        },
        grep_string = {
          prompt = "Grep String: ",
          theme = "dropdown",
        },
        treesitter = {
          prompt = "Treesitter: ",
          theme = "dropdown",
        },
        current_buffer_fuzzy_find = {
          prompt = "Fuzzy Find: ",
          theme = "dropdown",
        },
        diagnostics = {
          prompt = "Diagnostics: ",
          theme = "dropdown",
        },
        lsp_code_actions = {
          prompt = "Code Actions: ",
          theme = "cursor",
        },
        lsp_references = {
          prompt = "References: ",
          theme = "dropdown",
        },
        help_tags = {
          prompt = "Help Tags: ",
          theme = "dropdown",
        },
        command = {
          prompt = "Command: ",
          theme = "dropdown",
        },
        buffers = {
          prompt = "Buffers: ",
          theme = "dropdown",
        },
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
      flutter = {},
     -- dap = {},
    },
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('flutter')
 -- close the dap because need study next time
 -- require('telescope').load_extension('dap')

EOF




  " Find files using Telescope command-line sugar.
  nnoremap <space>ff     <cmd>Telescope find_files<cr>
  nnoremap <space>l     <cmd>Telescope live_grep<cr>
  nnoremap <space>fn    <cmd>Telescope current_buffer_fuzzy_find<cr>
  nnoremap <space>t    <cmd>Telescope treesitter<cr>
  nnoremap <space>fb    <cmd>Telescope buffers<cr>
  nnoremap <space>a     <cmd>Telescope diagnostics <cr>
  nnoremap <space>fc    <cmd>Telescope flutter commands<cr>
  nnoremap <space>cc     <cmd>Telescope commands<cr>
  nnoremap <space>j     <cmd>Telescope jumplist<cr>

  " add command to toggle  extensions for lsp
  nnoremap <silent>ga   <cmd>Telescope lsp_range_code_actions<cr>
  nnoremap <silent>gd   <cmd>Telescope lsp_definitions<cr>
  nnoremap <silent>gr   <cmd>Telescope lsp_references<cr>
  nnoremap <silent>gi   <cmd>Telescope lsp_implementations<cr>




endif
