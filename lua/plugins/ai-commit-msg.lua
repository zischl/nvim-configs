return {
	"aweis89/ai-commit-msg.nvim",
	ft = "gitcommit",
	config = true,
	opts = {
		spinner = false,
		provider = "gemini",
		providers = {
			gemini = {
				model = "gemini-2.5-flash-lite",
				temperature = 0.5,

				system_prompt = [[You are an expert developer. Generate a clean, conventional git commit message based on the diff.

Strictly adhere to this format:
1. The first line must be a concise, single-line summary prefixing the type of change (e.g., "Fix: ...", "Feat: ...").
2. Followed by exactly one blank line.
3. Followed by a detailed bulleted list explaining the specific changes, with each point starting with a dash and a space ("- "). Do not use paragraphs; group related technical details into concise bullet points.

Keep the tone professional, objective, and focused on the 'what' and 'why' of the changes.]],
			},
		},
	},
}
