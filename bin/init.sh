#!/bin/zsh

set -eu

#
# Clone dotfiles
#

# Check if ssh key is registered
ssh -T git@github.com 2>&1 | grep "successfully authenticated" > /dev/null

# Clone repository
readonly DOTFILES_DIR="${HOME}/dotfiles"
git clone git@github.com:koki-develop/dotfiles.git "${DOTFILES_DIR}"
pushd "${DOTFILES_DIR}"

#
# Create symbolic links
#

# zsh
ln -sf "${DOTFILES_DIR}/src/zsh/.zshrc" "${HOME}/.zshrc"

# git
mkdir -p "${HOME}/.config/git"
ln -sf "${DOTFILES_DIR}/src/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_DIR}/src/git/ignore" "${HOME}/.config/git/ignore"

# nvim
mkdir -p "${HOME}/.config/nvim"
ln -sf "${DOTFILES_DIR}/src/nvim/init.vim" "${HOME}/.config/nvim/init.vim"

# hammerspoon
mkdir -p "${HOME}/.hammerspoon"
ln -sf "${DOTFILES_DIR}/src/hammerspoon/init.lua" "${HOME}/.hammerspoon/init.lua"

# wezterm
mkdir -p "${HOME}/.config/wezterm"
ln -sf "${DOTFILES_DIR}/src/wezterm/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"

#
# Install Homebrew
#

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

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
