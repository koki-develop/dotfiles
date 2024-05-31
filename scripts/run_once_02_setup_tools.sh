#!/bin/zsh

#
# Set up git-secrets
# https://github.com/awslabs/git-secrets#advanced-configuration
#

echo "Setting up git-secrets..."
git secrets --register-aws --global
git secrets --install --force ~/.git-templates/git-secrets
echo "Done."
