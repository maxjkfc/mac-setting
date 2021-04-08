"FileType
 " Filetype: Sh, Zsh {{{2
     
    augroup filetypedetect

        autocmd FileType zsh,sh setl com-=:# sts=4 sw=4
                \| com! -buffer Lint Grepper -noprompt -buffer -grepprg shellcheck -fgcc

        autocmd! BufRead,BufNewFile *.csv,*.dat	setfiletype csv

        autocmd FileType yaml,yml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

        autocmd BufNewFile,BufReadPost *.md setfiletype markdown

        autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

        autocmd BufNewFile,BufRead *.html,*.htm set filetype=html

        autocmd FileType json syntax match Comment +\/\/.\+$+

        autocmd BufWritePre *.go silent! :call CocAction('runCommand', 'editor.action.organizeImport')

        autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    augroup END

