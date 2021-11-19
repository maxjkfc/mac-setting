" 設置運行的路徑在 ~/.vim 
set runtimepath^=~/.config/nvim

" 套件安裝
if filereadable(expand("$HOME/.config/nvim/bundles.vim"))
  source $HOME/.config/nvim/bundles.vim
endif

" base setting config
if filereadable(expand("$HOME/.config/nvim/setting.vim"))
  source $HOME/.config/nvim/setting.vim
endif

" visual_multi config
if filereadable(expand("$HOME/.config/nvim/visual_multi.vim"))
  source $HOME/.config/nvim/visual_multi.vim
endif

" vim_emoji config
if filereadable(expand("$HOME/.config/nvim/vim_emoji.vim"))
  source $HOME/.config/nvim/vim_emoji.vim
endif

" wildfire config
if filereadable(expand("$HOME/.config/nvim/wildfire.vim"))
  source $HOME/.config/nvim/wildfire.vim
endif

" dashboard_nvim config
if filereadable(expand("$HOME/.config/nvim/dashboard_nvim.vim"))
  source $HOME/.config/nvim/dashboard_nvim.vim
endif

" rainbow config
if filereadable(expand("$HOME/.config/nvim/rainbow.vim"))
  source $HOME/.config/nvim/rainbow.vim
endif

" nvim_tree config
if filereadable(expand("$HOME/.config/nvim/nvim_tree.vim"))
  source $HOME/.config/nvim/nvim_tree.vim
endif

" dracula config
if filereadable(expand("$HOME/.config/nvim/dracula.vim"))
  source $HOME/.config/nvim/dracula.vim
endif

" colorizer config
if filereadable(expand("$HOME/.config/nvim/colorizer.vim"))
  source $HOME/.config/nvim/colorizer.vim
endif

" easy_align config
if filereadable(expand("$HOME/.config/nvim/easy_align.vim"))
  source $HOME/.config/nvim/easy_align.vim
endif

" nerdcomment config
if filereadable(expand("$HOME/.config/nvim/nerdcomment.vim"))
  source $HOME/.config/nvim/nerdcomment.vim
endif

" coq config
if filereadable(expand("$HOME/.config/nvim/coq.vim"))
  source $HOME/.config/nvim/coq.vim
endif

" lspsaga config
if filereadable(expand("$HOME/.config/nvim/lspsaga.vim"))
  source $HOME/.config/nvim/lspsaga.vim
endif

" lspconfig config
if filereadable(expand("$HOME/.config/nvim/lspconfig.vim"))
  source $HOME/.config/nvim/lspconfig.vim
endif

" vim_go config
if filereadable(expand("$HOME/.config/nvim/vim_go.vim"))
  source $HOME/.config/nvim/vim_go.vim
endif
" easymotion config
if filereadable(expand("$HOME/.config/nvim/easymotion.vim"))
  source $HOME/.config/nvim/easymotion.vim
endif
" telescope config
if filereadable(expand("$HOME/.config/nvim/telescope.vim"))
  source $HOME/.config/nvim/telescope.vim
endif
" copilot config
if filereadable(expand("$HOME/.config/nvim/copilot.vim"))
  source $HOME/.config/nvim/copilot.vim
endif
" flutter config
if filereadable(expand("$HOME/.config/nvim/flutter.vim"))
  source $HOME/.config/nvim/flutter.vim
endif
" dart config
if filereadable(expand("$HOME/.config/nvim/dart.vim"))
  source $HOME/.config/nvim/dart.vim
endif
" lualine config
if filereadable(expand("$HOME/.config/nvim/lualine.vim"))
  source $HOME/.config/nvim/lualine.vim
endif
" gitsigns config
if filereadable(expand("$HOME/.config/nvim/gitsigns.vim"))
  source $HOME/.config/nvim/gitsigns.vim
endif
" lsp_signature config
if filereadable(expand("$HOME/.config/nvim/lsp_signature.vim"))
  source $HOME/.config/nvim/lsp_signature.vim
endif

" nvim-dap config
if filereadable(expand("$HOME/.config/nvim/nvim-dap.vim"))
  source $HOME/.config/nvim/nvim-dap.vim
endif
