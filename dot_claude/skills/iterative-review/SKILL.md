---
name: iterative-review
description: Deep iterative code review that runs independent review cycles until the code stabilizes (2 consecutive cycles with zero actionable findings). Use this skill whenever the user asks for a thorough review, deep review, iterative review, or wants a more rigorous code review than a single pass. Also trigger when the user says things like "review this carefully", "review my changes", "check this PR thoroughly", or uses /iterative-review. This is the go-to skill for any serious code review workflow.
allowed-tools: Skill(pr-review-toolkit:review-pr)
---

# Iterative Review

A convergence-based deep review process. Each cycle independently reviews the codebase, validates findings, and applies necessary fixes. The process continues until the code stabilizes — defined as **2 consecutive cycles where zero findings are classified as "Fix"** in the validation phase. The key property: **every review cycle starts completely fresh** with zero knowledge of previous cycles' findings.

## Why this exists

A single review pass catches obvious issues but misses subtle ones. Running multiple independent passes from scratch — not incremental re-reviews — surfaces different classes of issues each time, because each pass approaches the code with fresh eyes and different attention patterns. Fixes applied in earlier cycles also change the code surface, potentially revealing new issues that weren't visible before.

A fixed cycle count (e.g., 3) is arbitrary — sometimes 2 passes are enough, sometimes 5 are needed. By running until the review stabilizes, we stop exactly when there's nothing left to fix, without wasting cycles on already-clean code or stopping too early on code that still has issues.

## The Review Process

Run cycles until **2 consecutive cycles produce 0 "Fix" findings**, up to a maximum of 10 cycles. Each cycle has 3 phases: Review, Validate, Fix.

### Before starting

Determine the review scope. Check for:
- Unstaged changes (`git diff`)
- Staged changes (`git diff --cached`)
- PR context (if the user mentions a PR number)
- Specific files the user points to

This scope stays the same across all cycles (though the code itself evolves as fixes are applied).

### Cycle N (repeat until convergence or max 10 cycles)

#### Phase 1: Review (parent context — via Skill tool)

Invoke `pr-review-toolkit:review-pr` directly from the parent context using the Skill tool. This skill internally spawns fresh specialized subagents (code-reviewer, silent-failure-hunter, etc.) each time it runs, so every invocation gets independent reviewers with no memory of previous cycles.

**Critical rule: do NOT pass any previous cycle's findings, context, or fix history into the review-pr invocation.** The review-pr skill and its subagents must see only the current state of the code and the review scope — nothing else. This is what guarantees each cycle is a genuinely independent review.

If review-pr asks for or accepts arguments, provide only the review scope (diff, files, PR number). Never include phrases like "in the previous cycle we found..." or "focus on areas other than...".

#### Phase 2: Validate (parent context)

After review-pr completes and presents its findings, evaluate each finding:

1. **Verify accuracy** — Is the finding factually correct? Read the actual code and confirm the issue exists as described.
2. **Assess severity** — Is this a real problem or a stylistic nitpick? Would it cause bugs, security issues, performance problems, or maintenance burden?
3. **Judge necessity** — Does this actually need fixing, or is the reviewer being overzealous?

Classify each finding as:
- **Fix** — Genuine issue, will address now
- **Skip** — Not accurate, already fixed, or not worth changing

Report the validation results to the user before proceeding to fixes. Be brief — a short table or list showing what you'll fix and what you're skipping (with why).

#### Phase 3: Fix (parent context)

Apply fixes for everything classified as "Fix". Keep changes minimal and focused — fix the issue, don't refactor the neighborhood.

After fixing, briefly confirm what was changed.

---

Then move to the next cycle. The next review-pr invocation will spawn fresh subagents that review the code as it now stands (including fixes from this cycle). Those subagents won't know what was previously flagged or fixed — they just see code and review it from scratch.

### Convergence tracking

Track the number of "Fix" findings per cycle. The process ends when **either** condition is met:

1. **Convergence**: 2 consecutive cycles produce 0 "Fix" findings. The first zero-fix cycle isn't enough — a second independent pass confirming zero issues provides confidence that the code is genuinely clean, not that one pass just happened to miss things.
2. **Max cycles reached**: 10 cycles have been run. If this happens, note it in the summary — the code may still have issues, but further review cycles are hitting diminishing returns.

**Example progression:**
- Cycle 1: 4 Fix findings → apply fixes, continue
- Cycle 2: 2 Fix findings → apply fixes, continue
- Cycle 3: 0 Fix findings → first clean cycle, continue (need one more to confirm)
- Cycle 4: 0 Fix findings → second consecutive clean cycle → **stop**

If cycle 4 had found 1 issue instead, the consecutive-zero counter resets:
- Cycle 4: 1 Fix finding → apply fix, counter resets to 0, continue
- Cycle 5: 0 Fix findings → first clean cycle, continue
- Cycle 6: 0 Fix findings → **stop**

### After convergence (or max cycles)

Provide a brief summary:
- Total cycles run and whether convergence was reached
- Total findings across all cycles
- How many were valid / fixed / skipped
- Any patterns worth noting (e.g., "cycles 2 and 3 independently flagged the same error handling gap — worth keeping an eye on that pattern")
