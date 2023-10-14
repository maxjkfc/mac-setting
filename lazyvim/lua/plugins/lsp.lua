return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json"] = {
                  "daemon.{yml,yaml}",
                  "manager.{yml,yaml}",
                  "restapi.{yml,yaml}",
                  "role.{yml,yaml}",
                  "role_binding.{yml,yaml}",
                  "*onfigma*.{yml,yaml}",
                  "*ngres*.{yml,yaml}",
                  "*ecre*.{yml,yaml}",
                  "*eployment*.{yml,yaml}",
                  "*ervic*.{yml,yaml}",
                  "kubectl-edit*.yaml",
                  "deploy.{yml,yaml}",
                },
              },
            },
          },
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        gopls = {
          cmd = { "gopls", "serve" },
          settings = {
            gopls = {
              semanticTokens = true,
              usePlaceholders = true,
              codelenses = {
                generate = false,
                gc_details = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              staticcheck = true,
              gofumpt = false,
              analyses = {
                unusedparams = true,
                unreachable = false,
              },
              completeUnimported = true,
              hints = {
                constantValues = true,
                compositeLiteralTypes = true,
                assignVariableTypes = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        tailwindcss = {
          filetypes_exclude = { "markdown" },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
