local config = function()
  local theme = require 'lualine.themes.catppuccin'

  require('lualine').setup {
    options = { theme = theme, globalstatus = true },
    sections = {
      lualine_a = {
        {
          'buffers',
        },
      }
    },
  }
end


return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = config,
  } }
