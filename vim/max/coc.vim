" Coc.vim
if isdirectory(expand('~/.vim/bundle/coc.nvim'))
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=100
    " don't give |ins-completion-menu| messages.
    set shortmess+=c
    " always show signcolumns
    set signcolumn=yes

     "Use tab for trigger completion with characters ahead and navigate.
     "Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction


    " Use <c-space> to trigger completion.
    "inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[d` and `]d` to navigate diagnostics
    " 進入下一個診斷
    nmap <silent> [d <Plug>(coc-diagnostic-prev)
    nmap <silent> ]d <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    " 進入下一個定義
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <c-]> <Plug>(coc-definiton)

    " Use K to show documentation in preview window
    " 展現coc 文件
    nnoremap <silent> gh :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    "nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    "nmap <leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)


    " Using CocList
    " Show all diagnostics
    " 顯示所有的問題診斷
    "nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    "nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
     "Show commands
    "nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    " 取得該檔案的 outline
    "nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    "nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    "nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    "nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    "nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    
    " coc fzf 
    nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<CR>
    nnoremap <silent> <space>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
    "nnoremap <silent> <space>c  :<C-u>CocFzfList commands<CR>
    "nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<CR>
    "nnoremap <silent> <space>l  :<C-u>CocFzfList location<CR>
    nnoremap <silent> <space>o  :<C-u>CocFzfList outline<CR>
    "nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<CR>
    "nnoremap <silent> <space>S  :<C-u>CocFzfList services<CR>
    "nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>

    " coc-explorer
    nmap <space>e :CocCommand explorer <cr>
    " Use preset argument to open it
    nmap <space>ed :CocCommand explorer --preset .vim<CR>
    nmap <space>ef :CocCommand explorer --preset floating<CR>
    " List all presets
    "nmap <space>el :CocList explPresets
    
    " Multiple cursors support
    hi CocCursorRange guibg=red guifg=blue
    "xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
    "nmap <silent> <C-d> <Plug>(coc-cursors-word)*
    "xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
    "xmap <silent> <C-n> <Plug>(coc-cursors-range)


    " coc-snippets
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)
    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)
    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    " Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
    let g:coc_snippet_next = '<tab>'
    let g:coc_snippet_prev = '<c-k>'

    " coc-lists
    " grep word under cursor
    command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

    function! s:GrepArgs(...)
      let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
            \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
      return join(list, "\n")
    endfunction

    " Keymapping for grep word under cursor with interactive mode
    "nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
    "nnoremap <silent> <Leader>cfw  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
    "nnoremap <silent> <space>f :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
    "nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
    
endif

