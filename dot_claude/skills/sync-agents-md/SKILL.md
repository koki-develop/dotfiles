---
name: sync-agents-md
description: |
  Synchronize CLAUDE.md and AGENTS.md files with the actual codebase state. Use this skill when the user invokes /sync-agents-md, asks to sync documentation, or wants to check if CLAUDE.md/AGENTS.md are up to date with the codebase. This skill compares documented claims (file paths, commands, tool names, directory structures, workflows) against reality and fixes inaccuracies. It only corrects what's wrong — it does not add new sections or expand documentation beyond what already exists.
---

# Sync Agents MD

Synchronize CLAUDE.md / AGENTS.md content with the actual codebase, correcting inaccuracies without adding unnecessary content.

## Philosophy

These documentation files serve as instructions for AI coding assistants. When they describe something that no longer exists or has changed, it causes confusion and wasted effort. This skill fixes that drift — nothing more, nothing less.

The goal is **conservative correction**: fix what's wrong, remove what no longer exists, but don't add new content or restructure documents. Think of it as a fact-checker, not an author.

## Workflow

### 1. Discover target files

Find all CLAUDE.md and AGENTS.md files in the project:

```
Glob: **/CLAUDE.md
Glob: **/AGENTS.md
```

Read each file to understand what claims they make.

### 2. Extract verifiable claims

For each file, identify claims that can be checked against the codebase. Common categories:

- **File/directory paths** — Do referenced files and directories actually exist at the stated locations?
- **Commands and scripts** — Do referenced scripts/commands exist and do what's described?
- **Tool and dependency names** — Are listed tools still present in the project's dependency/config files?
- **Workflows** — Do described step-by-step sequences match the actual implementation?
- **Configuration references** — Do referenced config files exist with the described structure?
- **Directory structure descriptions** — Do listed naming conventions and structural patterns match reality?

Don't try to verify subjective statements, style guidelines, or behavioral instructions (e.g., "Write commit messages in plain English") — those are intentional rules, not factual claims.

### 3. Verify each claim

Use Glob, Grep, Read, and Bash to check each claim against the codebase. Work through claims efficiently — batch related checks together using parallel tool calls where possible.

For each claim, determine:
- **Accurate**: matches codebase state — no action needed
- **Inaccurate**: contradicts codebase state — needs correction
- **Stale**: references something that no longer exists — needs removal or update
- **Unverifiable**: can't be checked from the codebase alone — leave as-is

### 4. Apply corrections

For each inaccuracy or stale reference, edit the documentation to match reality:

- **Renamed files/dirs**: Update the path
- **Removed files/dirs**: Remove the reference or the bullet point
- **Changed behavior**: Update the description to match what the code actually does
- **New dependencies/tools**: Only mention them if they replace something already documented — don't add entirely new sections

When removing content, ensure the surrounding text still reads naturally. Don't leave orphaned headings or broken lists.

### 5. Report changes

After all edits, provide a concise summary of what was changed and why:

```
## Sync results

- `CLAUDE.md`: Updated X references, removed Y stale entries
  - line 23: `src/utils/logger.ts` → `src/lib/logger.ts` (file moved)
  - line 45: removed reference to `scripts/deploy.sh` (file deleted)
- `docs/AGENTS.md`: No changes needed
```

## Rules

- Never add new sections, headings, or documentation that didn't exist before
- Never rewrite or restructure existing content for "improvement"
- Never change behavioral instructions, style guidelines, or rules — only factual claims
- If unsure whether something is wrong, leave it alone
- Preserve the original writing style and tone of each file
