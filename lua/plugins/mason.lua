return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		event = "BufReadPre",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"prettier",
				"prettierd",
				"eslint_d",
				"stylua",
				"tree-sitter-cli",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
