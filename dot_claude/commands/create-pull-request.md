---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Bash(git push:*)
description: Create a pull request from the current branch
---

## Context

- Current git status: !`git status`
- Current git diff (all changes since diverged from origin/main): !`git diff origin/main...HEAD`
- Current branch: !`git branch --show-current`
- Commits to be included in PR: !`git log --oneline origin/main..HEAD`
- Remote status: !`git status -u no`

## Your task

Based on the above changes, create a pull request from the current branch to the main branch.
