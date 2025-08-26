# Makefile

.PHONY: all base_packages git_config

# Variaveis
SHELL := /bin/bash
HOME := $(shell echo ~)
XDG_CONFIG_HOME := $(shell echo ~)/.config
DOTFILES_HOME := $(shell pwd)

all: base_packages git_config

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
		EOF;
	elif [ "$(uname -s)" = "Linux" ]; then
		if command -v dnf >/dev/null; then
			echo "Plataforma Fedora detectada. Instalando pacotes...";
			sudo dnf upgrade -q -y;
			sudo dnf groupinstall -y '@development-tools' '@development-libraries';
			sudo dnf copr enable -y atim/lazygit;
			sudo dnf install -q -y automake curl gcc gcc-c++ git kernel-devel libffi-devel libpq-devel lua make neovim nodejs python3 python3-devel python3-pip readline readline-devel tmux wget zsh ripgrep fd-find lazygit jq stow;
		elif command -v apt >/dev/null; then
			echo "Plataforma Ubuntu/Debian detectada. Instalando pacotes...";
			sudo apt-get update -qq;
			sudo apt-get upgrade -qq -y;
			sudo apt-get install -qq -y build-essential apt-transport-https curl git gnupg2 libffi-dev libpq-dev libreadline-dev lua5.3 neovim python3 python3-dev python3-pip tmux wget zsh stow ripgrep fd-find jq;
			if ! command -v lazygit >/dev/null; then
				echo "Instalando LazyGit manualmente...";
				LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*');
				curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz";
				tar xf /tmp/lazygit.tar.gz -C /tmp lazygit;
				sudo install /tmp/lazygit /usr/local/bin;
				rm -f /tmp/lazygit.tar.gz /tmp/lazygit;
			fi;
		fi;
	else
		echo "Sistema operacional não suportado por esta regra.";
		exit 1;
	fi
	@echo "Instalação dos pacotes base concluída."
	@touch $@ # Cria o arquivo marcador para indicar que a instalação foi feita.

# Configura o Git criando symlinks para os arquivos de configuração.
# A flag -f em ln -sf força a sobreescrita caso os links já existam.
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

