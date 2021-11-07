if isdirectory(expand('~/.vim/bundle/lspsaga.nvim'))

lua<<EOF
  local saga = require 'lspsaga'

  saga.init_lsp_saga{
    -- add your config value here
    -- default value
    use_saga_diagnostic_sign = true,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    dianostic_header_icon = '   ',
    code_action_icon = ' ',
    code_action_prompt = {
       enable = true,
       sign = true,
       sign_priority = 20,
       virtual_text = true,
    },
    finder_definition_icon = '  ',
    finder_reference_icon = '  ',
    max_preview_lines = 20, -- preview lines of lsp_finder and definition preview
    finder_action_keys = {
      open = 'l', vsplit = 'v',split = 's',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    code_action_keys = {
      quit = 'q',exec = '<CR>'
    },
    rename_action_keys = {
      quit = '<C-c>',exec = '<CR>'  -- quit can be a table
    },
    definition_preview_icon = '  ',
    -- "single" "double" "round" "plus"
    border_style = "single",
    rename_prompt_prefix = '➤',
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    -- server_filetype_map = {}
  }

EOF


  nnoremap <silent> gd :Lspsaga lsp_finder<CR>
  " have bug in neovim 0.5.1
  " nnoremap <silent><leader>la :Lspsaga code_action<CR>
  " vnoremap <silent><leader>la :<C-U>Lspsaga range_code_action<CR>
  nnoremap <silent> K :Lspsaga hover_doc<CR>

  "-- scroll down hover doc or scroll in definition preview
  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  "-- scroll up hover doc
  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

  nnoremap <silent> gs :Lspsaga signature_help<CR>
  nnoremap <silent> gr :Lspsaga rename<CR>
  nnoremap <silent> gh :Lspsaga preview_definition<CR>

  nnoremap <silent> <space>al :Lspsaga show_line_diagnostics<CR>
  nnoremap <silent> <space>ac <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

  "jump diagnostic
  nnoremap <silent> [d :Lspsaga diagnostic_jump_next<CR>
  nnoremap <silent> ]d :Lspsaga diagnostic_jump_prev<CR>


  nnoremap <silent> <space>t :Lspsaga open_floaterm<CR>
  tnoremap <silent> <space>t <C-\><C-n>:Lspsaga close_floaterm<CR>

  highlight link LspSagaFinderSelection Search

endif

