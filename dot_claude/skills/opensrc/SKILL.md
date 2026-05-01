---
name: opensrc
description: Read third-party package source code via the `opensrc` CLI when investigating internal implementations of dependencies. ALWAYS invoke this skill before reading library/package source — including phrasings like "how does <pkg> work internally", "I want to read the source of <pkg>", "investigate the implementation of <pkg>", "let me check what <pkg> does under the hood", "git clone <repo> to read it", "look inside <pkg>", "<pkg> の実装を確認したい", "<pkg> のソースコードを調査", "<pkg> の中身を見たい", or any task that requires reading code from an npm / PyPI / crates.io package or a public GitHub/GitLab/Bitbucket repo. Use this skill instead of `git clone`, instead of asking the user to paste source, and instead of guessing from memory. Also use it when fetching only the path matters, e.g. setting up a search target for `rg` / `find` / `cat` across a dependency.
allowed-tools: Bash(opensrc:*), Bash(rg:*), Bash(cat:*), Bash(find:*), Bash(ls:*), Bash(head:*), Bash(tail:*), Bash(wc:*)
---

# Reading dependency source with opensrc

`opensrc` is a CLI that fetches a package's source code, shallow-clones it at the correct version tag, and caches it under `~/.opensrc/`. The cache is shared across all projects, so the same package is only fetched once per version.

The point of this skill: **when investigating how a third-party library actually works, do not git-clone, do not browse GitHub manually, do not guess from memory** — use `opensrc path` to get a real local path and read the source directly with normal Unix tools.

## Why this skill is mandatory for source investigation

Reading the source is the only way to answer questions about internal behavior reliably. Types tell you the shape, docs tell you the intent, but only the source tells you what actually happens. `opensrc` makes this fast: one command resolves the package, picks the right version, caches it, and returns a path you can pipe into anything.

Skipping this and answering from prior knowledge produces stale or hallucinated answers — library internals change between versions, and your memory of a package's source might be wrong, partial, or for a different version than the user has installed.

## Core pattern

`opensrc path <pkg>` prints the absolute path of the cached source on stdout (progress goes to stderr). Compose it inside `$(...)` and chain with `rg` / `cat` / `find`:

```bash
SRC=$(opensrc path zod)
rg "class ZodError" "$SRC"
cat "$SRC/src/types.ts"
find "$SRC" -name "*.test.ts"
```

Capture the path into a variable once, then reuse it — re-running `opensrc path` is cheap (cache hit) but stuffing it into every command clutters the trace.

## Specifying the package

| Source | Syntax | Example |
| --- | --- | --- |
| npm (default) | `<name>` or `npm:<name>` | `opensrc path zod` |
| PyPI | `pypi:<name>` | `opensrc path pypi:requests` |
| crates.io | `crates:<name>` | `opensrc path crates:serde` |
| GitHub | `<owner>/<repo>` | `opensrc path facebook/react` |
| GitLab | `gitlab:<owner>/<repo>` | `opensrc path gitlab:gitlab-org/gitlab` |
| Bitbucket | `bitbucket:<owner>/<repo>` | `opensrc path bitbucket:atlassian/python-bitbucket` |

Multiple packages in one call return paths separated by whitespace, ready to feed into `rg` etc.:

```bash
rg "useState" $(opensrc path react react-dom)
```

## Specifying the version

```bash
opensrc path zod@3.22.0           # exact version
opensrc path pypi:flask@3.0.0     # PyPI version
opensrc path owner/repo@v1.0.0    # git tag
opensrc path owner/repo#main      # branch / commit ref
```

For npm, when the user is asking about a package they have installed, **prefer letting opensrc resolve the version from the lockfile** rather than guessing latest. opensrc reads `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock` from the working directory automatically. Pass `--cwd <path>` if you are running from outside the user's project root:

```bash
opensrc path zod --cwd /Users/me/project
```

For PyPI / crates.io / repos, lockfile resolution is not supported — pass an explicit version when it matters, otherwise latest is used.

## Recommended workflow for source investigation

1. **Identify what you actually need to know.** A clear question ("where is `parse` defined and what does it do on invalid input?") shapes which files to read. Vague exploration burns time.
2. **Fetch the path.** `SRC=$(opensrc path <pkg>)` — pin a version with `@` if the question is version-specific.
3. **Get oriented before diving in.** Read the manifest (`package.json` / `Cargo.toml` / `pyproject.toml`) to find the entry point, then `ls "$SRC"` and look at the README. Two minutes here saves twenty minutes of grepping the wrong subtree.
4. **Locate the relevant code.** `rg "<symbol>" "$SRC"` to find definitions and call sites. For large packages, narrow with `-t ts`, `--glob '!**/dist/**'`, or scope to a subdirectory.
5. **Read the implementation.** `cat` files, follow imports. Don't stop at the first match — verify by checking a test in `**/*test*` or `**/__tests__/**` to confirm the behavior matches your reading.
6. **Cite file paths in the answer.** Use `<cache-path>:<line>` format (e.g. `~/.opensrc/repos/github.com/colinhacks/zod/.../src/types.ts:42`) so the user can jump there directly.

## Cache management

| Goal | Command |
| --- | --- |
| List what is cached | `opensrc list` (or `--json` for machine-readable) |
| Drop one package | `opensrc remove <pkg>` |
| Drop one repo | `opensrc remove <owner>/<repo>` |
| Wipe everything | `opensrc clean` |
| Wipe by registry | `opensrc clean --npm` / `--pypi` / `--crates` |
| Wipe only repos | `opensrc clean --repos` |
| Wipe only packages | `opensrc clean --packages` |

The cache lives at `~/.opensrc/` by default; override with `OPENSRC_HOME`. **Do not run `clean` as part of investigation** — it deletes the user's cached sources from other projects too. Only suggest it if the user explicitly asks to free disk space.
