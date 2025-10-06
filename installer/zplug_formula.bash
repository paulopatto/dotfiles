function ensure_zplug_installed() {
  # Ensure zplug has been installed
  echo "+----------------------------------------------------------+"
  echo "|           *** 🌸 Instalador do ZPLug  ***                |"
  echo "+----------------------------------------------------------+"

  export XDG_CONFIG_HOME=$HOME/.config

  case $PLATFORM_ARCH in
  Linux)
    if [ ! -d $XDG_CONFIG_HOME/zsh/plugins/zplug ]; then
      downlload_zplug_from_github
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
    echo "❌ Invalid option $PLATFORM_ARCH"
  esac

  if [ ! -d $XDG_CONFIG_HOME/zsh/plugins/zplug/ ]; then
    echo "❌ [ZSH] zplug - Zsh Plugin Manager não está instalado. Por favor, instale zplug de forma manual."
  fi
  creates_zsh_envs_to_zplug
  echo -e "\033[1;32m✔️  [SUCESSO] Zsh Plugin Manager configured \033[0m\n\n"
}

function downlload_zplug_from_github() {
  echo "[ZSH] Install zplug - Zsh Plugin Manager"
  mkdir -p $XDG_CONFIG_HOME/zsh/plugins/
  git clone https://github.com/zplug/zplug $XDG_CONFIG_HOME/zsh/plugins/zplug
}

function creates_zsh_envs_to_zplug() {
  echo "[zplug] Configuring zsh envs for zplug..."

  if [ ! -d $XDG_CONFIG_HOME/zsh/envs ]; then
    mkdir -p $XDG_CONFIG_HOME/zsh/envs
  fi

  echo "export ZPLUG_HOME=$XDG_CONFIG_HOME/zsh/plugins/zplug" > $XDG_CONFIG_HOME/zsh/envs/zplug.env.zsh
  echo "source \$ZPLUG_HOME/init.zsh" >> $XDG_CONFIG_HOME/zsh/envs/zplug.env.zsh
  echo "Arquivos de configuração do zsh para zplug criados com sucesso."
}
