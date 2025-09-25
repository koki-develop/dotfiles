#!/bin/zsh

#
# Homebrew
# https://brew.sh/ja/
#

echo "Install formulae..."

brew bundle --global

echo "Done."

#
# zplug
# https://github.com/zplug/zplug#installation
#

echo "Installing zplug..."

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Done."

#
# xbar-plugin-github
# https://github.com/koki-develop/xbar-plugin-github
#

echo "Installing xbar-plugin-github..."

(
  cd ~/work/repos/github.com/koki-develop/xbar-plugin-github
  make
)

echo "Done."
