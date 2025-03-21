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
########          ASDF-VM
############################################
export ASDF_HOME=$XDG_CONFIG_HOME/asdf
export ASDF_DIR=$ASDF_HOME

############################################
########          GIT
############################################
export GITCONFIG=$HOME/.gitconfig
export GITIGNORE=$HOME/.gitignore_global

############################################
########          ALIASES
############################################
alias l='ls --color=auto'
alias la='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias grep='grep --color=auto'
alias python=python3
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"   # [ robbyrussell | agnoster | sorin]

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
DISABLE_AUTO_TITLE="true"

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
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

########################
## Define os-platorm
########################
export PLATFORM_ARCH="$(uname -s)" # Linux | Darwin | ...
export MACHINE_ARCH="$(uname -p)" # arm | AMD_64 | x86-64 

start_time=`date +%s`

case $PLATFORM_ARCH in 
  Linux)
    if command -v dnf > /dev/null; then
      export PLATFORM_OS="Fedora";
    elif command -v apt > /dev/null; then
      export PLATFORM_OS="Ubuntu";
    else
      echo "Unsupported linux distro $(uname -a)"
    fi
    ;;
  Darwin)
    export PLATFORM_OS="MacOS";
    ;;
  *)
    echo "Invalid option $PLATFORM_ARCH"
esac

export ZPLUG_HOME=$XDG_CONFIG_HOME/zsh/plugins/zplug
if [ -f $ZPLUG_HOME/init.zsh ]; then 
  source $ZPLUG_HOME/init.zsh

  # General ZSH Plugins
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting",      from:github
  zplug "zsh-users/zsh-history-substring-search", from:github, defer:2
  zplug "djui/alias-tips",                        from:github
  #zplug "plugins/asdf",                           from:oh-my-zsh
  zplug "plugins/command-not-found",              from:oh-my-zsh
  zplug "plugins/compleat",                       from:oh-my-zsh

  # SSH
  zplug "hkupty/ssh-agent",                       from:github

  # Git Plugins
  zplug "plugins/git",                            from:oh-my-zsh, if:"which git"
  zplug "Seinh/git-prune",                        from:github

  # NodeJS
  zplug "lukechilds/zsh-nvm",                     from:github
  zplug "lukechilds/zsh-better-npm-completion",   from:github

  # Directory Navigation
  zplug "supercrabtree/k",                        from:github
  zplug "b4b4r07/enhancd",                        use:init.sh
  zplug "mollifier/anyframe"

  # OSX Platform
  zplug "lib/clipboard",                          from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/osx",                            from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

  
  # Theme
  zplug "themes/agnoster",                        from:oh-my-zsh, as:theme
  zplug "themes/robbyrussell",                    from:oh-my-zsh, as:theme

  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/* or $ZSH/plugins)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  # plugins=(git ruby rails pip zsh-syntax-highlighting)
  plugins=(git asdf compleat)

  zplug load
  # Em caso de erro de plugins não encontrados pode chamar um zplug install
  source $ZPLUG_HOME/repos/$ZSH_THEME/oh-my-zsh/oh-my-zsh.sh
fi

if [ -x tmuxifier ]; then
  eval "$(tmuxifier init -)"
fi

# Configs to ASDF-VM:
if [ -d $ASDF_HOME/completions/ ]; then
  # append completions to fpath
  fpath=($ASDF_HOME/completions $fpath)

  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
  [ -f $ASDF_HOME/completions/asdf.bash ] && source $ASDF_HOME/completions/asdf.bash
fi

[ -f $ASDF_HOME/asdf.sh ] && source $ASDF_HOME/asdf.sh
[ -f $ASDF_HOME/plugins/golang/set-env.zsh ] && source $ASDF_HOME/plugins/golang/set-env.zsh
[ -f $ASDF_HOME/plugins/java/set-java-home.zsh ] && source $ASDF_HOME/plugins/java/set-java-home.zsh
[ -d $XDG_CONFIG_HOME/tmux/plugins/tpm/bin ] && export PATH=$PATH:$XDG_CONFIG_HOME/tmux/plugins/tpm/bin

# Configs to Android commandline
if [ -d $HOME/.local/share/Android ]; then
  export ANDROID_HOME=$HOME/.local/share/Android
  export ANDROID_SDK_ROOT=$ANDROID_HOME
  export ANDROID_SDK_HOME=$ANDROID_HOME
  [ -d $ANDROID_HOME/cmdline-tools ] &&  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  [ -d $ANDROID_HOME/platform-tools ] &&  export PATH=$PATH:$ANDROID_HOME/platform-tools/
  [ -d $ANDROID_HOME/emulator ] &&  export PATH=$PATH:$ANDROID_HOME/emulator/
fi


# Carregar arquivos .env.zsh da pasta $HOME/.config/zsh/envs
if [ -d "$HOME/.config/zsh/envs" ]; then
  for env_file in $HOME/.config/zsh/envs/*.env.zsh; do
    if [ -f "$env_file" ]; then
      source "$env_file"
    fi
  done
fi

## Configs to gcloud
# Using asdf-gcloud
# 1. Install plugin
#   asdf plugin add gcloud https://github.com/jthegedus/asdf-gcloud
# 2. Install install gcloud installed
#   asdf install gcloud latest
# 3. Set global version
#   asdf global gcloud latest
