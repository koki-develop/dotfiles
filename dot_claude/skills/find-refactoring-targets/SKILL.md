---
name: find-refactoring-targets
description: |
  Scan the codebase to identify refactoring candidates — code that works correctly but would benefit from structural improvement. Use this skill when the user asks to find refactoring targets, code smells, cleanup opportunities, structural improvements, or wants to improve code maintainability. Also use when the user says things like "what should we clean up", "find messy code", "technical debt scan", or "what needs refactoring". This is NOT for bug hunting or security audits — it focuses purely on code structure, readability, and maintainability.
---

# Find Refactoring Targets

Scan a codebase to identify code that works correctly but would benefit from structural improvement. The goal is to surface the highest-impact refactoring opportunities — places where a relatively small change would meaningfully improve readability, maintainability, or developer experience.

This skill produces a prioritized candidate list. It does NOT produce refactoring plans or make changes — those are separate steps the user decides on.

## Workflow

### Step 1: Understand the Project

Before scanning, build context:

1. Identify languages, frameworks, and architectural patterns in use
2. Read project-level instruction files (README, contributing guides, etc.) if present — they may describe conventions or intentional design decisions
3. Note the directory structure and module boundaries
4. Check if the user specified a target scope (e.g., "look at the `api/` directory"). If not, scan the main source directories, excluding generated code, vendored dependencies, and build artifacts

### Step 2: Scan for Candidates

Launch multiple Explore agents in parallel, each responsible for a different detection category. See [references/detection-patterns.md](references/detection-patterns.md) for the detailed checklist per category.

**Detection categories:**

| Category | What to look for |
|----------|-----------------|
| **Complexity** | Nested conditionals, long boolean chains, deeply nested control flow, functions doing too many things |
| **Duplication** | Repeated conditional logic, copy-paste code with minor variations, duplicated derivation of the same value |
| **Size** | Oversized files, oversized functions/methods/classes, large code blocks that could be decomposed |
| **Abstraction** | Inline logic that should be extracted, missing data-driven patterns (e.g., lookup tables vs. switch chains), premature or unnecessary abstractions |
| **Coupling** | Mixed concerns in a single module, tight coupling between unrelated modules, excessive parameter passing across layers |

Each agent should:
- Search for the patterns described in the detection checklist
- Open and read files that look suspicious from search results
- Record specific file paths, line ranges, and a brief description of the issue
- Assess the severity and improvement potential
- Report at most **5 findings** per category — if more are found, keep only the highest-impact ones

**Important:** Agents should focus on patterns that are genuinely problematic. Not every long function needs splitting. Not every duplication warrants a shared abstraction. Apply judgment — the question is always "would a refactoring here meaningfully improve the developer's experience when reading or modifying this code?"

### Step 3: Compile and Prioritize

Collect results from all agents and merge into a single list. Remove duplicates (different agents may flag the same code from different angles). The final report should contain **at most 15 candidates total** — if more remain after deduplication, drop the lowest-priority items.

**Prioritization criteria:**

- **Impact**: How much would fixing this improve readability/maintainability?
- **Scope**: Does this pattern appear in many places, or is it isolated?
- **Complexity of fix**: Quick wins rank higher than multi-day refactors
- **Risk**: How likely is a refactoring to introduce bugs? Lower risk ranks higher.

Assign each candidate a priority level:

| Priority | Meaning |
|----------|---------|
| **High** | Clear improvement, relatively low risk, high readability impact |
| **Medium** | Worthwhile improvement, moderate effort or risk |
| **Low** | Minor improvement, or the fix is complex relative to the benefit |

### Step 4: Present the Report

Present findings as a structured list. For each candidate:

```
### [Priority] Category: Brief title

**File:** `path/to/file.ext` (lines X-Y)
**Issue:** 1-2 sentence description of the structural problem
**Example:** A brief code snippet or description showing the pattern
**Suggested approach:** 1 sentence on how to fix it (not a full plan)
```

Group by priority (High first), then by category within each priority level.

End with a summary:
- Total candidates found per priority level
- Suggested starting point (which candidate to tackle first and why)

## Guidelines

- **Respect project conventions.** If the project intentionally uses a pattern — whether documented or consistently applied throughout the codebase — don't flag it as a smell.
- **Quality over quantity.** A report with 5 high-impact candidates is more useful than one with 50 minor nitpicks. If you find many issues in the same category, group them and highlight the worst example.
- **Be specific.** "This file is too long" is not helpful. "This 400-line module handles parsing, validation, and serialization — the validation logic (lines 120-250) could be extracted into its own module" is helpful.
- **Consider the blast radius.** A refactoring that touches 1 file is safer than one that touches 20. Note this in the assessment.
- **Don't flag test files** unless they have structural issues that make them hard to maintain (e.g., massive test setup duplication). Test files are allowed to be verbose.
