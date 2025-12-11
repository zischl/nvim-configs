function BootRecentWork()
	local builtin = require("telescope.builtin")

	local nvim_exec_path = vim.fn.resolve(vim.fn.exepath("nvim"))
	local nvim_exec_dir = vim.fn.fnamemodify(nvim_exec_path, ":h")
	local current_cwd = vim.fn.getcwd()

	if vim.fn.argv(0) == "" and ((current_cwd == nvim_exec_dir) or (current_cwd == vim.fn.expand("~"))) then
	end
end

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

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("TelescopeStartup", { clear = true }),
	callback = BootRecentWork,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("AutoAddToDirHistory", { clear = true }),
	callback = function()
		local cwd = vim.fn.getcwd()
	end,
})
