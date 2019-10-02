    if isdirectory(expand('~/.vim/bundle/fzf.vim'))
        set runtimepath+=/usr/local/opt/fzf
        function! s:fzf_statusline()
          " Override statusline as you like
          highlight fzf1 ctermfg=161 ctermbg=251
          highlight fzf2 ctermfg=23 ctermbg=251
          highlight fzf3 ctermfg=237 ctermbg=251
          setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
        endfunction
        
        augroup fzfstatus
            autocmd! User FzfStatusLine call <SID>fzf_statusline()
        augroup END

        let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-v': 'vsplit' }

        " Default fzf layout
        " - down / up / left / right
        let g:fzf_layout = { 'down': '~40%' }

        " Enable per-command history.
        let g:fzf_history_dir = '~/.local/share/fzf-history'
        let g:fzf_command_prefix = 'Fzf'
        let g:fzf_buffers_jump = 1
        let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
        let g:fzf_tags_command = 'ctags -R'

        set grepprg=rg\ --vimgrep

        " Customize fzf colors to match your color scheme
        "let g:fzf_colors =
        "\ { 'fg':      ['fg', 'Normal'],
          "\ 'bg':      ['bg', 'Normal'],
          "\ 'hl':      ['fg', 'Comment'],
          "\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          "\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          "\ 'hl+':     ['fg', 'Statement'],
          "\ 'info':    ['fg', 'PreProc'],
          "\ 'border':  ['fg', 'Ignore'],
          "\ 'prompt':  ['fg', 'Conditional'],
          "\ 'pointer': ['fg', 'Exception'],
          "\ 'marker':  ['fg', 'Keyword'],
          "\ 'spinner': ['fg', 'Label'],
          "\ 'header':  ['fg', 'Comment'] }
        let g:fzf_colors =
        \ { 'fg':      ['fg', -1],
          \ 'bg':      ['bg', -1],
          \ 'hl':      ['fg', 230],
          \ 'fg+':     ['fg', 3],
          \ 'bg+':     ['bg', 233],
          \ 'hl+':     ['fg', 229],
          \ 'info':    ['fg', 150],
          \ 'prompt':  ['fg', 110],
          \ 'pointer': ['fg', 167],
          \ 'marker':  ['fg', 174],
          \ 'spinner': ['fg', 150],
          \ 'header':  ['fg', 'Comment'] }


        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        " 查詢字典
        
        imap <c-f>w <plug>(fzf-complete-word)
        " 查詢路徑
        imap <c-f>f <plug>(fzf-complete-path)
        " 查詢檔案
        imap <c-f>f <plug>(fzf-complete-file)
        " 查詢行數
        imap <c-f>l <plug>(fzf-complete-line)

        command! -bang -nargs=? -complete=dir FzfFilesP
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

        command! -bang -nargs=? -complete=dir FzfGitFilesP
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

        command! -bang -nargs=* FzfRg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)

        command! -bang -nargs=* FzfGGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

        fun! FzfOmniFiles()
          let is_git = system('git status')
          if v:shell_error
            :FzfFilesP
          else
            :FzfGitFilesP
          endif
        endfun

        nnoremap <C-f>l :FzfLines<CR>
        nnoremap <C-f>b :FzfBuffers<CR>
        nnoremap <C-f>r :FzfRg<CR>
        nnoremap <C-f>t :FzfTags<CR>
        nnoremap <C-f>p :call FzfOmniFiles()<CR>
        nnoremap <C-f>f :FzfFilesP<CR>
        nnoremap <C-f>h :FzfHistory<CR>
        nnoremap <C-f>s :FzfSnippets<CR>
        nnoremap <C-f>c :FzfCommit<CR>
        nnoremap <C-f>m :FzfMaps<CR>
        nnoremap <C-f>g :FzfGFiles?<CR>
    endif
