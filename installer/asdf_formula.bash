#!/bin/bash

function install_asdf() {

  echo "+----------------------------------------------------------+"
  echo "|           *** 🧩 Instalador do ASDF  ***                 |"
  echo "+----------------------------------------------------------+"

  if command -v asdf >/dev/null 2>&1; then
    echo "ASDF-VM já está instalado."
    return
  fi
  REPO="asdf-vm/asdf"
  INSTALL_DIR="/usr/local/bin"

  export ASDF_DIR="$HOME/.local/share/asdf"
  mkdir -p "$ASDF_DIR"


  # Obtém a última versão do release via GitHub API
  LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')
  VERSION="${LATEST_TAG#v}"  # Remove o 'v' inicial, se presente
  ARCHIVE_URL="https://github.com/$REPO/archive/refs/tags/$LATEST_TAG.tar.gz"

  echo "Baixando $ARCHIVE_URL..."
  curl -L "$ARCHIVE_URL" -o "/tmp/asdf-$LATEST_TAG.tar.gz"

  # Extrai para /usr/local/bin
  echo "Extraindo para $INSTALL_DIR..."
  sudo tar -xzf "/tmp/asdf-$LATEST_TAG.tar.gz" -C "$INSTALL_DIR"

  # Opcional: mostra conteúdo extraído
  echo "Conteúdo extraído:"
  ln -sf "$INSTALL_DIR/asdf-$VERSION" "$INSTALL_DIR/asdf"
  ls -lah "$INSTALL_DIR/" | grep asdf
  asdf --version

  # Limpeza
  rm "/tmp/asdf-$LATEST_TAG.tar.gz"

  echo "Instalação do asdf $VERSION concluída."
  echo "Adicione o seguinte ao seu arquivo de configuração do shell (ex: ~/.zshrc ou ~/.bashrc):"
  echo "  . /usr/local/bin/asdf-$LATEST_TAG/asdf.sh"
  echo "  . /usr/local/bin/asdf-$LATEST_TAG/completions/asdf.bash"
}
