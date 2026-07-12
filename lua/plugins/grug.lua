return {
	"MagicDuck/grug-far.nvim",
	opts = {
		headerMaxWidth = 80,
		transient = true,
	},
	keys = {
		{
			"<leader>sr",
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "GrugFar: Search and Replace Hub",
		},
		{
			"<leader>gw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "GrugFar: Search Current Word",
		},
	},
}
