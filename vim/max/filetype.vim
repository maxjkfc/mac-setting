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

        autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
    augroup END

    augroup autoformat_settings
      "autocmd FileType bzl AutoFormatBuffer buildifier
      autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
      "autocmd FileType dart AutoFormatBuffer dartfmt
      "autocmd FileType go AutoFormatBuffer gofmt
      "autocmd FileType gn AutoFormatBuffer gn
      "autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
      "autocmd FileType java AutoFormatBuffer google-java-format
      "autocmd FileType python AutoFormatBuffer yapf
      " Alternative: autocmd FileType python AutoFormatBuffer autopep8
      "autocmd FileType vue AutoFormatBuffer prettier
    augroup END
