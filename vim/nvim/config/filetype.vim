"FileType
 " Filetype: Sh, Zsh {{{2
    augroup filetypedetect

        au FileType zsh,sh setl com-=:# sts=4 sw=4
                \| com! -buffer Lint Grepper -noprompt -buffer -grepprg shellcheck -fgcc

        au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv

        au FileType yaml,yml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

        autocmd BufNewFile,BufReadPost *.md setfiletype markdown

        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

        autocmd BufNewFile,BufRead *.html,*.htm set filetype=html
    augroup END

