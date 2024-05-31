#!/bin/zsh

#
# Install Homebrew
# https://brew.sh/ja/
#

echo "Installing Homebrew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --global

echo "Done."

#
# Install HackGen
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
# Install zplug
# https://github.com/zplug/zplug#installation
#

echo "Installing zplug..."

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Done."

#
# Install vim-plug
# https://github.com/junegunn/vim-plug#unix-linux
#

echo "Installing vim-plug..."

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +UpdateRemotePlugins +qall

echo "Done."
