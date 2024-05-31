#!/bin/zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install dashlane/tap/dashlane-cli
dcli sync

#
# chezmoi
# https://www.chezmoi.io/
#

sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply koki-develop
