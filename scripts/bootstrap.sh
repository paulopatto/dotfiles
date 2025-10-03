#!/usr/bin/env bash

export XDG_CONFIG_HOME=$HOME/.config

# Função para criar os diretórios de configuração iniciais.
create_initial_dirs() {
    echo "📁 Criando diretórios de configuração iniciais..."
    mkdir -p "${HOME}/.local/bin"
    mkdir -p "${HOME}/.config/zsh/envs"
}

# Função para instalar pacotes no macOS.
install_macos_packages() {
  echo " Plataforma MacOS detectada."
  if ! command -v brew >/dev/null 2>&1; then
      echo "Instalando Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
      echo "Homebrew já instalado."
  fi

  echo "⚠️ Para manter compatibilidade entre Mac e Linux e vez de usar o pbcopy, use o xclip"
  echo "alias pbcopy='xclip -selection clipboard -i' >> ~/.zshrc"
  echo "alias pbpaste='xclip -selection clipboard -o' >> ~/.zshrc"

  echo "📦 Instalando pacotes via Brew..."
  brew bundle --file=- <<EOF
  brew "git"
  brew "zsh"
  brew "tmux"
  brew "neovim"
  brew "asdf"
  cask "1password"
  brew "ripgrep"
  brew "fd"
  brew "lazygit"
  brew "jq"
  brew "stow"
  brew "lazygit"
  brew "lazydocker"
  brew "xclip"
  brew "editorconfig-checker"
  brew "zplug"
EOF
}

# Função para instalar pacotes no Fedora.
install_fedora_packages() {
    echo "🐧 Plataforma Fedora detectada. "
    echo "📦 Instalando pacotes..."
    sudo dnf upgrade -q -y
    sudo dnf copr enable -y atim/lazygit
    sudo dnf copr enable -y atim/lazydocker
    sudo dnf groupinstall -y '@development-tools' '@development-libraries'
    sudo dnf install -q -y util-linux-user
    sudo dnf install -q -y  git kernel-devel libffi-devel libpq-devel editorconfig-checker lua make nodejs python3 python3-devel python3-pip readline readline-devel tmux wget  xclip
    sudo dnf install -y ripgrep zsh  fd-find lazygit lazydocker jq stow neovim tmux

    if command -v fd >/dev/null; then
      echo "✔️  fd já instalado"
    else
      sudo dnf install -y fd-find
      echo "Criando link simbólico para fd-find como fd (hack)"
      #sudo ln -s $(which fdfind) /usr/local/bin/fd
      fd --version
    fi

    if command -v stow >/dev/null; then
      echo "✔️  Stow já instalado"
    else
      echo "😢 Stow não instalado."
      echo "Instalando Stow isoladamente..."
      sudo dnf install -y stow
      stow --version
      echo "✔️  Stow instalado com sucesso."
    fi

    if command -v jq >/dev/null; then
      echo "✔️  jq já instalado"
    else
      echo "😢 jq não instalado."
      echo "Instalando jq isoladamente..."
      sudo dnf install -y jq
      jq --version
      echo "✔️  jq instalado com sucesso."
    fi

    if command -v zsh >/dev/null; then
      echo "✔️  zsh já instalado"
    else
      echo "😢 zsh não instalado."
      echo "Instalando zsh isoladamente..."
      sudo dnf install -y zsh
      zsh --version
      echo "✔️  zsh instalado com sucesso."
    fi


}

function install_lazydocker_from_source() {
  echo "+----------------------------------------------------------+"
  echo "|           🐙 Instalando LazyGit dos fontes...            |"
  echo "|           https://github.com/jesseduffield/lazygit       |"
  echo "+----------------------------------------------------------+"

  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"].*')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin
  rm -f /tmp/lazygit.tar.gz /tmp/lazygit

  if command -v lazygit >/dev/null; then
    echo "✔️  LazyGit instalado com sucesso."
  else
    echo "😢 Falha ao instalar o LazyGit."
  fi
}

function install_lazydocker_from_source() {
  echo "+----------------------------------------------------------+"
  echo "|           🐳 Instalando LazyDocker dos fontes...         |"
  echo "|           https://github.com/jesseduffield/lazydocker    |"
  echo "+----------------------------------------------------------+"

  curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest |
    grep browser_download_url |
    grep Linux_x86_64 |
    cut -d '"' -f 4 |
    wget -qi -
  tar xf lazydocker_*_Linux_x86_64.tar.gz lazydocker
  sudo install lazydocker /usr/local/bin
  rm -f lazydocker_*_Linux_x86_64.tar.gz lazydocker
  if command -v lazydocker >/dev/null; then
    echo "✔️  LazyDocker instalado com sucesso."
  else
    echo "😢 Falha ao instalar o LazyDocker."
  fi
}

