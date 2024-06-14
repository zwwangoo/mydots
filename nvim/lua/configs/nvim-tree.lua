return function()

	require("nvim-tree").setup({
		auto_reload_on_write = true,
		create_in_closed_folder = false,
		disable_netrw = true,
		hijack_cursor = true,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = true,
		open_on_tab = true,
		respect_buf_cwd = false,
		sort_by = "name",
		sync_root_with_cwd = true,
		view = {
			adaptive_size = true,
			centralize_selection = true,
			width = 30,
			side = "right",
			preserve_window_proportions = true,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			float = {
				enable = true,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 30,
					height = 49,
					row = 1,
					col = 1,
				},
			},
		},
		renderer = {
			add_trailing = false,
			group_empty = true,
			highlight_git = true,
			full_name = false,
			highlight_opened_files = "none",
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
			symlink_destination = true,
			indent_markers = {
				enable = true,
				icons = {
					corner = "└ ",
					edge = "│ ",
					item = "│ ",
					none = "  ",
				},
			},
			root_folder_label = ":.:s?.*?/..?",
			icons = {
				webdev_colors = true,
				git_placement = "after",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				padding = " ",
				symlink_arrow = " 󰁔 ",
			},
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
			ignore_list = {},
		},
		filters = {
			dotfiles = false,
			custom = { ".DS_Store", "__pycache__", ".git", ".idea" },
			exclude = {},
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
			},
			open_file = {
				quit_on_open = false,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			debounce_delay = 50,
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
		},
		git = {
			enable = true,
			ignore = false,
			show_on_dirs = true,
			timeout = 400,
		},
		trash = {
			cmd = "gio trash",
			require_confirm = true,
		},
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = true,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				dev = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
	})
end
