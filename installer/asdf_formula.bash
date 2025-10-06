#!/bin/bash

funcion install_asdf() {
  if command -v asdf >/dev/null 2>&1; then
    echo "ASDF-VM já está instalado."
    return
  fi
  REPO="asdf-vm/asdf"
  INSTALL_DIR="/usr/local/bin"


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
  ls "$INSTALL_DIR/asdf-$LATEST_TAG"
  ln -sf "$INSTALL_DIR/asdf-$LATEST_TAG" "$INSTALL_DIR/asdf"

  # Limpeza
  rm "/tmp/asdf-$LATEST_TAG.tar.gz"

  echo "Instalação do asdf $VERSION concluída."
  echo "Adicione o seguinte ao seu arquivo de configuração do shell (ex: ~/.zshrc ou ~/.bashrc):"
  echo "  . /usr/local/bin/asdf-$LATEST_TAG/asdf.sh"
  echo "  . /usr/local/bin/asdf-$LATEST_TAG/completions/asdf.bash"
}
