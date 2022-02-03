local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "module.lsp.lsp_installer"
require ("module.lsp.handlers").setup()
require "module.lsp.cmp"
require "module.lsp.null-ls"
-- Other lang tools
require "module.lsp.go"

