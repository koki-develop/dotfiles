#!/bin/zsh

function log() {
  echo "##########################"
  echo "# $1"
  echo "##########################"
}

log "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

log "Install Dashlane CLI"
brew install dashlane/tap/dashlane-cli

log "Execute Dashlane CLI sync"
dcli sync

log "Install chezmoi"
brew install chezmoi

log "Execute chezmoi init and apply dotfiles"
chezmoi init --apply koki-develop

log "Logout Dashlane CLI"
dcli logout
