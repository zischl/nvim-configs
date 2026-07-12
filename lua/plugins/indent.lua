return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				highlight = "IblScope",
				show_start = false,
				show_end = true,
			},
		},
		config = function(_, opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IblScope", { fg = "#c084fc", bold = true })
			end)
			require("ibl").setup(opts)
		end,
	},
}
