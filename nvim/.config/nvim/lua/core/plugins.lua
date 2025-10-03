-- This file can be loaded by calling `lua require('plugins')` from your init.vim or init.lua

--[[
  # Packer
  > https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#bootstrapping

  ## Install
  Run:
  ```sh
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```
]]--
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

  -- **************************************
  --               General
  -- **************************************
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdtree'                        -- file system explorer
  use 'ryanoasis/vim-devicons'                    -- Adds file type icons to Vim plugins such as: NERDTree
  use 'nvim-lualine/lualine.nvim'                 -- A blazing fast and easy to configure neovim statusline, written in pure lua.

  -- **************************************
  --          Themes / Colorschemes
  -- **************************************
  use 'Mangeshrex/uwu.vim'                        -- A beautiful and dark vim colorscheme.
  use 'altercation/vim-colors-solarized'          -- Solarized Colorscheme for Vim Description by Awesome-VIM
  use 'arcticicestudio/nord-vim'                  -- An arctic, north-bluish clean and elegant Vim theme.
  use 'arzg/vim-colors-xcode'                     -- Xcode 11’s dark and light colourschemes for Vim
  use 'chriskempson/base16-vim'                   -- Base16 for Vim
  use 'cormacrelf/vim-colors-github'              -- A Vim colorscheme based on Github's syntax highlighting as of 2018.
  use 'daylerees/colour-schemes'                  -- Color schem pack see options in http://daylerees.github.io/
  use 'drewtempelmeyer/palenight.vim'             -- Soothing color scheme for your favorite [best] text editor
  use 'gosukiwi/vim-atom-dark'                    -- A vim theme inspired by Atom's default dark theme
  use 'jaredgorski/SpaceCamp'                     -- Vim colors for the final frontier
  use 'joshdick/onedark.vim'                      -- A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
  use 'kaicataldo/material.vim'                   -- A port of the Material color scheme for Vim/Neovim
  use 'nanotech/jellybeans.vim'                   -- A colorful, dark color scheme, inspired by ir_black and twilight
  use 'preservim/vim-colors-pencil'               -- Light (& dark) color scheme inspired by iA Writer
  use 'romgrk/doom-one.vim'                       -- A dark colorschme for vim, ported from doom-emacs' doom-one theme.
  use 'sainnhe/sonokai'                           -- High Contrast & Vivid Color Scheme based on Monokai Pro
  use 'severij/vadelma'                           -- Super sexy Vim/Neovim color scheme for GUIs and 256-color terminals.
  use 'tomasiser/vim-code-dark'
  use 'jpo/vim-railscasts-theme'
  use 'mhinz/vim-janah'
  use 'morhetz/gruvbox'
  use 'sickill/vim-monokai'
  use 'rakr/vim-one'
  use 'sonph/onehalf'                             -- Clean, vibrant and pleasing color schemes for Vim, gnome-terminal and more.
  use 'tomasr/molokai'                            -- Molokai color scheme for Vim


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
)
