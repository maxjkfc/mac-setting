" Ale
    let g:ale_sign_error = emoji#for('x')
    let g:ale_sign_warning = emoji#for('sos')
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
