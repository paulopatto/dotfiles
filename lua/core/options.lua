-- Leader
-- Read: https://vimhelp.org/map.txt.html#%3CLeader%3E
-- vim.g.mapleader      = ' ' 
-- vim.g.maplocalleader = ' '

vim.opt.backspace  = '2'
vim.opt.showcmd    = true
vim.opt.laststatus = 2
vim.opt.autowrite  = true
vim.opt.cursorline = true
vim.opt.autoread   = true

--Line numbers
-- equivalente ao `set number`
vim.wo.number = true

-- use spaces for tabs and whatnot
vim.opt.tabstop    = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab  = true

vim.cmd [[ set noswapfile ]]

