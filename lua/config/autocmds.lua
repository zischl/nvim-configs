vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		print("Firing up java")
		require("jdtls_setup"):setup()
	end,
	group = vim.api.nvim_create_augroup("JDTLS", { clear = true }),
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.java",
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#a371f7", bold = false })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"html",
		"css",
		"scss",
		"json",
		"jsonc",
		"yaml",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
	group = vim.api.nvim_create_augroup("WebIndent", { clear = true }),
})
