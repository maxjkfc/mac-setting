local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		-- enable = true,
		-- TODO: wait for fix by https://github.com/p00f/nvim-ts-rainbow/issues/97
        enable = true,
		extended_mod = false,
		max_file_lines = 300,
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	indent = { enable = true, disable = { "yaml" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			-- mappings for incremental selection (visual mappings)
			init_selection = "gnn", -- maps in normal mode to init the node/scope selection
			node_incremental = "grn", -- increment to the upper named parent
			scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
			node_decremental = "grm", -- decrement to the previous node
		},
	},
	textobjects = {
		-- syntax-aware textobjects
		enable = true,
        lookahead = true,
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["df"] = "@function.outer",
				["dF"] = "@class.outer",
			},
		},
		keymaps = {
			["iL"] = {
				-- you can define your own textobjects directly here
				go = "(function_definition) @function",
			},
			-- or you use the queries from supported languages with textobjects.scm
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["aC"] = "@class.outer",
			["iC"] = "@class.inner",
			["ac"] = "@conditional.outer",
			["ic"] = "@conditional.inner",
			["ae"] = "@block.outer",
			["ie"] = "@block.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["is"] = "@statement.inner",
			["as"] = "@statement.outer",
			["ad"] = "@comment.outer",
			["am"] = "@call.outer",
			["im"] = "@call.inner",
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
	refactor = {
		-- navigation = {
		--   enable = true,
		--   keymaps = {
		--     goto_definition = "gnd",
		--     list_definitions = "gnD",
		--     list_definitions_toc = "gO",
		--     goto_next_usage = "<a-*>",
		--     goto_previous_usage = "<a-#>",
		--   },
		-- },
		-- 更名
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		-- 高亮包含所處的區塊
		-- highlight_current_scope = {enable = true},
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
	},
})
