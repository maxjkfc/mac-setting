local status_ok , telescope = pcall (require , "telescope")
if not status_ok then
    return
end


local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
   find_files = {
      prompt = "Find Files: ",
      theme = "dropdown",
    },
    live_grep = {
      prompt = "Grep: ",
      theme = "dropdown",
    },
    grep_string = {
      prompt = "Grep String: ",
      theme = "dropdown",
    },
    treesitter = {
      prompt = "Treesitter: ",
      theme = "dropdown",
    },
    current_buffer_fuzzy_find = {
      prompt = "Fuzzy Find: ",
      theme = "dropdown",
    },
    diagnostics = {
      prompt = "Diagnostics: ",
      theme = "dropdown",
    },
    lsp_code_actions = {
      prompt = "Code Actions: ",
      theme = "cursor",
    },
    lsp_references = {
      prompt = "References: ",
      theme = "dropdown",
    },
    help_tags = {
      prompt = "Help Tags: ",
      theme = "dropdown",
    },
    command = {
      prompt = "Command: ",
      theme = "dropdown",
    },
    buffers = {
      prompt = "Buffers: ",
      theme = "dropdown",
    },
  },
  extensions = {
    media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = {"png", "webp", "jpg", "jpeg"},
        find_cmd = "rg" -- find command (defaults to `fd`)
      },
    fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    flutter = {},
  },
}

telescope.load_extension('media_files')
telescope.load_extension('fzf')
-- telescope.load_extension('flutter')



