return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	init = function()
		if
			vim.fn.executable("tree-sitter") == 0
			and vim.fn.executable("gcc") == 0
			and vim.fn.executable("clang") == 0
			and vim.fn.executable("zig") == 0
		then
			vim.schedule(function()
				vim.notify(
					"nvim-treesitter: 'tree-sitter' CLI or C compiler not found on PATH. Run 'npm install -g tree-sitter-cli' to compile parsers.",
					vim.log.levels.WARN
				)
			end)
		end
	end,
	opts = {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "cmake" },
			disable = { "cmake" },
		},
		indent = {
			enable = true,
			disable = { "c", "cpp" },
		},
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
			"c_sharp",
			"razor",
			"xml",
			"proto",
			"yaml",
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
