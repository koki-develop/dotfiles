---
name: rigorous
description: |
  Enforce uncompromising implementation standards — no ad-hoc fixes, no shortcuts, no scope reduction. Use this skill whenever the user invokes /rigorous before giving an implementation task. This skill sets the mindset for the entire task: always pursue the architecturally correct solution regardless of change volume or complexity. Also use when the user says things like "ちゃんとやって", "しっかり実装して", "妥協しないで", "手を抜かないで", or any indication they want rigorous, no-compromise implementation.
---

# Rigorous Implementation Mode

This skill overrides the default tendency to minimize change volume or take the path of least resistance. When this skill is active, every implementation decision must be guided by one question: **"What is the correct design?"** — not "What is the easiest fix?" or "What changes the fewest lines?"

## Core Principles

### 1. Design-first, always

Every change must reflect the architecturally correct solution. Before writing any code, identify what the ideal design looks like — then implement exactly that.

Ad-hoc patches, workarounds, and "good enough for now" solutions are not acceptable. If the right solution requires restructuring existing code, changing interfaces, or modifying multiple files — that's the solution. The volume of changes is irrelevant; only correctness matters.

**What this looks like in practice:**
- If a bug exists because of a flawed abstraction, fix the abstraction — don't patch the symptom
- If a new feature doesn't fit cleanly into the current architecture, refactor the architecture to accommodate it properly
- If you notice that existing code around your change has structural problems that affect your work, fix those too

### 2. No compromise, no deferral

"Implementation cost" and "time constraints" are not valid reasons to reduce scope, skip steps, or defer work. Every task must be completed fully and correctly in this session.

This means:
- Do not suggest "we could do X later" — do X now
- Do not offer a "simpler alternative" when you know the correct approach — implement the correct approach
- Do not leave TODOs, FIXMEs, or partial implementations — finish everything
- If completing the task properly requires more work than initially apparent, do that work without hesitation

### 3. Embrace large-scale changes

When the correct solution touches many files or requires significant refactoring, that's not a problem — it's the right thing to do. Specifically:

- Changing 20 files is fine if that's what correctness requires
- Renaming widely-used interfaces is fine if the current names are wrong
- Rewriting a module is fine if the current implementation is fundamentally flawed
- Updating all callers of a changed API is expected, not optional

### 4. Propagate fixes to their root

When you encounter an issue, trace it to its root cause and fix it there. Surface-level fixes that mask deeper problems are not acceptable.

If fixing the root cause has a large blast radius (many files affected, interface changes, behavioral changes), that's expected. The blast radius of the correct fix is always acceptable. What's not acceptable is leaving the root cause intact because fixing it would be "too much work."

## How to Apply This

When you receive a task with this skill active:

1. **Analyze the problem space** — understand not just what needs to change, but why, and what the ideal state looks like
2. **Design the correct solution** — without constraining yourself by change volume or complexity
3. **Implement completely** — every file, every caller, every test, every edge case
4. **Verify thoroughly** — make sure the implementation is actually correct, not just "it compiles"

If at any point you feel the urge to take a shortcut or suggest deferring part of the work — that's the signal to push through and do it properly instead.
