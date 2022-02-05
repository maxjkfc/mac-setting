local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<cr>', "Comment" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<cr>", "Save" },
	["q"] = { "<cmd>q!<cr>", "Quit" },
	["\\"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
	["Z"] = { "<cmd>ZenMode<cr>", "Into ZenMode" },

	b = {
		name = "Buffers",
		l = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Buffers",
		},
		c = { "<cmd>Bdelete!<cr>", "Close Buffer" },
	},

	f = {
		name = "+Find 🔭",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		l = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		t = { "<cmd>Telescope treesitter<cr>", "Tressitter" },
		["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		T = { "<cmd>TodoTelescope<cr>", "TodoComments" },
		P = { "<cmd>Telescope projects<cr>", "Projects" },
		g = {
			name = "+GIT",
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		},
	},

	g = {
		name = "Git ♐",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
        a = { "<cmd>Gitsigns toggle_current_line_blame"},
	},

	h = {
		name = "Hop 🚗",
		l = { "<cmd>HopLine<cr>", "Line" },
		w = { "<cmd>HopWord<cr>", "Word" },
		s = { "<cmd>HopChar2<cr>", "Char2" },
		f = {
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
			"f",
		},
		F = {
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
			"F",
		},
		t = {
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
			"t",
		},
		T = {
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
			"T",
		},
	},

	l = {
		name = "LSP 🔈",
		a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics<cr>",
			"Diagnostics",
		},
		z = { "<cmd>lua vim.diagnostic.open_float()<cr>", "DiagnosticFloat" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		T = { "<cmd> TroubleToggle<cr>", "Trouble Diagnostic" },
	},

	P = {
		name = "Packer 📦",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	T = {
		name = "Terminal 💻",
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _GOTOP_TOGGLE()<cr>", "Top" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Git" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
    X = {
        name = "+TROUBLE 🚑",
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quick Fix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Loc List" },
        t = { "<cmd>TodoTrouble<cr>" , "Todo"}
    },

	z = {
		name = "LanguageTools 🧰",
		g = {
			name = "Golang",
			t = {
				name = "Test",
				["."] = { "<cmd>GoTestFile<cr>", "Test File" },
				a = { "<cmd>GoTest<cr>", "Test All File" },
				f = { "<cmd>GoTestFunc<cr>", "Test Func" },
				p = { "<cmd>GoTestPkg<cr>", "Test Package" },
			},
			l = {
				name = "LSP",
			},
			r = { "<cmd>GoRun<cr>", "Run" },
		},
		f = {
			name = "Flutter",
		},
	},
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
	["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', "Comment" },
	l = {
		name = "LSP",
		a = { "<cmd>Telescope lsp_range_code_actions<cr>", "Code Action" },
	},
}

local gopts = {
	mode = "n",
	prefix = "g",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local gmappings = {
	["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
	-- ["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
	["d"] = { "<cmd>Telescope lsp_definition<cr>", "Definition" },
	["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
	["k"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
	-- ["r"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
	["r"] = { "<cmd>Telescope lsp_references<cr>", "References" },
	-- ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
	["i"] = { "<cmd>Telescope lsp_implementation<cr>", "Implementation" },
	-- f = { "<cmd>Lspsaga lsp_finder<cr>" , "Finder"},
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(gmappings, gopts)
