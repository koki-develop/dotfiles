---
name: sync-claude-md
description: Compare all CLAUDE.md and AGENTS.md files with the codebase and update them as needed
allowed-tools: Read, Edit
---

# CLAUDE.md / AGENTS.md Sync Task

Compare the current state of the codebase with the contents of all CLAUDE.md and AGENTS.md files in the project, identify any discrepancies, and update them as needed.

## Discovery

First, discover all CLAUDE.md and AGENTS.md files in the project using the glob patterns `**/CLAUDE.md` and `**/AGENTS.md`. Each discovered file should be read and checked against its relevant scope in the codebase.

## Items to Check

Investigate the codebase from the following perspectives to identify discrepancies with CLAUDE.md / AGENTS.md:

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
- Do available commands match what's documented in CLAUDE.md / AGENTS.md?

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
2. **Update CLAUDE.md / AGENTS.md**: If discrepancies exist, update the relevant file(s) immediately
3. **Update Summary**: Briefly report what was changed

## Notes

- Do not add unnecessary information (keep CLAUDE.md / AGENTS.md concise)
- Do not change existing documentation that is correct
- Report changes in order of importance
- Also propose removing items from CLAUDE.md / AGENTS.md that no longer exist in the codebase
