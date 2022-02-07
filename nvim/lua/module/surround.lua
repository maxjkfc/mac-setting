local status_ok, opt = pcall(require, "surround")
if not status_ok then
	return
end

opt.setup({
	mapping_style = "sandwich",
	context_offset = 100,
	load_autogroups = false,
	map_insert_mode = true,
	quotes = { "'", '"' },
	brackets = { "(", "{", "[" },
	space_on_closing_char = false,
	pairs = {
		nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
		linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
	},
	prefix = "s",
})
