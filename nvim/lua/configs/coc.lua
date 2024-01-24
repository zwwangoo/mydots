return function()
	vim.g.coc_global_extensions = {
		'coc-json',
		'coc-git',
		'coc-docker',
		'coc-go',
		'coc-imselect',
		'coc-tabnine',
		'coc-jedi',
	}
	vim.g.disable_lsp = true
	vim.opt.backup = false
	vim.opt.writebackup = false

	-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
	-- delays and poor user experience
	vim.opt.updatetime = 300

	-- Always show the signcolumn, otherwise it would shift the text each time
	-- diagnostics appeared/became resolved
	vim.opt.signcolumn = "yes"

	local keyset = vim.keymap.set
	-- Autocomplete
	function _G.check_back_space()
	    local col = vim.fn.col('.') - 1
	    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
	end
	local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
	keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
	keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

	-- Make <CR> to accept selected completion item or notify coc.nvim to format
	-- <C-g>u breaks current undo, please make your own choice
	keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
	-- Use K to show documentation in preview window
	function _G.show_docs()
	    local cw = vim.fn.expand('<cword>')
	    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
		vim.api.nvim_command('h ' .. cw)
	    elseif vim.api.nvim_eval('coc#rpc#ready()') then
		vim.fn.CocActionAsync('doHover')
	    else
		vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
	    end
	end
	keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
	-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
	vim.api.nvim_create_augroup("CocGroup", {})
	vim.api.nvim_create_autocmd("CursorHold", {
	    group = "CocGroup",
	    command = "silent call CocActionAsync('highlight')",
	    desc = "Highlight symbol under cursor on CursorHold"
	})
end
