#!/bin/bash

set -euo pipefail

#
# Install Homebrew
#

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#
# Install HackGen
#

# Get latest version
HACK_GEN_REPO=yuru7/HackGen
HACK_GEN_VERSION=$(curl -s https://api.github.com/repos/${HACK_GEN_REPO}/releases/latest | jq -r .tag_name)

# Download and install
HACK_GEN_DOWNLOAD_URL=https://github.com/yuru7/HackGen/releases/download/${HACK_GEN_VERSION}/HackGen_NF_${HACK_GEN_VERSION}.zip
wget -O /tmp/HackGen.zip "${HACK_GEN_DOWNLOAD_URL}"
unzip -o /tmp/HackGen.zip -d /tmp
cp /tmp/HackGen_NF_"${HACK_GEN_VERSION}"/HackGenConsoleNF-* "${HOME}"/Library/Fonts/

#
# Install zplug
#

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
