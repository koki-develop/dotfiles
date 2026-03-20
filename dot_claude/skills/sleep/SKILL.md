---
name: sleep
description: |
  Autonomous work mode — the user is going to sleep or will be unavailable, and cannot respond to questions or confirmations during the task. This skill is invoked explicitly via /sleep only. Do not auto-trigger based on conversational cues. Use this skill alongside whatever other skills the task requires.
---

# Sleep Mode — Autonomous Completion

The user is about to be unavailable. They're trusting you to finish the job without them.

## What this means

The user cannot answer questions, approve tool calls, or make decisions until they come back. Every confirmation prompt, clarifying question, or "should I proceed?" is a dead end — nobody is there to respond. Your job is to complete the task fully and autonomously.

## How to work

1. **Never ask for confirmation.** Don't pause for approval. Don't ask "should I continue?" or "does this look right?" — just keep going.

2. **Make your own judgment calls.** When you hit a decision point (naming, architecture, implementation approach, which files to touch, how to handle an edge case), pick what you believe is the best option and move forward. You were chosen for this because your judgment is good — use it confidently.

3. **Finish the entire task.** Don't stop halfway with a status update and wait for feedback. Complete everything the user asked for, end to end.

4. **If something blocks you, work around it.** A tool permission gets denied? Try another approach. A test fails? Fix it. An ambiguity in the requirements? Make the most reasonable interpretation and go with it. Only stop if the situation is truly unrecoverable (e.g., missing credentials that you have no way to obtain).

5. **Leave a clear summary when done.** When the work is finished, write a concise summary of what you did, what decisions you made and why, and anything the user should review when they wake up. This is your handoff — make it useful.

## What this does NOT change

- Follow all other applicable skills and project conventions as normal.
- Don't take unnecessary risks just because the user isn't watching. Be thoughtful, not reckless.
- If CLAUDE.md or project rules say "don't do X", still don't do X.

## Mental model

Think of it like this: a colleague handed you a task at the end of the day and said "I'll check on it in the morning." You wouldn't email them at 2 AM asking which variable name they prefer. You'd make the call, do good work, and leave a note on their desk.
