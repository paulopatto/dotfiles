# -----------------------------------------------------------------------------
# Instala o 1Password em sistemas Linux seguindo o passo a passo
# oficial da 1Password.
#
# Referência:
#   Documentação oficial: https://1password.com/downloads/linux
# -----------------------------------------------------------------------------
function install_1password() {

  echo "+----------------------------------------------------------+"
  echo "|        *** 🗝️ Instalador do 1Password  ***               |"
  echo "+----------------------------------------------------------+"

  if [ -f /opt/1Password/op-ssh-sign ]; then
    echo "✔️  1Password já instalado."
    return
  fi

  case $PLATFORM_OS in
    Fedora)
      install_1password_fedora
      ;;
    Ubuntu)
      install_1password_debian_or_ubuntu
      ;;
    MacOS)
      echo "1Password no MacOS deve ser instalado via Homebrew ou manualmente."
      ;;
    *)
      echo "Invalid option $PLATFORM_ARCH"
  esac

  if [ $? -eq 0 ]; then
    echo "✔️  1Password instalado com sucesso."
  else
    echo "☠️ Falha ao instalar o 1Password."
    exit 1
  fi
}


# -----------------------------------------------------------------------------
# install_1password_debian_or_ubuntu
#
# Instala o 1Password em sistemas Debian ou Ubuntu seguindo o passo a passo
# oficial da 1Password.
#
# Passos realizados por esta função:
#   1. Adiciona o repositório oficial da 1Password.
#   2. Importa a chave GPG do repositório.
#   3. Atualiza a lista de pacotes.
#   4. Instala o pacote 1password.
#
# Requisitos:
#   - Permissões de superusuário (sudo).
#   - Conexão com a internet.
#
# Limitações e melhorias:
#   - Atualmente, esta função só da suporte a plataformas x86_64 (amd64).
#
# Referência:
#   Documentação oficial: https://support.1password.com/install-linux/#debian-or-ubuntu
# -----------------------------------------------------------------------------
function install_1password_debian_or_ubuntu() {
  _add_key_for_the_1Password_apt_repository_and_add_apt_repo
  sudo apt-get update -qq
  sudo apt-get install -y 1password
}

function _add_key_for_the_1Password_apt_repository_and_add_apt_repo() {
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
}

# -----------------------------------------------------------------------------
# install_1password_fedora
#
# Instala o 1Password em sistemas Fedora seguindo o passo a passo
# oficial da 1Password.
#
# Passos realizados por esta função:
#   1. Adiciona o repositório oficial da 1Password.
#   2. Importa a chave GPG do repositório.
#   3. Atualiza a lista de pacotes.
#   4. Instala o pacote 1password.
#
# Requisitos:
#   - Permissões de superusuário (sudo).
#   - Conexão com a internet.
#
#
# Referência:
#   Documentação oficial: https://support.1password.com/install-linux/#fedora-or-red-hat-enterprise-linux
# -----------------------------------------------------------------------------
function install_1password_fedora() {
  _add_key_for_the_1Password_yum_repository
  sudo dnf install -y 1password
}

function _add_key_for_the_1Password_yum_repository() {
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
}
