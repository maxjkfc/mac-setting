" markdown
if isdirectory(expand('~/.vim/bundle/vim-markdown'))
    " plasticboy/vim-markdown
    let g:vim_markdown_folding_disabled = 1
    " toml syntax
    let g:vim_markdown_toml_frontmatter = 1
    " yaml syntax
    let g:vim_markdown_frontmatter = 1
    " json syntax 
    let g:vim_markdown_json_frontmatter = 1
    " auto toc
    let g:vim_markdown_toc_autofit = 1
    " disable default key-map
    let g:vim_markdown_no_default_key_mappings = 1
    " disable conceal for code
    let g:vim_markdown_conceal_code_blocks = 0 
    "
    let g:vim_markdown_follow_anchor = 1
    " Used as $x^2$, $$x^2$$, escapable as \$x\$ and \$\$x\$\$.
    let g:vim_markdown_math = 1
    " auto  scale indent
    "let g:vim_markdown_new_list_item_indent = 2
endif
