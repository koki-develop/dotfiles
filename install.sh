#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$(uname -p)" == "arm"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install Dashlane CLI
brew install dashlane/tap/dashlane-cli
dcli sync

# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply koki-develop
