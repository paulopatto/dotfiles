return {
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Availables LSP Servers
        -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          "autopep8",
          "clangd",
          "jdtls",
          "kotlin_language_server",
          "lua_ls",
          "pyright",
          "ruby-lsp",
          "ruff",
          "solargrah",
          "tailwindcss",
          "terraformls",
          "tsserver",
        },
      })
    end,
  },
}
