return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "html",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- if require('nvim-treesitter.indent').get_indent then
      --   vim.filetype.add({
      --     extension = {
      --       jsx = {
      --         indent_func = require('nvim-treesitter.indent').get_indent,
      --       },
      --       tsx = {
      --         indent_func = require('nvim-treesitter.indent').get_indent,
      --       },
      --     },
      --   })
      -- end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
}
