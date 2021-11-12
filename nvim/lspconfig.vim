if isdirectory(expand('~/.vim/bundle/nvim-lspconfig'))
lua << EOF
  local coq = require "coq"
  local nvim_lsp = require "lspconfig"

  local on_attach = function(client , bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc' , 'v:lua.vim.lsp.omnifunc')
    -- Mappings
    local opts = { noremap=true , silent=true }

    -- KeyMapping
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end
  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'gopls','pyright', 'rust_analyzer', 'tsserver' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

   -- nvim_lsp.bashls.setup{}

   nvim_lsp.gopls.setup{
      coq.lsp_ensure_capabilities{
        cmd = { "gopls" };
        filetypes = { "go", "gomod" };
        root_dir = nvim_lsp.util.root_pattern('go.mod' , '.git');
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          };
        }
      }
   }
  -- nvim_lsp.vimls.setup{}
EOF

endif
