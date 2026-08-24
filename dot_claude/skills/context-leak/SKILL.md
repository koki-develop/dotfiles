---
name: context-leak
description: |
  Check any deliverable for conversation context that leaked into it, and cut it. Catches scope disclaimers ("out of scope", "not handled here"), conversational traces ("as requested"), change narration ("previously this was X"), and provisional hedges ("for now", "temporarily"). Use when the user invokes /context-leak, asks to check writing against the Writing Deliverables rule, or wants something proofread before it ships.
---

# Context Leak

A deliverable is read by someone who never saw the conversation that produced it. A sentence that only makes sense to a participant is a leak. Find every one.

## Scope

`$ARGUMENTS` decides the target when present — a path, a range, a description of what to look at, whatever it names. Without it, take every deliverable produced this session.

## The test

**Does this sentence carry value for a reader who never saw the conversation?** No means cut it.

| Leak | Example |
|---|---|
| Declaring absence | "X is out of scope", "deferred to a follow-up", "intentionally omitted" |
| Conversational trace | "as requested", "per the instructions", "this time we…" |
| Change narration | "previously this was foo", recounting how the work went |
| Provisional hedge | "for now", "temporarily", "simplified for the time being" |
| Naming what was excluded | any mention of X where the user asked to leave X out |

The last one is the sharpest: silence is the compliant output. One occurrence of X is a violation.

## Not a leak

The subject decides it. A property of the shipped thing that a reader must know to use it correctly stays; a property of the work episode goes.

- Constraints of the artifact itself — documented limitations, unsupported platforms, known failure modes
- An explanation of a deliberate no-op that its surroundings can't convey on their own
- Writing where recording rejected alternatives is the whole point of the document

When it's genuinely ambiguous, leave it.

## Fixing

Deletion first; rewrite only when the sentence has a salvageable fact. What surrounds a cut must still read naturally — no orphaned headings or dangling lists.

Apply the fix in place when it is yours to make and easy to undo. When it would rewrite history, reach an audience, or otherwise be hard to walk back, propose it and wait.

## Report

Each finding pinned down well enough to act on — a location where one exists, otherwise whatever identifies it — with the offending text and the pattern it matched. Nothing found is a one-line answer.
