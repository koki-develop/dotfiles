---
name: commit
description: |
  Create a git commit for work done in the current session. Use this skill whenever the user invokes /commit or asks to commit their changes. This skill handles file selection (session-changed files, staged files, or explicitly specified files), commit message generation based on the repository's existing style, and outputs a summary of the commit. MUST be used for any commit operation — never commit without following this workflow.
allowed-tools: Bash(git add *), Bash(git commit *)
---

# Commit

Create a git commit with intelligent file selection and style-consistent messages.

## Current git state

Staged files:
!`git diff --cached --name-only`

Unstaged changes:
!`git diff --name-only`

Untracked files:
!`git ls-files --others --exclude-standard`

Recent commit messages (for style reference):
!`git log --format="%s" -20`

## Step 1: Determine commit targets

Select files using this priority:

1. **Explicit targets** — if the user specified files in `$ARGUMENTS`, use exactly those.
2. **Session-changed files** — files you (Claude) modified during this conversation (via any tool — Edit, Write, Bash, NotebookEdit, etc.). Cross-reference your memory of which files you touched against the git state above. Include both staged and unstaged changes for those files.
3. **Already staged files** — if you didn't modify any files this session (e.g., the user invoked /commit after staging manually), use whatever is already staged.

If none of these produce any files, tell the user there's nothing to commit and stop.

## Step 2: Stage the files

Run `git add` with each file path specified individually. Never use `git add .`, `git add --all`, or `git add -A`.

After staging, verify with `git diff --cached --name-only` that all intended files are included.

## Step 3: Generate the commit message

Write a commit message that:
- Follows the style and conventions visible in the recent commit messages above (tense, capitalization, length, format)
- Summarizes what changed and why in a way that's useful to someone reading the log later
- Uses a single line unless the change is complex enough to warrant a body

## Step 4: Commit

The sandbox blocks access to `~/.gnupg`, which is required for GPG-signed commits. Run `git commit` with `dangerouslyDisableSandbox: true`.

## Step 5: Output the result

After a successful commit, run `git log -1 --format="%H"` and report:

- **Commit message** — the message you wrote
- **SHA** — the full commit hash
- **Files** — list of all committed files
