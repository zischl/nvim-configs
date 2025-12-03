return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup {
        'css',
        'javascript',
        'javascriptreact',
        html = {
          mode = 'foreground',
        }
      }
    end
  }
}
