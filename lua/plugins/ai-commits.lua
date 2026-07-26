return {
	"zischl/AI-Commits.nvim",
	cmd = { "AICommit", "GitAICommit" },
	keys = {
		{ "<leader>gc", "<cmd>AICommit<cr>", desc = "Generate AI Commit Msg" },
	},
	opts = {
		model = "gemini-2.5-flash",
		include_history = true,
		history_count = 10,
	},
}
