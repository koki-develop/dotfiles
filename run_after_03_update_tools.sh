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

#
# Completions
#

mkdir -p ~/.zsh/completion
codex completion zsh > ~/.zsh/completion/_codex
ghalint completion zsh > ~/.zsh/completion/_ghalint
gotrash completion zsh > ~/.zsh/completion/_gotrash
pinact completion zsh > ~/.zsh/completion/_pinact
pnpm completion zsh > ~/.zsh/completion/_pnpm
