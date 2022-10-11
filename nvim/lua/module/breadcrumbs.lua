local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    vim.notify("nvim-navic loading failed")
    return
end


navic.setup {
    icons = {
        Array = ""  .. " ",
        Boolean = "蘒"  .. " ",
        Class = ""  .. " ",
        Color = ""  .. " ",
        Constant = ""  .. " ",
        Constructor = ""  .. " ",
        Enum = ""  .. " ",
        EnumMember = ""  .. " ",
        Event = ""  .. " ",
        Field = ""  .. " ",
        File = ""  .. " ",
        Folder = ""  .. " ",
        Function = ""  .. " ",
        Interface = ""  .. " ",
        Key = ""  .. " ",
        Keyword = ""  .. " ",
        Method = ""  .. " ",
        Module = ""  .. " ",
        Namespace = ""  .. " ",
        Null = "ﳠ"  .. " ",
        Number = ""  .. " ",
        Object = ""  .. " ",
        Operator = ""  .. " ",
        Package = ""  .. " ",
        Property = ""  .. " ",
        Reference = ""  .. " ",
        Snippet = ""  .. " ",
        String = ""  .. " ",
        Struct = ""  .. " ",
        Text = ""  .. " ",
        TypeParameter = ""  .. " ",
        Unit = ""  .. " ",
        Value = ""  .. " ",
        Variable = "" .. " ",
    },

    highlight = true,
    separator = " " .. ">" .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
}

vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#000000", fg = "#ffffff" })



-- vim.api.nvim_create_augroup("_winbar", {})
-- vim.api.nvim_create_autocmd(
--     { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
--     {
--         group = "_winbar",
--         callback = function()
--             local ok , _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
--             if not ok then
--                 vim.notify("error with _winbar")
--             end

--         end,
--     }
-- )

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- local on_attach = function (client , bufnr)
--  if client.server_capabilities.documentSymbolProvider then
--         navic.attach(client, bufnr)
--     end
-- end


-- require("lspconfig").golang.setup {
--     on_attach = on_attach
-- }
