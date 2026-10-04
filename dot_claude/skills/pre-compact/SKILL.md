---
name: pre-compact
description: Writes a detailed handoff of the current session to a file so work can resume accurately after /compact. Use when the user invokes /pre-compact before compacting the conversation.
disable-model-invocation: true
---

# Pre-Compact

The conversation is about to be compacted, which replaces it with a lossy summary. Write a handoff file that lets you resume the work afterward with full detail, independent of that summary.

## Steps

1. Review the entire session and extract the information listed under "Handoff contents". If a fact is uncertain, verify it against the codebase or other sources before writing it down.
2. Write `handoff.md` in the session scratchpad directory. If the file already exists, overwrite it so it reflects only the current state.
3. Reply with the file path and a summary of a few lines.

## Handoff contents

Be specific: file paths, function names, commands, exact error messages. Mark anything not verified as `(unverified)`. Omit sections that have nothing to say.

- **Goal** — what the user ultimately wants to achieve, and why
- **Decisions** — what was decided and the reasoning; alternatives rejected and why
- **Status** — done / in progress (exactly where it stopped) / remaining
- **Changed files** — each path and what changed in it
- **Troubleshooting** — problems hit, their root causes, and fixes; approaches that failed and why
- **Constraints and user instructions** — rules, preferences, and corrections the user gave during the session
- **Open questions** — unresolved points and pending decisions
- **Verification** — commands that confirm the current state (tests, builds, checks)
- **Next step** — the very next action to take
