return {
	"zischl/AI-Commits.nvim",
	cmd = { "AICommit", "GitAICommit" },
	ft = "gitcommit",
	keys = {
		{ "<leader>gc", "<cmd>AICommit<cr>", ft = "gitcommit", desc = "Generate AI Commit Msg" },
	},
	opts = {
		model = "gemini-2.5-flash",
	},
}
