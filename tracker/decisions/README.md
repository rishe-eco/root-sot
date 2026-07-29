# Tracker Decisions — ADRs

*Where Tracker-only decisions live: domain model, architecture, API, engineering practice. One decision per file going forward; the historical ledger is `decision-log.md`.*

**Version 0.1 · Status: canonical · 2026-07-29 · Owner: _root**

---

## Scope

Decisions about **this product only** — data model, GraphQL surface, frontend architecture, conventions, testing, deployment.

Anything about *purpose* defers upward to `../../ecosystem/decisions/`. Tracker never re-derives brand or philosophy; it links up to it. If a decision would change what Tracker is *for*, it is an ecosystem decision, not one of these.

**The code is the tiebreaker.** An ADR here describes a moving system. When an ADR and the source disagree, read the source, then fix the ADR.

## The two forms

**`decision-log.md`** — the original ledger. Living, append-only, newest first. It stays the authority for everything decided up to consolidation and is **not** being split into ADRs retroactively.

**`NNNN-slug.md`** — one file per decision, from 2026-07-29 onward. Numbering is sequential from `0001`, never reused. A reversed decision is **superseded, not deleted**.

## ADR template

```markdown
# ADR NNNN — <the decision, as a statement>

**Status:** proposed | accepted | superseded by [ADR NNNN](NNNN-slug.md)
**Date:** YYYY-MM-DD · **Owner:** _root
**Grounding:** as-built | spec | inferred

## Context
What forced a decision. What was true before.

## Decision
What we chose, stated as a commitment.

## Consequences
What this makes easier, what it makes harder, what it forecloses.
Name the migration if one is needed.

## Alternatives considered
What else was on the table, and why it lost.
```

## Rules

- **Don't fork a decision — update it.** One file per topic; add a changelog line when it changes.
- **Grade your grounding.** Every claim about the code is **as-built** (verified against the repo on the stated date), **spec** (designed, may not match code), or **inferred** ("verify in code").
- **Name the migration.** A decision that changes the schema is not complete until the migration is identified.
- **Don't re-litigate a refusal.** Streaks, native apps, and a rich-text editor are settled — see `../roadmap.md` §7. Reopening one is an ecosystem decision.

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Convention established at repo consolidation; `decision-log.md` moved here from `tracker-canon/05-log/`.
