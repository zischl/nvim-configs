--general
vim.keymap.set("i", "<C-j>", "<Esc>")

vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })
vim.keymap.set({ "n", "i" }, "<C-s><C-s>", ":wa<CR>", { silent = true })

vim.keymap.set("n", "<C-q>", ":q<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>", { silent = true })
vim.keymap.set("n", "<C-q><C-q>", ":q!<CR>", { silent = true })
vim.keymap.set("i", "<C-q><C-q>", "<Esc>:q!<CR>", { silent = true })

-- Buffer Controls
vim.keymap.set("n", "<leader>bd", ":bd<CR>")

--Comment Bind
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })

--nvim-tree Binds
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = false })

--LSP
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float()
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
	vim.diagnostic.open_float()
end, { desc = "Prev diagnostic" })
