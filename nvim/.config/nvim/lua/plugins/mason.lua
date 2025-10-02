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
}
