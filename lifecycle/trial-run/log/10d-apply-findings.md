# 10d Apply findings — 2026-10-19

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md` and `lifecycle/trial-run/findings.md`. Apply the accepted findings as `revise` on the method, group by group, showing me each group's diff before committing." Claude desktop app (Code tab), Linux machine. The pull was already up to date at `bb29b95`.

## Read
- `lifecycle/trial-run/README.md` and `findings.md`, whole.
- `lifecycle/README.md`, `skills-plan.md`, `review-instrument.md`, `decision-log.md`, `status.md`, whole: every one is a destination.
- `log/10c-trial-wrap-up.md` (*Spec gaps* to *Next*) and the top of `imnstr/modules/01-website/STATE.md`, for what the apply session owes.
- `log/10a-consolidate-proposal.md` §1–§4 and *Decisions*: many findings say "L*n* as drafted", and the drafts live there.
- *Outside, for content:* the *Lessons* and *Spec gaps* of `08c-B4b`, `B5`, `B6`, `B7`, `B8`, `B9` verify, `08d-MS2`, `08a-B5`, `08a-B8` and `08c-PL1` (the engineering checklist's seeds); the headers of change notes 04–06 (the IMNSTR decisions index); `lifecycle/personas.md`'s header; `~/Desktop/buildMemory/brief-common.md`, whole, before committing it as the example brief.

## Gate
`findings.md` 0.2 exists, with every group marked accepted on Claude's judgement. The 10c block names this session as next. No `STALE` cells. **GATE OK.**

## Did
1. Groups 1–4: drafted each group's edits, showed the founder the diff with a plain explanation, and committed on their word. DR-2, M-2 and LE-2, flagged by 10c, were raised on their own; all three were accepted.
2. During group 5 the founder said: "continue with drafting and committing the groups continuously, only stop and ask me if something needs my attention". Groups 5–15 were committed without a diff review. Their decision-log entries say so.
3. One commit per group, each with its `lifecycle/decision-log.md` entry (L-7 to L-21).
4. Skill items bound for reference files that don't exist yet went into each skill's section as *Reference holds*, a convention defined once in `skills-plan.md` §0. Template contents went into each skill's section as *Template* lines. Group 15 named every template in stage 1's list rather than drafting them.
5. Checked the method files for stale references afterwards (`team/open-work.md`, `wireframes mode`, `M1`, the old change-note name).

## Output
| Group | Findings | Commit | Entry |
|---|---|---|---|
| 1 Method README | M-1–M-8 | `d59daec` | L-7 |
| 2 Shared mechanics | S0-1–S0-10 | `a8d0944` | L-8 |
| 3 Every-session skills | ST, HO, DR, LE | `5320183` | L-9 |
| 4 `ideate`, `research`, `personas` | ID, RE, PE | `5becf97` | L-10 |
| 5 `spec` | SP-1–SP-11 | `c25951f` | L-11 |
| 6 `journeys`, `wireframes` | JO, WF | `ff15ccf` | L-12 |
| 7 The design step | DS-1–DS-8 | `ea671e9` | L-13 |
| 8 `eval-plan`, `build-plan` | EV, BP | `432a89b` | L-14 |
| 9 Project config | PC-1–PC-9 | `787aef3` | L-15 |
| 10 `build-phase`, `debug` | BF, BL, DB | `1200a6b` | L-16 |
| 11 `verify` | VE, VM | `3dbf50d` | L-17 |
| 12 Reviews | UX, RI, DE | `1eb507e` | L-18 |
| 13 `revise`, `close-out` | RV, CO, JO-9 | `313278f` | L-19 |
| 14 Trial brief | TR-1–TR-5 | `2448013` | L-20 |
| 15 Foundation list | F-1–F-18 | `d7ff20b` | L-21 |

Files: `lifecycle/README.md` 0.5, `skills-plan.md` 0.5 (twenty skills), `review-instrument.md` 0.2, `trial-run/README.md` 0.6, `decision-log.md` 0.21. New: `lifecycle/engineering-checklist.md` 0.1, `lifecycle/templates/brief-common.example.md`, `imnstr/modules/01-website/decisions.md` 0.1 (L-2, L-3, L-5, L-6 moved there, ids kept). `findings.md` 0.3, this log and a `STATE.md` block: this commit.

## Spec gaps
1. **`revise` on the method has no step for a batch this size,** as 10c found. Group by group, with the diff shown, worked for four groups. The founder then waived the diff for the rest. *Proposal:* `revise --method` shows each group's diff, and records a waiver as such.
2. **"Reference file" destinations don't exist yet.** I put them in each skill's section as *Reference holds*, so `skills-plan.md` stays the one source the skills are transcribed from. It grew from about 5,000 to 10,300 words.
3. **Three of 10c's own gaps weren't findings,** so they weren't applied: a propose step for `revise --method`; numbering each log's *Spec gaps* items; and the 10c row's inputs leaving out 10a's decisions.
4. **IMNSTR's seven change files keep their old names** (`NN-slug.md`), against the new `NN-change-` and `NN-req-` names. Renaming them would break citations across the module. L-11 leaves it to a later catch-up.
5. **The review instrument changed after IMNSTR's two passes.** 0.2 applies from the next module, so a module's passes still compare. Its changelog says so.

## Template sample
Not a phase output. Each method file kept its own headings. The decision-log entries use the format in `decision-record`'s *Reference holds*.

## Missing foundation
- The templates and `bin/gate`: listed, not built (stage 1).
- The build machine's memory (`root-app-dev-machine`) for L30, L31 and L33 is on the Windows machine. This machine has only a copy in `~/Desktop/buildMemory/`. The lessons are in `skills-plan.md`'s `brief-common.md` list instead.

## Founder Q&A
1. Group 1, with the small Change raised on its own → "commit".
2. Group 2 → "go ahead".
3. Group 3, with the decisions file move and milestone consolidation raised on their own → "commit".
4. Group 4 → "commit".
5. During group 5 → "continue with drafting and committing the groups continuously, only stop and ask me if something needs my attention".

## Skill shape
- **`revise --method`**, Opus · high. Not forked, since the founder decides between groups.
- **Inject:** `findings.md`'s *Decisions* table; the heading list of each destination file; the latest decision-log id.
- **Reference file:** one commit and one decision-log entry per group; show the diff unless the founder waives it, and record the waiver in the entry; reference-file items go under *Reference holds*; afterwards, grep for stale names.

## Lessons
1. **Rule:** when applying a batch of edits, write a small helper for the repeated mechanics (exact-match replace that fails on zero or two matches, the changelog line, the next decision-log id) before the first group. **Event:** groups 1–4 repeated the same boilerplate, and one group failed partway on a string that didn't match. The assert stopped it before it wrote a partial file. **Cost:** one rerun. **Scope:** `revise --method`, `learned --consolidate`. **Destination:** their reference files. **Urgent:** no.

## Cost
From the founder's paste: **$6.00**; API 34 m, wall 36 m; Opus 5.5 only. Tokens: 106 input, 95.7k output, 10.4M cache read, 227.1k cache write. The figure is exact, and covers the whole session: 15 groups, the session record, and the templates decision. Most of the output went on the drafted edits, about 8,000 words added to the method files.

## Next
- **Templates:** the founder chose rollout stage 1, together with `bin/gate`.
- **The founder's items** (in the `STATE.md` block): the build machine's memory edits; F-17's test helpers in IMNSTR's open-work.
- **The trial is complete.** The 10b2 block's IMNSTR items (launch, E2's dates, V-5 to V-9) stand.
