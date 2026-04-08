local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1. 基礎 LazyVim 核心
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    
    -- 2. 這些功能在 VS Code 裡也很好用，保留！
    { import = "lazyvim.plugins.extras.coding.mini-surround" }, 
    { import = "lazyvim.plugins.extras.vscode" }, -- 關鍵

    -- 3. 使用 vim.g.vscode 判斷：只在「非」VS Code 模式下才載入這些重型模組
    -- 這樣在 Antigravity 裡啟動速度會更快，且完全避免衝突
    not vim.g.vscode and {
       -- 語言支援 (IDE 本身就有了，不需要載入)
       { import = "lazyvim.plugins.extras.lang.json" },
       { import = "lazyvim.plugins.extras.lang.docker" },
       { import = "lazyvim.plugins.extras.lang.go" },
       -- 測試與重新命名 (IDE 有自己的介面)
       { import = "lazyvim.plugins.extras.test.core" },
       { import = "lazyvim.plugins.extras.editor.inc-rename" }, 
    } or nil,

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax", "catppuccin" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
