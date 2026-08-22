---
name: commit
description: Create a git commit for the current session's work. Use whenever the user invokes /commit or asks to commit changes. MUST be used for any commit operation — never commit without following this workflow.
allowed-tools: Bash(git add *), Bash(git commit *)
---

# Commit

## Current git state

Staged files:
!`git diff --staged --name-only --relative`

Unstaged changes:
!`git diff --name-only --relative`

Untracked files:
!`git ls-files --others --exclude-standard`

Recent commit messages (style reference):
!`git log --format="%s" -20`

## Workflow

1. **Pick targets** — in priority order: files named in `$ARGUMENTS`; else files you changed this session; else whatever is already staged. If none apply, tell the user there's nothing to commit and stop.
2. **Stage** — `git add` each path individually, never `.` / `-A` / `--all`. The paths listed above are already relative to cwd.
3. **Commit** — write a message that matches the style of the recent messages above.
4. **Report** — the message, the full SHA, and the committed files.

`git add` and `git commit` need `dangerouslyDisableSandbox: true`; the sandbox blocks `.git/` writes and `~/.gnupg`.
