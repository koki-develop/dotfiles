#!/bin/bash

ln -sf ~/dotfiles/src/zsh/zshrc ~/.zshrc
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/src/nvim/init.vim  ~/.config/nvim/init.vim
mkdir -p ~/.config/git
ln -sf ~/dotfiles/src/git/config ~/.gitconfig
ln -sf ~/dotfiles/src/git/ignore ~/.config/git/ignore

ln -sf ~/dotfiles/src/hyper/hyper.js ~/.hyper.js

mkdir -p ~/.hammerspoon
ln -sf ~/dotfiles/src/hammerspoon/init.lua ~/.hammerspoon/init.lua
