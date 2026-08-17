---
name: research
description: Research a question across many web sources, adversarially vote-verify every extracted claim, and synthesize a cited report. A heavy investigation that runs dozens of subagents in parallel through Workflow.
argument-hint: "[--light|--deep] <topic to research>"
---

# research

## Procedure

1. If `$ARGUMENTS` is too vague to form search queries, ask 2–3 clarifying questions before starting
2. Write the script to the spec below and run it with `Workflow({script})`. `meta.phases` must list the phases from the model table, titled exactly as the script titles them
3. Read the returned open questions. Answer any that the conclusion depends on by retrieving the primary source yourself
4. Present the result as prose. Never paste raw JSON

## Scale and model assignment

| Flag | Angles | Fetch cap | Verify cap | Gap agents |
|---|---|---|---|---|
| `--light` | 3 | 9 | 8 | 2 |
| (default) | 5 | 15 | 18 | 3 |
| `--deep` | 6 | 24 | 25 | 5 |

Vote count is always 3. The presets scale the breadth of exploration, not the strictness of verification.

| Phase | model | effort |
|---|---|---|
| Scope | omit | high |
| Search | sonnet | low |
| Fetch | sonnet | medium |
| Verify | sonnet | medium |
| Answer check | sonnet | low |
| Close | omit | high |
| Synthesize | omit | high |

Deduplication and claim-pool ranking are plain JS in the script, not agents, and get no phase of their own.

## Pipeline

```
Scope → Search → ║ → Fetch → ║ → [Verify → Answer check] per angle → ║ → Close → ║ → Synthesize
```

`║` is a barrier: everything upstream completes before anything downstream starts.

- **After Search** — deduplicating URLs across angles and allocating fetch slots are cross-angle merges, so they cannot run while an angle is still searching. Search is the cheapest phase, so the wait is short, and collecting first keeps slot allocation deterministic enough to survive a workflow resume
- **After Fetch** — assemble the full claim pool, rank it by importance and source quality, then verify the top N, allocated **per angle, round-robin**, so one angle cannot take the whole quota
- **Before Close** — gaps are ranked against each other and capped, which needs every angle's answer check in hand
- **Before Synthesize** — it merges everything

Verify and Answer check are not separated by a barrier. Every selected claim belongs to an angle, so run the two as a `pipeline()` keyed by angle: angle A can be answer-checking while angle B is still voting. Inside that pipeline, assign each `agent()` its phase through `opts.phase` rather than calling `phase()` — the global phase state races once stages overlap.

Underfilled pool at the Fetch barrier: if the claim pool falls short of the preset's verify cap, verify all of it and log the shortfall. Verification is bounded by the pool on its own. Do not shrink the gap-agent cap to match — a thin pool means more gaps to close, not fewer.

### Scope

Decompose the question into complementary search angles.

- Rebuild the axes to fit the topic's domain. A generic starting shape is "broad/primary · academic/technical · recent news · contrarian/skeptical · practitioner/implementation", but reusing it verbatim on every topic means searching the same thing N times
- Explicitly require that the angles do not overlap
- Make each query specific enough to surface high-signal results
- Give each angle a **central question**: one sentence, answerable by a quote. Later phases test against it

### Search

Run one WebSearch per angle and return the top 4–6 results.

- Rank by relevance to the **original question**, not to the search query
- Have each result tagged high/medium/low relevance
- Exclude SEO spam and content farms
- Deduplicate URLs across angles before handing off to Fetch. Normalize to host + path, dropping `www.` and any trailing slash, lowercased
- Allocate fetch slots **per angle, round-robin**. A global relevance sort lets one angle drain the pool
- Log how many results were dropped to deduplication and to the slot cap

### Fetch

Retrieve each source and extract falsifiable claims.

**Retrieval.**

- Prefer a retriever that returns the document's own text over one that answers a question about it. ToolSearch may surface one specialized to the source's ecosystem
- Designate the highest-quality primary source in each angle a **full read**: retrieve the whole document, paginating as needed, and extract from all of it. It costs 2 slots from that angle's share
- With a prompt-directed fetcher, ask for heading structure and verbatim passages rather than an answer, then follow up on the sections that carry the argument

**Extraction.**

- Rate source quality as primary/secondary/blog/forum/unreliable. Every claim carries its source's rating as `sourceQuality` — Verify reads it off the claim, not off the page
- Extract 2–5 claims, each carrying a direct quote and a central/supporting/tangential grade
- Concrete, checkable statements only — no vague generalities
- Record each claim's **scope**: the population, version, platform, or case the quote actually covers
- When a page gives several examples, or a table with exceptions, extract the contrast between them as its own claim
- Record the publish date when one is available
- On fetch failure, paywall, or irrelevance, return `claims: []` with `unreliable`

### Verify

Three adversarial votes per claim. Cast every voter as trying to refute it.

Checklist:

1. Does the quote actually support the claim, or is it an overreach or a misreading?
2. Is the quote's scope narrower than the claim's? Evidence about one case, version, or platform does not establish the claim for another
3. Search for contradicting evidence, including elsewhere in the same source
4. Is the source quality sufficient for the strength of the claim?
5. Is it outdated?
6. Is it a marketing claim, press release, cherry-picked benchmark, or forum speculation?

Each refuting vote must classify what it refutes on:

