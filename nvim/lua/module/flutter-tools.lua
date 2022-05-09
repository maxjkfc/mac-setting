
local status_ok, tools = pcall(require, "flutter-tools")
if not status_ok then
	vim.notify("flutter-tools not ok 🥶")
	return
end

tools.setup{
    ui = {
        border = "rounded",
        notification_style = 'plugin'
    },
    decorations = {
        statusline = {
            app_version = true,
            device = true,
        }
    },
    debugger = {
      endabled = false,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
        -- register_configurations = function(paths)
        --     require("dap").configurations.dart = {
        --     }
        -- end,
    },
    fvm = false,
    -- flutter_lookup_cmd = "dirname $(which flutter)",
    widget_guides = {
      enabled = false ,
    },
    dev_log = {
      open_cmd = "tabedit"
    },
    dev_tools = {
      autostart = true,
      auto_open_browser = true
    },
    outline = {
      open_cmd = "40vnew", -- command to use to open the outline buffer
      auto_open = true -- if true this will open the outline automatically when it is first populated
    },
}
