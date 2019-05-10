" move line up/down
"nnoremap <c-s-j> :m .+1<CR>==
"nnoremap <c-s-k> :m .-2<CR>==
"inoremap <c-s-k> <Esc>:m .-2<CR>==gi
"inoremap <c-s-j> <Esc>:m .+1<CR>==gi
vnoremap <c-s-k> :m '<-2<CR>gv=gv
vnoremap <c-s-j> :m '>+1<CR>gv=gv
