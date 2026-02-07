---
name: codebase-auditor
description: |
  Comprehensive codebase audit skill for detecting critical bugs, implementation flaws, security vulnerabilities, and code quality issues. Use this skill when: (1) conducting a full codebase health check, (2) reviewing code for security vulnerabilities, (3) identifying performance bottlenecks, (4) assessing code quality and maintainability, (5) finding dead code or technical debt, (6) evaluating test coverage gaps, (7) analyzing dependency issues, or (8) performing pre-release audits. Language and framework agnostic. Produces structured Markdown reports with severity-classified findings.
---

# Codebase Auditor

Conduct thorough codebase audits to identify critical issues across multiple dimensions.

## Audit Workflow

### Phase 1: Discovery

1. Identify project type, languages, and frameworks used
2. Locate configuration files, entry points, and core modules
3. Map directory structure and understand architecture
4. Identify existing testing and CI/CD setup

### Phase 2: Systematic Investigation

Investigate each category using the checklists in references/. For each category:

1. Read the relevant checklist from `references/`
2. Search for patterns matching potential issues
3. Examine suspicious code sections in detail
4. Document findings with severity, location, and evidence

**Investigation order (by typical impact):**

1. **Security** - See [security-checklist.md](references/security-checklist.md)
2. **Error Handling** - See [error-handling-checklist.md](references/error-handling-checklist.md)
3. **Concurrency** - See [concurrency-checklist.md](references/concurrency-checklist.md)
4. **Performance** - See [performance-checklist.md](references/performance-checklist.md)
5. **Code Quality** - See [code-quality-checklist.md](references/code-quality-checklist.md)
6. **Testing** - See [testing-checklist.md](references/testing-checklist.md)
7. **Dependencies** - See [dependencies-checklist.md](references/dependencies-checklist.md)
8. **Configuration** - See [configuration-checklist.md](references/configuration-checklist.md)

### Phase 3: Report Generation

Generate a Markdown report using the template in [assets/report-template.md](assets/report-template.md).

**Severity Classification:**

| Severity | Criteria |
|----------|----------|
| Critical | Immediate security risk, data loss, or system failure |
| High | Significant bugs, security issues, or major performance problems |
| Medium | Code quality issues, potential bugs, or moderate performance impact |
| Low | Minor improvements, style issues, or optimization opportunities |

## Output Guidelines

- Include file paths with line numbers for all findings
- Provide code snippets showing the issue
- Suggest specific fixes where possible
- Prioritize findings by severity
- Group related issues together
- Include statistics summary at end
