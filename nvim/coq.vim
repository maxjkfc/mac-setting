
if isdirectory(expand('~/.vim/bundle/coq_nvim/'))
lua<<EOF
  require("coq_3p"){
    { src = "nvimlua",  short_name = "nlua" },
    { src = "vimtex",   short_name = "vTEX" },
    { src = "copilot",  short_name = "COP" , tmp_accept_key = "<c-r>"  },
    { src = "nvimlua",  short_name = "nLUA", conf_only = true },
    { src = "bc",       short_name = "MATH", precision = 6 },
  }

EOF

  "不使用建議的keymap
  let g:coq_settings = { 
        \ "auto_start": v:true,
        \ "display.pum.fast_close": v:false,
        \ "keymap.recommended": v:false,
        \ "keymap.jump_to_mark": "<S-Tab>",
        \ "keymap.bigger_preview": "",
        \ }

  " Keybindings
  ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
  ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
  ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
  ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
  ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

endif




