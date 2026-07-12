local function GetPreHook(ctx)
	local ft = vim.bo.filetype

	if ft ~= "javascriptreact" and ft ~= "typescriptreact" then
		return nil
	end

	local ts_status, ts = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
	if not ts_status then
		return nil
	end

	return ts.create_pre_hook()(ctx)
end

return {

	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
		lazy = true,
	},

	opts = {
		pre_hook = GetPreHook,

		mappings = {
			basic = true,
			extra = true,
		},
	},
	lazy = false,
}
