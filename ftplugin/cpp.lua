vim.keymap.set("n", "<F5>", ":CMakeRun<CR>")
vim.keymap.set("n", "<F6>", ":CMakeSelectLaunchTarget<cr>", { desc = "Select Run Target", buffer = true })
vim.keymap.set("n", "<F7>", ":CMakeBuild<CR>")
vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<cr>", { desc = "CMake Generate" })
vim.keymap.set("n", "<leader>ct", ":CMakeSelectBuildTarget<cr>", { desc = "Select Target", buffer = bufnr })
vim.keymap.set("n", "<leader>cd", ":CMakeDebug<cr>", { desc = "CMake Debug" })

-- Toggle Custom Overseer Telescope task list
vim.keymap.set("n", "<leader>oo", function()
	require("BuildSentry").open()
end, { desc = "Open BuildSentry", buffer = true })
