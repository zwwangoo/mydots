return function()
	vim.g.ale_c_clang_options = '-std=c17 -Wall -Wno-deprecated'
	vim.g.ale_python_flake8_options = ' --config $HOME/.flake8'
	vim.g.ale_close_preview_on_insert = true
	vim.g.ale_sign_column_always = false
	vim.g.ale_completion_enabled = true
	vim.g.ale_python_mypy_show_notes = false
	vim.g.ale_virtualtext_cursor = 'disabled'
	vim.g.ale_linters = {
		python = {'flake8'},
		cpp = {'gcc'},
		c = {'gcc'},
		lua = {'luac'},
		javascript = {'prettier'},
		html = {'prettier'},
		rust = {'rls'},
		reStructuredText = {'rstcheck'},
	}
end
