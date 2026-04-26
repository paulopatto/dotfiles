return {
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Availables LSP Servers
        -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          "clangd",
          "jdtls",
          "java-lanuage-server",
          "kotlin_language_server",
          "lua_ls",
          "pyright",
          "ruby_lsp",
          "solargraph",
          "tailwindcss",
          "terraformls",
          "ts_ls",
        },
      })
    end,
  },
}
