return {
	{
		"stevearc/conform.nvim",
		opts = {},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },
					yaml = { "prettierd", "prettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					graphql = { "prettierd", "prettier", stop_after_first = true },
					lua = { "stylua" },
					cpp = { "clang-format" },
					c = { "clang-format" },
					python = { "black", "isort" },
					go = { "goimports" },
					cmake = { "cmake_format" },
				},

				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 2000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 2000,
				})
			end, { desc = "Format file or range (in visual mode)", silent = true })
		end,
	},
}
