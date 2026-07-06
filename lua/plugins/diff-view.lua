return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
	keys = {
		{
			"<leader>dv",
			function()
				require("lazy").load({ plugins = { "diffview.nvim" } })

				local actions = {
					{ label = "Open Project Diff", cmd = "DiffviewOpen" },
					{ label = "Close Diffview", cmd = "DiffviewClose" },
					{ label = "Current File History", cmd = "DiffviewFileHistory %" },
					{ label = "Project Git History", cmd = "DiffviewFileHistory" },
					{ label = "Toggle File Panel", cmd = "DiffviewToggleFiles" },
				}

				-- Numbering actions as a prefix for shortcuts so the key goes like <leader>dv1/2/3/4
				local numbered_labels = {}
				for i, action in ipairs(actions) do
					table.insert(numbered_labels, string.format("%d. %s", i, action.label))
				end

				local has_telescope, _ = pcall(require, "telescope")

				-- Just get telescope.. looks better, faster to use
				if has_telescope then
					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local actions_state = require("telescope.actions.state")
					local telescope_actions = require("telescope.actions")
					local themes = require("telescope.themes")

					local opts = themes.get_dropdown({
						prompt_title = "Diffview Actions",
						results_height = 6,
						layout_config = { width = 0.4 },
						sorter = false,
					})

					pickers
						.new(opts, {
							finder = finders.new_table({ results = numbered_labels }),
							attach_mappings = function(prompt_bufnr, map)
								local run_idx = function(idx)
									telescope_actions.close(prompt_bufnr)
									if actions[idx] then
										vim.cmd(actions[idx].cmd)
									end
								end

								-- Standard Enter key selection
								telescope_actions.select_default:replace(function()
									local selection = actions_state.get_selected_entry()
									if not selection then
										return
									end
									-- In case u ever change this.. do update fallback menu regex too
									local idx = tonumber(selection[1]:match("^(%d+)%."))
									run_idx(idx)
								end)

								-- Hot key selections
								for i = 1, #actions do
									map("i", tostring(i), function()
										run_idx(i)
									end)
									map("n", tostring(i), function()
										run_idx(i)
									end)
								end

								return true
							end,
						})
						:find()
				else
					-- Fallback menu just in case
					vim.ui.select(numbered_labels, {
						prompt = "Diffview Actions:",
						kind = "diffview_menu",
					}, function(choice)
						if not choice then
							return
						end
						local idx = tonumber(choice:match("^(%d+)%"))
						if actions[idx] then
							vim.cmd(actions[idx].cmd)
						end
					end)
				end
			end,
			desc = "Diffview Action Menu (Telescope)",
		},
	},
	config = function(_, opts)
		local diffview = require("diffview")
		diffview.setup(opts)

		-- 'q' to close Diffview
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "DiffviewFiles", "DiffviewFileHistory" },
			callback = function()
				vim.keymap.set("n", "q", "<cmd>DiffviewClose<CR>", { buffer = true, silent = true })
			end,
		})
	end,
	opts = {
		enhanced_diff_hl = true,
		use_icons = true,
		view = {
			default = { layout = "diff2_horizontal" },
		},
		file_panel = {
			win_config = { position = "left", width = 35 },
		},
	},
}
