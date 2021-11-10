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
  " nvim-tree
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

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
  " 快速對齊
  Plug 'junegunn/vim-easy-align'
  " 自動產生對應符號
  Plug 'jiangmiao/auto-pairs'


" 核心工具
  " 多游標選取
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " 快速移動
  Plug 'easymotion/vim-easymotion'

" tressiter 工具套組
  " 核心 - Syntax highlighting 語法高亮
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

" fuzzy finder
  " FZF
  Plug 'junegunn/fzf.vim' 
  Plug 'junegunn/fzf'
  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

" lsp
  " lsp tools
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim' 

  " coq-nvim
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  " 9000+ Snippets
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

  " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
  " Need to **configure separately**
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}


" develop
  " golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' , 'for':'go'}
  " github copilot 輔助系統
  Plug 'github/copilot.vim'

call plug#end()
