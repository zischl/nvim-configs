return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("roslyn_ls", {
			cmd = { "roslyn-language-server", "--stdio" },
			filetypes = { "cs", "razor" },
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {
					noremap = true,
					silent = true,
					buffer = bufnr,
					desc = "LSP Hover Documentation",
				})
			end,
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
			},
		})

		vim.lsp.enable("roslyn_ls")
	end,
}
