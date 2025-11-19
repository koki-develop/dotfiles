---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Read
description: Create a pull request using gh pr create command
---

## Your task

Create a pull request using the `gh pr create` command.

### Requirements

1. Check the current git status and branch information
2. Review all changes and commits that will be included in the PR
3. Check if a PR template exists, for example:
   - `.github/PULL_REQUEST_TEMPLATE.md`
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE/*.md`
4. If a PR template exists, read it and ensure the PR description follows the template structure
5. Push the current branch to remote if needed
6. Execute `gh pr create` with an appropriate title and body
