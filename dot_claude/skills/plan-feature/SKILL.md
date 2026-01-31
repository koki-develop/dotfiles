---
name: plan-feature
description: Create an implementation plan for a feature
argument-hint: [Brief description of the feature to implement]
---

# Feature Implementation Planning

## Workflow

Follow these steps to create an implementation plan.

### 1. Clarify Requirements

Confirm the following with the user:
- Purpose and background of the feature
- Expected behavior and use cases
- Distinction between required and optional requirements
- Known constraints and considerations

### 2. Codebase Investigation

**Explore related code:**
- Existing similar features or related components
- Patterns and conventions in use
- Files that may need modification
- Tests and documentation that may be affected

### 3. Technical Research

Research the following as needed:
- Documentation for libraries or APIs to be used
- Best practices and implementation patterns
- Security considerations

### 4. Create the Implementation Plan

Based on the investigation, create a plan that includes:

#### Plan Contents

1. **Overview**
   - Purpose of the feature
   - Key technical approach

2. **Implementation Steps**
   - Concrete steps (in clear order)
   - Files to be modified or created in each step
   - Dependencies between steps

3. **File Change Summary**
   - Files to be created
   - Files to be modified
   - Summary of changes

4. **Considerations**
   - Potential risks and challenges
   - Edge cases
   - Performance impact

### 5. Present the Plan

Present the created plan to the user and confirm:
- Whether there are any issues with the plan
- Whether there are additional considerations
- Whether priority or order adjustments are needed

## Important Rules

- **Do not start implementation**: This command only creates the plan
- **Always confirm**: Ask the user about any unclear points
- **Respect existing patterns**: Follow the project's existing conventions and patterns
- **Proceed incrementally**: Break large features into smaller steps
