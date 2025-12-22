local leap = require("leap")
leap.opts.case_sensitive = true
leap.opts.substitute_chars = { ["\r"] = "¬" }
leap.opts.special_keys = {
	next_target = "<enter>",
	prev_target = "<tab>",
	next_group = "<space>",
	prev_group = "<tab>",
}

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
