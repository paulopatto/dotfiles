-- Treesitter configs
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter_configs = require("nvim-treesitter.configs")
    treesitter_configs.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
        -- keep java enabled; parser will be updated
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

    -- no hard-disable; rely on updated parser
  end,
}
