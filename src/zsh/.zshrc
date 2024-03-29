# !/bin/zsh -e

#
# Environment variables
#

export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.config/v-analyzer/bin:${PATH}"
export GPG_TTY=$(tty)
export EDITOR='lvim'
export GHQ_ROOT="${HOME}/work/repos"

#
# Homebrew
#

eval "$(brew shellenv)"
export PATH="$(brew --repo)/opt/mysql-client/bin:$PATH"

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
zplug load

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
# Set up tools
#

# aqua
export PATH="$(aqua root-dir)/bin:${PATH}"
export AQUA_GLOBAL_CONFIG="${HOME}/dotfiles/src/aqua/aqua.yaml"

# Flutter
export PATH="${HOME}/work/repos/github.com/flutter/flutter/bin:${PATH}"

# mise
eval "$(mise activate zsh)"

# direnv
eval "$(direnv hook zsh)"

# aws-cli
complete -C "$(which aws_completer)" aws

# starship
eval "$(starship init zsh)"

# gcloud
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

# libpq
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

#
# Aliases
#

# aws
alias av='aws-vault'
# docker
alias d='docker'
alias dc='docker compose'
# cat
alias cat='gat'
function gess() {
  gat --force-color "$@" | less -R
}
# cd
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias cdd="cd ${HOME}/dotfiles"
alias cdg='cd "$GHQ_ROOT/$(gh q ls -f)"'
alias cdw="cd ${HOME}/work"
# echo
alias echo='ego'
# git
alias g='git'
alias gad='git add'
alias gbr='git branch'
alias gcom='git commit -m'
alias gdi='git diff'
alias gdem="git branch --merged | egrep -v '\*|develop|master|main' | xargs git branch --delete"
alias gfe='git fetch'
alias glo='git log --pretty=oneline'
alias gnow='git commit --all --message "commit"'
alias gre='git reset'
alias grest='git restore'
alias gst='git status'
alias gsw='git switch'
# grep
alias grep='rg --ignore-case'
# ls
alias ls='eza -1 --icons always'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias tree='ls --tree --git-ignore'
# mkdir
alias mkdir='mkdir -p'
# mv
alias mv='mv -i'
# rm
alias rm='gotrash put'
# sed
alias sed='gsed'
# terraform
alias tf='terraform'
# vim
alias vi='lvim'
