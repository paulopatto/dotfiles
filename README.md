# dotfiles
Config files

## Requirements

### Neovim (LazyVim)

- Neovim >= 0.8.0 (needs to be built with LuaJIT) [install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- Git >= [2.19.0+](https://git-scm.com/download/linux) (for partial clones support)
- The [Nerd Fonts](https://www.nerdfonts.com/) (_optional_)
- a C compiler for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- **[ripgrep (rg)](https://github.com/BurntSushi/ripgrep)**: line-oriented search tool that recursively searches the current directory for a regex pattern. _By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files._

#### Install packages dependecies

Mac OS/X

```sh
brew install neovim ripgrep fd
```

Ubuntu (jammy+)

```sh
sudo apt install -y ripgrep fd-find
```

Fedora

```sh
# Install neovim 0.9+ via Flatpak
flatpak install flathub io.neovim.nvim

# Install Packages
sudo dnf install -y ripgrep fd-find
```

### Tmux

### ZSH

