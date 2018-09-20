" Set the shell
    set shell=/bin/zsh
" Load the other config
    if filereadable(expand('~/.vimrc.bundles'))
          source ~/.vimrc.bundles
    endif

" Base 
    
   "set nocompatible          " VIM 不使用和 VI 相容的模式
    set clipboard=unnamed     " On mac and Windows, use * register for copy-paste
    filetype plugin indent on " Automatically detect file types.
    syntax on                 " Syntax highlighting
    set mouse=a               " Automatically enable mouse usage
    set mousehide             " Hide the mouse cursor while typing
    set encoding=utf-8
    scriptencoding utf-8
    
     "Always switch to the current file directory
    "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT              " Abbrev. Of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore                 " Allow for cursor beyond last character
    set history=1000                        " Store a ton of history (default is 20)
    set hidden                              " Allow buffer switching without saving
    set backup                              " Backups are nice ...
    set undofile                            " So is persistent undo ...
    set undolevels=1000                     " Maximum number of changes that can be undone
    set undoreload=10000                    " Maximum number lines to save for undo on a buffer reload

    set writebackup
    


" GUI 
    colorscheme molokai-max         " use vim theme
    set background=dark             " Assume a dark background
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    set cursorcolumn
    highlight clear SignColumn      " Sign Column should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    set ruler                       " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                     " Show partial commands in status line and

    set laststatus=2
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code

" Formatting
    set nowrap                              " Do not wrap long lines
    "set autoindent                          " Indent at the same level of the previous line
    set smartindent
    set shiftwidth=4                        " Use indents of 4 spaces
    set expandtab                           " Tabs are spaces, not tabs
    set tabstop=4                           " An indentation every four columns
    set softtabstop=4                       " Let backspace delete indent
    set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                          " Puts new vsplit windows to the right of the current
    set splitbelow                          " Puts new split windows to the bottom of the current

" Key Mappings
    let mapleader =','          " set the key map leader
    let maplocalleader = '_'

    " Easier Moving
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    "To clear search highlighting rather than toggle
    nmap <silent> <leader>/ :nohlsearch<CR>

     " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

     " Some helpers to edit mode
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%
    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " settings for resize splitted window
    nmap w[ :vertical resize -3<CR>
    nmap w] :vertical resize +3<CR>

    nmap w- :resize -3<CR>
    nmap w= :resize +3<CR>

" Plugins


" FZF 
    set runtimepath+=/usr/local/opt/fzf
    function! s:fzf_statusline()
      " Override statusline as you like
      highlight fzf1 ctermfg=161 ctermbg=251
      highlight fzf2 ctermfg=23 ctermbg=251
      highlight fzf3 ctermfg=237 ctermbg=251
      setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
    endfunction

    autocmd! User FzfStatusLine call <SID>fzf_statusline()

    " An action can be a reference to a function that processes selected lines
    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      cc
    endfunction

    let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'down': '~40%' }

    " Enable per-command history.
    let g:fzf_history_dir = '~/.local/share/fzf-history'
    let g:fzf_command_prefix = 'Fzf'
    let g:fzf_buffers_jump = 1
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    let g:fzf_tags_command = 'ctags -R'

    set grepprg=rg\ --vimgrep

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }


    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    " 查詢字典
    
    imap <c-f>w <plug>(fzf-complete-word)
    " 查詢路徑
    imap <c-f>f <plug>(fzf-complete-path)
    " 查詢檔案
    imap <c-f>f <plug>(fzf-complete-file)
    " 查詢行數
    imap <c-f>l <plug>(fzf-complete-line)

    command! -bang -nargs=? -complete=dir FzfFilesP
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    command! -bang -nargs=? -complete=dir FzfGitFilesP
        \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

    command! -bang -nargs=* FzfRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

    command! -bang -nargs=* FzfGGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number '.shellescape(<q-args>), 0,
        \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

    fun! FzfOmniFiles()
      let is_git = system('git status')
      if v:shell_error
        :FzfFilesP
      else
        :FzfGitFilesP
      endif
    endfun

    nnoremap <C-f>l :FzfLines<CR>
    nnoremap <C-f>b :FzfBuffers<CR>
    nnoremap <C-f>r :FzfRg<CR>
    nnoremap <C-f>t :FzfTags<CR>
    nnoremap <C-f>p :call FzfOmniFiles()<CR>
    nnoremap <C-f>h :FzfHistory<CR>
    nnoremap <C-f>s :FzfSnippets<CR>
    nnoremap <C-f>c :FzfCommit<CR>
    nnoremap <C-f>m :FzfMaps<CR>
    nnoremap <C-f>g :FzfGFiles?<CR>
    
" vim-emoji
"
    let g:signify_sign_add = emoji#for('small_blue_diamond')
    let g:signify_sign_change = emoji#for('small_orange_diamond')
    "let g:signify_sign_changedelete = emoji#for('collision')
    let g:signify_sign_delete = emoji#for('small_red_triangle')
    "let g:signify_sign_delete_first_line = emoji#for('small_red_triangle_down')

" Golang
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = 'goimports'
    let g:go_test_timeout = '30s'
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    let g:go_auto_sameids = 1
    let g:go_auto_type_info =1
    let g:go_snippet_engine = 'neosnippet'
    
    augroup golangcmd
        au FileType go nmap <Leader>s <Plug>(go-implements)
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>e <Plug>(go-rename)
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <leader>co <Plug>(go-coverage)
    augroup END

