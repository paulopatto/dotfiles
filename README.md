# dotfiles
Config files

## Requirements

### Neovim (LazyVim)

- Neovim >= 0.8.0 (needs to be built with LuaJIT) [install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- Git >= [2.19.0+](https://git-scm.com/download/linux) (for partial clones support)
- The [Nerd Fonts](https://www.nerdfonts.com/) (_optional_)
- a C compiler for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- **[ripgrep (rg)](https://github.com/BurntSushi/ripgrep)**: line-oriented search tool that recursively searches the current directory for a regex pattern. _By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files._
- Extras
    - Git simple terminal UI for git commands via [LazyGit](https://github.com/jesseduffield/lazygit)
#### Install packages dependecies

Mac OS/X

```sh
brew install neovim ripgrep fd lazygit
```

Ubuntu (jammy+)

```sh
sudo apt install -y ripgrep fd-find

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
echo "Verify the correct installation of lazygit:"
echo "  lazygit --version"
```

Fedora

```sh
# Install neovim 0.9+ via Flatpak
flatpak install flathub io.neovim.nvim


# Enable repo to LazyGit
sudo dnf copr enable atim/lazygit -y

# Install Packages
sudo dnf install -y ripgrep fd-find lazygit
```

### Tmux

### ZSH

