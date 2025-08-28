return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "debugpy",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Availables LSP Servers
        -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          "jdtls",
          "kotlin_language_server",
          "vscode-java-debug",
          "lua_ls",
          "pyright",
          "ruff",
          "solargraph",
          "tailwindcss",
          "terraformls",
          "ts_ls",
        },
      })
    end,
  },
}

