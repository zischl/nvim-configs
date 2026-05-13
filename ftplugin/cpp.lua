vim.keymap.set("n", "<F5>", ":CMakeRun<CR>")
vim.keymap.set("n", "<F6>", ":CMakeSelectLaunchTarget<cr>", { desc = "Select Run Target", buffer = true })
vim.keymap.set("n", "<F7>", ":CMakeBuild<CR>")

-- Toggle Build Sentry task list
vim.keymap.set("n", "<leader>oo", function()
	require("buildsentry").open()
end, { desc = "Open BuildSentry", buffer = true })
