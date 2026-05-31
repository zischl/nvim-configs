return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {
			fastwarp = {
				enable = true,
				enable_bck = true,
				map = "<A-e>",
				rmap = "<A-E>",
			},
			bs = {
				enable = true,
			},
			cr = {
				enable = true,
			},
			space = {
				enable = true,
			},
			tabout = {
				enable = true,
			},
		},
	},
}
