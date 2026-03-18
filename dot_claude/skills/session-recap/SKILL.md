---
name: session-recap
description: |
  Review the current session's work and evaluate whether any CLAUDE.md / AGENTS.md files in the project need updating. Only update when genuinely necessary. Use at the end of a session or at a natural breakpoint. Trigger when the user invokes /session-recap, or says things like "review docs", "do CLAUDE.md files need updating?", "reflect on what we did", "recap the session", or wants to check documentation consistency after completing work. This is not a mechanical codebase scan — it evaluates update needs based on the context of what was done during the session.
---

# Session Recap

Review the work done during this session and evaluate whether CLAUDE.md / AGENTS.md files need updating. If no updates are needed, do nothing.

## Workflow

### 1. Reflect on the session

Review the conversation and identify changes that may affect documentation:

- **Architecture changes** — new directory structures, module reorganization, dependency additions/removals
- **Workflow changes** — build, test, or deploy procedure modifications
- **Conventions and patterns** — new or changed coding conventions, naming rules, error handling policies
- **Tooling and configuration** — new tools introduced, config file changes, CI/CD modifications
- **Key design decisions** — decisions that affect future work (e.g., "we're using pattern X in this project")

Do not read any files yet. First, build an understanding of "what changed" purely from the session context.

### 2. Assess whether documentation is affected

Consider whether the changes identified in step 1 affect content that is (or should be) in CLAUDE.md / AGENTS.md.

**Updates are likely needed when:**
- Documented workflows or procedures no longer match reality after this session's changes
- New conventions or patterns were introduced but aren't yet reflected in documentation
- Tools or commands referenced in documentation have changed
- Important design decisions were made that would help future sessions if documented

**Updates are likely NOT needed when:**
- The session's work falls outside the scope of what's documented (e.g., a simple bug fix)
- The work followed existing documented conventions — nothing new to capture
- Changes were temporary or experimental and shouldn't be persisted

If no impact is found, communicate that and stop. There is no obligation to update anything.

### 3. Read relevant files

Only if step 2 indicates likely impact, read the relevant files:

```
Glob: **/CLAUDE.md
Glob: **/AGENTS.md
```

No need to read every file. Based on step 1, focus on the files most likely affected. For example, if frontend conventions changed, only check the frontend-related CLAUDE.md.

### 4. Apply updates

When updating, follow these principles:

- **Minimal changes**: Only modify what needs changing. Do not rewrite entire documents.
- **Preserve existing tone and structure**: Match the document's existing writing style.
- **Distinguish facts from conventions**: Factual corrections (e.g., path changes) can be applied silently. New conventions or rules should be confirmed with the user before adding.
- **Additions require judgment**: Appending to an existing section is fine. Adding entirely new sections should be confirmed with the user first.

### 5. Report results

**When no updates are needed:**
```
Reviewed the session. No CLAUDE.md / AGENTS.md updates needed.
Reason: [brief reason]
```

**When updates were made:**
```
Based on this session's work, updated the following:

- `path/to/CLAUDE.md`:
  - [what changed and why]
- `path/to/AGENTS.md`:
  - [what changed and why]
```

## When in doubt

If you're unsure whether something belongs in documentation, apply these filters:

- **Would future-me (Claude) benefit from knowing this in the next session?** → Yes means it's worth documenting
- **Can this be derived by reading the code?** → Yes means don't document it (code is the source of truth)
- **Can this be found in git log?** → Yes means don't document it
- **Is this a project-specific decision or convention?** → Yes means it's worth documenting
