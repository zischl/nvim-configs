-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

--general
vim.keymap.set("i", "<C-j>", "<Esc>")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>", { silent = true, desc = "move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>", { silent = true, desc = "move line up" })

vim.keymap.set("n", "<C-q>", ":q<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>", { silent = true })
vim.keymap.set("n", "<C-q><C-q>", ":q!<CR>", { silent = true })
vim.keymap.set("i", "<C-q><C-q>", "<Esc>:q!<CR>", { silent = true })

-- Save the current buffer/file
vim.keymap.set("n", "<Space>w", ":w<CR>", { desc = "Save File" })

-- Close the current window/buffer
vim.keymap.set("n", "<Space>q", ":q<CR>", { desc = "Quit Window" })

-- Close all windows and exit Neovim
vim.keymap.set("n", "<Space>Q", ":qa<CR>", { desc = "Quit All" })

-- Buffer Controls
vim.keymap.set("n", "<leader>bd", ":bd<CR>")

-- New tab
vim.keymap.set("n", "te", ":tabedit")
vim.keymap.set("n", "<tab>", ":tabnext<Return>")
vim.keymap.set("n", "<s-tab>", ":tabprev<Return>")

-- Split window
vim.keymap.set("n", "ss", ":split<Return>")
vim.keymap.set("n", "sv", ":vsplit<Return>")

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- Increment/decrement
vim.keymap.set("n", "+", "<C-x>")
vim.keymap.set("n", "-", "<C-a>")

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

local function ToggleRelativeNumbering()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = true
	else
		vim.wo.relativenumber = false
	end
end

vim.keymap.set("n", "<S>", function()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = true
	else
		vim.wo.relativenumber = false
	end
end)

--Refactor
vim.keymap.set("n", "<leader>rr", function()
	require("refactoring").select_refactor({
		show_success_message = true,
	})
end, { expr = false, silent = true, noremap = true })
