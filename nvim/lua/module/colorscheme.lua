-- local colorscheme = "darkplus"
-- local colorscheme = "dracula"

-- Theme for tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" , "NvimTreeNormal"}
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found")
	return
end
