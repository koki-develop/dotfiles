---
name: commit
description: Review changes made during the current session, then commit only those files. If no session changes exist, commit currently staged files instead. Use when the user wants to commit their work.
allowed-tools: Bash(git status:*), Bash(git add:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
---

# Session Commit

Review and commit only the changes made during the current Claude Code session. If no session changes exist, commit the currently staged files instead.

## Context

Current git status:

!`git status`

Recent commit log:

!`git log --oneline -20`

## Critical Rule

**ONLY commit files that were changed during THIS session.** If there are pre-existing uncommitted changes that were NOT part of this session's work, leave them untouched.

**Exception:** If the session file list is empty (no files were created, edited, or deleted during this session), use the currently staged files as the commit target instead. In this case, skip to step 2b.

## Procedure

### 1. Identify Session Changes

Review the conversation history to build a complete list of files that were created, edited, or deleted during this session. This is the **session file list**.

### 2. Determine Commit Target

#### 2a. Session changes exist

Compare the session file list against the git status provided in the Context section:

- Files in both the session file list AND git status → **include** in the commit
- Files in git status but NOT in the session file list → **exclude** from the commit (these are pre-existing changes unrelated to this session)
- If no session files appear in git status (all changes already committed or reverted), report that there is nothing to commit and stop

#### 2b. No session changes (fallback)

If the session file list from step 1 is empty:

- Use the currently staged files (shown in git status as "Changes to be committed") as the commit target
- If there are no staged files either, report that there is nothing to commit and stop
- Do NOT stage additional unstaged files — commit only what is already staged

### 3. Draft a Commit Message

- Review the session conversation to understand the purpose and context of the changes
- **Analyze the recent commit log** in the Context section to identify the repository's commit message style (tone, tense, length, capitalization, format). Match that style closely.
- Write a concise commit message that describes the "why" not the "what"
- End the message with a blank line followed by `Co-Authored-By: Claude <noreply@anthropic.com>`

### 4. Stage and Commit

- **If committing session changes (2a):** Stage each file identified in step 2a using `git add` with explicit file paths, then create the commit
- **If committing staged files (2b):** Create the commit directly without modifying the staging area
- End the commit message with a blank line followed by `Co-Authored-By: Claude <noreply@anthropic.com>`
- Run `git status` to verify success

### 5. Report

Show the user:
- The commit hash and message
- The list of files committed
- Current git status after the commit
