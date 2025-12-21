---
description: Compare CLAUDE.md with the codebase and update CLAUDE.md as needed
allowed-tools: Read, Edit
---

# CLAUDE.md Sync Task

Compare the current state of the codebase with the contents of CLAUDE.md, identify any discrepancies, and update CLAUDE.md as needed.

## Current CLAUDE.md Contents

@CLAUDE.md

## Items to Check

Investigate the codebase from the following perspectives to identify discrepancies with CLAUDE.md:

### 1. Project Structure
- Does the directory structure match what's documented in CLAUDE.md?
- Have any new directories or files been added?
- Have any directories or files been removed?

### 2. Tech Stack & Dependencies
- Check dependency files (package.json, requirements.txt, Cargo.toml, etc.)
- Framework and library versions in use
- Newly added dependencies

### 3. Development Commands & Scripts
- Scripts section in package.json
- Makefile and other build scripts
- Do available commands match what's documented in CLAUDE.md?

### 4. Configuration Files
- Environment variable settings (.env.example, etc.)
- Configuration file structure and required fields

### 5. Coding Conventions & Patterns
- Patterns used in actual code
- Linter/formatter settings (.eslintrc, .prettierrc, pyproject.toml, etc.)

### 6. Testing
- How to run tests
- Test file locations

## Output Format

1. **Report Discrepancies**: List discovered discrepancies as bullet points
2. **Update CLAUDE.md**: If discrepancies exist, update CLAUDE.md immediately
3. **Update Summary**: Briefly report what was changed

## Notes

- Do not add unnecessary information (keep CLAUDE.md concise)
- Do not change existing documentation that is correct
- Report changes in order of importance
- Also propose removing items from CLAUDE.md that no longer exist in the codebase
