function ensure_tmux_tpm_installed() {
  export XDG_CONFIG_HOME=$HOME/.config

  echo "+----------------------------------------------------------+"
  echo "|              *** Configuring TMUX  ***                   |"
  echo "+----------------------------------------------------------+"

  if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]; then
    echo "[*] Install TMUX Plugin Manager (TPM)"
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
    echo "+------------------------------------------------------------------------------------------------------------------------------+"
    echo "| Press [prefix] + [I] (capital i, as in Install) Installs new plugins from GitHub or any other git repository & refresh env.  |"
    echo "| Press [prefix] + [U] (capital u, as in Update) updates plugin(s).                                                            |"
    echo "| Visit https://github.com/tmux-plugins/tpm                                                                                    |"
    echo "+------------------------------------------------------------------------------------------------------------------------------+"
  else
    echo "[ ] Install TMUX Plugin Manager (TPM) (SKIPPED)"
  fi

  echo -e "\033[1;32m✔️  [SUCESSO] TMUX configued \033[0m\n\n"
}
