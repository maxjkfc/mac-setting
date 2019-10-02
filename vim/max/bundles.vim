let s:bundle_dir = $HOME.'/.vim/bundle'
let g:plug_shallow = 0
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'

call plug#begin(s:bundle_dir)

" TabNine
    "Plug 'zxqfl/tabnine-vim'

" Golang
    Plug 'fatih/vim-go', { 'for': 'go' ,'tag': '*' }
    Plug 'tweekmonster/hl-goimport.vim', { 'for': 'go' }
    
" Snippet
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'

" Code fmt 
    "Plug 'google/vim-maktaba'
    "Plug 'google/vim-codefmt'
    "Plug 'google/vim-glaive'

" ColorScheme
    Plug 'google/vim-colorscheme-primary'
    Plug 'morhetz/gruvbox'

" Dash
    Plug 'rizzatti/dash.vim' , {'on':'Dash'}

" Tools
    Plug 'tpope/vim-sensible'
    " 快速產生對應的括弧
    Plug 'jiangmiao/auto-pairs'
    " 可視化縮進的插件
    Plug 'nathanaelkane/vim-indent-guides'
    " 快速選取區塊內容
    Plug 'gcmt/wildfire.vim'

" EasyMotion
    " 快速移動
    Plug 'easymotion/vim-easymotion'

" Emoji
    Plug 'junegunn/vim-emoji'

" GUI
    Plug 'mhinz/vim-startify'
    " 彩虹括弧
    Plug 'luochen1990/rainbow'

" Importain    
    " 快速建立雙引號
    Plug 'tpope/vim-surround'   
    " 快速註解
    Plug 'scrooloose/nerdcommenter'                                     " Easy commenting
    " 快速對齊
    Plug 'junegunn/vim-easy-align', { 'on': '<plug>(EasyAlign)' }
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" FZF
    Plug '/usr/local/bin/fzf'
    "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim' 

" NerdTree
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'jistr/vim-nerdtree-tabs'

" syntax
    Plug 'elzr/vim-json'
    Plug 'stephpy/vim-yaml'
    Plug 'ekalinin/Dockerfile.vim'
    Plug 'chr4/nginx.vim'
    Plug 'cespare/vim-toml'
    Plug 'chrisbra/csv.vim'


" Git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'mhinz/vim-signify'

" UndoTree
    Plug 'mbbill/undotree'

" Ale
    Plug 'dense-analysis/ale'
    
" AirLine 
    Plug 'powerline/fonts'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'

" HTML
    Plug 'gorodinskiy/vim-coloresque'
    "Plug 'hail2u/vim-css3-syntax'
    "Plug 'mattn/emmet-vim', { 'for': 'html' }
    "Plug 'pangloss/vim-javascript'

" dev-icons
    Plug 'ryanoasis/vim-devicons'

" markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" coc
"
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
