" Code Fmt
    augroup autoformat_settings
      autocmd FileType bzl AutoFormatBuffer buildifier
      autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
      autocmd FileType dart AutoFormatBuffer dartfmt
      autocmd FileType go AutoFormatBuffer gofmt
      autocmd FileType gn AutoFormatBuffer gn
      autocmd FileType html,css,json AutoFormatBuffer js-beautify
      autocmd FileType java AutoFormatBuffer google-java-format
      autocmd FileType python AutoFormatBuffer yapf
      autocmd FileType vue AutoFormatBuffer prettier
    augroup END
