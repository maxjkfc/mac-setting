local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- remove default keymap for space
keymap("", "<space>", "<Nop>", opts)
-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode
-- 視窗移動
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
keymap('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
keymap('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
keymap('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
keymap('n', "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

-- 調整視窗大小
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- 切換不同buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-tab>", ":bnext<CR>", opts)

-- 快速移動
keymap("n", "zh", "^", opts)
keymap("n", "zl", "$", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Visual Mode
-- 移動文字上下
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<C-j>", ":m '<+1<CR>gv=gv", opts)
-- 貼上所複製的內容，而不會被替換的暫存所取代
-- keymap("v", "p", '"_dP', opts)
keymap("n" , "<c-p>" , '"0p' , opts)

-- 移動文字左右
keymap("v", ">", ">gv", opts)
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", opts)

