vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd "set number"
vim.g.mapleader = "\\" 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- Telescope configs
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Treesitter configs
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


-- NeoTree
vim.keymap.set('n', '<leader>p', ':Neotree filesystem reveal left<CR>', {})

-- Colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
