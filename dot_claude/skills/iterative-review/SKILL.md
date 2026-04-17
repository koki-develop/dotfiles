---
name: iterative-review
description: Deep iterative code review that runs independent review cycles until the code stabilizes (2 consecutive cycles with zero actionable findings). Use this skill whenever the user asks for a thorough review, deep review, iterative review, or wants a more rigorous code review than a single pass. Also trigger when the user says things like "review this carefully", "review my changes", "check this PR thoroughly", or uses /iterative-review. This is the go-to skill for any serious code review workflow.
allowed-tools: Skill(iterate), Skill(pr-review-toolkit:review-pr)
---

# Iterative Review

This skill is a thin wrapper around the `iterate` skill, pre-configured for code review.

## How it works

1. Determine the review scope (unstaged changes, staged changes, PR context, or specific files the user points to).
2. Invoke the `iterate` skill with the context below.

## Invocation

Invoke the `iterate` skill (via the Skill tool) with the following context:

- **Verification instruction**: Run `Skill(pr-review-toolkit:review-pr)` directly from the parent context. This **overrides `iterate`'s default of spawning a subagent for verification** — do not wrap it in a subagent. `review-pr` internally spawns fresh subagents (code-reviewer, silent-failure-hunter, etc.) each cycle, so independent verification is already guaranteed. Nesting it inside another subagent would fail because Claude Code subagents cannot spawn subagents.
- **Scope**: The review scope determined in step 1 (git diff output, file list, PR number, etc.)

The `iterate` skill handles the full convergence loop — verify, validate, fix, repeat until 2 consecutive clean cycles or 10 max.
