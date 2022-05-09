local options = {
    -- file
    backup = false,                             -- don't backup files
    writebackup = false,                        -- don't write backups
    undofile = true,                            -- use undo files
    swapfile = false,                           -- don't use swap files
    -- encoding
    encoding = "utf-8",                         -- encoding
    fileencoding = "utf-8",                     -- file encoding
    -- basic
    clipboard = "unnamedplus",                  -- 剪貼簿
    cmdheight = 2,                              -- command line height
    completeopt = { "menuone,noinsert" },       -- completeopt
    conceallevel = 2,                           -- conceal level (0-3) (default: 2) (0: no concealing) (1: conceal only cursor line) (2: conceal cursor line and cursor column) (3: conceal all) (4: conceal cursor line and cursor column and all empty lines)
    undolevels=1000,                            -- undo levels
    undoreload=1000,                            -- undo reload
    updatetime = 300,                           -- update time
    timeoutlen = 500,                           -- timeout length
    expandtab = true,                           -- expand tab
    shiftwidth = 4,                             -- shiftwidth
    tabstop = 4,                                -- tabstop
    history = 1000,                             -- history
    virtualedit = "block",                      -- virtualedit
    -- layout
    splitbelow = true,                          -- split window below
    splitright = true,                          -- split window right
    -- search
    hlsearch = true,                            -- highlight search
    ignorecase = true,                          -- ignore case
    smartcase = true,                           -- smart case
    -- buffer
    hidden = true,                              -- allow buffer switching without  save
    -- mouse
    mouse = "a",                                -- mouse
    -- gui
    syntax = "on",                              -- syntax
    background = "dark",                        -- background
    tabpagemax = 15,                            -- tab page max
    showmode = true,                            -- show mode
    showcmd = true,                             -- show command
    showmatch = true,                           -- show match
    showtabline = 2,                            -- show tabline
    lazyredraw = true,                          -- lazy redraw
    pumheight = 10,                             -- popup menu height
    smartindent = true,                         -- smart indent
    cursorline = false,                          -- cursor line highlight
    number = true,                              -- number
    relativenumber = true,                      -- relative line number
    numberwidth = 2,                            -- number width
    signcolumn = "yes",                         -- sign column
    wrap = false,                               -- wrap
    scrolloff = 8,                              -- scroll offset
    sidescrolloff = 8,                          -- side scroll offset
    ruler = true,                               -- ruler
    rulerformat = " %l : %c %p%% %m %t",        -- ruler format
    -- fold
    -- foldmethod = 'expr',
    -- foldexpr   = "nvim_treesitter#foldexpr()",
    -- foldenable = false,
}

-- 將所有設定變數轉為設定
for k , v in pairs(options) do
    vim.opt[k] = v
end

vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_exec([[let g:loaded_perl_provider = 0]],false)
