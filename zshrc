# You may need to manually set your language environment
export XDG_CONFIG_HOME=$HOME/.config
export LANG="pt_BR.UTF-8"
export LOCALE="pt_BR.UTF-8"
export EDITOR='nvim'
export TERM='xterm-256color' # old: 'screen-256color'
export PAGER='less -rS'      # By @dlisboa

############################################
########          GIT
############################################
export GITCONFIG=$HOME/.gitconfig
export GITIGNORE=$HOME/.gitignore_global

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



# Ensure zplug has been installed
if [ ! -d $XDG_CONFIG_HOME/zsh/plugins/zplug ]; then
  echo "[ZSH] Install zplug - Zsh Plugin Manager"
  git clone https://github.com/zplug/zplug $XDG_CONFIG_HOME/zsh/plugins/zplug
  echo "[ZSH] Zplugin installed, can you run: zplug install" 
  zplug install
fi


if [ -f $XDG_CONFIG_HOME/zsh/plugins/zplug/init.zsh ]; then 
  export ZPLUG_HOME=$XDG_CONFIG_HOME/zsh/plugins/zplug
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

if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]; then
  echo "[TMUX] Install TMUX Plugin Manager (TPM)"
  git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
  echo "[TMUX] Press [prefix] + [I] (capital i, as in Install) Installs new plugins from GitHub or any other git repository & refresh env."
  echo "[TMUX] Press [prefix] + [U] (capital u, as in Update) updates plugin(s)."
  echo "[TMUX] Visit https://github.com/tmux-plugins/tpm"
fi
PATH=$PATH:$XDG_CONFIG_HOME/tmux/plugins/tmuxifier/bin
eval "$(tmuxifier init -)"

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

alias ll="ls -lh"
alias python=python3
alias ipy="python -c 'import IPython;
IPython.terminal.ipapp.launch_new_instance()'"

## Configs to gcloud
#FIXME: Move it to be managed by asdf-vm
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google/cloud-sdk/path.zsh.inc' ]; then . '/opt/google/cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google/cloud-sdk/completion.zsh.inc' ]; then . '/opt/google/cloud-sdk/completion.zsh.inc'; fi
