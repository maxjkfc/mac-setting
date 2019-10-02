# neovim 




## Plugin

### COC

#### Install

```vim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

#### Plugin
##### coc-tabnine
*Install*
```vim
    :CocInstall coc-tabnine

    Run :CocCommand to open commands list.

    tabnine.openConfig: open config file of tabnine.
    Note: to make coc.nvim works better with TabNine, add "ignore_all_lsp": true to config file of tabnine.
```

##### coc-json

##### coc-css

##### coc-html

##### coc-tsserver

##### coc-snippets

##### coc-rls
rust support for coc.nvim

##### coc-yaml

##### ShellScript
```shell
    nvim -c 'CocInstall -sync coc-json coc-css coc-html coc-tsserver|q'
```


#### Config

```json

{    
    "languageserver": {
        "golang": {
            "command": "gopls",
            "rootPatterns": ["go.mod"],
            "filetypes": ["go"]
        }
    }
}

```
