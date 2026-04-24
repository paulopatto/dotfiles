## ENVIRONMENTS

## Detectar o sistema operacional
case "$(uname -s)" in
  Linux*)
    OS="Linux"
    ;;
  Darwin*)
    OS="Darwin"
    ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*)
    OS="Windows"
    ;;
  *)
    OS="Unknown"
    ;;
esac

############################################
########          SHELL
############################################
export XDG_CONFIG_HOME=$HOME/.config
export LANG="pt_BR.UTF-8"
export LOCALE="pt_BR.UTF-8"
export EDITOR='nvim'
export TERM='xterm-256color' # old: 'screen-256color'
export PAGER='less -rS'      # By @dlisboa
export DOTFILES_HOME="$HOME/Code/dotfiles"
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin


############################################
########          GIT
############################################
export GIT_HOME=$XDG_CONFIG_HOME/git
export GITCONFIG=$GIT_HOME/.gitconfig
export GITIGNORE=$GIT_HOME/.gitignore_global


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="catppuccin"   # [ robbyrussell | agnoster | sorin | catppuccin ]
export CATPPUCCIN_FLAVOR="macchiato"
export CATPPUCCIN_SHOW_TIME=true
export CATPPUCCIN_SHOW_HOSTNAME="never"
export CATPPUCCIN_SHOW_USER="always"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
export HIST_STAMPS="yyyy-mm-dd"
export HISTFILE=~/.local/share/zsh/zsh_history
# HISTSIZE=100000
# SAVEHIST=100000
[ ! -d $HOME/.local/share/zsh/ ] && mkdir -p $HOME/.local/share/zsh/
[ ! -f $HISTFILE ] &&  touch $HISTFILE

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

########################
## Define os-platorm
########################
export PLATFORM_ARCH="$(uname -s)" # Linux | Darwin | ...
export MACHINE_ARCH="$(uname -p)" # arm | AMD_64 | x86-64

start_time=`date +%s`

# case $PLATFORM_ARCH in
#   Linux)
#     if command -v dnf > /dev/null; then
#       export PLATFORM_OS="Fedora";
#     elif command -v apt > /dev/null; then
#       export PLATFORM_OS="Ubuntu";
#     else
#       echo "Unsupported linux distro $(uname -a)"
#     fi
#     ;;
#   Darwin)
#     export PLATFORM_OS="MacOS";
#     ;;
#   *)
#     echo "Invalid option $PLATFORM_ARCH"
# esac


if [ -x tmuxifier ]; then
  eval "$(tmuxifier init -)"
fi

[ -d $XDG_CONFIG_HOME/tmux/plugins/tpm/bin ] && export PATH=$PATH:$XDG_CONFIG_HOME/tmux/plugins/tpm/bin



# Carregar arquivos .conf.zsh da pasta $HOME/.config/zsh/etc
export ZSH_CONF_DIR=$XDG_CONFIG_HOME/zsh/etc
if [ -d "$ZSH_CONF_DIR" ]; then
  for config_file in $ZSH_CONF_DIR/*.conf.zsh(N); do
    source "$config_file"
  done
fi

# Carregar arquivos .env.zsh da pasta $HOME/.config/zsh/envs
if [ -d "$HOME/.config/zsh/envs" ]; then
  for env_file in $HOME/.config/zsh/envs/*.env.zsh(N); do
    source "$env_file"
  done
fi

