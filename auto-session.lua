local defaults = {
	-- Saving / restoring
	enabled = true, -- Enables/disables auto creating, saving and restoring
	auto_save = true, -- Enables/disables auto saving session on exit
	auto_restore = true, -- Enables/disables auto restoring session on start
	auto_create = true, -- Enables/disables auto creating new session files. Can be a function that returns true if a new session file should be allowed
	auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
	cwd_change_handling = false, -- Automatically save/restore sessions when changing directories
	single_session_mode = false, -- Enable single session mode to keep all work in one session regardless of cwd changes. When enabled, prevents creation of separate sessions for different directories and maintains one unified session. Does not work with cwd_change_handling

	-- Filtering
	suppressed_dirs = nil, -- Suppress session restore/create in certain directories
	allowed_dirs = nil, -- Allow session restore/create in certain directories
	bypass_save_filetypes = nil, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
	close_filetypes_on_save = { "checkhealth" }, -- Buffers with matching filetypes will be closed before saving
	close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
	preserve_buffer_on_restore = nil, -- Function that returns true if a buffer should be preserved when restoring a session

	-- Git / Session naming
	git_use_branch_name = false, -- Include git branch name in session name, can also be a function that takes an optional path and returns the name of the branch
	git_auto_restore_on_branch_change = false, -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name
	custom_session_tag = nil, -- Function that can return a string to be used as part of the session name

	-- Deleting
	auto_delete_empty_sessions = true, -- Enables/disables deleting the session if there are only unnamed/empty buffers when auto-saving
	purge_after_minutes = nil, -- Sessions older than purge_after_minutes will be deleted asynchronously on startup, e.g. set to 14400 to delete sessions that haven't been accessed for more than 10 days, defaults to off (no purging), requires >= nvim 0.10

	-- Saving extra data
	save_extra_data = nil, -- Function that returns extra data that should be saved with the session. Will be passed to restore_extra_data on restore
	restore_extra_data = nil, -- Function called when there's extra data saved for a session

	-- Argument handling
	args_allow_single_directory = true, -- Follow normal session save/load logic if launched with a single directory as the only argument
	args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. Can be true or a function that returns true when saving is allowed. See documentation for more detail

	-- Misc
	log_level = "error", -- Sets the log level of the plugin (debug, info, warn, error).
	root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Root dir where sessions will be stored
	show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
	restore_error_handler = nil, -- Function called when there's an error restoring. By default, it ignores fold and help errors otherwise it displays the error and returns false to disable auto_save. Default handler is accessible as require('auto-session').default_restore_error_handler
	continue_restore_on_error = true, -- Keep loading the session even if there's an error
	lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
	lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used
	legacy_cmds = true, -- Define legacy commands: Session*, Autosession (lowercase s), currently true. Set to false to prevent defining them

	---@type SessionLens
	session_lens = {
		picker = nil, -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also set one manually. Falls back to vim.ui.select
		load_on_setup = true, -- Only used for telescope, registers the telescope extension at startup so you can use :Telescope session-lens
		picker_opts = nil, -- Table passed to Telescope / Snacks / Fzf-Lua to configure the picker. See below for more information
		previewer = "summary", -- 'summary'|'active_buffer'|function - How to display session preview. 'summary' shows a summary of the session, 'active_buffer' shows the contents of the active buffer in the session, or a custom function

		---@type SessionLensMappings
		mappings = {
			-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
			delete_session = { "i", "<C-d>" }, -- mode and key for deleting a session from the picker
			alternate_session = { "i", "<C-s>" }, -- mode and key for swapping to alternate session from the picker
			copy_session = { "i", "<C-y>" }, -- mode and key for copying a session from the picker
		},

		---@type SessionControl
		session_control = {
			control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
			control_filename = "session_control.json", -- File name of the session control file
		},
	},
}

return {
	"rmagatti/auto-session",
	lazy = false,

	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
	},

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- The following are already the default values, no need to provide them if these are already the settings you want.
		session_lens = {
			picker = nil, -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
			mappings = {
				-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
				delete_session = { "i", "<C-d>" },
				alternate_session = { "i", "<C-s>" },
				copy_session = { "i", "<C-y>" },
			},

			picker_opts = {
				attach_mappings = function(prompt_bufnr, map)
					print("test")
					-- suppress session (GRAVITY BIND !)
					map("i", "<C-s>", function()
						local selection = require("telescope.actions.state").get_selected_entry()
						local session_dir = selection.path
						require("auto-session").suppressed_dirs.insert(session_dir)
						vim.notify("Suppressed: " .. session_dir)
						require("telescope.actions").close(prompt_bufnr)
					end)

					-- reset/delete session
					map("i", "<C-r>", function()
						local selection = require("telescope.actions.state").get_selected_entry()
						local session_path = selection.path
						require("auto-session").DeleteSession(session_path)
						vim.notify("Deleted: " .. session_path)
						require("telescope.actions").close(prompt_bufnr)
					end)
					return true
				end,

				-- For Telescope, you can set theme options here, see:
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
				--
				-- border = true,
				-- layout_config = {
				--   width = 0.8, -- Can set width and height as percent of window
				--   height = 0.5,
				-- },

				-- For Snacks, you can set layout options here, see:
				-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
				--
				-- preset = "dropdown",
				-- preview = false,
				-- layout = {
				--   width = 0.4,
				--   height = 0.4,
				-- },

				-- For Fzf-Lua, picker_opts just turns into winopts, see:
				-- https://github.com/ibhagwan/fzf-lua#customization
				--
				--  height = 0.8,
				--  width = 0.50,
			},

			-- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
			load_on_setup = true,
		},
	},
}
