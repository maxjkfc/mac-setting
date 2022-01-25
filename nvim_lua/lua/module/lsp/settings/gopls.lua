return {
    cmd = { "gopls" , "serve"},
    filetype = { "go", "gomod"},
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
