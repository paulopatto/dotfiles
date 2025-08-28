return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "debugpy",
          "stylua",
					"shellcheck",
					"shfmt",
					"flake8",
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

