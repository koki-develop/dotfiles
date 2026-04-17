---
name: iterate
description: Generic convergence-based iteration loop — repeats a verify-validate-fix cycle until the work stabilizes (2 consecutive cycles with zero actionable findings, max 10 cycles). Use this skill whenever the user wants to iteratively refine work through repeated independent verification passes, such as "fact-check this document thoroughly", "review and fix the accessibility of these pages until clean", "keep checking the translations until accurate", or any request that implies convergence-based refinement where a single fix pass isn't enough because fixes can introduce new issues or reveal previously hidden problems. Also trigger on /iterate. This is the go-to skill for any "verify independently, validate, fix, repeat until stable" workflow.
---

# Iterate

A convergence-based iteration loop. You run a verify-validate-fix cycle repeatedly until the work stabilizes — defined as **2 consecutive cycles where zero findings are classified as "Fix"** in the validation phase, up to a maximum of 10 cycles.

## Why this exists

Many tasks benefit from repeated independent passes: fact-checking documents, reviewing translations, auditing accessibility, verifying compliance, etc. A single pass catches obvious issues but misses subtler ones. Each fix can also introduce new issues or reveal problems that were previously hidden. Running until convergence means you stop exactly when the work is genuinely clean — not too early, not too late.

This skill is designed for tasks where **the verification itself is subjective or complex enough that a single pass can't be trusted** — where independent fresh eyes catch different things each time. It's not for tasks with deterministic pass/fail outcomes (like "run tests until they pass"), which are better handled with a simple fix loop.

## Before starting

Parse the user's request to identify two things:

1. **Verification instruction** — What should the subagent check, and how? This becomes the core of the subagent prompt each cycle. Examples:
   - "Fact-check this technical document against official documentation and source code"
   - "Review these pages for accessibility violations against WCAG 2.1 AA"
   - "Check the Japanese translations for accuracy, naturalness, and consistency"
   - "Verify that all API examples in the docs actually work as described"

2. **Scope** — What files, directories, or artifacts are being iterated on.

If either is ambiguous, ask the user before starting. Don't guess the verification instruction — it's the most important input, and it directly determines the quality of each subagent's work.

Confirm your understanding with the user briefly before starting.

## The Iteration Loop

### Cycle N (repeat until convergence or max 10 cycles)

#### Phase 1: Verify (subagent)

**Always spawn a fresh subagent for verification.** The parent agent's context accumulates the full conversation history — previous cycles' findings, fixes, validation judgments — making truly independent verification impossible from the parent. A subagent starts with a clean context every time, which is the only way to guarantee each cycle is a genuinely independent check.

Compose a prompt for the subagent that includes:
- The user's verification instruction (what to check and how)
- The scope (which files/artifacts to examine)
- An instruction to report a list of specific, actionable findings

**Never include in the subagent prompt:** previous cycles' findings, fix history, skip reasons, or any other context from earlier cycles. The subagent sees only the current state of the work and the verification instruction — nothing else. This independence is what makes the convergence signal meaningful.

#### Phase 2: Validate (parent context)

The subagent's job was to find issues. Your job now is to ruthlessly verify whether those issues are real. Subagents are useful for independent discovery, but they hallucinate, misread code, and make confident-sounding claims that are flat-out wrong. **Never take a subagent's findings at face value.**

For each finding:

1. **Verify accuracy** — Go to the primary source yourself. Read the actual file, check the actual URL the subagent referenced, consult the actual documentation. If the subagent says "function X doesn't handle null" — read function X. If the subagent says "this contradicts the official docs at URL Y" — fetch URL Y and confirm. If the subagent cites a source but you don't verify that source, you haven't validated anything — you've just added a layer of unchecked trust. The whole point of this phase is to catch the subagent's mistakes, so skipping source verification defeats the purpose.
2. **Assess severity** — Is this a real problem or noise? Would ignoring it cause actual harm?
3. **Judge necessity** — Does this need fixing now, or is it a false positive / nitpick?

Classify each finding as:
- **Fix** — Genuine issue, will address now
- **Skip** — Not accurate, not worth changing, or out of scope

Report the validation results to the user before proceeding. Keep it brief — a short list showing what you'll fix and what you're skipping (with a reason for each skip).

#### Phase 3: Fix

Apply fixes for everything classified as "Fix". Keep changes minimal and focused.

After fixing, briefly confirm what was changed.

---

Then move to the next cycle. The next verification spawns a fresh subagent that sees only the updated state — it has no memory of what previous cycles found or fixed.

## Convergence Tracking

Track the number of "Fix" findings per cycle. The process ends when **either** condition is met:

1. **Convergence**: 2 consecutive cycles produce 0 "Fix" findings. One clean pass isn't enough — a second independent pass confirming zero issues provides confidence that the work is genuinely clean, not that the verification just happened to miss something.
2. **Max cycles reached**: 10 cycles have been run. If this happens, note it in the summary — the work may still have issues, but further cycles are hitting diminishing returns.

**Example progression:**
- Cycle 1: 3 Fix findings → apply fixes, continue
- Cycle 2: 1 Fix finding → apply fix, continue
- Cycle 3: 0 Fix findings → first clean cycle, continue (need confirmation)
- Cycle 4: 0 Fix findings → second consecutive clean cycle → **stop**

If cycle 4 had found 1 issue instead, the consecutive-zero counter resets:
- Cycle 4: 1 Fix finding → apply fix, counter resets to 0, continue
- Cycle 5: 0 Fix findings → first clean cycle, continue
- Cycle 6: 0 Fix findings → **stop**

## After Convergence (or max cycles)

Provide a brief summary:
- Total cycles run and whether convergence was reached
- Total findings across all cycles (Fix + Skip)
- How many were fixed vs. skipped
- Any recurring patterns worth noting (e.g., "cycles 2 and 4 both independently flagged the same section as inaccurate — might need a more fundamental rewrite")
