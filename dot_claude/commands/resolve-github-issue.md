---
allowed-tools: Bash(gh issue view:*)
description: Analyze and resolve a GitHub issue with automated workflow
---

## Context

- Issue details: !`gh issue view $ARGUMENTS --json number,title,body,state,assignees,labels`
- Current branch: !`git branch --show-current`
- Current git status: !`git status --porcelain`

## Your task

Based on the GitHub issue: $ARGUMENTS

Follow these steps:

1. Analyze the issue details from the context above
2. Search the codebase for relevant files and understand the current implementation
3. Implement the necessary changes to resolve the issue
4. Write and run tests to verify the resolution
5. Ensure code passes formatting, linting, type checking, and all tests
6. Create a descriptive commit message and commit the changes
7. Push changes and create a PR with detailed description of the work done
