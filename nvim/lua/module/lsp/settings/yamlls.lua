return {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
        }
    }
}
