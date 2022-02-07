vim.api.nvim_exec(
	[[
    let g:VM_maps = {}
    let g:VM_default_mappings = 0
    let g:VM_maps["Add Cursor Down"] = '<A-j>'
    let g:VM_maps["Add Cursor Up"] = '<A-k>'
    let g:VM_maps["Select All"] = '<A-a>'
    let g:VM_maps["Visual All"] = '<A-a>'
]],
	false
)
