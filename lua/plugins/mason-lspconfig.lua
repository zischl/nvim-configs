local on_attach = function(client, bufnr)
	vim.keymap.set(
		"n",
		"K",
		vim.lsp.buf.hover,
		{ noremap = true, silent = true, buffer = bufnr, desc = "LSP Hover Documentation" }
	)
end

local opts = {
	ensure_installed = { "efm", "lua_ls", "clangd", "pyright", "ts_ls" },
	automatic_installation = true,
	automatic_enable = {
		exclude = {
			"jdtls",
		},
	},
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = opts,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},

		handlers = {
			["*"] = function(server_name)
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			jdtls = function()
				return true
			end,
		},
	},
}
