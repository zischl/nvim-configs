function GetLuaLib()
	local os_name = vim.loop.os_uname().sysname

	if os_name == "Windows_NT" or "win" then
		local command = os_name:match("Windows") and "where nvim" or "which nvim"

		local result = vim.fn.system(command)
		result = result:gsub("nvim.exe", "")

		local nvim_path = result:gsub("^%s*(.-)%s*$", "%1")
		if nvim_path == "" or result:match("not found") or result:match("could not find") then
			return nil, "nvim not found in PATH."
		end

		return nvim_path .. "lua51.dll"
	end

	return nil
end

return {

	"hrsh7th/nvim-cmp",

	config = function()
		local cmp = require("cmp")

		require("luasnip.loaders.from_vscode").lazy_load()
		require("cmp").setup({

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "cmdline" },
				{ name = "path" },
				{ name = "buffer" },
			}),

			completion = {
				completeopt = "menu,menuone,noselect",
				get_trigger_characters = function(chars)
					local new_chars = {}
					for _, char in ipairs(chars) do
						if char ~= " " then
							table.insert(new_chars, char)
						end
					end
					return new_chars
				end,
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
				["<tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = function()
				local lua_lib = GetLuaLib()
				if lua_lib then
					return "make LDLIBS=" .. lua_lib .. "install_jsregexp"
				end
				return "make install_jsregexp"
			end,
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},
	},

	event = "InsertEnter",
	priority = 1000,
}
