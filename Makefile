.PHONY: all base_packages git_config zsh_config asdf_config tmux_config nvim

all: base_packages git_config zsh_config asdf_config tmux_config nvim

# Variaveis
SHELL := /bin/bash
HOME := $(shell echo ~)
XDG_CONFIG_HOME := $(shell echo ~)/.config
DOTFILES_HOME := $(shell pwd)


base_packages: .base_packages_installed
	@echo "Pacotes base já estão instalados."

.base_packages_installed:
	@echo "Criando diretórios de configuração iniciais..."
	@mkdir -p $(HOME)/.local/bin
	@mkdir -p $(XDG_CONFIG_HOME)/zsh/envs
	@echo "Verificando e instalando pacotes base..."
	@if [ "$(uname -s)" = "Darwin" ]; then
		echo "Plataforma MacOS detectada.";
		if ! command -v brew >/dev/null 2>&1; then
			echo "Instalando Homebrew...";
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
		else
			echo "Homebrew já instalado.";
		fi;
		echo "Instalando pacotes via Brew...";
		brew bundle --file=- <<EOF;
		brew "git"
		brew "zsh"
		brew "tmux"
		brew "neovim"
		brew "asdf"
		brew "1password-cli"
		brew "ripgrep"
		brew "fd"
		brew "lazygit"
		brew "jq"
		brew "stow"
		brew "lazygit"
		brew "lazydocker"
		brew "xclip"
		brew "editorconfig-checker"
		EOF;
	elif [ "$(uname -s)" = "Linux" ]; then
		if command -v dnf >/dev/null; then
			echo "Plataforma Fedora detectada. Instalando pacotes...";
			sudo dnf upgrade -q -y;
			sudo dnf groupinstall -y '@development-tools' '@development-libraries';
			sudo dnf copr enable -y atim/lazygit;
			sudo dnf copr enable -y atim/lazydocker
			sudo dnf install -q -y automake curl gcc gcc-c++ git kernel-devel libffi-devel libpq-devel editorconfig-checker lua make neovim nodejs python3 python3-devel python3-pip readline readline-devel tmux wget zsh ripgrep fd-find lazygit lazydocker jq stow xclip;
		elif command -v apt >/dev/null; then
			echo "Plataforma Ubuntu/Debian detectada. Instalando pacotes...";
			sudo apt-get update -qq;
			sudo apt-get upgrade -qq -y;
			sudo apt-get install -qq -y build-essential apt-transport-https curl git gnupg2 libffi-dev libpq-dev libreadline-dev editorconfig-checker lua5.3 neovim python3 python3-dev python3-pip tmux wget zsh stow ripgrep fd-find jq xclip;

			if ! command -v lazygit >/dev/null; then
				echo "Instalando LazyGit dos fontes...";
				LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*');
				curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz";
				tar xf /tmp/lazygit.tar.gz -C /tmp lazygit;
				sudo install /tmp/lazygit /usr/local/bin;
				rm -f /tmp/lazygit.tar.gz /tmp/lazygit;
			fi;

			if ! command -v lazydocker >/dev/null; then
				echo "Instalando LazyDocker dos fontes...";
				curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
					| grep browser_download_url \
					| grep Linux_x86_64 \
					| cut -d '"' -f 4 \
					| wget -qi -
					tar xf lazydocker_*_Linux_x86_64.tar.gz lazydocker
					sudo install lazydocker /usr/local/bin
			fi;

		fi;
	else
		echo "Sistema operacional não suportado por esta regra.";
		exit 1;
	fi
	@echo "Instalação dos pacotes base concluída."
	@touch $@ # Cria o arquivo marcador para indicar que a instalação foi feita.

git_config:
	@echo "Configurando o Git..."
	@ln -sf $(DOTFILES_HOME)/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DOTFILES_HOME)/gitignore_global $(HOME)/.gitignore_global
	@if [ "$(uname -s)" = "Darwin" ]; then \
		ln -sf $(DOTFILES_HOME)/gitconfig-osx $(HOME)/.gitconfig-ssh; \
		elif [ "$(uname -s)" = "Linux" ]; then \
		ln -sf $(DOTFILES_HOME)/gitconfig-linux $(HOME)/.gitconfig-ssh; \
		fi
	@echo "Configuração do Git concluída."

zsh_config: .zplug_installed
	@echo "Zplug já está instalado."

zplug_installed:
	@echo "Configurando Zsh e instalando Zplug..."
	@if [ ! -d "$(XDG_CONFIG_HOME)/zsh/plugins/zplug" ]; then \
		echo "Instalando Zplug..."; \
		git clone https://github.com/zplug/zplug $(XDG_CONFIG_HOME)/zsh/plugins/zplug; \
		fi
	@touch $@ # Cria o arquivo marcador para indicar que a instalação foi feita.

asdf_config:
	@echo "Configurando ASDF..."
	@ln -sf $(DOTFILES_HOME)/asdfrc $(HOME)/.asdfrc
	@ln -sf $(DOTFILES_HOME)/default-gems $(HOME)/.default-gems
	@ln -sf $(DOTFILES_HOME)/default-npm-packages $(HOME)/.default-npm-packages
	@ln -sf $(DOTFILES_HOME)/default-python-packages $(HOME)/.default-python-packages
	@ln -sf $(DOTFILES_HOME)/default-golang-pkgs $(HOME)/.default-golang-pkgs
	@echo "Configuração do ASDF concluída."

tmux_config: .tmux_configured
	@echo "Tmux já está configurado."
	.tmux_configured:
	@echo "Configurando Tmux..."
	@if [ ! -d "$(XDG_CONFIG_HOME)/tmux/plugins/tpm" ]; then \
	echo "Instalando Tmux Plugin Manager (TPM)..."; \
	git clone https://github.com/tmux-plugins/tpm $(XDG_CONFIG_HOME)/tmux/plugins/tpm; \
	fi
	@mkdir -p $(XDG_CONFIG_HOME)/tmux/
	@ln -sf $(DOTFILES_HOME)/tmux/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf
	@touch $@ # Cria o arquivo marcador para indicar que a instalação foi feita.

nvim:
	@echo "--> Configuring neovim"
	@if [ ! -L "$(XDG_CONFIG_HOME)/nvim" ]; then \
		echo "Creating symlink for neovim config"; \
		ln -s "$(DOTFILES_DIR)/nvim" "$(XDG_CONFIG_DIR)/nvim"; \
		else \
		echo "neovim config symlink already exists"; \
		fi
	@echo "Installing/updating neovim plugins..."
	# @nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	@nvim --headless "+Lazy! sync" +qa

