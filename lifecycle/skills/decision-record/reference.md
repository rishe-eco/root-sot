# `decision-record` — the entry format, and which log

*The format every decision-log entry in the lifecycle method is written in, and which log a decision goes to. `decision-record` loads it, and so do the skills that write decision-log entries of their own (`learned --consolidate`, `personas`, `revise` on the method), so all of them read this one file (`README.md` §4; `skills-plan.md` §0, "Skills don't call skills").*

**Version 0.4 · Status: reference — binds from `decision-record` 0.1 · 2026-10-21 · Owner: _root**

---

## Entry format

```markdown
## <letter>-<n> · <YYYY-MM-DD> · <title: what was decided, in words, not ids>

**Decision.** <What was decided, concretely: the files and versions it changed. Bullets if it has parts.>

**Why.** <The reason and the evidence, citing files by repo-relative path.>

**Decided by.** <Who, when and how, exactly as it happened.>

**Revisit.** <When, and what would reopen it. "None" if nothing would.>
```

- **The id rule:** one letter per log, numbered in sequence, never reused. The method's log is `L-`. An id that moved to another log keeps its number, and the old log says where it went, as IMNSTR's L-2, L-3, L-5 and L-6 did.
- ***Decided by* says how it was decided.** "Founder, <date>, after reviewing the diff ("keep it")". "Founder, <date>: accepted on Claude's judgement, without a line-by-line review". "Claude's, accepted on the diff". A decision the founder accepted on Claude's judgement is recorded as exactly that, never as a reviewed decision (root `CLAUDE.md`). Quote the founder's words where they were short.
- **A decision is superseded, not rewritten.** A new entry says which entry it supersedes and what changed. The old entry is never edited, apart from a pointer forward where its log allows one.
- **The log's version line** is bumped by one minor version, with today's date, in the same commit. A log with a changelog gets a line there too.
- **The commit** is its own: `Decision log: <id> records <what>`, by path.

## Which log

| Decision | Log | How entries are written |
|---|---|---|
| About the method: `lifecycle/` files, skills, templates, the gate, project configs | `lifecycle/decision-log.md` | the entry format above, appended at the foot, oldest first |
| A module's product decision | `<module>/decisions.md` | one row in its *Index*: id · date · decision · the change note that holds it. `revise` and `spec change` write the rows for their notes. `decision-record` writes any other, pointing to wherever the substance is written, or holding it in the row if it fits in one line. A new `decisions.md` takes a letter no other log uses. Ids moved in from another log don't set the letter: IMNSTR's rows are all moved `L-` ids, so its first new row takes a letter of its own, which the founder picks |
| Tracker-wide, outside a module | `tracker/decisions/decision-log.md` | its own form, older than the method: `### D-<n> · <title> — <date>`, then prose, newest at the top of §2, with a changelog line |
| Root-wide (brand, pillars, the engine, shared platform choices) | `ecosystem/decisions/` | an ADR, `NNNN-slug.md`, in the template in its `README.md`, for anything expected to be cited on its own. A small item goes in `decision-log.md`, newest at the top of its section. Brand is the apex: a Tracker decision that constrains Root goes here, and Tracker links up to it |

The logs older than the method keep their own form. Converting them would rewrite history. Write in the form of their newest entries, and use the entry format above everywhere else. Private-register material (`ecosystem/personal-canon.md`, anything tagged INTERNAL or PRIVATE) never goes in a log: root-sot is public.

## Source

`tracker/decisions/decision-log.md`, `ecosystem/decisions/`, and `lifecycle/decision-log.md` L-1 to L-31.

## Changelog

- **0.4 · 2026-10-21** — `SKILL.md`: on a model other than Sonnet it says so and carries on. From `learned --consolidate`, the first (L-40).
- **0.3 · 2026-10-20** — *Which log*: ids moved in from another log don't set a module log's letter. Found by a test render: IMNSTR's next row would otherwise have been an L- id that clashes with the method's.
- **0.2 · 2026-10-20** — Placed by `decision-record` 0.1 (rollout stage 2, session A). The one-line seed is written out as the entry format, with the rules for *Decided by*, superseding, the version line and the commit, read from L-1 to L-31 and the root `CLAUDE.md`. Added *Which log*, from `skills-plan.md` §1 and the three logs as they stand. This file stays the reference, not a stub, because several skills write entries in this format.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md` 0.5 at 0.6.
