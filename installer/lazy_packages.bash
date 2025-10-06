function install_lazygit_from_source() {
  echo "+----------------------------------------------------------+"
  echo "|           🐙 Instalando LazyGit dos fontes...            |"
  echo "|           https://github.com/jesseduffield/lazygit       |"
  echo "+----------------------------------------------------------+"

  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/

  echo "🧹 Cleaning up..." && rm -rf lazygit.tar.gz

  if command -v lazygit >/dev/null; then
    echo "✔️  LazyGit instalado com sucesso."
    lazygit --version
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
