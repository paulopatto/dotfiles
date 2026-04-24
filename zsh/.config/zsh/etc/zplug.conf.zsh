# vim: filetype=sh
# Configuração de plugins zsh usando zplug

export ZPLUG_HOME=$XDG_CONFIG_HOME/zsh/plugins/zplug

if [ -f $ZPLUG_HOME/init.zsh ]; then
    source $ZPLUG_HOME/init.zsh
    # zplug check --verbose
    # 1. Carrega a biblioteca base do Oh My Zsh (essencial para plugins e temas)
    zplug "lib/history", from:oh-my-zsh
    zplug "lib/theme-and-appearance", from:oh-my-zsh
    zplug "lib/completion", from:oh-my-zsh # Opcional, mas recomendado
    zplug "robbyrussell/oh-my-zsh", from:oh-my-zsh, use:"lib/*.zsh"

    # General ZSH Plugins
    zplug "plugins/asdf", from:oh-my-zsh
    zplug "plugins/command-not-found", from:oh-my-zsh
    zplug "plugins/compleat", from:oh-my-zsh
    zplug "lib/functions", from:oh-my-zsh
    zplug "lib/async_prompt", from:oh-my-zsh
    zplug "ohmyzsh/ohmyzsh", use:lib/async_prompt.zsh
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-syntax-highlighting", from:github
    zplug "zsh-users/zsh-history-substring-search", from:github, defer:2
    zplug "catppuccin/zsh-syntax-highlighting", defer:2
    zplug "djui/alias-tips", from:github
    zplug "plugins/asdf", from:oh-my-zsh
    zplug "plugins/command-not-found", from:oh-my-zsh
    zplug "plugins/compleat", from:oh-my-zsh
    zplug "plugins/sudo", from:oh-my-zsh

    # SSH
    zplug "hkupty/ssh-agent", from:github

    # Git Plugins
    zplug "plugins/git", from:oh-my-zsh, if:"which git"
    zplug "Seinh/git-prune", from:github

    # NodeJS
    zplug "lukechilds/zsh-nvm", from:github
    zplug "lukechilds/zsh-better-npm-completion", from:github

    # Directory Navigation
    zplug "supercrabtree/k", from:github
    zplug "b4b4r07/enhancd", use:init.sh
    zplug "mollifier/anyframe"

    # OSX Platform
    zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
    zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

    # Theme
    zplug "romkatv/powerlevel10k", as:theme
    zplug "themes/robbyrussell", from:oh-my-zsh, as:theme
    zplug "dracula/zsh", as:theme
    zplug "JannoTjarks/catppuccin-zsh", use:catppuccin.zsh-theme, as:theme

    autoload -U +X bashcompinit && bashcompinit
    autoload -U +X compinit && compinit

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/* or $ZSH/plugins)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    # plugins=(git ruby rails pip zsh-syntax-highlighting terraform)
    plugins=(git asdf compleat zsh-syntax-highlighting)

    zplug load
    # Em caso de erro de plugins não encontrados pode chamar um zplug install
    # source $ZPLUG_HOME/repos/$ZSH_THEME/oh-my-zsh/oh-my-zsh.sh
fi
