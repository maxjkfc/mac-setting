" deoplete
    set completeopt+=noselect
    let g:deoplete#enable_at_startup = 1
    " deoplete-go
    
    let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
    let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
    let g:deoplete#sources#go#use_cache = 1
    let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/'
    let g:deoplete#sources#go#package_dot = 1
    let g:deoplete#sources#go#pointer=1
    let g:deoplete#sources#go#source_importer=1
    let g:deoplete#sources#go#unimported_packages=1
