" Coc.vim
if isdirectory(expand('~/.vim/bundle/coc.nvim'))
    " 安裝插件
    let g:coc_global_extensions = [
    \ 'coc-json', 
    \ 'coc-git', 
    \ 'coc-explorer',
    \ 'coc-go',
    \ 'coc-fzf-preview',
    \ 'coc-tabnine',
    \ 'coc-diagnostic' 
    \ ]


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

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call CocAction('fold', <f-args>)


    " Using CocList
    " 顯示所有的問題診斷
    "nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " 顯示所有coc 插件
    "nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " 顯示所有指令
    "nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
    " 取得該檔案的 outline
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " 取得目前 git 狀態
    "nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR> 
    

    " 列出有哪些錯誤
    nnoremap <silent> <space>a     :<C-u>CocCommand fzf-preview.CocDiagnostics <CR>
    nnoremap <silent> <space>aa     :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics <CR>
    " 找尋檔案
    nnoremap <silent> <space>p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
    " 查詢此 Git 狀態
    nnoremap <silent> <space>gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
    " 調用 Git 命令列
    nnoremap <silent> <space>ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
    " 調用 Git Log
    nnoremap <silent> <space>gl    :<C-u>CocCommand fzf-preview.GitLogs<CR>
    " 取得 目前 Buffers 清單
    nnoremap <silent> <space>b     :<C-u>CocCommand fzf-preview.Buffers<CR>
    " 取得 目前所有 Buffers 
    nnoremap <silent> <space>B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
    " 跳轉列表
    nnoremap <silent> <space><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
    " 查看最近修改內容
    nnoremap <silent> <space>g;    :<C-u>CocCommand fzf-preview.Changes<CR>
    " 搜尋此檔案
    nnoremap <silent> <space>/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
    " 搜尋此單字 在此檔案
    nnoremap <silent> <space>*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
    " 搜尋所有檔案
    nnoremap          <space>gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    " 查詢 PullRequest
    nnoremap <silent> <space>pr    :<C-u>CocCommand fzf-preview.BlamePR<CR>
    " 查詢實做
    nnoremap <silent> <space>i    :<C-u>CocCommand fzf-preview.CocImplementations<CR>

    " coc-explorer
    " 啟動檔案管理器
    nmap <space>e :CocCommand explorer <cr>
    " Use preset argument to open it
    " 啟動浮動視窗的 檔案管理列
    nmap <space>ef :CocCommand explorer --preset floating<CR>
    " List all presets
    "nmap <space>el :CocList explPresets
    
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

