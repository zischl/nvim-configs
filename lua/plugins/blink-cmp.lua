return {
	"saghen/blink.cmp",
	lazy = false,
	version = "*",

	build = "cargo build --release",

	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	opts = {
		snippets = {
			preset = "default",
		},

		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
					components = {
						label = {
							text = function(ctx)
								return ctx.label .. ctx.label_detail
							end,
							highlight = "BlinkCmpLabel",
						},
						label_description = {
							text = function(ctx)
								return ctx.label_description
							end,
							highlight = "BlinkCmpLabelDescription",
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				update_delay_ms = 50,
				window = {
					border = "rounded",
					max_width = 60,
					max_height = 20,
				},
			},
		},

		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = {
				function(cmp)
					if cmp.is_documentation_visible() then
						cmp.hide_documentation()
					else
						cmp.show_documentation()
					end
				end,
				"show",
				"fallback",
			},
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						if cmp.get_selected_item() == nil then
							cmp.select_next()
						end
						return cmp.accept()
					end
				end,
				"fallback",
			},
		},
		cmdline = {
			enabled = true,
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == ":" then
					return { "path", "cmdline" }
				end
				return {}
			end,
		},

		sources = {
			default = { "lsp", "snippets", "path", "buffer" },

			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					score_offset = 100,
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 85,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 50,
					opts = {
						get_cwd = function()
							return vim.fn.getcwd()
						end,
					},
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					score_offset = 25,
					min_keyword_length = 3,
				},
			},
		},
	},
}
