if isdirectory(expand('~/.vim/bundle/flutter-tools.nvim'))
lua << EOF
  require("flutter-tools").setup{
    ui = {
      border = "rounded"
    },
    decorations = {
      statusline = {
          app_version = true,
          device = true,
      }
    },
    debugger = {
      endabled = false,
    },
    fvm = false,
    widget_guides = { 
      enabled = false 
    },
    dev_log = {
      open_cmd = "tabedit"
    },
    dev_tools = {
      autostart = true,
      auto_open_browser = true
    },
    outline = {
      open_cmd = "30vnew", -- command to use to open the outline buffer
      auto_open = false -- if true this will open the outline automatically when it is first populated
    },
  } -- use defaults
EOF




endif
