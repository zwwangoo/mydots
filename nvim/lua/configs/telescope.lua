return function()
	local builtin = require('telescope.builtin')
	-- vim.keymap.set('n', '<C-g>', builtin.find_files, {})
	vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
	-- vim.keymap.set('n', '<leader>b', function()
	-- 	require('telescope.builtin').buffers {
	-- 		select_current = true,
	-- 		selection_strategy = 'closest',
	-- 	}
	-- end, { desc = 'Buffer list' })

	require('telescope').setup({
		scroll_strategy = "limit",
		results_title = false,
		layout_strategy = "horizontal",
		path_display = { "absolute" },
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		color_devicons = true,
		file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.85,
			height = 0.92,
			preview_cutoff = 120,
		},
	})

end
