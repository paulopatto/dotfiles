-- Treesitter configs
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter_configs = require("nvim-treesitter.configs")
    treesitter_configs.setup({
      highlight = {
        enable = true,
        additiona_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "groovy",
        "html",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "luadoc",
        "markdown",
        "python",
        "query",
        "ruby",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
    })
  end,
}

