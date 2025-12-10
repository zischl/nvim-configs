print("AutoCmds Loading !")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    print("Firing up java")
    require("jdtls_setup"):setup()
  end,
  group = vim.api.nvim_create_augroup("JDTLS", { clear = true }),
})
