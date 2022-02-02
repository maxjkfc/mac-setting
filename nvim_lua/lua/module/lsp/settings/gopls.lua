return {
    -- cmd = { "gopls" , "serve"},
    cmd = { "gopls" , "-remote=auto" , "-remote.debug=:0"},
    filetype = { "go", "gomod","gohtmltmpl","gotexttmpl"},
    root_dir = require('lspconfig').util.root_pattern('go.mod','.git'),
    setting = {
        gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    }
}
