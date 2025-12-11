return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				config = function()
					local dap, dapui = require("dap"), require("dapui")

					dapui.setup({
						layouts = {
							{
								elements = {
									{ id = "scopes", size = 0.25 },
									{ id = "breakpoints", size = 0.25 },
									{ id = "stacks", size = 0.25 },
									{ id = "watches", size = 0.25 },
								},
								size = 40,
								position = "left",
							},
							{
								elements = {
									{ id = "repl", size = 0.5 },
									{ id = "console", size = 0.5 },
								},
								size = 10,
								position = "bottom",
							},
						},
					})

					dap.listeners.before.attach.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.launch.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated.dapui_config = function()
						dapui.close()
					end
					dap.listeners.before.event_exited.dapui_config = function()
						dapui.close()
					end
				end,
			},
		},
		config = function()
			local dap = require("dap")
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Continue Debugging" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dp", require("dap").pause, { desc = "Pause" })
			vim.keymap.set("n", "<leader>dq", require("dap").terminate, { desc = "terminate" })
			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<leader>dc", function()
				require("dapui").toggle({ reset = true, layout = 2 })

				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)
					if name:match("%[dap%-terminal%]") then
						local line_count = vim.api.nvim_buf_line_count(buf)
						vim.api.nvim_win_set_cursor(win, { line_count, 0 })
					end
				end
			end, { desc = "Open DAP Console" })
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
