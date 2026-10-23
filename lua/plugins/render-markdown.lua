return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		file_types = { "markdown", "codecompanion" },
	},
	ft = { "markdown", "codecompanion" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
	},
}
