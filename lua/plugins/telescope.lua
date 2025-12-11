-- func to fix native build issues
function TelescopeNativeBuildHelper()
	local os_name = vim.loop.os_uname().sysname
	if os_name == "Windows_NT" or "win" then
		local plugin_base_dir = vim.fn.stdpath("data")
		local native_telescope_dir = plugin_base_dir .. [[\]] .. "telescope-fzf-native.nvim"

		if vim.fn.isdirectory(native_telescope_dir) == 1 then
			return
		end

		local result = pcall(vim.fn.mkdir, native_telescope_dir, "p")
		print("Build helper did it's thing")
		return
	end
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = function()
				TelescopeNativeBuildHelper()
				return "make"
			end,
		},
	},

	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope Symbols" })
		vim.keymap.set("n", "<leader>fh", builtin.lsp_references, { desc = "Telescope lsp_references" })
	end,
}
