local opts = {
  ensure_installed = { "efm", "lua_ls", "clangd", "pyright", "ts_ls" },
  automatic_installation = true,
}

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = opts,
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },

    handlers = {
      function(server_name)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
    },
  },
}
