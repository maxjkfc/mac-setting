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
	-- ignore = nil,
    ignore = '^$',

	mappings = {
		---Operator-pending mapping
		---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
		---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
		basic = true,
		---Extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = true,
		---Extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extended = true,
	},

	---LHS of toggle mappings in NORMAL mode
	---@type table
	toggler = {
		---Line-comment toggle keymap
		-- line = "gcc",
		line = "<leader>/",
		---Block-comment toggle keymap
		block = "<leader>/b",
	},

	---LHS of operator-pending mappings in NORMAL mode
	---LHS of mapping in VISUAL mode
	---@type table
	opleader = {
        ---Line-comment keymap
		line = "<leader>/",
        -- -Block-comment keymap
		block = "<leader>/b",
	},

	---LHS of extra mappings
	---@type table
	extra = {
		-- Add comment on the line above
		above = "<leader>/0",
		-- Add comment on the line below
		below = "<leader>/o",
		-- Add comment at the end of line
		eol = "<leaser>/a",
	},

	-- @param ctx CommentCtx
	pre_hook = function(ctx)
		-- Only calculate commentstring for tsx filetypes
		if vim.bo.filetype == "typescriptreact" then
			local U = require("Comment.utils")

			-- Determine whether to use linewise or blockwise commentstring
			local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

			-- Determine the location where to calculate commentstring from
			local location = nil
			if ctx.ctype == U.ctype.blockwise then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location,
			})
		end
	end,
})
