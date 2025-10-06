# List of packages to manage with GNU Stow
STOW_PACKAGES := asdf git mcphub nvim tmux vscode zsh

# The stow command defaults to the parent of the current directory,
# but we explicitly set it to HOME for clarity.
STOW_TARGET := $(HOME)

# Variaveis
SHELL := /bin/bash
XDG_CONFIG_HOME := $(shell echo ~)/.config
DOTFILES_HOME := $(shell pwd)

.PHONY: all base_packages git_config zsh_config asdf_config tmux_config nvim

.PHONY: all link unlink test

all: bootstrap link

link:
	@echo "Linking dotfiles to $(STOW_TARGET)..."
	@stow --restow $(STOW_PACKAGES)

unlink:
	@echo "Unlinking dotfiles from $(STOW_TARGET)..."
	@stow --delete $(STOW_PACKAGES)


bootstrap:
	@echo "Verificando a necessidade de bootstrap..."
	@if [ ! -f .bootstrap ]; then \
		echo "Executando bootstrap de dependências do sistema..."; \
		./scripts/bootstrap.sh; \
		echo "Bootstrap concluído."; \
		touch .bootstrap; \
	else \
		echo "Bootstrap já realizado, arquivo .bootstrap encontrado."; \
	fi
# nvim:
# 	@echo "--> Configuring neovim"
# 	@if [ ! -L "$(XDG_CONFIG_HOME)/nvim" ]; then \
# 		echo "Creating symlink for neovim config"; \
# 		ln -s "$(DOTFILES_DIR)/nvim" "$(XDG_CONFIG_DIR)/nvim"; \
# 		else \
# 		echo "neovim config symlink already exists"; \
# 		fi
# 	@echo "Installing/updating neovim plugins..."
# 	# @nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# 	@nvim --headless "+Lazy! sync" +qa

