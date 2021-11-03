if isdirectory(expand('~/.vim/bundle/nvim-lspconfig'))
lua << EOF
  local coq = require "coq"
  local lsp = require "lspconfig"
   -- lsp.bashls.setup{}
   -- lsp.solargraph.setup{}
   -- lsp.tsserver.setup{}

   lsp.gopls.setup{
      coq.lsp_ensure_capabilities{
        cmd = { "gopls" };
        filetypes = { "go", "gomod" };
        root_dir = lsp.util.root_pattern('go.mod' , '.git');
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
  -- lsp.vimls.setup{}
  -- lsp.yamlls.setup{}
  -- lsp.graphql.setup{}
EOF

endif
