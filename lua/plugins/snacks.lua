-- Dimensions of layouts
local MIN_VT_MODE_HEIGHT = 40
local MIN_VT_MODE_WIDTH = 110

local MIN_HT_MODE_HEIGHT = 24
local MIN_HT_MODE_WIDTH = 106

local PANE_WIDTH = 48

local NvimHeader = table.concat({
	"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
	"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
	"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
	"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
	"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}, "\n")

local HeaderSplit1 = table.concat({
	"███╗   ██╗███████╗ ██████╗",
	"████╗  ██║██╔════╝██╔═══██╗",
	"██╔██╗ ██║█████╗  ██║   ██║",
	"██║╚██╗██║██╔══╝  ██║   ██║",
	"██║ ╚████║███████╗╚██████╔╝",
	"╚═╝  ╚═══╝╚══════╝ ╚═════╝",
}, "\n")

local HeaderSplit2 = table.concat({
	" ██╗   ██╗██╗███╗   ███╗",
	" ██║   ██║██║████╗ ████║",
	" ██║   ██║██║██╔████╔██║",
	" ╚██╗ ██╔╝██║██║╚██╔╝██║",
	"  ╚████╔╝ ██║██║ ╚═╝ ██║",
	"   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}, "\n")

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			ui_select = true,
		},
		dashboard = {
			enabled = true,
			width = PANE_WIDTH,
			pane_gap = 0,
			formats = {
				file = function(item, ctx)
					local FName = vim.fn.fnamemodify(item.file, ":~")
					local Name = vim.fn.fnamemodify(FName, ":t")
					local Dir = vim.fn.fnamemodify(FName, ":h")

					if Name == "" or Dir == "." then
						return { { FName, hl = "file" } }
					end

					-- Safety margin for long names
					local MaxDirLen = (ctx.width or 40) - #Name - 6
					if MaxDirLen <= 0 then
						return { { Name, hl = "file" } }
					end

					if #Dir > MaxDirLen then
						Dir = vim.fn.pathshorten(Dir)
						if #Dir > MaxDirLen then
							Dir = "…" .. Dir:sub(-MaxDirLen + 1)
						end
					end

					return {
						{ Name, hl = "file" },
						{ " " },
						{ Dir, hl = "dir" },
					}
				end,
			},
			preset = {
				header = NvimHeader,
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = " ",
						key = "p",
						desc = "Projects",
						action = function()
							Snacks.picker.projects()
						end,
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = function()
							local ConfigDir = vim.fn.stdpath("config")
							vim.fn.chdir(ConfigDir)
							require("telescope.builtin").find_files({ cwd = ConfigDir })
						end,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = function(self)
				local Height = self and self._size and self._size.height or vim.o.lines
				local Width = self and self._size and self._size.width or vim.o.columns

				local ListLimit = 5

				if self and self.opts then
					self.opts.width = 48
					self.opts.pane_gap = 0
				end

				local VerticalMode = (Height >= MIN_VT_MODE_HEIGHT and Width <= MIN_VT_MODE_WIDTH)
				local HorizontalMode = (not VerticalMode and Width >= MIN_HT_MODE_WIDTH)

				if VerticalMode then
					return {
						{ header = NvimHeader, padding = 1 },
						{ section = "keys", gap = 1, padding = 1 },
						{
							icon = " ",
							title = "Recent Files",
							section = "recent_files",
							indent = 2,
							padding = 1,
							limit = ListLimit,
						},
						{
							icon = " ",
							title = "Projects",
							section = "projects",
							indent = 2,
							padding = 1,
							limit = ListLimit,
						},
						{ section = "startup" },
					}
				elseif HorizontalMode then
					return {
						{ header = HeaderSplit1, align = "right", padding = 1 },
						{ section = "keys", gap = 1, padding = 1 },

						{ header = HeaderSplit2, pane = 2, align = "left", padding = 1 },
						{
							pane = 2,
							icon = "    ",
							title = "Recent Files",
							section = "recent_files",
							indent = 6,
							padding = 1,
							limit = ListLimit,
						},
						{
							pane = 2,
							icon = "    ",
							title = "Projects",
							section = "projects",
							indent = 6,
							padding = 1,
							limit = ListLimit,
						},
						{ section = "startup", pane = 2, indent = 5 },
					}
				else
					return {
						{ title = " " },
						{ header = NvimHeader, padding = 1 },
						{ section = "keys", gap = 1, padding = 1 },
						{ section = "startup" },
						{ title = " " },

						{
							icon = " ",
							title = "Recent Files",
							section = "recent_files",
							indent = 2,
							padding = 1,
							limit = ListLimit,
						},
						{
							icon = " ",
							title = "Projects",
							section = "projects",
							indent = 2,
							padding = 1,
							limit = ListLimit,
						},
					}
				end
			end,
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Scroll reset
		vim.api.nvim_create_autocmd("User", {
			pattern = "SnacksDashboardUpdatePost",
			callback = function()
				vim.schedule(function()
					pcall(vim.fn.winrestview, { topline = 1 })
				end)
			end,
		})
	end,
}
