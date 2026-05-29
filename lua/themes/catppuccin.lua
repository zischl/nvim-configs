return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = "italic",
						hints = "italic",
						warnings = "italic",
						information = "italic",
					},
					underlines = {
						errors = "underline",
						hints = "underline",
						warnings = "underline",
						information = "underline",
					},
				},

				lsp_trouble = true,
				cmp = true,
				gitsigns = true,
			},
			custom_highlights = function(colors)
				return {
					["cmakeStatement"] = { fg = "#569CD6", style = { "bold" } },
					["cmakeCommand"] = { fg = "#569CD6" },

					["cmakeVariable"] = { fg = "#C586C0" },

					["cmakeEscaped"] = { fg = "#4EC9B0" },

					["cmakeString"] = { fg = "#CE9178" },
					["cmakeVariableValue"] = { fg = "#CE9178" },

					["cmakeArguments"] = { fg = "#d8b595" },

					["cmakeConditional"] = { fg = "#C586C0" },

					["cmakeRegistry"] = { fg = "#D16969" },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