" Rainbow
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" Multip Cursor
    let g:multi_cursor_next_key = '<C-n>'
    let g:multi_cursor_prev_key = '<C-p>'
    let g:multi_cursor_skip_key = '<C-x>'
    let g:multi_cursor_quit_key = '<Esc>'

" deoplete
    let g:deoplete#enable_at_startup = 1
    " Disable deoplete when in multi cursor mode
    function! Multiple_cursors_before()
        let b:deoplete_disable_auto_complete = 1
    endfunction

    function! Multiple_cursors_after()
        let b:deoplete_disable_auto_complete = 0
    endfunction

    set completeopt+=noselect

    " deoplete-go
    let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
    let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
    let g:deoplete#sources#go#use_cache = 1
    let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/'

" markdown
    " plasticboy/vim-markdown
    let g:vim_markdown_folding_disabled = 1

" NerdTree
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
        "map <C-e> <plug>NERDTreeTabsToggle<CR>
        "map <leader>e :NERDTreeFind<CR>
        "nmap <leader>nt :NERDTreeFind<CR>
        map <leader>e <plug>NERDTreeTabsToggle<CR>            

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    endif

" easy-align
    if isdirectory(expand("~/.vim/bundle/vim-easy-align"))
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)
        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)
    endif


" TagBar 
    if isdirectory(expand('~/.vim/bundle/tagbar/'))
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
    endif
" Rainbow 
    if isdirectory(expand('~/.vim/bundle/rainbow/'))
        let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    endif
" Fugitive
    if isdirectory(expand('~/.vim/bundle/vim-fugitive/'))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
    endif
" Airline
    let g:airline_theme='molokai'
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_extensions = ['tagbar']
    let g:airline#extensions#ale#enabled = 1

" vim-indent-guides
    if isdirectory(expand('~/.vim/bundle/vim-indent-guides/'))
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    endif

" UndoTree
    if isdirectory(expand('~/.vim/bundle/undotree/'))
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
     endif

" WildFire
    if isdirectory(expand('~/.vim/bundle/wildfire.vim/'))
        let g:wildfire_objects = {
        \ '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
        \ 'html,xml' : ['at'],
        \ }
    endif
" vim-easymotion
    let g:EasyMotion_do_mapping = 0 " Disable default mappings

    let g:EasyMotion_smartcase = 1
    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)

"FileType
 " Filetype: Sh, Zsh {{{2
    augroup filetypedetect
        au FileType zsh,sh setl com-=:# sts=4 sw=4
                \| com! -buffer Lint Grepper -noprompt -buffer -grepprg shellcheck -fgcc
        au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
        au FileType yaml,yml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufReadPost *.md setfiletype markdown
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup END

" Code Fmt
    augroup autoformat_settings
      autocmd FileType bzl AutoFormatBuffer buildifier
      autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
      autocmd FileType dart AutoFormatBuffer dartfmt
      autocmd FileType go AutoFormatBuffer gofmt
      autocmd FileType gn AutoFormatBuffer gn
      autocmd FileType html,css,json AutoFormatBuffer js-beautify
      autocmd FileType java AutoFormatBuffer google-java-format
      autocmd FileType python AutoFormatBuffer yapf
    augroup END
" Ale
    let g:ale_sign_error = emoji#for('x')
    let g:ale_sign_warning = emoji#for('sos')
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views':  'viewdir',
                    \ 'swap':   'directory',
                    \ 'undo':   'undodir'}

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists('*mkdir')
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo 'Warning: Unable to create backup directory: ' . directory
                echo 'Try: mkdir -p ' . directory
            else
                let directory = substitute(directory, ' ', "\\\\ ", 'g')
                exec 'set ' . settingname . '=' . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()

" Startify
     let g:startify_custom_header = [
                \'    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',
                \'    @@@@@@@@@@@@@@@@@@*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,,,,@@@@@@@@@@@@@@@@@,,,,@@@@@@@@,,,,@@@',
                \'    @@@@@@@@@@@@@@@@@***@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@@@@@****,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@@@@******@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@@@********@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@@****@@****@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@****@@@@****@@@@@****@@@@@****@@,*****@@@@@****@@@@@@*****@@@@@@*********,@@****@@@',
                \'    @@@@@@@@@@@****@@@@@@****@@@@@****@@@****@@.*******@@@@****@@@@@*******@@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@@****@@@@@@@@****@@@@@****@@@**@@@****@****@@@****@@@@****@****@@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@@****@@@@@@@@@@@@@@@@@@@****@@@@@@****@@,****@@****@@@****@@@****@@@****@@@@@@@@****@@@',
                \'    @@@@@@@@****@@@*************@@@@@****@@@@@@@@@@@@@@@@@@****@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@',
                \'    @@@@@@@*****@@***************@@@@*****@@@****@@@@****@@****@@****@@@@,****@@@****@@@@@@@****@@@',
                \'    @@@@@@****,@@@@@@@@@@@@@@*****@@*******@@@****@@*****@@****@@@****@@.****@@@@@****@@@@@@****@@@',
                \'    @@@@@*****@@@@@@@@@@@@@@@@****,****@****@@@********@@@@****@@@@****@****@@@@@@@****@@@@@****@@@',
                \'    @@@@*****@@@@@@@@@@@@@@@@@@*******@@@****@@@******@@@@@****@@@@@*******@@@@@@@@@****@@@@****@@@',
                \'    @@@*****@@@@@@@@@@@@@@@@@@@@*****@@@@@****@@@****@@@@@@****@@@@@@,****@@@@@@@@@@@****@@@****@@@',
                \'    @@.****@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@@@',
                \'    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',
                \ ]
