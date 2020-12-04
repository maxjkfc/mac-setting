let s:bundle_dir = $HOME.'/.vim/bundle'
let g:plug_shallow = 0
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'

call plug#begin(s:bundle_dir)

" Golang
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' , 'for':'go'}
    Plug 'tweekmonster/hl-goimport.vim', { 'for': 'go' }
    
" Snippet
    "Plug 'honza/vim-snippets'
    "Plug 'SirVer/ultisnips'

" Code fmt 
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'

" ColorScheme
    Plug 'dracula/vim',{'as':'dracula'}

" Tools
    Plug 'tpope/vim-sensible'
    " 快速產生對應的括弧
    Plug 'jiangmiao/auto-pairs'
    " 可視化縮進的插件
    Plug 'nathanaelkane/vim-indent-guides'
    " 快速選取區塊內容
    Plug 'gcmt/wildfire.vim'
    " 多游標選取
    Plug 'terryma/vim-multiple-cursors'    

" EasyMotion
    " 快速移動
    Plug 'easymotion/vim-easymotion'

" Emoji
    Plug 'junegunn/vim-emoji'

" GUI
    " vim 登入起始畫面
    Plug 'mhinz/vim-startify'
    " 彩虹括弧
    Plug 'luochen1990/rainbow'

" Importain    
    " 快速建立雙引號
    Plug 'tpope/vim-surround'   
    " 快速註解
    Plug 'scrooloose/nerdcommenter' 
    " 快速對齊
    Plug 'junegunn/vim-easy-align', { 'on': '<plug>(EasyAlign)' }
    " 標籤視窗
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" FZF
    Plug 'junegunn/fzf.vim' 
    Plug 'junegunn/fzf'

" syntax
    Plug 'ekalinin/Dockerfile.vim' , {'for': 'dockerfile' }
    Plug 'cespare/vim-toml' , {'for': 'toml'}
    Plug 'chrisbra/csv.vim' , {'for': 'csv'}
    Plug 'towolf/vim-helm', {'for':'yaml,yml' }

" Git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/conflict-marker.vim'
    "Plug 'mhinz/vim-signify'
    "Plug 'airblade/vim-gitgutter'
" UndoTree
    Plug 'mbbill/undotree'

" Ale
    Plug 'dense-analysis/ale'
" StatusLine (AirLine  , LightLine)
    Plug 'powerline/fonts'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'
    Plug 'josa42/vim-lightline-coc'
"HTML
    Plug 'gorodinskiy/vim-coloresque'
" dev-icons
    Plug 'ryanoasis/vim-devicons'
" markdown
    Plug 'plasticboy/vim-markdown' , {'for':'md'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" other
    Plug 'wakatime/vim-wakatime'
"
    "Plug 'tweekmonster/startuptime.vim'
    Plug 'dstein64/vim-startuptime'


call plug#end()
