# Learnings — index

*Every lesson about working that has been integrated: what it says, where it now lives, and how often it recurred before it was. Written only by `learned --consolidate`, once the founder accepts each integration; each row also has its `decision-log.md` entry. Capture notes wait in `inbox/` until then, and nothing in them is acted on. Method: `README.md` §5 rule 7; skill: `skills-plan.md` §1 `learned`.*

**Version 0.1 · Status: empty — no consolidation has run since the inbox was created · 2026-10-20 · Owner: _root**

---

## Capture notes

`learned` writes one file per session, `inbox/<YYYY-MM-DD>-<slug>.md`, holding **zero to three** notes. Zero is a valid result; filler is not. A note that cites no specific event, wouldn't change a future action, or couldn't be checked later is rejected. Notes aren't deduplicated: a lesson recurring across sessions is the evidence consolidation needs. `verify` adds one capture note per review (the lane report's item 7, and any lesson from the review).

Each note is at most six lines, in fixed bold fields, so consolidation extracts them with one `awk`:

```markdown
## <short title>

**Rule:** <the lesson, as an instruction>
**Event:** <the specific event in this session that taught it: step, file, command>
**Cost:** <what it cost, if known: time, tokens, a failed push · unknown>
**Scope:** <repo · project · method · skill `<name>` · model behaviour>
**Destination:** <suggested, from the table below>
**Urgent:** <yes · no> — yes if waiting for consolidation would repeat a costly mistake; an urgent note is also copied into `STATE.md` as a carry-over
```

A file header is one line: `*Session: <date> · <module or lifecycle> · <step> · <model>*`.

## When consolidation runs

When the inbox passes **15 notes or 14 days**, at each milestone during a build, and before any `close-out` (`learned --consolidate`, Opus, high, in a session of its own). `lifecycle-status` reports "inbox over cap" when it is. Each cluster of notes is **integrated** (two or more sessions, or once at high cost), **held** (once and cheap: it stays in the inbox) or **discarded** (already integrated, obsolete, or not specific). At a module's last consolidation, holds become seeds for their destination's reference file.

## Where an integrated lesson goes

| Kind of lesson | Destination |
|---|---|
| Repo or environment gotcha | that repo's `CLAUDE.md` (kept under 200 lines; over it, propose what moves out) |
| How lanes should work | `projects/<project>/brief-common.md` |
| How a phase should be done | that skill's reference file (`skills/<skill>/reference.md` until the skill is written) |
| What reviews should check | `projects/<project>/review-checklist.md` |
| A change to the method | `skills-plan.md` or `README.md`, through `revise` |
| A fact about building software, true beyond this project | `lifecycle/engineering-checklist.md` |

## Integrated

<!-- One row per integration, newest first. Recurred: the number of sessions whose notes carried it, with the date range. -->

| # | Lesson | Destination | Recurred | Integrated | Decision |
|---|---|---|---|---|---|

*None yet.* The IMNSTR trial's lessons were consolidated before this index existed (trial step 10a, `trial-run/log/10a-consolidate.md`). Where each accepted item was placed is in `trial-run/findings.md` §11, and they are not listed again here.

## Changelog

- **0.1 · 2026-10-20** — Created in rollout stage 1 (`skills-plan.md` §5), with the capture fields from `skills/learned/reference.md`.
