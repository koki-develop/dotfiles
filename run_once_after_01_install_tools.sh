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
# vim-plug
# https://github.com/junegunn/vim-plug#unix-linux
#

echo "Installing vim-plug..."

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +UpdateRemotePlugins +qall

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

#
# aqua
#

echo "Installing tools with aqua..."

aqua install

echo "Done."
