" auto compatible the vim commond
"set nocompatible
" show the rows number
set number
set linebreak                  
set showbreak=+++              
set textwidth=100              
set showmatch                  
set visualbell                 
" hight search result 
set hlsearch                   

set smartcase                  
set ignorecase                 
set incsearch                  
" the hight line
set cursorline
" the hight column
"set cursorcolumn

set laststatus=2
" auto indent 
set autoindent                 
set expandtab                  
set shiftwidth=4               
set smartindent                
set smarttab                   
set softtabstop=4              

" set the backespace active
set backspace=2

" set mapleader
let mapleader = ";"


set bg=dark
" show the status on the right down
set ruler                      

" Pathogen install
execute pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" seti ui 
" Plugin 'trusktr/seti.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'bling/vim-airline'

" Vim-Go
Plugin 'fatih/vim-go'

" YCM (YouCompleteMe)
Plugin 'Valloric/YouCompleteMe'
" Dash Api (mac)
Plugin 'rizzatti/dash.vim'
" NERDtree
Plugin 'scrooloose/nerdtree'
" NERDtree git plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'

Bundle 'majutsushi/tagbar'
" NERDtree tabs
Bundle 'jistr/vim-nerdtree-tabs'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal


"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <Leader>p :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" vim-go custom mappings
" au FileType go nmap <Leader>s <Plug>(go-implements)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
 au FileType go nmap <leader>r <Plug>(go-run)
 au FileType go nmap <leader>b <Plug>(go-build)
 au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <Lader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" au FileType go nmap <Leader>e <Plug>(go-rename)

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_right_sep = "<"

"YCM settings
let g:ycm_key_list_select_completion = ['', '']
let g:ycm_key_list_previous_completion = ['']
let g:ycm_key_invoke_completion = '<C-Space>'
"
 " UltiSnips setting
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Hight light 
syntax on
au BufRead,BufNewFile *.go set filetype=go
" set the vim Theme
colorscheme molokai
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
"let g:molokai_original =1
"let g:rehash256 = 1
