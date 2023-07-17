# !/bin/zsh -e

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
