return {
  "nvim-java/nvim-java",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
