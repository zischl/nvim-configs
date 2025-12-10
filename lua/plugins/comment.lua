local function GetPreHook(ctx)
  local ft = vim.bo.filetype

  if ft ~= "javascriptreact" and ft ~= "typescriptreact" then
    return nil
  end

  local pre = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
  local cs = pre(ctx)


  if cs then
    return cs
  end

  return ctx
end



return {

  'numToStr/Comment.nvim',
  opts = {
    ---Function to call before (un)comment
    pre_hook = GetPreHook
  },
  lazy = false,

  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    },
    lazy = true,
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
}
