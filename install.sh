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
echo "Please complete the initial Keeper login setup:
1. The Keeper shell will open for initial authentication
2. After logging in with your credentials and 2FA, run:
  > this-devise persistent-login on
  > quit"
keeper shell

log "Install chezmoi"
brew install chezmoi

log "Execute chezmoi init and apply dotfiles"
chezmoi init --verbose --apply koki-develop
