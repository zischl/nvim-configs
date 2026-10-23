local on_attach = function(client, bufnr)
	vim.keymap.set(
		"n",
		"K",
		vim.lsp.buf.hover,
		{ noremap = true, silent = true, buffer = bufnr, desc = "LSP Hover Documentation" }
	)
end

local opts = {

	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
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
		"eslint",
		"jsonls",
	},
	automatic_installation = true,
	automatic_enable = true,

	handlers = {
		["*"] = function(server_name)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,

		jdtls = function()
			return true
		end,

		["efm"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").efm.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					languages = {},
				},
			})
		end,

		["gopls"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

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
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			capabilities.offsetEncoding = { "utf-16" }

			require("lspconfig").clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
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

				local capabilities = require("blink.cmp").get_lsp_capabilities()
				nvim_lsp.neocmake.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					init_options = {
						format = { enable = true },
						lint = { enable = true },
						scan_cmake_in_package = true,
					},
				})
			end
		end,

		["ts_ls"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)

					vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
						vim.lsp.buf.execute_command({
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(bufnr) },
						})
					end, { desc = "Organize Imports" })

					vim.keymap.set(
						"n",
						"<leader>co",
						"<cmd>OrganizeImports<CR>",
						{ buffer = bufnr, desc = "Organize Imports" }
					)
				end,
				root_dir = require("lspconfig.util").root_pattern(
					"tsconfig.json",
					"jsconfig.json",
					"package.json",
					".git"
				),
				single_file_support = false,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
					},
				},
			})
		end,

		["tailwindcss"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = require("lspconfig.util").root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.cjs",
					"postcss.config.mjs",
					"postcss.config.ts",
					"package.json",
					"node_modules",
					".git"
				),
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
						includeLanguages = {
							typescript = "javascript",
							typescriptreact = "javascript",
							javascript = "javascript",
							javascriptreact = "javascript",
						},
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "twMerge\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "tv\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "tw\\`([^\\`]*)\\`", "([^\\`]*)" },
							},
						},
					},
				},
			})
		end,

		["cssls"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					css = { validate = true, lint = { unknownAtRules = "ignore" } },
					scss = { validate = true, lint = { unknownAtRules = "ignore" } },
					less = { validate = true, lint = { unknownAtRules = "ignore" } },
				},
			})
		end,

		["emmet_ls"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").emmet_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
			})
		end,

		["eslint"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "silent! EslintFixAll",
					})
				end,
				settings = {
					workingDirectories = { mode = "auto" },
					format = false,
				},
			})
		end,

		["jsonls"] = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").jsonls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					json = {
						validate = { enable = true },
					},
				},
			})
		end,

		roslyn = function()
			return true
		end,
	},
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		opts = opts,
	},
}
