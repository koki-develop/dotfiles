# !/bin/zsh -e

#
# Completion
#

fpath=(${HOME}/.zsh/completion $fpath)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

#
# Options
#

setopt auto_cd
setopt magic_equal_subst
setopt hist_ignore_dups
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

#
# Styles
#

zstyle ':completion:*:default' menu select=2

#
# Set up zplug
#

# Load zplug
. "${HOME}/.zplug/init.zsh"

# Add plugins
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load plugins
zplug load --verbose

#
# Setup tools
#

# rtx
eval "$(rtx activate zsh)"

# direnv
eval "$(direnv hook zsh)"

# aws-cli
complete -C "$(which aws_completer)" aws
