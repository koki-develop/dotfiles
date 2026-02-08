---
name: validate-plan
description: Validate the accuracy and quality of plans created by Claude Code. Checks whether a plan is self-contained, deterministic, executable, and accurate against the actual codebase. Use before approving a plan.
argument-hint: <plan-file-path>
context: fork
allowed-tools: Read, Glob, Grep
---

# Plan Validation Skill

Validate the accuracy and quality of a given plan file.

## Input

- Plan file path: $ARGUMENTS

## Validation Criteria

Validate the plan from the following four perspectives.

### 1. Self-Containedness

Plans are handed off to a separate execution session with no access to the planning conversation. Verify that all information necessary for execution is contained within the plan itself.

Information that must be present:
- Exact file paths to read, create, edit, or delete
- Referenced code snippets, type definitions, and interface signatures
- External information sources (documentation URLs, API references, etc.)
- Specific configuration values, environment variables, or parameters
- Constraints, edge cases, and decisions made during planning

### 2. Determinism

The plan must be a linear, unambiguous sequence of instructions. Verify that no alternative options, conditional branches, vague choices, or hedging language remains.

### 3. Executability

Verify that each step specifies exactly one concrete action and is detailed enough to execute without additional context.

### 4. Accuracy

Verify that information referenced in the plan matches the actual codebase.

- Use `Glob` to confirm file paths exist (excluding files explicitly marked as new)
- Use `Read` to compare quoted code snippets against actual file contents
- Use `Grep` to verify type definitions and function signatures

## Execution Steps

1. Read the plan file
2. Extract all referenced file paths and code snippets
3. Validate against each of the four criteria
4. Report the results

## Output Format

Report results in the following format:

```
## Plan Validation Report

### Target
- File: [path]
- Steps: [N]

---

### 1. Self-Containedness: ✅ / ⚠️ / ❌
[Findings and specific issues]

### 2. Determinism: ✅ / ⚠️ / ❌
[Findings and specific issues (with quotes from the plan)]

### 3. Executability: ✅ / ⚠️ / ❌
[Findings and specific issues]

### 4. Accuracy: ✅ / ⚠️ / ❌
[File path and code snippet verification results]

---

### Overall Verdict: ✅ Approved / ⚠️ Revisions Recommended / ❌ Revisions Required
[Summary of findings and required fixes]
```

## Verdict Criteria

- **✅ Approved**: No issues found across all four criteria
- **⚠️ Revisions Recommended**: No critical issues, but room for improvement
- **❌ Revisions Required**: Critical issues found in one or more criteria

## Notes

- The plan's strategic validity (whether the approach itself is correct) is out of scope. This skill only validates description quality.
- Quoted code snippets with minor whitespace or formatting differences are not flagged.
- Issues must include quotes from the relevant part of the plan.
