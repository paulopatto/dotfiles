# vim: filetype=sh
# Definição de aliases para o shell zsh

############################################
########          ALIASES
############################################
alias l='ls --color=auto'
alias la='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias grep='grep --color=auto'
alias python=python3
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

if which tree >/dev/null 2>&1; then
    alias lt='tree -I .gitignore'
fi
