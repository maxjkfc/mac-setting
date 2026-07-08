return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- 顯示 dotfiles（.gitignore/.dockerignore/.github/.env*）
            ignored = true, -- 顯示被 gitignore 的檔案
            exclude = { ".DS_Store", "thumbs.db" },
          },
        },
      },
      dashboard = {
        preset = {
          header = [[
              ███╗   ███╗ █████╗ ██╗  ██╗
              ████╗ ████║██╔══██╗╚██╗██╔╝
              ██╔████╔██║███████║ ╚███╔╝
              ██║╚██╔╝██║██╔══██║ ██╔██╗
              ██║ ╚═╝ ██║██║  ██║██╔╝ ██╗
              ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
        ]],
        },
      },
    },
  },
}
