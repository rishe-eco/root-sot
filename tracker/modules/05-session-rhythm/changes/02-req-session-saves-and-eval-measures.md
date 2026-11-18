# 02 — The session's own saves, and the eval plan's measures, written into the spec

*Module `tracker/modules/05-session-rhythm/` · Change request written by `revise` · 2026-11-19. Kind: req · `rishe-eco/tracker main @ eea1c59` · spec 0.2 → 0.3. Sources: `03-journeys.md` 0.3 §4 S13 (J5.9c); `06-eval-plan.md` 0.1 §6 items 1 to 5. Grading: every outcome was settled by Claude during the founder's unattended run (`lifecycle/unattended.md`), logged in `calls.md` rows 10 and 11, and is **proposal**.*

## What changes and why

The journeys update to spec 0.2 found that AC-69's list of saves that fail visibly leaves out the session's own steps. A **Finish** that failed silently would leave the session open with no reason given (S13). Spec 0.3 adds them to §4.10 and AC-69.

The eval plan, written from spec 0.2, refined four measures so that they can be read: M2 counts a return whose old days were filled in; M3's typical value ignores paused look-backs; M5 is read from dated paper pages; the record query also counts what the look-back leaves behind. The spec's §3 and AC-58 now say what the plan already proceeds on. Nothing new is stored, and no criterion is added.

## Items and outcomes

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | The session's own steps show "Not saved." and Try again, and stay at the failed step | journeys S13, J5.9c | **Accepted** (call 10) | §2.4 #38, §4.10; AC-69 amended |
| 2 | M2 counts a filled-in return | eval plan §6 #1 | **Accepted** (call 11) | §2.4 #39, §3 M2 |
| 3 | M3's typical value is the median of unpaused look-backs | eval plan §6 #2 | **Accepted** (call 11) | §2.4 #40, §3 M3 |
| 4 | M5 read from the paper pages | eval plan §6 #3 | **Accepted** (call 11) | §2.4 #41, §3 M5 |
| 5 | AC-58's query also counts the left-behind and the unfinished sessions | eval plan §6 #4 | **Accepted** (call 11) | §2.4 #42; AC-58 amended |
| 6 | The query script gets a card | eval plan §6 #5 | **Left to the build plan** | `07-build-plan.md` |

**Scope.** No criterion added; the ledger's 0.3 column equals 0.2's (75). Still the smallest version worth trying.

## Changes to the spec

`02-spec.md` 0.2 → 0.3: the version line; the ledger's 0.3 column; §3 M2, M3, M5 marked **[0.3]**; a new §2.4, #38 to #42; §4.10's failed-save line; AC-58 and AC-69 amended in place; a changelog line naming this note.

## Carried to design

- None: the module has no design step. S13's failure states are drawn by the build from §4.10, carried below.

## `STALE`

None. No downstream file says the opposite: the journeys raise S13 as a Suggested item, which this accepts, and the eval plan already proceeds on items 2 to 5.

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| S13 marked "accepted at spec 0.3" | the next `journeys update` | after the build, before `close-out` |
| S13's failure states on the session's steps, not drawn in the wireframes | `build-plan`, then the stage that builds the session | its card |
| The eval plan's §6 items marked as taken, and its input line moved to spec 0.3 | the next `eval-plan --touch-up` | before `close-out` |

## What must not break

- Saves stay as they are made (AC-30); a failed one never loses what was entered (AC-69).
- No count, no red (§4.9).
- The record (§6.8) stores nothing new; the query reads AC-55 to AC-57.

## Open

- The query script's card (eval plan §6 #5): `build-plan`.

## Owed by other skills

1. `build-plan tracker/modules/05-session-rhythm` (Opus, high).
2. After the build: `journeys update tracker/modules/05-session-rhythm --from-note 02` and `eval-plan tracker/modules/05-session-rhythm --touch-up changes/02-req-session-saves-and-eval-measures.md`, before `close-out`.
