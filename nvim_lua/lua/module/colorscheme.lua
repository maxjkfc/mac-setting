--vim.cmd "colorscheme darkplus"
--vim.cmd "colorscheme dracula"
local colorscheme = "darkplus"

local status_ok , _ = pcall(vim.cmd , "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found")
    return
end
