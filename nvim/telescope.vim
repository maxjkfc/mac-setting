if isdirectory(expand('~/.vim/bundle/telescope.nvim'))

lua << EOF
  require('telescope').setup{
    defaults = {
      

    },
    pickers = {},
    extensions = {},
  }

EOF




  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fs <cmd>Telescope grep_string<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fe <cmd>Telescope file_browser<cr>
  nnoremap <space>a <cmd>Telescope lsp_workspace_diagnostics<cr>


endif