- `refutes` — external counter-evidence supersedes the claim: better source, later correction, retraction. Rate the counter-source's quality
- `conflicts` — a source of comparable authority asserts the opposite, with neither superseding the other. Rate the counter-source's quality
- `unsupported` — the claim fails on its own source, no counter-source involved: the quote does not support it, the quote's scope is narrower than the claim, the source is too weak for the claim's strength, or it is stale, marketing, or speculation

A `refutes` or `conflicts` vote whose counter-source ranks below the claim's own source, or carries no rating at all, does not count toward the tally — a blog contradicting a specification does not overturn it. Carry it to the caveats instead. A claim can therefore survive even a unanimous refutation when every counter-source is weaker than it. That is intended; the confidence grade is what absorbs the doubt.

Default to `refuted=true` when uncertain. Evidence must be specific.

`NEEDED` is 2. It serves as both the refutations required to decide a claim and the minimum valid votes needed to adjudicate at all; raising it tightens both.

Tally four ways. `agent()` returns `null` when skipped or errored, so counting a null as a refuting vote would report a wholesale verifier failure as "every claim was refuted".

```js
const RANK = { primary: 0, secondary: 1, blog: 2, forum: 3, unreliable: 4 }
const sourced  = v => v.counterEvidence === 'refutes' || v.counterEvidence === 'conflicts'
const credible = v => !sourced(v) || RANK[v.counterQuality] <= RANK[claim.sourceQuality]

const valid    = verdicts.filter(Boolean)
const refuting = valid.filter(v => v.refuted && credible(v))
const weak     = valid.filter(v => v.refuted && !credible(v))   // → caveats, never a verdict
const peer     = refuting.filter(v => v.counterEvidence === 'conflicts')

const survives    = valid.length >= NEEDED && refuting.length < NEEDED
const isContested = refuting.length >= NEEDED && peer.length >= NEEDED
const isRefuted   = refuting.length >= NEEDED && !isContested
// none of the above → unverified (fewer than NEEDED valid votes)
```

Return four outcomes, never collapsing them:

- `survived` — carry into findings
- `refuted` — drop from findings; keep for the misconception list
- `contested` — comparable sources disagree. **Carry into its own report section with both sides quoted**, not into caveats. Not confidence-graded
- `unverified` — too few valid votes to adjudicate. Keep out of findings entirely. Any claim graded `central` becomes an open question; the rest appear only in the tally

### Answer check

One agent per angle, in parallel. Give it the angle's central question and that angle's `survived` claims, and require: answer the question and quote the answer, or return null.

`contested` and `unverified` claims are withheld on purpose. An angle whose central question rests on a disputed or unadjudicated claim should register as a gap and be routed to Close.

A null is a gap. So is an angle whose central question was answered only by tangential-graded claims.

### Close

Fan out one agent per gap, capped per the scale table. Rank gaps by how much the original question depends on them; gaps past the cap pass to Synthesize as `still-open`.

Instruct each:

> Do not search and summarize. Retrieve the most authoritative source in full and read it end to end, paginating if necessary. Prefer specification, reference, and first-party documentation over commentary. Report the answer with a quote, or report that the source does not address it and quote the closest passage.

Pass results to Synthesize tagged `closed` or `still-open`.

### Synthesize

Merge the verified material into a report.

1. Merge claims that say the same thing and combine their sources
2. Group related claims into coherent findings. Each finding must directly answer the original question
3. Collect `contested` claims into their own section, quoting each side, and state what would settle it. They take no confidence grade. If a `closed` gap result settles one, promote the winning side into findings and record how it was settled rather than leaving the pair contested
4. Fold `closed` gap results into findings; carry `still-open` ones into the open questions
5. State a finding's scope wherever the evidence is narrower than the finding's phrasing invites
6. Assign confidence on the votes as cast, not on the credibility-filtered tally — **high**: multiple primary sources and not one refuting vote, counted or discarded / **medium**: secondary sources, a split vote, or any refutation discarded for counter-source quality / **low**: a single source or blog-quality
7. In the caveats, record weak sources, time-sensitivity, split votes, refuting votes discarded for counter-source quality, and refuted claims worth flagging as misconceptions
8. List 2–4 questions that surfaced but went unanswered, plus every `central` claim left `unverified` that no `closed` gap result already covers

If this agent returns `null` because it was skipped or errored, return the verified claims unmerged instead of touching `report.findings`. One failure at the final step must not discard the work of dozens of agents.

## Label sanitization

A source's URL and title are web-controlled values, and they reach the terminal through `label`. This governs every phase that derives a label from a URL — Fetch, the counter-evidence lookups in Verify, and Close.

- Extract the hostname with a regex. Exclude `\` and `@` from the host character class, and match userinfo greedily through the last `@`. Anything laxer labels `evil.com\@trusted.com` or `x@trusted.com@evil.com` as trusted.com
- Before display, strip C0/C1 control characters, bidi overrides, zero-width characters, and the double-quote lookalike family
- Emit a bare `<phase>:<host>` only when the hostname is strict ASCII and sanitization altered nothing. Otherwise wrap it in quotes, which defeats IDN homographs and truncation forgery
- Never sanitize the normalized key used for deduplication

## Report

Conclusion → key findings, with source URLs, grouped by confidence → contested points → caveats → open questions.

Close with the agent count, **claims extracted / selected for verification / survived**, and the `contested` / `refuted` / `unverified` tallies. `unverified` means the votes did not adjudicate it, not that it was disproved — say so. Claims never selected are neither verified nor unverified; they are the gap between extracted and selected.
