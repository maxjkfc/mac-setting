-- 讀取Plugin cmp 並確保該檔案存在
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("cmp not ready!!")
    return
end

-- 讀取Plugin cmp 並確保該檔案存在
local snip_lua_status_ok, luasnip = pcall(require, "luasnip")
if not snip_lua_status_ok then
    vim.notify("luasnip not ready!!")
    return
end

-- 啟動luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- 設置刪除鍵
local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- 跳到選單上一個項目
        ["<C-j>"] = cmp.mapping.select_next_item(), -- 跳到選單下一個項目
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- 調整顯示內容向下移動
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- 調整顯示內容向上移動
        -- ["<C->"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `selct` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- cmp.select_next_item()
                cmp.confirm({ select = true })
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM_LUA]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                emoji = "[Emoji]",
                tmux = "[TMUX]",
            })[entry.source.name]
            return vim_item
        end,

    },
    -- 設定每個來源的優先度，最上面最優先
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
        { name = "tmux",
            option = {
                -- Source from all panes in session instead of adjacent panes
                all_panes = false,
                -- Completion popup label
                label = '[tmux]',
                -- Trigger character
                trigger_characters = { '.' },
                -- Specify trigger characters for filetype(s)
                -- { filetype = { '.' } }
                trigger_characters_ft = {},
                -- Keyword patch mattern
                keyword_pattern = [[\w\+]],
            }
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        -- documentation = "native",
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },

    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})
