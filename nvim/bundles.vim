let s:bundle_dir = $HOME.'/.vim/bundle'
let g:plug_shallow = 0
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'

call plug#begin(s:bundle_dir)
" Theme
  " ColorScheme
  Plug 'dracula/vim',{'as':'dracula'}
  " 可視化縮進的插件
  Plug 'nathanaelkane/vim-indent-guides'
  " vim emoji support
  Plug 'junegunn/vim-emoji'
  " 彩虹括弧
  Plug 'luochen1990/rainbow'
  " 檔案管理工具
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'jiangmiao/auto-pairs'

" 小工具
  " 可視化色塊工具
  Plug 'norcalli/nvim-colorizer.lua'

" Startup
  " 美化登入起始畫面
  Plug 'glepnir/dashboard-nvim'

" 文本工具
  " 快速建立/替換/移除對應的括弧或雙引號等符號
  Plug 'tpope/vim-surround'   
  " 快速選取區塊內容
  Plug 'gcmt/wildfire.vim'
  " 快速註解
  Plug 'scrooloose/nerdcommenter'
  " 快速建立相應區塊
  Plug 'rstacruz/vim-closer'
  " 快速對齊
  Plug 'junegunn/vim-easy-align'

" 核心工具
  " 多游標選取
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " 快速移動
  Plug 'justinmk/vim-sneak'

" tressiter 工具套組
  " 核心 - Syntax highlighting 語法高亮
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

" fuzzy finder
  " FZF
  Plug 'junegunn/fzf.vim' 
  Plug 'junegunn/fzf'

" lsp
  " golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' , 'for':'go'} 

call plug#end()
