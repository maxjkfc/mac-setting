let s:bundle_dir = $HOME.'/.vim/bundle'
let g:plug_shallow = 0
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'

call plug#begin(s:bundle_dir)

" Golang
    Plug 'fatih/vim-go', { 'for': 'go' ,'tag': '*' }
    Plug 'tweekmonster/hl-goimport.vim', { 'for': 'go' }
    Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/bundle/gocode/vim/symlink.sh' }

" Deoplete  

    if has('nvim')
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/deoplete.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif

    Plug 'fszymanski/deoplete-emoji'
    Plug 'zchee/deoplete-go',{'do':'make'}
    Plug 'zchee/deoplete-jedi'
    Plug 'zchee/deoplete-zsh' ,{ 'for': ['zsh' , 'sh'] }
    Plug 'Shougo/neco-vim'
    Plug 'Shougo/neco-syntax'
    
" Snippet
    "Plug 'Shougo/neosnippet.vim'
    "Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'

" Code fmt 
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'

" Dash
    Plug 'rizzatti/dash.vim' , {'on':'Dash'}

" Tools
    Plug 'tpope/vim-sensible'
    Plug 'jiangmiao/auto-pairs'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'gcmt/wildfire.vim'

" EasyMotion
    Plug 'easymotion/vim-easymotion'

" Emoji
    Plug 'junegunn/vim-emoji'

" GUI
    Plug 'mhinz/vim-startify'
    Plug 'luochen1990/rainbow'

" Importain    
    Plug 'tpope/vim-surround'   
    Plug 'scrooloose/nerdcommenter'                                     " Easy commenting
    Plug 'terryma/vim-multiple-cursors'
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
    Plug 'w0rp/ale'
    
" AirLine || lightline
    Plug 'powerline/fonts'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'

" HTML
    Plug 'gorodinskiy/vim-coloresque'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'mattn/emmet-vim', { 'for': 'html' }
    Plug 'pangloss/vim-javascript'
    Plug 'prettier/vim-prettier', { 'for': 'javascript' }

" dev-icons
    Plug 'ryanoasis/vim-devicons'

" markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()
