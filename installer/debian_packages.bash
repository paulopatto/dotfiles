source ./installer/lazy_packages.bash

# Função para instalar pacotes no Debian/Ubuntu.
install_debian_packages() {
  echo "🌀 Plataforma Ubuntu/Debian detectada."
  echo "📦 Instalando pacotes..."
  sudo apt-get update -qq
  sudo apt-get install -y build-essential apt-transport-https curl coreutils git gnupg2 libffi-dev libpq-dev libreadline-dev lua5.3 python3 python3-dev python3-pip tmux wget xclip neovim stow zsh stow ripgrep fd-find jq tmux
  if ! command -v lazygit >/dev/null; then
    install_lazygit_from_source
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
