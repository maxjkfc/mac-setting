local opts = { noremap = true , silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- remove default keymap for space
keymap("","<space>","<Nop>",opts)
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
keymap("n","<C-h>","<C-w>h",opts)
keymap("n","<C-j>","<C-w>j",opts)
keymap("n","<C-k>","<C-w>k",opts)
keymap("n","<C-l>","<C-w>l",opts)

-- 調整視窗大小
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<leader>=", "<C-w>=",opts)

-- 切換不同buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n" , "<C-tab>", ":bnext<CR>", opts)

-- 快速移動
keymap("n", "zh", "^", opts)
keymap("n", "zl", "$", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Visual Mode
-- 移動文字上下
keymap("v" , "<C-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v" , "<C-j>", ":m '<+1<CR>gv=gv", opts)
-- 貼上所複製的內容，而不會被替換的暫存所取代
keymap("v", "p", '"_dP', opts)

-- 移動文字左右
keymap("v", ">", ">gv", opts)
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", opts)

--
keymap("n","<leader>e",":Lex 25<CR>",opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Telescope --
keymap("n", "<leader>ff",   ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg",   ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>/",    ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>ft",   ":Telescope <CR>", opts)
keymap("n", "<leader>tt",   ":Telescope treesitter<CR>", opts)
keymap("n", "<leader>d",    ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>b",    ":Telescope buffers<CR>", opts)
keymap("n", "<leader>cc",   ":Telescope commands<CR>", opts)
-- keymap("n", "<leader>fc",   ":Telescope flutter commands<CR>", opts)
-- lsp keymaps
keymap("n" , "<leader>ca", ":Telescope lsp_code_actions<CR>",opts)


