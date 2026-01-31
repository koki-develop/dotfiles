# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by chezmoi, containing personal development environment configuration files. The repository manages configuration for tools like Neovim, Zsh, Git, Ghostty, Starship, Atuin, and various development utilities.

## Common Commands

### Dotfiles Management
- `task` or `task default` - Apply dotfiles and update all tools
- `chezmoi apply -v` - Apply dotfiles changes
- `chezmoi add <file>` - Add a new file to dotfiles management
- `chezmoi edit <file>` - Edit a managed file

### Development Updates
Updates are automatically executed via `run_after_03_update_tools.sh` after `chezmoi apply`:
- Homebrew packages (`brew update && brew bundle --global && brew upgrade`)
- mise tools (`mise install`)
- zinit plugins (`zinit update`)

Manual update command:
- `mise install` - Install/update tools defined in mise.toml

### Setup
- `./install.sh` - Initial setup script (installs Homebrew, Keeper Commander, chezmoi, and applies dotfiles)

### Package Management
- `brew bundle --global` - Install/update Homebrew packages from dot_Brewfile
- Tools are managed via mise (defined in mise.toml)
- Zsh plugins managed via zinit

## Architecture Notes

### File Structure
- Files prefixed with `dot_` become dotfiles in the home directory (e.g., `dot_zshrc.tmpl` → `~/.zshrc`)
- Files prefixed with `private_` have restricted permissions (600) for sensitive data
- Template files (`.tmpl`) are processed by chezmoi and can contain dynamic content
- `run_once_after_*` scripts execute once after chezmoi apply for setup tasks
- `run_after_*` scripts execute every time after chezmoi apply (e.g., update tasks)
- Numbered scripts (`01_`, `02_`, `03_`) define execution order

### Tool Configuration
- Development tools versioned and managed through mise.toml (Go, Node, Python, Ruby, Rust, Bun, etc.)
- Homebrew packages defined in dot_Brewfile using Ruby DSL
- Shell configuration in dot_zshrc.tmpl with zinit for plugin management
- Terminal: Ghostty (dot_config/ghostty/), Alacritty (dot_config/alacritty/)
- Prompt: Starship (dot_config/starship.toml)
- Shell history: Atuin (dot_config/private_atuin/)
- Editor: Neovim (installed via Homebrew), Zed (dot_config/zed/)
- Claude Code: dot_claude/ (settings.json, skills, agents)
- Global mise config at ~/.local/share/chezmoi/mise.toml (referenced via MISE_GLOBAL_CONFIG_FILE)

### Key Dependencies
- **chezmoi**: Dotfiles management system
- **mise**: Development tool version management (successor to asdf)
- **Task**: Task runner for common operations
- **Homebrew**: Package management for macOS
- **zinit**: Zsh plugin manager
- **Neovim**: Text editor (installed via Homebrew)
- **Starship**: Cross-shell prompt
- **Atuin**: Shell history sync and search

### Security
- SSH keys and sensitive data managed as private templates
- Keeper Commander integration for secret management and credential injection
- GPG signing enabled for Git commits
- git-secrets configured for AWS credential detection
- AWS configuration managed through Keeper Commander templates

### Git Conventions
- Do not use Conventional Commits format (e.g., `feat:`, `fix:`, `chore:`)
- Write commit messages in plain English

### Default Task Workflow
The `task` command (or `task default`) performs a complete update workflow:
1. Authenticate with Keeper Commander (`keeper shell`)
2. Fetch and rebase from origin/main
3. Apply dotfiles changes (`chezmoi apply -v`)
4. After apply, `run_after_03_update_tools.sh` automatically updates tools