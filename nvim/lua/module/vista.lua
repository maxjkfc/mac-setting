vim.api.nvim_exec([[
    let g:vista_default_executive = 'nvim_lsp'
    let g:vista_sidebar_open_cmd = '30vsplit'
    let g:vista_echo_cursor_strategy = 'both'
    let g:vista_executive_for = {
        \ 'vimwiki': 'markdown',
        \ 'pandoc': 'markdown',
        \ 'markdown': 'toc',
        \ }
    let g:vista#renderer#icons = {
        \   "function": "\uf794",
        \   "variable": "\uf71b",
        \ }
    let g:vista_stay_on_open = 0

]],false)
