-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
-- set helm filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("helm filetype"),
  pattern = "*/templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml",
  callback = function()
    vim.bo.filetype = "helm"
  end,
})
-- Use {{/* */}} as comments
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("helm filetype"),
  pattern = "helm",
  callback = function()
    vim.bo.commentstring = "{{/* %s */}}"
  end,
})

-- cancle concealing in json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})
