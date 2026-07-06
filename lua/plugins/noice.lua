return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					max_width = 50,
					timeout = 2000,
					top_down = false,
					fps = 30,
				},
				config = function(_, opts)
					require("notify").setup(opts)
				end,
			},
		},
		opts = {
			cmdline = {
				view = "cmdline_popup",
			},
			messages = {
				enabled = true,
				view = "notify",
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.style_highlight"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
		},
	},
}
