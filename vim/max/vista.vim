
if isdirectory(expand('~/.vim/bundle/vista.vim'))
  " vista.vim
  function! NearestMethodOrFunction() abort
      return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  set statusline+=%{NearestMethodOrFunction()}
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

  let g:vista_default_executive = 'coc'

  let g:vista_executive_for = {
              \ 'cpp': 'nvim_lsp',
              \ 'php': 'coc',
              \ 'go': 'coc',
              \ }
  let g:vista_ctags_cmd = {
              \ 'haskell': 'hasktags -x -o - -c',
              \ 'go': 'gotags -R ./*',
              \ }

  let g:vista_fzf_preview = ['right:50%']

  let g:vista#renderer#enable_icon = 1

  let g:vista#renderer#icons = {
              \   "function": "\uf794",
              \   "variable": "\uf71b",
              \  }


  nnoremap <silent><nowait> <space>m :<C-u>Vista!!<cr>

endif
