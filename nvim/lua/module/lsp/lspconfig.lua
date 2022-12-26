local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    vim.notify("mason-lspconfig not ready!!!")
    return
end

mason_lspconfig.setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer", "gopls", "yamlls" },
    automatic_installation = true,
})

-- lspconfig setting

local status_ok_2, lspconfig = pcall(require, "lspconfig")
if not status_ok_2 then
    vim.notify("lspconfig not ready!!!")
    return
end

local opts = {
    on_attach = require("module.lsp.handlers").on_attach,
    capabilities = require("module.lsp.handlers").capabilities,
}

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup { opts }
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup {
            cmd = { "gopls", "-remote=auto" },
            filetype = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
            root_dir = require('lspconfig').util.root_pattern('go.mod', '.git'),
            setting = {
                gopls = {
                    -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                    analyses = { unusedparams = true, unreachable = false },
                    codelenses = {
                        generate = true, -- show the `go generate` lens.
                        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                        test = true,
                        tidy = true
                    },
                    completeUnimported = true,
                    staticcheck = true,
                    matcher = 'fuzzy',
                    diagnosticsDelay = '500ms',
                    experimentalWatchedFileDelay = '100ms',
                    symbolMatcher = 'fuzzy',
                    gofumpt = true, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
                    buildFlags = { "-tags", "integration" },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        rangeVariableTypes = true
                    }
                }
            },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup {
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = true,
                    schemaStore = {
                        enable = true,
                        url = "https://www.schemastore.org/api/json/catalog.json",
                    },
                    schemas = {
                        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["kubernetes"] = {
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
                    }
                },
            },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }
    end,
    ["pyright"] = function()
        lspconfig.pyright.setup {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "off"
                    }
                }
            },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            },
            setup = {
                commands = {
                    Format = {
                        function()
                            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
                        end,
                    },
                },
            },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }
    end,
    ["sumneko_lua"] = function()
        local default_workspace = {
            library = {
                vim.fn.expand "$VIMRUNTIME",
            },

            maxPreload = 1000,
            preloadFileSize = 10000,
        }

        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    runtime = {
                        version = "LuaJIT",
                        special = {
                            reload = "require",
                        },
                    },
                    diagnostics = {
                        globals = { "vim", "lvim", "packer_plugins", "reload" },
                    },
                    workspace = default_workspace,
                },
            },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        }
    end,
})
