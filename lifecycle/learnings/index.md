# Learnings — index

*Every lesson about working that has been integrated: what it says, where it now lives, and how often it recurred before it was. Written only by `learned --consolidate`, once the founder accepts each integration; each row also has its `decision-log.md` entry. Capture notes wait in `inbox/` until then, and nothing in them is acted on. Method: `README.md` §5 rule 7; skill: `skills-plan.md` §1 `learned`.*

**Version 0.2 · Status: in use — one consolidation run · 2026-10-21 · Owner: _root**

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
| 8 | Tracker's UI review checks the light scheme only, until the app sets `.dark` | `projects/tracker/review-checklist.md` §4 | 1 session (2026-10-20) | 2026-10-21 | L-45 |
| 7 | One Tracker e2e spec runs on the Linux machine from a scratch Chrome config and database | `projects/tracker/config.md` §2, §3; `review-checklist.md` §7 | 1 session (2026-10-20), about 15 min | 2026-10-21 | L-44 |
| 6 | Before the card, check `config.md`'s branch and deploy rows against the remote, and that each targeted command reads its arguments | `skills/build-phase/SKILL.md` Launch step 3 | 2 sessions (2026-10-20) | 2026-10-21 | L-43 |
| 5 | Reproduce a bug on the surface the user saw: grep the callers, render the component | `skills/debug/SKILL.md` rule 1 | 2 sessions (2026-10-20) | 2026-10-21 | L-42 |
| 4 | Scope searches; run commands that can wait for input in a Bash call of their own | root `CLAUDE.md` *Shell* | 2 sessions (2026-10-20) | 2026-10-21 | L-41 |
| 3 | `handoff` and `decision-record` name a wrong model and carry on; prompts write founder-only skills as founder steps | both `SKILL.md`s; `skills-plan.md` §0 | 3 sessions (2026-10-20) | 2026-10-21 | L-40 |
| 2 | A session checks the previous session landed and the installed skills are current | `README.md` §5 rule 9 | 2 sessions (2026-10-20 to 2026-10-21) | 2026-10-21 | L-39 |
| 1 | No apostrophe inside `${var:-…}` or `${var:+…}` in a double-quoted string | `engineering-checklist.md` *Shell scripts* | 2 sessions (2026-10-20) | 2026-10-21 | L-38 |

The IMNSTR trial's lessons were consolidated before this index existed (trial step 10a, `trial-run/log/10a-consolidate.md`). Where each accepted item was placed is in `trial-run/findings.md` §11, and they are not listed again here.

## Changelog

- **0.2 · 2026-10-21** — The first consolidation: eight integrations (L-38 to L-45), accepted by the founder on Claude's judgement. Dropped as already in `projects/root-app/config.md` 0.4: the slot's ports checked free, and the two `--` for one e2e test. Five notes held in the inbox.
- **0.1 · 2026-10-20** — Created in rollout stage 1 (`skills-plan.md` §5), with the capture fields from `skills/learned/reference.md`.
