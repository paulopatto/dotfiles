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
    sudo dnf install -q -y ripgrep zsh  fd-find lazygit lazydocker jq stow neovim tmux

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
