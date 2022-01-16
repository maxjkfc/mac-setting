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
  " statusline
  Plug 'nvim-lualine/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  
" 檔案管理工具
  " nvim-tree
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

" 小工具
  " 可視化色塊工具
  Plug 'norcalli/nvim-colorizer.lua'
  " terminal tools
  Plug 'akinsho/toggleterm.nvim' 

" Startup
  " 美化登入起始畫面
  Plug 'glepnir/dashboard-nvim'

" 文本工具
  " 快速建立/替換/移除對應的括弧或雙引號等符號
  Plug 'tpope/vim-surround'   
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
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-dap.nvim'

" lsp
  " nvim officel lsp tools
  Plug 'neovim/nvim-lspconfig'
  " 強化提供提示訊息的Lsp 插件
  Plug 'ray-x/lsp_signature.nvim'
  " 強化lsp工具
  Plug 'folke/lsp-colors.nvim'
  Plug 'folke/trouble.nvim'

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
    " debug golang for dap 
    " Plug 'leoluz/nvim-dap-go'
  " debug tools
    " Plug 'mfussenegger/nvim-dap'
    " Plug 'rcarriga/nvim-dap-ui'
  " github copilot 輔助系統
    Plug 'github/copilot.vim'
  " flutter
    " flutter SDK
    Plug 'nvim-lua/plenary.nvim'
    Plug 'akinsho/flutter-tools.nvim' , { 'for': 'dart' }
    Plug 'dart-lang/dart-vim-plugin' ,{ 'for':'dart' }
  " git
    " git 擴充指令插件
    Plug 'tpope/vim-fugitive'
    " git 擴充插件工具
    Plug 'lewis6991/gitsigns.nvim'
  " tag
    Plug 'liuchengxu/vista.vim'   
call plug#end()
