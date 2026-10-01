#!/bin/zsh

#
# Homebrew
#

brew update
brew bundle --global
brew upgrade

#
# APM
#

apm update --global --yes

#
# mise
#

mise install

#
# herdr
#

herdr integration install claude
herdr integration install codex

#
# Zinit
#

zsh -c '. ~/.local/share/zinit/zinit.git/zinit.zsh && zinit update'
