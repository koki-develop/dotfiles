---
name: audit
description: |
  Audit an entire project for stale comments and documentation, implementations that drift from the declared architecture, bugs, security risks, and blind spots, then report every confirmed problem with a recommended action. Read-only, and heavy — it runs a many-agent Workflow. Prefer /code-review for a diff.
argument-hint: "[--light|--deep] [path]"
disable-model-invocation: true
---

# audit

Read-only. Never edit a file, never propose a command that would. Running a command is confined to Ground truth; every other phase reads.

## Procedure

1. **Recon** — build the inventory inline: every tracked file with its line count. Do not delegate it
2. Write the script to the spec below and run it with `Workflow({script, args: inventory})`. `meta.phases` must title the phases exactly as the script does
3. Report in chat as prose

## Scope

`$ARGUMENTS` may carry a path; without one, the whole repository.

Everything tracked is in scope — tests, fixtures, CI config, scripts, documentation, vendored dependencies, and generated output alike. Risk ranking in Partition decides what gets read deeply.

## What counts as a finding

Exactly four things:

1. A statement in a comment or document that is factually false about the current code
2. A defect with a concrete failure scenario — the input, the state, the wrong result
3. A violation of a rule the project declares for itself, cited to where it declares it
4. A security risk with a plausible attacker path

## Scale

| Flag | Lens groups per slice (high / normal / low) | Inspect cap | Verify cap | Gap agents | Report cap |
|---|---|---|---|---|---|
| `--light` | 2 / 1 / 1 | 16 | 8 | 0 | 8 |
| (default) | 4 / 2 / 1 | 40 | 20 | 4 | 15 |
| `--deep` | 4 / 3 / 2 | 80 | 40 | 8 | 25 |

A default run is roughly 120 agents; say so before starting on a large repository. Every cap or collapse that drops work is `log()`ed and named in the coverage statement.

Baseline, Coverage critic, and Synthesize run on the default model at high effort; Dedupe and Triage on sonnet at low; every other phase on sonnet at medium. Slicing, deduplication keys, lens allocation, and vote adjudication are plain JS, not agents.

## Pipeline

```
Recon (inline) → Baseline → ║ → Partition → ║ → ┬ Inspect
                                                └ Global sweep
  → ║ → Dedupe → [Verify → Triage] → ║ → Coverage critic → gap round → Synthesize
```

Dedupe needs the whole pool in hand before merging duplicates and allocating the verify cap. Verify and Triage share no barrier — run them as a `pipeline()` keyed by theme, assigning each `agent()` its phase through `opts.phase`, since `phase()` races once stages overlap.

### Baseline

Three agents in parallel, producing the standard everything downstream is judged against:

- **Declared** — the architecture, conventions, and invariants the project claims for itself in its own prose, each cited to where it says so
- **Actual** — the real module boundaries, dependency direction, and error-handling patterns, as the code implements them
- **Ground truth** — the project's own checks, run and read as evidence, returning each diagnostic as a finding with none dropped or summarized. `TODO|FIXME|HACK|XXX` markers and credential-shaped literals come back separately, as leads for Inspect rather than findings

What Ground truth may run, by flag:

| Flag | Runs |
|---|---|
| `--light` | The analyzers the project already configures, in check-only mode |
| (default) | Those, plus the declared type or compile check — `tsc --noEmit`, `go vet`, `cargo clippy` |
| `--deep` | Those, plus the declared test command |

Only commands the project declares for itself — in its configuration, its task runner, or its CI — and only in the form it declares them. Never install a tool. Never run a project script for anything past those checks: a script named for setup, apply, deploy, or update mutates the machine, whatever else it also does. Run each command once, one at a time, and let build artifacts be the only trace left behind; a command that would write a tracked file or reach the network is dropped instead. One that cannot run is a stated coverage limit, not a finding.

Ground truth findings enter the pool pre-confirmed, bypassing Verify. Where Declared and Actual disagree, the gap is a seed finding for `drift`.

### Partition

A slice is a coherent unit — a directory, a module, a related set of scripts — not an alphabetical chunk. Target 25 files per slice, cap 40; past that, keep the 40 highest-risk and give the remainder one **sweep slice** read at inventory level — paths, names, and sizes, not contents. A file too large for one pass becomes its own slice, split into ~1500-line ranges overlapping by ~50.

Score each on blast surface, churn, and opacity, then tier by rank: top quartile `high`, bottom quartile `low`, the rest `normal`.

### Inspect

One agent per (slice, lens group), each given the Baseline output. Judge against **this project's declared rules**, not general best practice.

