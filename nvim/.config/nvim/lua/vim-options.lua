--
-- [ GENERAL ]
--
vim.cmd "set nocompatible"            -- disable compatibility to old-time vi
vim.cmd "set number"                  -- add line numbers
vim.cmd "set showmatch"               -- show matching
vim.cmd "set ignorecase"              -- case insensitive
vim.cmd "set termguicolors"           -- Term true colors
vim.cmd "set hlsearch"                -- highlight search
vim.cmd "set incsearch"               -- incremental search
vim.cmd "set cursorline"              -- highlight current cursorline
vim.cmd "set ttyfast"                 -- Speed up scrolling in Vim
vim.cmd "set wildmode=longest,list"   -- get bash-like tab completions
vim.cmd "set mouse=v"                 -- middle-click paste with
vim.cmd "set mouse=a"                 -- enable mouse click
vim.cmd "set clipboard=unnamedplus"   -- using system clipboard
vim.cmd "set backupdir=~/.cache/vim"  -- Directory to store backup files.
vim.cmd "set background=dark"

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

--
-- [ Default identation ]
--
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")              -- converts tabs to white space
vim.cmd("set tabstop=2")              -- number of columns occupied by a tab
vim.cmd("set shiftwidth=2")           -- width for autoindents

--
-- key mapping for window navigation
--
vim.keymap.set('n', "<C-h>", "<C-w>h", {})
vim.keymap.set('n', "<C-j>", "<C-w>j", {})
vim.keymap.set('n', "<C-k>", "<C-w>k", {})
vim.keymap.set('n', "<C-l>", "<C-w>l", {})
