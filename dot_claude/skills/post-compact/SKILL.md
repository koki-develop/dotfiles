---
name: post-compact
description: Rebuilds an accurate understanding of the session's work after /compact by reading the handoff file and checking it against the current codebase and other up-to-date sources. Use when the user invokes /post-compact after compacting the conversation.
disable-model-invocation: true
---

# Post-Compact

The conversation was just compacted. The compaction summary and the handoff file describe the past; the codebase and external sources describe the present. Reconstruct the present.

## Steps

1. Read `handoff.md` in the session scratchpad directory. If it does not exist, rely on the compaction summary and tell the user the file was not found.
2. Check the handoff and the summary against current reality. Decide what to check based on what the work involves — for example, read the changed files, inspect the repository state, re-run cheap checks that the status depends on, or look up PRs, issues, and docs the work relies on.
3. Report to the user:
   - **Goal** — one or two lines
   - **Current status** — as verified in step 2
   - **Discrepancies** — where the handoff or summary disagrees with reality
   - **Keep in mind** — constraints, user instructions, and pitfalls
   - **Next step**
4. Stop after the report. Do not resume the work until the user says so.
