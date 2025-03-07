#!/bin/zsh

function log() {
  echo "##########################"
  echo "# $1"
  echo "##########################"
}

log "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

log "Install Keeper Commander"
brew install keeper-commander

log "Login to Keeper Commander"
echo 'this-device persistent-login on' | keeper --batch-mode shell

log "Install chezmoi"
brew install chezmoi

log "Execute chezmoi init and apply dotfiles"
chezmoi init --apply koki-develop
