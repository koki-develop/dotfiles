# Global Instructions

This document defines mandatory rules and prohibited actions for Claude Code.

---

## MUST DO (Required Actions)

### Planning
- Plans MUST be fully self-contained and include ALL information necessary for task execution. Plans are handed off to a separate execution session with no access to the planning conversation—any information not written in the plan will be lost. Treat the plan as the sole source of truth.
- The plan MUST explicitly include:
  - Exact file paths to read, create, edit, or delete
  - Relevant code snippets, type definitions, and interface signatures referenced during investigation
  - External information sources (documentation URLs, API references, etc.) consulted during research
  - Specific configuration values, environment variables, or parameters required
  - Step-by-step implementation instructions detailed enough for execution without additional context
  - Any constraints, edge cases, or decisions made during the planning phase
- Do NOT rely on prior conversation context or assume the implementer has access to previously discussed information. Everything must be written into the plan.
- The final plan MUST be deterministic: every step specifies exactly one concrete action. ALL decisions and trade-offs MUST be resolved with the user BEFORE writing the plan. The plan must never contain:
  - Alternative options (e.g., "do X, or alternatively do Y")
  - Conditional branches based on unresolved decisions (e.g., "if we use approach A... if approach B...")
  - Vague or deferred choices (e.g., "choose an appropriate method")
  - Hedging language that leaves implementation details open (e.g., "we could", "consider using", "optionally")
  The finalized plan must read as a linear, unambiguous sequence of instructions executable without any further judgment calls.
- After writing a plan, you MUST run the `validate-plan` skill (`/validate-plan <plan-file-path>`) before presenting the plan to the user for approval. If the validation result is not "✅ Approved", you MUST revise the plan to address all reported issues and re-run validation until it passes. Do NOT present an unvalidated or failed plan to the user.

### Decision Making
- When multiple valid approaches exist for solving a problem, you MUST present all options to the user with clear explanations and wait for their explicit decision before proceeding. Never make independent choices when alternatives exist.

### Problem Solving
- When encountering errors or getting stuck, you MUST first investigate and research the latest information (official documentation, release notes, known issues) using web search or other available tools to understand the root cause before attempting solutions. DO NOT blindly attempt trial-and-error fixes.

### Git Operations
- When executing `git add`, you MUST always specify individual file paths explicitly.
  - Example: `git add src/index.ts` `git add README.md`
- When executing `git push`, you MUST always specify the remote and branch name explicitly.
  - Example: `git push origin main`

### File Operations
- When creating, editing, or deleting files, you MUST use the Task tool with `subagent_type=file-editor`. This agent strictly follows given instructions and asks for confirmation when instructions are unclear or additional edits seem necessary.
- When there are multiple independent edit tasks with different contexts, launch separate file-editor agents in parallel for each task to maximize efficiency.

### Tool Usage
- When using the Task tool with `subagent_type=Explore`, you MUST specify `model: "sonnet"` to use the Sonnet model for efficiency.

---

## MUST NOT (Prohibited Actions)

### Git Operations
- **NEVER** use `git add .`, `git add --all`, or `git add -A`.
- **NEVER** use `git push` without specifying remote and branch.

### File Operations
- **NEVER** use `Edit`, `Write`, or `NotebookEdit` tools directly.

### Planning
- **NEVER** include unresolved alternatives, conditional branches, or ambiguous choices in a finalized plan. All decisions must be made before the plan is written.
- **NEVER** present a plan to the user that has not passed `validate-plan` validation. All plans must be validated and receive "✅ Approved" before requesting user approval.
