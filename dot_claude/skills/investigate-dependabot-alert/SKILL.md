---
name: investigate-dependabot-alert
description: Investigate a Dependabot alert by fetching details via gh CLI, analyzing the dependency chain, identifying the update path, and assessing the impact of the update. Use when the user wants to investigate or triage a Dependabot security alert.
argument-hint: <alert-number-or-url>
allowed-tools: Bash(gh api repos/*/*/dependabot/alerts/*), Bash(gh api repos/*/*/compare/*), Bash(gh api repos/*/*/releases/tags/*), Bash(gh api repos/*/*/contents/*), Bash(gh api repos/*/*/commits/*), Grep, Glob, Read, WebFetch, WebSearch
---

# Investigate Dependabot Alert

Investigate a Dependabot security alert and assess the impact of updating the vulnerable dependency.

## Input

- Alert identifier: $ARGUMENTS
  - Accepts either an alert number (e.g., `256`) or a full URL (e.g., `https://github.com/owner/repo/security/dependabot/256`)
  - If a URL is provided, extract the owner, repo, and alert number from it
  - If only a number is provided, use the current repository's owner and repo

## Procedure

### 1. Fetch Alert Details

Use `gh api` to retrieve the alert information:

```
gh api repos/{owner}/{repo}/dependabot/alerts/{number}
```

Extract and summarize the following:
- **Package name** and ecosystem (e.g., npm, pip, maven, go, cargo, nuget)
- **Vulnerability summary** (CVE ID, GHSA ID, description)
- **Severity** (CVSS score and level)
- **Vulnerable version range**
- **First patched version**
- **Manifest path** (which lockfile/manifest is affected)
- **Dependency relationship** (direct or transitive)

Present this summary to the user before proceeding.

### 2. Check for Existing Dependabot Pull Request

Check whether Dependabot has already created a pull request to address this alert.

1. Search for related PRs created by Dependabot:
   ```
   gh pr list --repo {owner}/{repo} --author "app/dependabot" --search "{package_name}" --state all --json number,title,url,state
   ```
2. If a matching PR is found:
   - Record the PR number, URL, and state (open / closed / merged)
   - Fetch the PR diff using `gh pr diff {number} --repo {owner}/{repo}` and review:
     - What version changes are made in the lockfile
     - Whether any files other than the lockfile are modified
     - Whether the updated version meets or exceeds the patched version identified in step 1
   - Summarize the diff findings
3. If no matching PR is found, note this and proceed to the next step

### 3. Analyze Dependency Chain

Determine how the vulnerable package is used in the project.

1. Detect the package manager by inspecting the manifest path from the alert (e.g., `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `go.sum` → go)
2. Run the package manager's dependency tracing command (e.g., "why" or "dependency tree" subcommand) from the directory containing the manifest to identify the full dependency chain
   - If unsure of the exact command, check `<package-manager> help` or search the web for the latest usage
3. Document the full dependency chain from the project's direct dependency down to the vulnerable package
4. For each parent package that depends on the vulnerable package, identify:
   - What purpose the vulnerable package serves in the parent (e.g., file glob matching, path resolution, template rendering, etc.)
   - Whether the parent is a runtime dependency or a development tool (linter, test framework, build tool, etc.)

### 4. Check Direct Usage

Search the project codebase (excluding lockfiles, vendor directories, and dependency directories) to determine whether the vulnerable package is imported or used directly.

- Use `Grep` to search for import/require/use statements referencing the package
- Use `Grep` to search for any direct usage of the package's API

Clearly state whether the package is used directly or only as a transitive dependency.

### 5. Assess Indirect Usage Impact

Even when the vulnerable package is not imported directly in project code, it may still affect the project through its parent packages. This step investigates the actual behavioral impact of the version change on those parent packages.

1. **Fetch version diff**: Use `gh api` to retrieve the commit comparison between the current and target versions of the vulnerable package (e.g., `gh api repos/{owner}/{repo}/compare/v{current}...v{target}`). Identify all changes, focusing on:
   - Behavioral changes to core functionality (e.g., matching logic, parsing rules, output format)
   - New default values or configuration options that alter existing behavior
   - Bug fixes that correct previously incorrect behavior (note: these are intentional changes but may still affect dependents)
   - Changes to internal APIs that parent packages may rely on

2. **Analyze impact on each parent package**: For each parent package identified in step 3, assess whether the changes in the vulnerable package could affect the parent's behavior:
   - Map each change to the parent's usage pattern (e.g., "glob pattern matching changed → ESLint's file matching could be affected")
   - Consider whether the parent's typical input patterns would trigger the changed behavior
   - Check if the parent package has pinned or constrained internal usage that would isolate it from the change

3. **Determine scope of indirect impact**:
   - Does the parent package affect runtime behavior or only development tooling?
   - If it affects development tooling, which workflows are impacted? (e.g., linting, testing, building)
   - Is there a simple way to verify no regression? (e.g., running lint, running tests)

### 6. Identify Update Path

Determine how to update to the patched version:

1. Check available versions of the vulnerable package using the package manager's version listing command or the ecosystem's public registry (e.g., npmjs.com, pypi.org, crates.io, Maven Central)
   - Confirm that the patched version identified in step 1 actually exists

2. For **transitive dependencies**, check whether the parent package's version constraint allows the patched version:
   - If the constraint includes the patched version → a simple dependency update should work
   - If the constraint does not include the patched version → an override/resolution may be needed, or the parent package needs updating

3. For **direct dependencies**, check if upgrading to the patched version introduces breaking changes by reviewing changelogs.

### 7. Assess Update Impact

Investigate changes between the current version and the target version:

1. Check the package's changelog or release notes:
   - Use `gh release` to check GitHub releases, or `gh api` to fetch changelog files from the repository
   - Look for breaking changes, new features, and bug fixes

2. Classify the update considering both direct and indirect usage:
   - **No impact**: Package is not used directly, the update is within compatible version range, AND the behavioral changes do not affect the parent packages' typical usage patterns
   - **Low impact**: Package is used directly but changes are backward-compatible, OR package is used indirectly and behavioral changes may affect parent packages in edge cases only
   - **Medium impact**: Package is used directly and there are behavioral changes that may require code adjustments, OR package is used indirectly and behavioral changes are likely to affect parent packages' common usage patterns
   - **High impact**: Breaking changes that require code modifications

### 8. Report Findings

Present a structured report:

```
## Dependabot Alert #{number} Investigation Results

### Alert Summary
- Package: {name} ({ecosystem})
- Vulnerability: {summary} ({CVE ID})
- Severity: {severity} (CVSS {score})
- Affected versions: {vulnerable range}
- Patched version: {patched version}

### Dependabot PR
- PR: #{number} ({url}) — {state}  * If no PR exists, state "None"
- Diff summary: {summary of lockfile changes, whether non-lockfile files are modified, and whether the target version meets the patched version}

### Dependency Chain
{dependency chain from direct dep to vulnerable package, including what each parent package uses the vulnerable package for}

### Direct Usage
{whether the package is used directly in project code}

### Indirect Usage Impact
- Parent packages: {list of parent packages and their purpose}
- Version diff ({current} → {target}):
  - {list of behavioral changes identified from GitHub compare view}
- Impact on each parent package:
  - {parent package}: {how the changes affect this parent's behavior, or why they don't}

### Update Method
{how to update: simple update / override / parent package update}

### Impact Assessment
- Impact level: {No impact / Low / Medium / High}
- Reason: {explanation considering both direct and indirect usage}
- Breaking changes: {yes/no, details}

### Recommended Actions
{recommended next steps; if a Dependabot PR exists, include whether to merge it as-is or if modifications are needed; include verification steps such as running lint/tests if applicable}
```

After presenting the report, ask the user how they would like to proceed (e.g., apply the update, dismiss the alert, or investigate further).
