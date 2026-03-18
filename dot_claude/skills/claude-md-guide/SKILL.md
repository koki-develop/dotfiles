---
name: claude-md-guide
description: >
  Fetch the latest CLAUDE.md best practices from the official documentation.
  Use this skill before creating, updating, reviewing, or improving any CLAUDE.md file.
  Trigger on requests like "I want to write a CLAUDE.md", "review my CLAUDE.md",
  "what are the CLAUDE.md best practices?", or any work involving CLAUDE.md files.
context: fork
---

# CLAUDE.md Best Practices Guide

Fetch the latest best practices from the official documentation before any CLAUDE.md-related work. This skill only retrieves and presents information — it does not create or modify any files.

## What to do

Use WebFetch to retrieve the official best practices and present them to the user. That's it.

```
URL: https://code.claude.com/docs/en/best-practices.md
Prompt: Extract ALL best practices, guidelines, and recommendations related to CLAUDE.md files. Include: what to include, what to avoid, file structure, size guidelines, team usage patterns, and any examples provided. Return the full content without summarizing.
```

Present the fetched content to the user. Do not hardcode any best practices in this skill — always treat the fetched content as the source of truth.

Creating, updating, or reviewing CLAUDE.md files is out of scope for this skill.
