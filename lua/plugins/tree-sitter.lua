return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "c", "cpp", "lua", "vim", "go", "javascript", "typescript", "tsx"
    },
  },
  config = function(_, opts)
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if not status then
      configs = require("nvim-treesitter")
    end
    configs.setup(opts)
  end,
}
