---
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr comment:*), Bash(gh pr review:*)
description: Review a Renovate Pull Request and assess merge safety
---

## Context

- PR Number: $ARGUMENTS

## Your task

Conduct a detailed review of the Renovate Pull Request and assess the safety of merging.

**IMPORTANT**: Do NOT run local testing or build commands. This review should be based solely on static analysis of changes, release notes, and impact assessment.

### Execution Steps

1. **PR Analysis**
   - Get PR details with `gh pr view <PR_NUMBER>`
   - Get PR diff with `gh pr diff <PR_NUMBER>`
   - Identify the target package and version changes

2. **Release Content Investigation**
   - Review release notes and CHANGELOG of the target package
   - Understand breaking changes, new features, and bug fixes
   - Check for security-related fixes

3. **Codebase Impact Analysis**
   - Search for usage locations of the target package in the current codebase
   - Verify necessity of code modifications due to API changes
   - Investigate impact on other packages due to dependency changes
   - Check impact on configuration files and environment settings

4. **Safety Assessment (3 levels)**
   - **Safe**: Backward compatibility is maintained, can be merged immediately
   - **Needs Manual Migration**: Manual code modifications or configuration changes required
   - **Not Safe**: Significant breaking changes or security risks

5. **Post Review Results as Comment**
   - Comment detailed analysis results with `gh pr comment <PR_NUMBER> --body '## Renovate PR Review Results ...'`
   - Include investigation content, impact scope, safety assessment, and recommended actions

6. **Approval Process**
   - Execute `gh pr review <PR_NUMBER> --approve` only when safety assessment is "Safe"

### Report Format

```markdown
## Renovate PR Review Results

### ⚖️ Safety Assessment: [✅ Safe | ⚠️ Needs Manual Migration | ❌ Not Safe]

### 🔍 Release Content Analysis
- [Major changes]
- [Breaking Changes]
- [Security fixes]

### 🎯 Impact Scope Investigation
- [Usage location identification results]
- [Required modification work]
- [Impact on other dependencies]

### 💡 Recommended Actions
- [Specific response methods]

### 🔗 Reference Links
- [Release Notes]
- [CHANGELOG]
```
