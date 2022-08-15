local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
     ---Add a space b/w comment and the line
    ---@type boolean|fun():boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = nil,

    mappings = {


    },
	toggler = {
		---Line-comment toggle keymap
		-- line = "gcc",
        line = "<leader>/",
		---Block-comment toggle keymap
		block = "gbc",
	},
	opleader = {
		line = "<leader>/",
		block = "gb",
	},
    -- @param ctx CommentCtx
    pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == 'typescriptreact' then
            local U = require('Comment.utils')

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring({
                key = type,
                location = location,
            })
        end
    end,
})
