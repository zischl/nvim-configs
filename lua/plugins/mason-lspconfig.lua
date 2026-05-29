local on_attach = function(client, bufnr)
	vim.keymap.set(
		"n",
		"K",
		vim.lsp.buf.hover,
		{ noremap = true, silent = true, buffer = bufnr, desc = "LSP Hover Documentation" }
	)
end

local opts = {
	ensure_installed = {
		"lua_ls",
		"clangd",
		"pyright",
		"ts_ls",

		"gopls",

		"tailwindcss",
		"cssls",
		"html",
		"emmet_ls",

		"stylua",
	},
	automatic_installation = true,
	automatic_enable = true,

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

		["efm"] = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("lspconfig").efm.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					languages = {},
				},
			})
		end,

		["gopls"] = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})
		end,

		["clangd"] = function()
			require("lspconfig").clangd.setup({
				on_new_config = function(new_config, _)
					local status, cmake = pcall(require, "cmake-tools")
					if status then
						cmake.clangd_on_new_config(new_config)
					end
				end,
			})
		end,

		["neocmake"] = function()
			local configs = require("lspconfig.configs")
			local nvim_lsp = require("lspconfig")
			if not configs.neocmake then
				configs.neocmake = {
					default_config = {
						cmd = { "neocmakelsp", "stdio" },
						filetypes = { "cmake" },
						root_dir = function(fname)
							return nvim_lsp.util.find_git_ancestor(fname)
						end,
						single_file_support = true,
					},
				}
				nvim_lsp.neocmake.setup({
					on_attach = on_attach,
					init_options = {
						format = {
							enable = true,
						},
						lint = {
							enable = true,
						},
						scan_cmake_in_package = true,
					},
				})
			end
		end,
	},
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = opts,
	},
}
