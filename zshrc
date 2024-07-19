## ENVIRONMENTS
export XDG_CONFIG_HOME=$HOME/.config
export LANG="pt_BR.UTF-8"
export LOCALE="pt_BR.UTF-8"
export EDITOR='nvim'
export TERM='xterm-256color' # old: 'screen-256color'
export PAGER='less -rS'      # By @dlisboa
export DOTFILES_HOME="$HOME/Code/dotfiles"
export PATH=$PATH:$HOME/.local/bin

if [ ! -d $HOME/.local/bin ]; then
  mkdir -p $HOME/.local/bin
fi

############################################
########          GIT
############################################
export GITCONFIG=$HOME/.gitconfig
export GITIGNORE=$HOME/.gitignore_global

if [ ! -L $HOME/.gitconfig ]; then  
  ln -s $DOTFILES_HOME/gitconfig $HOME/.gitconfig
fi


if [ ! -L $HOME/.gitignore_global ]; then 
  ln -s $DOTFILES_HOME/gitignore_global $HOME/.gitignore_global
fi

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

case $PLATFORM_ARCH in 
  Linux)
    if [ -x dnf ]; then
      export PLATFORM_OS="Fedora";
    elif [ -x apt ]; then
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

# Ensure ripgrep has been installed
# TODO: Creates a function to checks and install
#       ripgrep in diferents systems: macOS | fedora | ubuntu

# Ensure zplug has been installed
if [ ! -d $XDG_CONFIG_HOME/zsh/plugins/zplug ]; then
  echo "[ZSH] Install zplug - Zsh Plugin Manager"
  git clone https://github.com/zplug/zplug $XDG_CONFIG_HOME/zsh/plugins/zplug
  echo "[ZSH] Zplugin installed, can you run: zplug install" 
  zplug install
fi
export ZPLUG_HOME=$XDG_CONFIG_HOME/zsh/plugins/zplug

if [ -f $ZPLUG_HOME/init.zsh ]; then 
  source $ZPLUG_HOME/init.zsh

  zplug "lib/clipboard",             from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/asdf",              from:oh-my-zsh
  zplug "plugins/command-not-found", from:oh-my-zsh
  zplug "plugins/compleat",          from:oh-my-zsh
  zplug "plugins/git",               from:oh-my-zsh, if:"which git"
  zplug "plugins/osx",               from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/pip",               from:oh-my-zsh
  zplug "plugins/rails",             from:oh-my-zsh
  zplug "plugins/ruby",              from:oh-my-zsh
  zplug "plugins/sudo",              from:oh-my-zsh
  zplug "themes/agnoster",           from:oh-my-zsh, as:theme
  zplug "themes/robbyrussell",       from:oh-my-zsh, as:theme
  zplug "zsh-users/zsh-completions"

  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/* or $ZSH/plugins)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  # plugins=(git ruby rails pip zsh-syntax-highlighting)
  plugins=(git ruby rails pip asdf compleat)

  zplug load
  source $ZPLUG_HOME/repos/$ZSH_THEME/oh-my-zsh/oh-my-zsh.sh
fi

if ! command -v tmux &> /dev/null 
then 
  echo "[TMUX] Install tmux for $PLATFORM_OS"

  if [ $PLATFORM_OS = "Fedora" ]; then
    sudo dnf install -y tmux
  elif [ $PLATFORM_OS = "Ubuntu" ]; then
    sudo apt install -y tmux
  elif [ $PLATFORM_OS = "MacOS" ]; then
    brew install tmux
  else
    echo "Unsupported platorm"
  fi
fi

if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]; then
  echo "[TMUX] Install TMUX Plugin Manager (TPM)"
  git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
  echo "[TMUX] Press [prefix] + [I] (capital i, as in Install) Installs new plugins from GitHub or any other git repository & refresh env."
  echo "[TMUX] Press [prefix] + [U] (capital u, as in Update) updates plugin(s)."
  echo "[TMUX] Visit https://github.com/tmux-plugins/tpm"
fi
PATH=$PATH:$XDG_CONFIG_HOME/tmux/plugins/tpm/bin

if [ ! -L $XDG_CONFIG_HOME/tmux/tmux.conf ]; then
  ln -s $DOTFILES_HOME/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
fi

if [ -x tmuxifier ]; then
  eval "$(tmuxifier init -)"
fi

# Configs to ASDF-VM:
if [ -d $HOME/.asdf/completions/ ]; then
  # append completions to fpath
  fpath=($HOME/.asdf/completions $fpath)

  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi
[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh
[ -f $HOME/.asdf/completions/asdf.bash ] && source $HOME/.asdf/completions/asdf.bash

if [ -d $HOME/.android/ ]; then
  export ANDROID_HOME=$HOME/.android
  export ANDROID_SDK_ROOT=$ANDROID_HOME

  [ -d $HOME/.android/cmdline-tools ] &&  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  [ -d $HOME/.android/platform-tools ] &&  export PATH=$PATH:$ANDROID_HOME/platform-tools/
  [ -d $HOME/.android/emulator ] &&  export PATH=$PATH:$ANDROID_HOME/emulator/
fi

if [ ! -L $HOME/.default-gems ]; then
  ln -s $DOTFILES_HOME/defaul-gems $HOME/.default-gems
fi

if [ ! -L $HOME/.default-npm-packages ]; then
  ln -s $DOTFILES_HOME/default-npm-packages $HOME/.default-npm-packages
fi

if [ ! -L $HOME/.default-python-packages ]; then
  ln -s $DOTFILES_HOME/default-python-packages $HOME/.default-python-packages
fi

# Aliases
alias l='ls --color=auto'
alias la='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias grep='grep --color=auto'
alias python=python3
alias ipy="python -c 'import IPython;
IPython.terminal.ipapp.launch_new_instance()'"

## Configs to gcloud
#FIXME: Move it to be managed by asdf-vm
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google/cloud-sdk/path.zsh.inc' ]; then . '/opt/google/cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google/cloud-sdk/completion.zsh.inc' ]; then . '/opt/google/cloud-sdk/completion.zsh.inc'; fi
