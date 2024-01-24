return function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<C-g>', builtin.find_files, {})
	vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>b', builtin.buffers, {})
	-- vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
	require('telescope').setup {}

end
