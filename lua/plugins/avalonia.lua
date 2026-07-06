vim.filetype.add({
	extension = {
		axaml = "xml",
	},
})

return {
	"Johanw123/avalonia.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		displayMethod = "html",
	},
	keys = {
		{ "<leader>ap", "<cmd>lua require('avalonia').open_preview()<cr>", desc = "Avalonia UI Preview" },
	},
}
