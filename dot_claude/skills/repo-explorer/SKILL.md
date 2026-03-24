---
name: repo-explorer
context: fork
description: >
  Clone and explore external GitHub repositories locally for source code investigation.
  Use this skill whenever you need to look at the source code of an external project — whether it's
  understanding a library's internal implementation, tracing a bug in a dependency, checking how a
  specific API or feature works under the hood, or verifying behavior from source. If you're about
  to reach for WebFetch or `gh api` to read source files, use this skill instead — cloning locally
  is far more efficient and gives you full access to the codebase with Grep, Glob, and Read.
  Trigger on any request involving: inspecting OSS internals, reading dependency source code,
  understanding how a library/framework feature is implemented, checking upstream code for a bug,
  or any "how does X work internally" question about an external project.
---

# Repo Explorer

Investigate external GitHub repositories by cloning them locally and using standard file-exploration tools (Read, Grep, Glob). This is drastically faster and more thorough than fetching files one-by-one via API.

## When to use this

- "このライブラリの内部実装を見たい"
- "依存パッケージのソースを確認したい"
- "OSSのバグの原因を追いたい"
- "この機能が内部的にどう動いてるか知りたい"
- Any time you'd otherwise use WebFetch or `gh api` to read source files

## Workflow

### 1. Identify the repository

Determine the GitHub repository to investigate. The user might provide:
- A direct repo URL (`https://github.com/org/repo`)
- A package name (e.g., `zod`, `next`, `lefthook`) — resolve it to a GitHub repo
- A vague reference ("the library we're using for X") — check `package.json`, `go.mod`, `Cargo.toml`, etc. in the current project to find the actual package, then resolve to its repo

For package name → repo resolution:
- **npm**: check `package.json` for the exact package, then look up the repo via `npm view <pkg> repository.url` or the package's homepage
- **Go**: the import path usually maps directly to the repo
- **Other ecosystems**: use the package manager's metadata to find the source repo

### 2. Clone the repository

Clone into a temporary directory under `/tmp/claude/repos/`. Reuse an existing clone if one is already there.

```bash
REPO_DIR="/tmp/claude/repos/<org>--<repo>"

if [ -d "$REPO_DIR" ]; then
  echo "Already cloned, reusing: $REPO_DIR"
else
  git clone <clone-flags> "git@github.com:<org>/<repo>.git" "$REPO_DIR"
fi
```

**Clone strategy** — pick based on what the investigation needs:
- **Default (source reading only)**: `git clone --depth 1` — fast, small, gets latest code
- **Need git history** (blame, log, bisect): `git clone` — full clone, takes longer but gives complete history
- **Specific branch/tag**: `git clone --depth 1 --branch <ref>` — when investigating a particular version

The clone might require sandbox override since `github.com` isn't in the default network allowlist. That's expected.

### 3. Investigate

Now explore the cloned repo using standard tools. This is the core of the skill — you have the entire codebase locally, so use it effectively.

**Orientation first**: Before diving into specifics, get a quick lay of the land.
- `ls` the repo root to understand project structure
- Check for a `src/`, `lib/`, `packages/`, or `internal/` directory — that's usually where the interesting code lives
- Skim the README if the project structure isn't obvious

**Finding what you're looking for**:
- Use **Glob** to find files by name pattern (e.g., `**/*transform*.ts`)
- Use **Grep** to search for specific identifiers, function names, error messages, or patterns
- Use **Read** to examine specific files once you've found them

**Tracing code flow**: When understanding how a feature works internally:
1. Find the public API entry point (exported function, class, or method)
2. Follow the call chain inward — read each function and trace what it calls
3. Note key data structures and how they're transformed
4. If there's a relevant test file, read it — tests often reveal intended behavior and edge cases

**Using git history** (when cloned with full history):
- `git log --oneline -20 -- <path>` to see recent changes to a specific file
- `git blame <file>` to see who changed what and when
- `git log --all --oneline --grep="<keyword>"` to find commits related to a topic

### 4. Report findings

Summarize what you found in a way that directly answers the user's question. Include:
- File paths and line numbers for key code locations (so the user can follow up)
- Relevant code snippets where they help understanding
- How the pieces fit together (the "story" of how the code works)

Don't just dump raw code — explain what it does and why it matters in the context of the user's question.
