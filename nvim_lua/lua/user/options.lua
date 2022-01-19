local options = {
    -- file
    backup = false,                             -- don't backup files
    writebackup = false,                        -- don't write backups
    undofile = false,                           -- don't use undo files
    swapfile = false,                           -- don't use swap files
    -- 
    clipboard = "unnamedplus",                  -- 剪貼簿
    cmdheight = 2,                              -- command line height
    completeopt = { "menuone,noinsert" },       -- completeopt
    conceallevel = 2,                           -- conceal level (0-3) (default: 2) (0: no concealing) (1: conceal only cursor line) (2: conceal cursor line and cursor column) (3: conceal all) (4: conceal cursor line and cursor column and all empty lines)

    fileencoding = "utf-8",                     -- file encoding
    -- search
    hlsearch = true,                            -- highlight search
    ignorecase = true,                          -- ignore case
    smartcase = true,                           -- smart case
    -- buffer
    hidden = true,                              -- allow buffer switching without  save
}

-- 將所有設定變數轉為設定
for k , v in pairs(options) do
    vim.opt[k] = v
end

vim.api.nvim_command('filetype plugin indent on')