| Group | Looks for |
|---|---|
| `defect` | Wrong logic, unhandled edge cases, error paths that swallow or mislabel, tests that assert nothing |
| `security` | Injection, unvalidated input, secrets in tracked files, over-broad permissions, unsafe defaults |
| `drift` | Comments and documentation that contradict the code, implementations that violate a declared rule |
| `waste` | Unreachable code, unused exports and settings, duplicated logic, operations that are not idempotent or that leave state half-applied |

How many groups a slice gets comes from the scale table by tier; which ones comes from rotating through the four, so each covers a comparable share of slices. Every slice keeps at least one — absorb the inspect cap by cutting depth from the top tier down, and if one group per slice still exceeds it, fold the lowest-risk slices into the sweep slice rather than leave one silently unread.

Every finding carries `path`, `startLine`, `endLine`, a verbatim quote of the code as it actually is, its lens group, a severity, and a concrete failure scenario. Quoteless findings are discarded before Dedupe. A finding resting on external behavior names that thing and its version.

Severity is calibrated against consequence, not against how interesting the finding is:

- `critical` — exploitable, data-destroying, or already broken in production
- `high` — a defect with a realistic trigger, or documentation that will actively mislead
- `medium` — a real defect on an unlikely path, or drift with limited reach
- `low` — accurate, worth knowing, no urgency

### Global sweep

One agent per question, working from the inventory and targeted `grep` rather than a slice:

- Does every command, path, and file named in the documentation exist and behave as described?
- Does the actual dependency direction match the declared layering?
- What logic exists in three places that should exist in one?
- Which configuration keys, environment variables, flags, and exported symbols are referenced nowhere?
- What does CI verify, and what does it silently not verify?

### Dedupe

Key on `path` plus overlapping line range plus lens group; one agent merges the semantic duplicates that survive and normalizes severity across the pool, having no stake in any finding. Select up to the verify cap from what is not already confirmed, **per lens group, round-robin** — a global severity sort lets `security` take the whole quota. The rest pass to Synthesize as `unchecked`.

### Verify

Independent voters per finding, each cast as trying to refute it: three votes for `critical` and `high`, two for `medium` and `low`.

A voter settles a finding by reading, never by running the project against it. Every voter reads the cited lines first. If the quote does not match what is there, the finding is refuted as `misread` — terminally, on that one vote. Otherwise those lines are only the start: read the call sites, tests, configuration, and history the finding turns on. When it turns on how something external behaves, settle it against that thing's own authority at the version this project pins, never from memory.

Refutation categories: `misread`, `unreachable` (guarded upstream so it cannot fire), `intentional` (evidenced by documentation or by consistent practice), `out-of-scope` (taste rather than defect), `duplicate`. Every vote cites evidence. A voter that cannot reach the authority it needs returns `unresolved` — an abstention, not a refutation, and neither is a `null` from a skipped or errored agent.

```js
const valid    = verdicts.filter(v => v && !v.unresolved)
const refuting = valid.filter(v => v.refuted)
const needed   = (f.severity === 'critical' || f.severity === 'high') ? 2 : 1

if (valid.some(v => v.category === 'misread')) return 'refuted'      // terminal, one vote
if (valid.length < needed)                     return 'unverified'
return refuting.length >= needed ? 'refuted' : 'confirmed'
```

Never collapse the three outcomes: `confirmed` carries into the report, `refuted` drops to the dismissed tally, `unverified` means the votes could not decide — not a clean bill of health.

A finding refuted **only** as `intentional`, where no voter could cite documentation of that intent, becomes a `low` severity `drift` finding without re-verification.

### Triage

Group confirmed findings by theme in JS — lens group plus shared directory or root cause — capped at 8. One agent per theme, not one per finding. Each finding gets a blast radius, an effort estimate of S/M/L, and a recommended action naming the file and what to change, and any severity the evidence no longer supports is corrected.

### Coverage critic

One agent, given the slice map, lens allocation, analyzer output, and every finding, answering one question: what did this audit not look at? Fan out one Inspect agent per ranked gap up to the gap agent cap, run the results through the same Verify path on a fresh allowance equal to that cap, and merge. Gaps past the cap become stated limits.

## Report

**Synthesize** — one agent merges everything into the report structure; if it returns `null`, present the triaged findings ungrouped. Capped at the report cap.

1. **Verdict** — three or four sentences on the state of the project, worst thing first
2. **Coverage** — files audited, slices, which caps were hit, which analyzers ran and which were absent
3. **Findings** — by severity then blast radius. Each in a few lines: severity, `path:line`, what is wrong, the failure scenario, the recommended action
4. **Accounting** — findings past the cap as a count by severity and lens; `critical` and `high` findings left `unverified`, by name; refuted counts by category

Close with the agent count and the tally: extracted / deduplicated / selected / confirmed / refuted / unverified.
