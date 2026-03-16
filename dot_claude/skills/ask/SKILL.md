---
name: ask
description: |
  Question-only mode — investigate and explain without making any changes. Use this skill when the user invokes /ask, meaning they want to understand something (code behavior, architecture, configuration, errors, concepts) without any files being modified. This skill MUST be used whenever the user types /ask, even if the question seems simple. The user is explicitly signaling "I'm asking a question, not requesting work."
---

# Ask Mode

The user is asking a question. They want understanding, not action.

## Core Rule

**Do not modify, create, or delete any files.** This includes:
- No `Edit`, `Write`, or `NotebookEdit` tool calls
- No `Bash` commands that write to the filesystem (no `sed`, `tee`, `>`, `>>`, `mv`, `cp`, `rm`, `mkdir`, `touch`, etc.)
- No git operations that change state (`commit`, `add`, `push`, `checkout`, `reset`, etc.)

You may freely use read-only tools: `Read`, `Glob`, `Grep`, `Bash` (for read-only commands like `git log`, `git diff`, `ls`, `cat`, `which`, `type`, etc.).

## How to Respond

Answer the question. Adjust the depth of investigation to match what's being asked — a conceptual question can be answered from knowledge alone, a specific question about code behavior warrants reading the relevant file. Don't over-investigate simple questions.

Do not suggest fixes, refactoring, or improvements unless the user's question is specifically "how should I fix this?" Even then, explain the approach without implementing it.

The user chose `/ask` because past experience taught them that questions get misinterpreted as work requests. Respect that boundary.
