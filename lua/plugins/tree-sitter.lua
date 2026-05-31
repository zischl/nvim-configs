return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "cmake" },
			disable = { "cmake" },
		},
		indent = { enable = false },
		ensure_installed = {
			"c",
			"cpp",
			"cmake",
			"lua",
			"vim",
			"go",
			"javascript",
			"typescript",
			"tsx",
		},
	},
	config = function(_, opts)
		local status, configs = pcall(require, "nvim-treesitter.configs")
		if not status then
			configs = require("nvim-treesitter")
		end
		configs.setup(opts)
	end,
}
