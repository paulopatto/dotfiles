# vim: filetype=sh
# Configurações do asdf (gerenciador de versões)

############################################
########          ASDF-VM
############################################

is_asdf_installed() {
  command -v asdf &>/dev/null
}

if is_asdf_installed; then
  export ASDF_HOME=$XDG_CONFIG_HOME/asdf
  export ASDF_CONFIG_FILE=$ASDF_HOME/.asdfrc
  export ASDF_DATA_DIR=$HOME/.local/share/asdf

  # Ensure ASDF_DATA_DIR
  if [ ! -d "$ASDF_DATA_DIR" ]; then
    mkdir -p "$ASDF_DATA_DIR"
  fi

  # Ensure ASDF_CONFIG_FILE
  if [ ! -f "$ASDF_CONFIG_FILE" ]; then
    touch "$ASDF_CONFIG_FILE"
  fi

  export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
  export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-npm-packages"
  export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-python-packages"
  export ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-gem-packages"
  export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-golang-packages"

  [ -f "$ASDF_HOME/asdf.sh" ] && source "$ASDF_HOME/asdf.sh"
  [ -f "$ASDF_DATA_DIR/plugins/golang/set-env.zsh" ] && source "$ASDF_DATA_DIR/plugins/golang/set-env.zsh"
  [ -f "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh" ] && source "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"

  export PATH="$ASDF_DATA_DIR/shims:$PATH"

  # Configs to ASDF-VM:
  if [ -d "$ASDF_HOME/completions/" ]; then
    # append completions to fpath
    fpath=("$ASDF_HOME/completions" $fpath)

    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
    [ -f "$ASDF_HOME/completions/asdf.bash" ] && source "$ASDF_HOME/completions/asdf.bash"
  fi
fi
