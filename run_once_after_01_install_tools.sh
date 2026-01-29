#!/bin/zsh

#
# Homebrew
# https://brew.sh/ja/
#

echo "Install formulae..."

brew bundle --global

echo "Done."

#
# Zinit
# https://github.com/zdharma-continuum/zinit#manual
#

ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#
# mise
#

export MISE_GLOBAL_CONFIG_FILE="${HOME}/.local/share/chezmoi/mise.toml"
mise install
eval "$(mise activate zsh)"

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
