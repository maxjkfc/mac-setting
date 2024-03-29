local fn = vim.fn

-- 自動安裝 packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })

    print("Installing packer close and reopen nvim")
    vim.cmd([[packadd packer.nvim]])
end
-- 設定檔確認是否存在
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- 自動重讀配置檔案當你儲存 plugins.lua 時
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup END
]])

-- 彈出漂浮視窗
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- 安裝插件
return packer.startup(function(use)
    -- Core
    use("wbthomason/packer.nvim") -- 安裝插件管理工具
    use("nvim-lua/popup.nvim") -- 控管懸浮視窗的插件
    use("nvim-lua/plenary.nvim") -- 大量Lua 方法覆用工具
    use("lewis6991/impatient.nvim") -- 加速導入lua 模組工具

    use("mg979/vim-visual-multi") -- 可以多重選取並同時操作

    -- Colorschems
    use({ "dracula/vim", as = "dracula" }) -- 主題
    use("lunarvim/darkplus.nvim")
    use("vim-scripts/peaksea")
    use("sheerun/vim-wombat-scheme")
    -- use "yong1le/darkplus.nvim"
    use("folke/tokyonight.nvim")

    -- Transparent Background
    use("xiyaowong/nvim-transparent")

    -- todo comments
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- Notify
    use("rcarriga/nvim-notify")
    -- GUI
    use("lukas-reineke/indent-blankline.nvim") -- 段落縮進線
    use("gelguy/wilder.nvim") -- More useful wild menu
    use("folke/which-key.nvim") -- Help you learn keybindings
    use("goolord/alpha-nvim") -- 歡迎頁面
    use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
    use("folke/twilight.nvim") -- 讓你編寫中的代碼高亮
    use("folke/zen-mode.nvim")
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })

    -- Explor
    use("kyazdani42/nvim-web-devicons") -- nvim-tree所用icons
    use("kyazdani42/nvim-tree.lua") -- explor 插件

    -- Buffer
    use("akinsho/bufferline.nvim") -- buffer 視窗插件
    use("moll/vim-bbye") -- buffer 關閉當下插件

    -- StatusLine
    use("nvim-lualine/lualine.nvim") -- 狀態列工具

    -- Ternmail
    use("akinsho/toggleterm.nvim") -- 內建ternmail 工具

    -- Snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim", -- 大量Lua 方法覆用工具
            "nvim-telescope/telescope-project.nvim", -- Manage projects with telescope
            "nvim-telescope/telescope-frecency.nvim", -- Frequent and recent file cache
            "nvim-telescope/telescope-media-files.nvim", -- Media file
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "ahmedkhalf/project.nvim", -- 專案管理工具
        },
    })
    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("p00f/nvim-ts-rainbow") -- 括弧彩色對應

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    }

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        -- tag = 'release' -- To use the latest release
    })
    -- EasyMotion
    use({
        "phaazon/hop.nvim",
        branch = "v1", -- optional but strongly recommended
        config = function()
            require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
        end,
    })

    -- LSP
    use("neovim/nvim-lspconfig") -- Neovim native LSP configuration
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("b0o/schemastore.nvim")


    use("ray-x/lsp_signature.nvim") -- Show signature when completing function parameters

    use("windwp/nvim-autopairs") -- Completion pairs
    use("jose-elias-alvarez/null-ls.nvim") -- 用來擴充formatting 與 linter 使用

    -- Comment
    use("numToStr/Comment.nvim") -- quick comment
    use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })

    -- Surround
    use("tpope/vim-surround")
    use("tpope/vim-repeat")

    -- Undotree
    use("mbbill/undotree")

    -- CMP
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-nvim-lsp", -- LSP completions
            "hrsh7th/cmp-path", -- path completions
            "hrsh7th/cmp-cmdline", -- cmdline completions
            "hrsh7th/cmp-nvim-lua", -- cmp-nvim-lua
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "andersevenrud/cmp-tmux", -- tmux buffer
            -- "hrsh7th/cmp-copilot"                       -- cmp-copilot
        },
    }) -- The completion plugin

    -- Golang
    use({
        "ray-x/go.nvim",
        run = ":GoInstallBinaries",
        requires = {
            { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
        },
    })

    -- Flutter
    use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
    -- tag
    use("liuchengxu/vista.vim")
    -- markdown
    use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" })

    -- breadcrumbs
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
