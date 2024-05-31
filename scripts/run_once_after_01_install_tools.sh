#!/bin/zsh

#
# Homebrew
# https://brew.sh/ja/
#

echo "Install formulae..."

brew bundle --global

echo "Done."

#
# HackGen
# https://github.com/yuru7/HackGen
#

echo "Installing HackGen..."

# Get latest version
HACK_GEN_REPO=yuru7/HackGen
HACK_GEN_VERSION=$(curl -s https://api.github.com/repos/${HACK_GEN_REPO}/releases/latest | jq -r .tag_name)

# Download and install
HACK_GEN_DOWNLOAD_URL=https://github.com/${HACK_GEN_REPO}/releases/download/${HACK_GEN_VERSION}/HackGen_NF_${HACK_GEN_VERSION}.zip
wget -O /tmp/HackGen.zip "${HACK_GEN_DOWNLOAD_URL}"
unzip -o /tmp/HackGen.zip -d /tmp
cp /tmp/HackGen_NF_"${HACK_GEN_VERSION}"/HackGenConsoleNF-* "${HOME}"/Library/Fonts/

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
