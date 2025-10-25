return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = {
				"python",
				"codelldb",
				"node2",
			},
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,

				python = function(config)
					local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

					require("dap").adapters.python = {
						type = "executable",
						command = mason_path,
						args = { "-m", "debugpy.adapter" },
					}

					require("dap").configurations.python = {
						{
							type = "python",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							pythonPath = mason_path, -- Ensures debugged code uses the same Python
							console = "integratedTerminal",
							stopOnEntry = true,
							justMyCode = false,
						},
					}

					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
