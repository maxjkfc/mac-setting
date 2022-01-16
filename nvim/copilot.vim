if isdirectory(expand('~/.vim/bundle/copilot.vim'))

  let g:copilot_filetypes = {
        \ '*': v:true,
        \ '.vim': v:false,
        \ }
  " imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  " let g:copilot_no_tab_map = v:true
  highlight CopilotSuggestion guifg=#555555 ctermfg=8
endif
