vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
]])
vim.cmd([[
    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end
]])
vim.cmd([[
    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end
]])
vim.cmd([[
    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd = 
    augroup end
]])
vim.cmd([[
    augroup _alpha
        autocmd!
        autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    augroup end
]])

vim.cmd([[
    augroup _go
        autocmd!
        autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    augroup end
]])

-- Remove nvim_tree autoclose autocmd
-- vim.cmd([[
--     augroup _nvim_tree
--         autocmd!
--         autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
--     augroup end
-- ]])
