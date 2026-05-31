return {
	{
		"nvchad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("colorizer").setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"json",

					"c",
					"cpp",
					"objc",
					"objcpp",
					"rust",
					"go",
					"java",
					"python",

					"lua",
					"toml",
					"yaml",
					"jsonc",
				},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					RRGGBBAA = true,
					AARRGGBB = true,

					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,

					names = false,
					mode = "background",
					tailwind = true,
				},
			})
		end,
	},
}
