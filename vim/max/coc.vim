" Coc.vim
if isdirectory(expand('~/.vim/bundle/coc.nvim'))
    " better display for message
    "set cmdheight=2
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300
    " don't give |ins-completion-menu| messages.
    set shortmess+=c
    " always show signcolumns
    set signcolumn=yes
    "set signcolumn=auto:2

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



    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[d` and `]d` to navigate diagnostics
    " 進入下一個診斷
    nmap <silent> [d <Plug>(coc-diagnostic-prev)
    " 上一個診斷
    nmap <silent> ]d <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    " 進入下一個定義
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use gh to show documentation in preview window
    " 展現coc 文件
    nnoremap <silent> gh :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocActionAsync('doHover')
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
    "vmap <leader>a  <Plug>(coc-codeaction-selected)
    "nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    "nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    "nmap <leader>qf  <Plug>(coc-fix-current)
    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)


    " Using CocList
    " 顯示所有的問題診斷
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " 顯示所有coc 插件
    "nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " 顯示所有指令
    nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
    " 取得該檔案的 outline
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    "nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    "nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    "nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    "nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    " 取得目前 git 狀態
    nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR> 

    " coc-explorer
    " 啟動檔案管理器
    nmap <space>e :CocCommand explorer <cr>
    " Use preset argument to open it
    " 啟動檔案管理列在 .vim 內
    "nmap <space>ed :CocCommand explorer --preset .vim<CR>
    " 啟動浮動視窗的 檔案管理列
    nmap <space>ef :CocCommand explorer --preset floating<CR>
    " List all presets
    "nmap <space>el :CocList explPresets
    
    " 多個浮標支援
    " Multiple cursors support
    "hi CocCursorRange guibg=red guifg=white
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
    " coc-snippet  使用 tab 去觸發下一個要輸入的參數
    let g:coc_snippet_next = '<tab>'
    " coc-snippet 使用<ctrl-k> 去出發上一個要輸入的參數
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
    
    " 依據此行去列出有相關 單字的行數
    nnoremap <silent> <space>f :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
    " 依據此單字去列出有相關 單字
    nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
    
    " 大於 1M 的檔案就不開啟 coc - autocomplete
    let g:trigger_size = 1*1048576
    augroup hugefile
      autocmd!
      autocmd BufReadPre *
            \ let size = getfsize(expand('<afile>')) |
            \ if (size > g:trigger_size) || (size == -2) |
            \   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
            \   exec 'CocDisable' |
            \ else |
            \   exec 'CocEnable' |
            \ endif |
            \ unlet size
    augroup END
    "
endif

