return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin'
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = "auto",
          globalstatus = true
        },
        sections = {
          lualine_a = {
            { 'buffers' },
          }
        },
      }
    end,
  }
}
