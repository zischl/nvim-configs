return {
  {
    'stevearc/conform.nvim',
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          typescript = { "prettier" },
          lua = { "stylua" },
          cpp = { "clang-format" },
          c = { "clang-format" },
          python = { "black", "isort" },
        },

        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)", silent = true })
    end,
  }
}
