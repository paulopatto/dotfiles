return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    opts = {
      -- This line is essential to making automatic installation work
      -- :exploding-brain
      -- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
      handlers = {},
      automatic_installation = {
        exclude = {
          "python",
        },
        ensure_installed = {
          "python",
          "debugpy",
          "vscode-java-debug",
        },
      },
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "python",
          "debugpy",
        },
      })
    end,
  },
}

