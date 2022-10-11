local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig not ready!!!")
    return
end

-- require "module.lsp.lsp_installer"
require ("module.lsp.handlers").setup()
require "module.lsp.mason"
require "module.lsp.lspconfig"
require "module.lsp.cmp"
require "module.lsp.null-ls"
require "module.lsp.lsp_signature"
-- Other lang tools
require "module.lsp.go"

