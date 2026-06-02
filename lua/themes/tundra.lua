return {
	"sam4llis/nvim-tundra",
	lazy = false,
	priority = 1000,
	config = function()
		local status, tundra = pcall(require, "tundra")
		if not status then
			return
		end
		tundra.setup({
			transparent_background = false,
			dim_inactive_windows = {
				enabled = true,
				color = nil,
			},
			sidebars = {
				enabled = true,
				providers = { "NvimTree", "neo-tree", "SidebarNvim", "Outline", "trouble" },
			},
			plugins = {
				lspconfig = true,
				treesitter = true,
				telescope = true,
				gitsigns = true,
				nvim_cmp = true,
			},
			overwrite = {
				DiagnosticVirtualTextError = { fg = "#ef6a7b", bg = "none", italic = true },
				DiagnosticVirtualTextWarn = { fg = "#f1ad6e", bg = "none", italic = true },
				DiagnosticVirtualTextHint = { fg = "#7cb7ff", bg = "none" },
				DiagnosticVirtualTextInfo = { fg = "#b3deef", bg = "none" },

				TelescopeBorder = { fg = "#20344c" },
				TelescopePromptBorder = { fg = "#3d5b80" },
			},
		})

		vim.cmd("colorscheme tundra")
	end,
}
