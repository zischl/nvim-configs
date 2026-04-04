return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-jdtls",
	},

	config = function()
		require("mason").setup()

		local is_windows = vim.fn.has("win32") == 1

		local function get_project_python()
			local cwd = vim.fn.getcwd()

			if is_windows then
				local venv = cwd .. "\\venv\\Scripts\\python.exe"
				local dot_venv = cwd .. "\\.venv\\Scripts\\python.exe"

				if vim.fn.filereadable(dot_venv) == 1 then
					return dot_venv
				end

				if vim.fn.filereadable(venv) == 1 then
					return venv
				end

				return "python"
			end

			local venv = cwd .. "/venv/bin/python"
			local dot_venv = cwd .. "/.venv/bin/python"

			if vim.fn.filereadable(dot_venv) == 1 then
				return dot_venv
			end

			if vim.fn.filereadable(venv) == 1 then
				return venv
			end

			return "python3"
		end

		local function get_debugpy_python()
			local base = vim.fn.stdpath("data") .. "/mason/packages/debugpy"

			if is_windows then
				return base .. "\\venv\\Scripts\\python.exe"
			end

			return base .. "/venv/bin/python"
		end

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = {
				"debugpy",
				"codelldb",
				"js-debug-adapter",
			},

			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,

				debugpy = function(config)
					require("dap").adapters.python = {
						type = "executable",
						command = get_debugpy_python(),
						args = { "-m", "debugpy.adapter" },
					}

					require("dap").configurations.python = {
						{
							type = "python",
							request = "launch",
							name = "Launch file (Z-TAS Debug)",
							program = "${file}",
							pythonPath = get_project_python,
							console = "integratedTerminal",
						},
					}

					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
