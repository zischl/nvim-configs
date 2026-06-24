return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"igorlfs/nvim-dap-view",
				config = function()
					local dap, dap_view = require("dap"), require("dap-view")

					dap_view.setup({})

					dap.listeners.before.attach.dap_view_config = function()
						dap_view.open()
					end
					dap.listeners.before.launch.dap_view_config = function()
						dap_view.open()
					end
					dap.listeners.before.event_terminated.dap_view_config = function()
						dap_view.close()
					end
					dap.listeners.before.event_exited.dap_view_config = function()
						dap_view.close()
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
			vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })

			vim.keymap.set("n", "<leader>du", function()
				require("dap-view").toggle()
			end, { desc = "Toggle DAP View" })
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
