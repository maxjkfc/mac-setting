local status_ok , neogen = pcall(require , "neogen")
if not status_ok then
    vim.notify("no load the neogen plugins , please check it !!", "error")
end

neogen.setup({
    enabled = true,
    input_after_comment = true,
    languages = {
        go = {
            template = {
                annotation_convention = "godoc"
            }
        }
    }
})
