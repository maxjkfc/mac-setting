local status_ok , configs = pcall(require,"nvim-treesitter.configs")
if not status_ok then
   return
end

configs.setup{
    ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    rainbow = {
        enable = true,
        extended_mod = true,
        max_file_lines = nil,
    },
    autopairs = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    indent = { enable = true, disable = { "yaml" } },
}