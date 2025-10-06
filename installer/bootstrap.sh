#!/usr/bin/env bash

source ./installer/fedora_packages.bash
source ./installer/debian_packages.bash
source ./installer/brew_packages.bash
source ./installer/lazy_packages.bash
source ./installer/zplug_formula.bash
source ./installer/tmux_formula.bash

export XDG_CONFIG_HOME=$HOME/.config

# Função para criar os diretórios de configuração iniciais.
create_initial_dirs() {
    echo "📁 Criando diretórios de configuração iniciais..."
    mkdir -p "${HOME}/.local/bin"
    mkdir -p "${HOME}/.config/"
}

# Função principal que orquestra o bootstrap.
main() {
  echo "Bootstrapping system dependencies..."
  echo "🔍  Verificando e instalando pacotes base..."
  if [[ "$(uname -s)" == "Darwin" ]]; then
    PLATFORM_OS="MacOS"
    PLATFORM_ARCH="Darwin"
  elif [[ "$(uname -s)" == "Linux" ]]; then
    PLATFORM_ARCH="Linux"
    if command -v dnf >/dev/null; then
      PLATFORM_OS="Fedora"
    elif command -v apt >/dev/null; then
      PLATFORM_OS="Ubuntu"
    else
      echo "☠️ Distribuição Linux não suportada (nem dnf, nem apt encontrados)."
      exit 1
    fi
  else
    echo "☠️ Sistema operacional não suportado por este script."
    exit 1
  fi
  echo "🖥️  Sistema detectado: $PLATFORM_OS ($PLATFORM_ARCH)"
  install_os_packages
  create_initial_dirs
  echo "🏆 Instalação dos pacotes base concluída."

  change_shell_to_zsh
  ensure_zplug_installed
  ensure_tmux_tpm_installed
  echo "🎉 Bootstrap concluído com sucesso!"
}

function install_os_packages() {
  case $PLATFORM_OS in
    Fedora)
      install_fedora_packages
      ;;
    Ubuntu)
      install_debian_packages
      ;;
    MacOS)
      install_macos_packages
      ;;
    *)
      echo "Invalid option $PLATFORM_ARCH"
  esac
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


# Este bloco permite que o script seja executado diretamente.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main
fi
