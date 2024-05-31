#!/bin/zsh

#
# chezmoi
# https://www.chezmoi.io/
#

sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply koki-develop
