if isdirectory(expand('~/.vim/bundle/nvim-tree.lua'))
lua << EOF
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  -- following options are the default
  require('nvim-tree').setup {
    -- disables netrw completely
    disable_netrw       = true,
    -- hijack netrw window on startup
    hijack_netrw        = true,
    -- open the tree when running this setup function
    open_on_setup       = true,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup  = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close          = false,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab         = false,
    -- hijacks new directory buffers when they are opened.
    update_to_buf_dir   = {
      -- enable the feature
      enable = true,
      -- allow to open the tree if it was previously closed
      auto_open = true,
    },
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor       = false,
    -- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
    update_cwd          = false,
    -- show lsp diagnostics in the signcolumn
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
      -- enables the feature
      enable      = false,
      -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
      -- only relevant when `update_focused_file.enable` is true
      update_cwd  = false,
      -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
      -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
      ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
      -- the command to run this, leaving nil should work in most cases
      cmd  = nil,
      -- the command arguments as a list
      args = {}
    },
    filters = {
      dotfiles = false,
      custom = {
          ".git",
          },
    },
    view = {
      -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
      width = '20%',
      -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
      height = 30,
      -- Hide the root path of the current folder on top of the tree 
      hide_root_folder = false,
      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      side = 'left',
      -- if true the tree will resize itself after opening a file
      auto_resize = true,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = true,
        -- list of mappings to set on the tree manually
        list = {
          { key = {"<CR>", "o", "l"},       cb = tree_cb("edit") },
          { key = "v",                      cb = tree_cb("vsplit") },
          { key = "s",                      cb = tree_cb("split") },
          { key = "<",                      cb = tree_cb("prev_sibling") },
          { key = ">",                      cb = tree_cb("next_sibling") },
          { key = "P",                      cb = tree_cb("parent_node") },
          { key = "<BS>",                   cb = tree_cb("close_node") },
          { key = "<S-CR>",                 cb = tree_cb("close_node") },
          { key = "<Tab>",                  cb = tree_cb("preview") },
          { key = "K",                      cb = tree_cb("first_sibling") },
          { key = "J",                      cb = tree_cb("last_sibling") },
          { key = "I",                      cb = tree_cb("toggle_ignored") },
          { key = "H",                      cb = tree_cb("toggle_dotfiles") },
          { key = "R",                      cb = tree_cb("refresh") },
          { key = "a",                      cb = tree_cb("create") },
          { key = "d",                      cb = tree_cb("remove") },
          { key = "r",                      cb = tree_cb("rename") },
          { key = "<C-r>",                  cb = tree_cb("full_rename") },
          { key = "x",                      cb = tree_cb("cut") },
          { key = "c",                      cb = tree_cb("copy") },
          { key = "p",                      cb = tree_cb("paste") },
          { key = "y",                      cb = tree_cb("copy_name") },
          { key = "Y",                      cb = tree_cb("copy_path") },
          { key = "gy",                     cb = tree_cb("copy_absolute_path") },
          { key = "[c",                     cb = tree_cb("prev_git_item") },
          { key = "]c",                     cb = tree_cb("next_git_item") },
          { key = "-",                      cb = tree_cb("dir_up") },
          { key = "q",                      cb = tree_cb("close") },
          { key = "?",                      cb = tree_cb("toggle_help") },
          }
        }
      }
    }

EOF
  " 要忽略的檔案,不顯示
  " let g:nvim_tree_ignore = [] "empty by default
  " 是否要忽略 .gitignore 內的檔案
  let g:nvim_tree_gitignore = 1 "0 by default
  " 是否在文件夾後面加入斜槓
  let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
  let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

  nnoremap <space>e :NvimTreeToggle<CR>
  set termguicolors

endif