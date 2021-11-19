if isdirectory(expand('~/.vim/bundle/telescope.nvim'))

lua << EOF
  local actions = require('telescope.actions')
  local previewers = require('telescope.previewers')



  require('telescope').setup{
    defaults = {
      layout_config = {
          vertical = { width = 0.5 },
        },
      mappings = {
          i = {
              ["<esc>"] = actions.close
            },
      },
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
        lsp_workspace_diagnostics = {
          prompt = "Diagnostics: ",
          theme = "dropdown",
        },
        lsp_workspace_symbols = {
          prompt = "Symbols: ",
          theme = "dropdown",
        },
        lsp_code_actions = {
          prompt = "Code Actions: ",
          theme = "cursor",
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
  nnoremap <space>f     <cmd>Telescope find_files<cr>
  nnoremap <space>r     <cmd>Telescope live_grep<cr>
  nnoremap <space>rb    <cmd>Telescope current_buffer_fuzzy_find<cr>
  nnoremap <space>rs    <cmd>Telescope grep_string<cr>
  nnoremap <space>ft    <cmd>Telescope treesitter<cr>
  nnoremap <space>fb    <cmd>Telescope buffers<cr>
  nnoremap <space>fh    <cmd>Telescope help_tags<cr>
  " nnoremap <space>fe    <cmd>Telescope file_browser<cr>
  nnoremap <space>a     <cmd>Telescope lsp_workspace_diagnostics<cr>
  nnoremap <space>fc    <cmd>Telescope flutter commands<cr>
  " nnoremap <space>d     <cmd>Telescope dap commands<cr>
  nnoremap <space>c     <cmd>Telescope commands<cr>
  " add command to toggle  extensions for lsp
  nnoremap <silent>ga   <cmd>Telescope lsp_code_actions<cr>




endif
