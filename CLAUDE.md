# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by chezmoi, containing personal development environment configuration files. The repository manages configuration for tools like Neovim, Zsh, Git, and various development utilities.

## Common Commands

### Dotfiles Management
- `task` or `task default` - Apply dotfiles and update all tools
- `chezmoi apply -v` - Apply dotfiles changes
- `chezmoi add <file>` - Add a new file to dotfiles management
- `chezmoi edit <file>` - Edit a managed file

### Development Updates
- `task update` - Update all development tools (Neovim plugins, Homebrew formulae, zplug packages, mise tools)
- `task update-nvim-plugins` - Update Neovim plugins only
- `task update-brew-formula` - Update Homebrew packages only
- `task update-zplug-packages` - Update zsh plugins only
- `mise install` - Install/update tools defined in mise.toml

### Package Management
- `brew bundle --global` - Install/update Homebrew packages from dot_Brewfile
- Tools are managed via mise (defined in mise.toml)
- Zsh plugins managed via zplug

## Architecture Notes

### File Structure
- Files prefixed with `dot_` become dotfiles in the home directory (e.g., `dot_zshrc.tmpl` → `~/.zshrc`)
- Template files (`.tmpl`) are processed by chezmoi and can contain dynamic content
- `run_once_after_*` scripts execute once after chezmoi apply for setup tasks

### Tool Configuration
- Development tools versioned and managed through mise.toml
- Homebrew packages defined in dot_Brewfile using Ruby DSL
- Neovim configuration in dot_config/nvim/init.vim using vim-plug
- Shell configuration in dot_zshrc.tmpl with zplug for plugin management

### Key Dependencies
- **chezmoi**: Dotfiles management system
- **mise**: Development tool version management (successor to asdf)
- **Task**: Task runner for common operations
- **Homebrew**: Package management for macOS
- **zplug**: Zsh plugin manager
- **vim-plug**: Neovim plugin manager

### Security
- SSH keys and sensitive data managed as private templates
- Keeper Commander integration for secret management