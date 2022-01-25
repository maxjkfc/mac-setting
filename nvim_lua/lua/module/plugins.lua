local fn = vim.fn

-- 自動安裝 packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path, }

    print "Installing packer close and reopen nvim"
    vim.cmd [[packadd packer.nvim]]
end
-- 設定檔確認是否存在
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- 自動重讀配置檔案當你儲存 plugins.lua 時
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup END
]]

-- 彈出漂浮視窗
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- 安裝插件
return packer.startup(function(use)
    -- Core
    use "wbthomason/packer.nvim"                    -- 安裝插件管理工具
    use "nvim-lua/popup.nvim"                       -- 控管懸浮視窗的插件
    use "nvim-lua/plenary.nvim"                     -- 大量Lua 方法覆用工具

    -- Colorschems
    use { "dracula/vim" , as = "dracula" }          -- 主題
    use "lunarvim/darkplus.nvim"
    -- GUI
    use "lukas-reineke/indent-blankline.nvim"       -- 段落縮進線
    use "glepnir/dashboard-nvim"                    -- nvim啟動的Dashboard客製化
    use "gelguy/wilder.nvim"	                    -- More useful wild menu
    use "folke/which-key.nvim"	                    -- Help you learn keybindings


    -- Explor
    use "kyazdani42/nvim-web-devicons"              -- nvim-tree所用icons
    use "kyazdani42/nvim-tree.lua"                  -- explor 插件
    use "ahmedkhalf/project.nvim"                   -- 專案管理工具

    -- Buffer
    use "akinsho/bufferline.nvim"                   -- buffer 視窗插件
    use "moll/vim-bbye"                             -- buffer 關閉當下插件

    -- StatusLine
    use "nvim-lualine/lualine.nvim"                 -- 狀態列工具

    -- Ternmail
    use "akinsho/toggleterm.nvim"                   -- 內建ternmail 工具

    -- Core
    use "lewis6991/impatient.nvim"                  -- 加速導入lua 模組工具

    -- Snippets
    use "L3MON4D3/LuaSnip"                          -- snippet engine
    use "rafamadriz/friendly-snippets"              -- a bunch of snippets to use

    -- Telescope
    use "nvim-telescope/telescope.nvim"             -- 搜尋工具
    use "nvim-telescope/telescope-project.nvim" 	-- Manage projects with telescope
    use "nvim-telescope/telescope-frecency.nvim"	-- Frequent and recent file cache
    use 'nvim-telescope/telescope-media-files.nvim' -- Media file
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use "folke/trouble.nvim"	                    -- Show code troubles etc

    -- Treesitter
    use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use "lewis6991/gitsigns.nvim"                   -- git 狀態信號燈
    -- EasyMotion
    use "phaazon/hop.nvim"                          -- 更先進的快速移動插件

    -- LSP
    use "neovim/nvim-lspconfig"	                    -- Neovim native LSP configuration
    use "williamboman/nvim-lsp-installer"	        -- Manage each LSP engine
    use "tami5/lspsaga.nvim"                        -- LSP saga
    use "ray-x/lsp_signature.nvim"	                -- Show signature when completing function parameters
    use "windwp/nvim-autopairs"	                    -- Completion pairs
    use "jose-elias-alvarez/null-ls.nvim"	        -- Null LSP

    -- CMP
    use "hrsh7th/nvim-cmp"                          -- The completion plugin
    use "hrsh7th/cmp-buffer"                        -- buffer completions
    use "hrsh7th/cmp-nvim-lsp"                      -- LSP completions
    use "hrsh7th/cmp-path"                          -- path completions
    use "hrsh7th/cmp-cmdline"                       -- cmdline completions
    use "hrsh7th/cmp-nvim-lua"                      -- cmp-nvim-lua
    use "saadparwaiz1/cmp_luasnip"                  -- snippet completions
    -- use "hrsh7th/cmp-copilot"                       -- cmp-copilot
    -- use "github/copilot.vim"                        -- Copilot LSP


    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
