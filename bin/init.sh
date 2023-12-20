#!/bin/zsh

set -eu

#
# Clone dotfiles
#

# Check if ssh key is registered
echo "Checking if ssh key is registered..."
ssh -T git@github.com 2>&1 | grep "successfully authenticated" > /dev/null
echo "Done."

# Clone repository
echo "Cloning dotfiles..."
readonly DOTFILES_DIR="${HOME}/dotfiles"
git clone git@github.com:koki-develop/dotfiles.git "${DOTFILES_DIR}"
echo "Done."
pushd "${DOTFILES_DIR}"

#
# Create symbolic links
#

echo "Creating symbolic links..."

# zsh
ln -sf "${DOTFILES_DIR}/src/zsh/.zshrc" "${HOME}/.zshrc"

# git
mkdir -p "${HOME}/.config/git"
ln -sf "${DOTFILES_DIR}/src/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_DIR}/src/git/ignore" "${HOME}/.config/git/ignore"

# LunarVim
mkdir -p "${HOME}/.config/lvim"
ln -sf "${DOTFILES_DIR}/src/lvim/config.lua" "${HOME}/.config/lvim/config.lua"

# hammerspoon
mkdir -p "${HOME}/.hammerspoon"
ln -sf "${DOTFILES_DIR}/src/hammerspoon/init.lua" "${HOME}/.hammerspoon/init.lua"

# wezterm
mkdir -p "${HOME}/.config/wezterm"
ln -sf "${DOTFILES_DIR}/src/wezterm/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"

# starship
mkdir -p "${HOME}/.config"
ln -sf "${DOTFILES_DIR}/src/starship/starship.toml" "${HOME}/.config/starship.toml"

# homebrew
ln -sf "${DOTFILES_DIR}/src/brew/.Brewfile" "${HOME}/.Brewfile"

# asdf
ln -sf "${DOTFILES_DIR}/src/asdf/.tool-versions" "${HOME}/.tool-versions"

echo "Done."

#
# Install Homebrew
#

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Done."
brew bundle --global

#
# Install LunarVim
#

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

#
# Install HackGen
#

echo "Installing HackGen..."

# Get latest version
HACK_GEN_REPO=yuru7/HackGen
HACK_GEN_VERSION=$(curl -s https://api.github.com/repos/${HACK_GEN_REPO}/releases/latest | jq -r .tag_name)

# Download and install
HACK_GEN_DOWNLOAD_URL=https://github.com/yuru7/HackGen/releases/download/${HACK_GEN_VERSION}/HackGen_NF_${HACK_GEN_VERSION}.zip
wget -O /tmp/HackGen.zip "${HACK_GEN_DOWNLOAD_URL}"
unzip -o /tmp/HackGen.zip -d /tmp
cp /tmp/HackGen_NF_"${HACK_GEN_VERSION}"/HackGenConsoleNF-* "${HOME}"/Library/Fonts/

echo "Done."

#
# Install zplug
#

echo "Installing zplug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
echo "Done."

#
# Set up git-secrets
#

echo "Setting up git-secrets..."
git secrets --register-aws --global
git secrets --install --force ~/.git-templates/git-secrets
echo "Done."

#
# Clean up
#

popd
