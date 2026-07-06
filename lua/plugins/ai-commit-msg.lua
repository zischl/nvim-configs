return {
	"aweis89/ai-commit-msg.nvim",
	ft = "gitcommit",
	config = true,
	opts = {
		spinner = true,
		notifications = true,
		provider = "gemini",
		providers = {
			gemini = {
				model = "gemini-2.5-flash-lite",
				temperature = 0.5,

				system_prompt = [[Generate a commit message keep a dash+space prefix]],
			},
		},
	},
}
