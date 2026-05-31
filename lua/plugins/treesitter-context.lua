return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = {
			max_lines = 4,
			min_window_height = 15,
			separator = "─",
		},
	},
}
