if isdirectory(expand('~/.vim/bundle/dashboard-nvim'))
  " 設定預設模糊搜尋工具
  let g:dashboard_default_executive = 'fzf'
  " 設定表單快捷鍵
  "SPC mean the leaderkey
  let g:dashboard_custom_shortcut={
    \ 'last_session'       : '',
    \ 'find_history'       : '',
    \ 'find_file'          : '',
    \ 'new_file'           : '',
    \ 'change_colorscheme' : '',
    \ 'find_word'          : '',
    \ 'book_marks'         : '',
    \ }

  " 暫時關閉
  "nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
  "nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
  "nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
  "nnoremap <silent> <Leader>fw :DashboardFindWord<CR>
  "nnoremap <silent> <Leader>nf :DashboardNewFile<CR>
  "nnoremap <silent> <Leader>bm :DashboardJumpMark<CR>

  " 禁止 tabline 在 dashboard 中啟動
  autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
  " 設定顯示標頭圖標
  let g:dashboard_custom_header = [
                              \'████████╗██╗   ██╗██████╗    ███╗   ███╗ █████╗ ██╗  ██╗',
                              \'╚══██╔══╝╚██╗ ██╔╝██╔══██╗   ████╗ ████║██╔══██╗╚██╗██╔╝',
                              \'   ██║    ╚████╔╝ ██████╔╝   ██╔████╔██║███████║ ╚███╔╝ ',
                              \'   ██║     ╚██╔╝  ██╔══██╗   ██║╚██╔╝██║██╔══██║ ██╔██╗ ',
                              \'   ██║      ██║   ██║  ██║██╗██║ ╚═╝ ██║██║  ██║██╔╝ ██╗',
                              \'   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝',
                              \ ]

endif
