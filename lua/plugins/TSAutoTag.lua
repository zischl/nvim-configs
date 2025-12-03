return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,
        enable_rename = true,
      },

      filetypes = {
        'html',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'tsx',
        'jsx',
        'vue',
        'svelte',
        'xml',
        'php'
      },
    })
  end,
}
