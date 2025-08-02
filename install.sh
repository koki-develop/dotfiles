#!/bin/zsh

# Color codes
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Color output functions
function print_yellow() {
  echo "${YELLOW}$1${NC}"
}

function print_blue() {
  echo "${BLUE}$1${NC}"
}

function print_cyan() {
  echo "${CYAN}$1${NC}"
}

function print_bold() {
  echo "${BOLD}$1${NC}"
}

function log() {
  echo "${BLUE}##########################${NC}"
  echo "${BLUE}#${NC} ${GREEN}$1${NC}"
  echo "${BLUE}##########################${NC}"
}

log "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

log "Install Keeper Commander"
brew install pipx
pipx install keepercommander

log "Login to Keeper Commander"
print_yellow "Please complete the initial Keeper login setup:"
print_cyan "1. The Keeper shell will open for initial authentication"
print_cyan "2. After logging in with your credentials and 2FA, run:"
print_blue "  > this-device persistent-login on"
print_blue "  > quit"
print_bold "Opening Keeper shell..."
keeper shell

log "Install chezmoi"
brew install chezmoi

log "Execute chezmoi init and apply dotfiles"
chezmoi init --verbose --apply koki-develop
