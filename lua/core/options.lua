-- Leader
-- Read: https://vimhelp.org/map.txt.html#%3CLeader%3E
-- vim.g.mapleader      = ' ' 
-- vim.g.maplocalleader = ' '


-- [ GENERAL ]
vim.opt.backspace  = '2'
vim.opt.showcmd    = true
vim.opt.laststatus = 2
vim.opt.autowrite  = true
vim.opt.autoread   = true
vim.opt.mouse      = 'a'           -- enable mouse for all
--vim.cmd [[ set noswapfile ]]
vim.opt.swapfile   = false         -- Disable swap file
vim.opt.history    = 100
vim.opt.wildignore:append("*/node_modules/*,*/vendor/*,*/venv/*,*/.venv/*,*/target/*")


-- [ THEME ]
vim.opt.termguicolors = true
vim.cmd [[ colorscheme onedark ]] 


-- [ EDITOR ]
-- use spaces for tabs and whatnot
vim.opt.shiftround = true
vim.opt.expandtab  = true
vim.opt.tabstop    = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.wo.number = true -- vim.opt.number = true
vim.opt.signcolumn = 'yes' -- Extra left colum
vim.opt.showmatch = true -- Show match parentesis
vim.opt.foldmethod = 'marker'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
