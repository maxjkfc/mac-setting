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

" vim_sneak config
if filereadable(expand("$HOME/.config/nvim/vim_sneak.vim"))
  source $HOME/.config/nvim/vim_sneak.vim
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
