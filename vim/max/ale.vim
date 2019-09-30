" Ale
    let g:ale_linters = { 
    \ 'golang' : ['gopls'], 
    \ }
    let g:ale_sign_error = emoji#for('x')
    let g:ale_sign_warning = emoji#for('sos')
    let g:ale_sign_column_always = 1

    " change the format for echo messages
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    " Write this in your vimrc file
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_insert_leave = 0
    " You can disable this option too
    " if you don't want linters to run on opening a file
    let g:ale_lint_on_enter = 0
    " use quickfix list
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1


    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