# Função para instalar pacotes no Debian/Ubuntu.
install_debian_packages() {
  echo "🌀 Plataforma Ubuntu/Debian detectada."
  echo "📦 Instalando pacotes..."
  sudo apt-get update -qq
  sudo apt-get install -qq -y build-essential apt-transport-https curl git gnupg2 libffi-dev libpq-dev libreadline-dev editorconfig-checker lua5.3 python3 python3-dev python3-pip tmux wget xclip
  sudo apt-get install -y neovim stow zsh stow ripgrep fd-find jq tmux
  if ! command -v lazygit >/dev/null; then
    install_lazydocker_from_source
  fi

  if ! command -v lazydocker >/dev/null; then
    install_lazydocker_from_source
  fi

  if ! command -v fd >/dev/null; then
    sudo apt install -y fd-find
    echo "Criando link simbólico para fd-find como fd (hack)"
    sudo ln -s $(which fdfind) /usr/local/bin/fd
  fi

  if command -v stow >/dev/null; then
    echo "✔️  Stow já instalado"
  else
    echo "☠️ Stow não instalado e já deveria estar disponível"
    echo "Tentando instalar novamente Stow..."
    sudo apt-get install -y stow
    stow --version
  fi
}

# Função principal que orquestra o bootstrap.
run_bootstrap() {
    echo "Bootstrapping system dependencies..."

    create_initial_dirs

    echo "🔍  Verificando e instalando pacotes base..."
    if [[ "$(uname -s)" == "Darwin" ]]; then
        install_macos_packages
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if command -v dnf >/dev/null; then
            install_fedora_packages
        elif command -v apt >/dev/null; then
            install_debian_packages
        else
            echo "☠️ Distribuição Linux não suportada (nem dnf, nem apt encontrados)."
            exit 1
        fi
    else
        echo "☠️ Sistema operacional não suportado por este script."
        exit 1
    fi
    echo "🏆 Instalação dos pacotes base concluída."
    change_shell_to_zsh
    ensure_zplug_installed
    ensure_tmux_tpm_installed
    echo "🎉 Bootstrap concluído com sucesso!"
}

function change_shell_to_zsh() {
  if command -v zsh >/dev/null 2>&1; then
    echo "✔️  Zsh já instalado."
    if [ "$SHELL" != "$(which zsh)" ]; then
      echo "🔄 Alterando shell padrão para zsh..."
      chsh -s "$(which zsh)"
      echo "✔️  Shell padrão alterado para zsh. Por favor, reinicie o terminal."
    else
      echo "✔️  Shell padrão já é zsh."
    fi
  else
    echo "☠️ Zsh não está instalado. Por favor, instale o zsh e execute este script novamente."
    exit 1
  fi
}

function ensure_zplug_installed() {
  # Ensure zplug has been installed
  echo "+----------------------------------------------------------+"
  echo "|           *** Ensure zplug instaleld  ***                |"
  echo "+----------------------------------------------------------+"

  case $PLATFORM_ARCH in
    Linux)
      if [ ! -d $XDG_CONFIG_HOME/zsh/plugins/zplug ]; then
        echo "[ZSH] Install zplug - Zsh Plugin Manager"
        git clone https://github.com/zplug/zplug $XDG_CONFIG_HOME/zsh/plugins/zplug
        echo "[ZSH] Zplugin installed, can you run: zplug install"
        zplug install
      else
        echo "[ZSH] zplug - Zsh Plugin Manager Alrady configured run '$ zplug install'"
        echo -e "\033[1;32m✔️  [SUCESSO] Zsh Plugin Manager Alrady configured run '$ zplug install' \033[0m\n\n"
      fi
      ;;
    Darwin)
      echo "[ZSH] On MacOS zplug should be installed via brew, skipping..."
      echo "[ZSH] After install run '$ zplug install'"
      ;;
    *)
      echo "Invalid option $PLATFORM_ARCH"
  esac
  echo -e "\033[1;32m✔️  [SUCESSO] Zsh Plugin Manager configured \033[0m\n\n"

}

function ensure_tmux_tpm_installed() {
  echo "+----------------------------------------------------------+"
  echo "|              *** Configuring TMUX  ***                   |"
  echo "+----------------------------------------------------------+"

  if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]; then
    echo "[*] Install TMUX Plugin Manager (TPM)"
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
    echo "+------------------------------------------------------------------------------------------------------------------------------+"
    echo "| Press [prefix] + [I] (capital i, as in Install) Installs new plugins from GitHub or any other git repository & refresh env.  |"
    echo "| Press [prefix] + [U] (capital u, as in Update) updates plugin(s).                                                            |"
    echo "| Visit https://github.com/tmux-plugins/tpm                                                                                    |"
    echo "+------------------------------------------------------------------------------------------------------------------------------+"
  else
    echo "[ ] Install TMUX Plugin Manager (TPM) (SKIPPED)"
  fi

  echo -e "\033[1;32m✔️  [SUCESSO] TMUX configued \033[0m\n\n"
}

# Este bloco permite que o script seja executado diretamente.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    run_bootstrap
fi
