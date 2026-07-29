# Ecosystem Decisions — ADRs

*Where Root-level decisions live: brand, philosophy, the pillars, the engine, and shared platform choices. One decision per file going forward; the historical ledger is `decision-log.md`.*

**Version 0.1 · Status: canonical · 2026-07-29 · Owner: _root**

---

## Scope

Decisions that bind **the whole ecosystem** — brand and naming, philosophy and refusals, pillar definitions and ordering, the five-phase engine, and shared platform choices that more than one product inherits.

Tracker-only decisions belong in `../../tracker/decisions/`. If a decision constrains both, it belongs here and the Tracker side links up to it — **brand is the apex**, and Tracker never re-derives it.

## The two forms

**`decision-log.md`** — the original ledger. Living, append-only, thematic, newest at top of each section; started 2026-07-14 and current through 2026-07-23. It is **not** being retired or split into ADRs retroactively; it stays the authority for everything decided up to consolidation.

**`NNNN-slug.md`** — one file per decision, from 2026-07-29 onward. Use this for anything substantial enough to be cited on its own.

Numbering is sequential from `0001`, never reused. A decision that is later reversed is **superseded, not deleted** — set its status and link forward.

## ADR template

```markdown
# ADR NNNN — <the decision, as a statement>

**Status:** proposed | accepted | superseded by [ADR NNNN](NNNN-slug.md)
**Date:** YYYY-MM-DD · **Owner:** _root

## Context
What forced a decision. What was true before.

## Decision
What we chose, stated as a commitment.

## Consequences
What this makes easier, what it makes harder, what it forecloses.

## Alternatives considered
What else was on the table, and why it lost.
```

## Rules

- **Don't fork a decision — update it.** If an ADR is still `proposed`, edit it. Once `accepted`, write a new ADR that supersedes it rather than rewriting history.
- **Append small items to `decision-log.md`** instead of minting an ADR. An ADR is for something you expect to cite later.
- **Grade your evidence.** Where a decision rests on research, say how strong the research is — reality over fiction applies to our own foundations.
- **Private register stays out.** Material tagged INTERNAL/PRIVATE never becomes a team-facing ADR (see Core Philosophy §7).

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Convention established at repo consolidation; `decision-log.md` moved here from `root-canon/05-log/`.
