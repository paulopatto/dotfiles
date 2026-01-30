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
