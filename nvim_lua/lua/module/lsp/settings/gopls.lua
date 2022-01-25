return {
    cmd = { "gopls" , "serve"},
    setting = {
        gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    }
}
