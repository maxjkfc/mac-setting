vim.api.nvim_exec(
    [[
        let g:undotree_WindowLayout = 1
        " auto open diff 
        let g:undotree_DiffAutoOpen = 1
        " when open windows , focus the windows 
        let g:undotree_SetFocusWhenToggle = 1
        let g:undotree_RelativeTimestamp = 1
    ]],
    false
)
