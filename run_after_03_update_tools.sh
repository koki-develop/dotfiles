#!/bin/zsh

#
# Homebrew
#

brew update
brew bundle --global
brew upgrade

#
# mise
#

mise install

#
# Zinit
#

zsh -c '. ~/.local/share/zinit/zinit.git/zinit.zsh && zinit update'
