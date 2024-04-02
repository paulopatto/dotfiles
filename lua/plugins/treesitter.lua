-- Treesitter configs
return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    local treesitter_configs = require("nvim-treesitter.configs")
    treesitter_configs.setup({
      highlight        = { enable = true },
      indent           = { enable = true },  
      ensure_installed = {
        "c", 
        "html",
        "javascript", 
        "lua",
        "python",
        "ruby",
        "typescript", 
      },
    })
  end
}
