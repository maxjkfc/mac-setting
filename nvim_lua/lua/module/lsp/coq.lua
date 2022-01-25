local status_ok, coq = pcall(require, "coq")
if not status_ok then
  return
end

local status_ok, coq3p = pcall(require, "coq_3p")
if not status_ok then
  return
end

require("coq_3p"){
    { src = "nvimlua", short_name = "nLUA" },
    { src = "vimtex", short_name = "vTEX" },
    { src = "copilot", short_name = "COP", accept_key = "<C-F>" },
    {
      src = "repl",
      sh = "zsh",
      shell = { p = "perl", n = "node" },
      max_lines = 99,
      deadline = 500,
      unsafe = { "rm", "poweroff", "mv" },
    },
}

-- TODO: check why it doesn't work
vim.g.coq_settings = {
     auto_start = true ,
     ['keymap.recommended'] = false,
     ['keymap.jump_to_mark'] = '<tab>',
}

vim.cmd("COQnow --shut-up")
