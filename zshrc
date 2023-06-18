# You may need to manually set your language environment
export LANG="pt_BR.UTF-8"
export LOCALE="pt_BR.UTF-8"
export EDITOR='nvim'
export TERM='xterm-256color' # old: 'screen-256color'
export PAGER='less -rS' # By @dlisboa

############################################
########          GIT
############################################
export GITCONFIG=$HOME/.gitconfig
export GITIGNORE=$HOME/.gitignore_global

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git ruby rails pip zsh-syntax-highlighting)

if [ ! -d $HOME/.zplug ]; then
  echo "[ZSH] Install zplug - Zsh Plugin Manager"
  git clone https://github.com/zplug/zplug $HOME/.zplug
fi

if [ -f $HOME/.zplug/init.zsh ]; then 
  source $HOME/.zplug/init.zsh

  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/sudo", from:oh-my-zsh
  zplug "plugins/pip", from:oh-my-zsh
  zplug "plugins/rails", from:oh-my-zsh
  zplug "plugins/ruby", from:oh-my-zsh
  zplug "plugins/asdf", from:oh-my-zsh
  zplug "plugins/command-not-found", from:oh-my-zsh
  zplug "plugins/compleat", from:oh-my-zsh
  zplug "themes/agnoster", from:oh-my-zsh, as:theme
  zplug "zsh-users/zsh-completions"

  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit

  plugins=(git ruby rails pip zsh-syntax-highlighting asdf compleat)

  zplug load
fi

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  echo "[TMUX] Install TMUX Plugin Manager (TPM)"
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  echo "[TMUX] Press [prefix] + [I] (capital i, as in Install) Installs new plugins from GitHub or any other git repository & refresh env."
  echo "[TMUX] Press [prefix] + [U] (capital u, as in Update) updates plugin(s)."
  echo "[TMUX] Visit https://github.com/tmux-plugins/tpm"
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

alias ll="ls -lh"