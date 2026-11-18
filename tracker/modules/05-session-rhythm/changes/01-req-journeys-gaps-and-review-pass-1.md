# 01 — The journeys' gaps and the UX review's first pass, written into the spec

*Module `tracker/modules/05-session-rhythm/` · Change request written by `revise` · 2026-11-19. Kind: req · `rishe-eco/tracker main @ eea1c59` · spec 0.1 → 0.2. Sources: `STATE.md`'s blocks since the spec (3a personas, 3b journeys, 4 wireframes; no earlier `revise`), and the sections their items cite: `03-journeys.md` 0.2 §1 and §4 (S1–S12); `05-ux-review.md` 0.1 pass 1, *Findings* and *For `revise`* (P1-F1 to F18); `04-wireframes.html` draft 1a, *Calls made here*. Grading: S1 and S2 are **[F]**, decided at journeys. Every other outcome was settled by Claude during the founder's unattended run (`lifecycle/unattended.md`, founder's go-ahead in chat on 2026-11-19), logged in `calls.md` rows 5 to 9, and is **proposal**: the founder vetoes any of them with a change note or a second `revise`.*

## What changes and why

The journeys walk found twelve places where the spec was silent or wrong (S1–S12). Two were the founder's own answers at journeys: the first session looks back from the switch date (S1), and a session continued on a later day keeps its answers and range but re-anchors its look-ahead (S2). The other ten fill holes a resumable, failure-prone session would otherwise fall into: where "From before" sits, what happens to a gap's items, how a changed answer undoes its fate, what a failed save shows.

The UX review's first pass then found one high-severity hole: crossed items arrive pre-filled "happened", but only **Confirm these** recorded it, so a person who moved on without confirming lost those answers for good, and progress never moved (P1-F1). It also found that "Done for now" promises a return that never comes (P1-F3), that uncrossing left a re-dated item re-dated (P1-F4), that failures were drawn for two surfaces of many (P1-F6), and that ordering was drag-only (P1-F14).

Spec 0.2 writes all of these in: §2.3 #19 to #37, a new §4.10 *Failures*, eleven new criteria (AC-65 to AC-75) and ten amended ones. Nobody was asked mid-run: the founder had handed the run over. The two findings routed `question` were answered as calls, each the smaller and easier-to-undo option.

## Items and outcomes

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | The first look-back covers the switch date to yesterday | journeys §1 #1, §4 S1 | **Accepted [F]** | §2.2 #3, §2.3 #19; AC-31 amended |
| 2 | A continued session keeps its date, answers and range; the look-ahead re-anchors | journeys §1 #2, §4 S2 | **Accepted [F]** | §2.3 #20; AC-28, AC-31, AC-40 amended |
| 3 | Where "From before" sits; what "offered" means | S3 | **Accepted** (call 5) | §2.3 #21, §4.6; AC-51, AC-52 amended |
| 4 | The look-back's day picker before the next date is chosen | S4 | **Accepted** (call 5) | §2.3 #22, §4.5; **AC-65** |
| 5 | Changing an answer restores the fate it set | S5 | **Accepted** (call 5) | §2.3 #24, §4.5; **AC-66** |
| 6 | Crossing a past-dated item | S6 | **Accepted** (call 5) | §2.2 #9, §2.3 #23; AC-19 amended |
| 7 | "From the gap" | S7 | **Accepted** (call 5) | §2.3 #25, §4.6; **AC-67** |
| 8 | Empty Today and the hidden fold | S8 | **Accepted** (call 5) | §2.3 #26, §4.1; **AC-68** |
| 9 | Failed saves, widened to every surface, and failed loads | S9; P1-F6 | **Accepted** (call 5) | §2.3 #27, §4.10; **AC-69**, **AC-70** (new area J) |
| 10 | Capture refuses a past date | S10 | **Accepted** (call 5) | §2.3 #28, §4.2; **AC-71** |
| 11 | A removed operation from an old tab | S11 | **Accepted** (call 5) | §2.3 #29, §4.10; **AC-72** |
| 12 | `/session` hides the top bar; `N` still captures | S12 | **Accepted** (call 5) | §2.3 #30, §4.4; **AC-73** |
| 13 | A pre-filled "happened" counts when the step completes | P1-F1 (High) | **Accepted** (call 5) | §2.3 #31, §4.5; AC-32, AC-38 amended |
| 14 | Rename "Done for now" | P1-F3 | **Accepted: "Skip the rest"**, fa «بقیه رو رد کن» (call 5) | §2.3 #32, §4.5, §5 R1; AC-38 amended |
| 15 | Uncrossing on the same day undoes the move | P1-F4 | **Accepted** (call 5) | §2.3 #33, §4.3; AC-18, AC-55 amended |
| 16 | Move up / Move down; the refused drop | P1-F14 | **Accepted** (call 5) | §2.3 #34, §4.1; **AC-74** |
| 17 | Focus shows a filled box beside unmoved progress | P1-F5 (question) | **Accepted, option *a quiet line*:** "Moves at your next session"; the square control stays as the founder chose (W26) (call 6) | §2.3 #35, §4.3; **AC-75** |
| 18 | Items the look-back leaves behind leave every planning surface | P1-F2 (question) | **Refused as a requirement** (call 7): they stay on their day, on the project page and the actions list, as §2.1 #2 [F] already said for "didn't happen" with no follow-up. `eval-plan` watches for them | §2.3 #36; `06-eval-plan.md` (owed) |
| 19 | "Let them all go" has no undo | P1-F7 (design) | **Accepted** (call 8): a rule, not a drawing | §2.3 #37; AC-51, AC-67 |
| 20 | P1-F8 to F13, F16 to F18: layout and caption findings | `05-ux-review.md` pass 1 | **Carried to the wireframes' draft 2** (call 8): no design step exists for this module, so the wireframes are the design | `04-wireframes.html` |
| 21 | P1-F15: 44 px hit areas | `05-ux-review.md` pass 1 (build) | **Left to the build plan** | `07-build-plan.md` |
| 22 | Wireframe calls W1 to W26 | `04-wireframes.html` | **Left to the build plan**, which accepts, refuses or carries each | `07-build-plan.md` |

**Scope.** Against intake, every area is in scope; none has doubled (B 9 → 11, E 12 → 14, the largest moves), and the largest, E, is 14 of 75, under a quarter. The new area J holds failure states the intake's "each step saves as it is done" implies. Still the smallest version worth trying: no capability is added, and P1-F2's new block was refused for that reason.

## Changes to the spec

`02-spec.md` 0.1 → 0.2: the version line; the scope ledger's 0.2 column and area J; §2.2 #3 and #9 marked **[0.2]**; a new §2.3 *Decisions taken at the 0.2 revise*, #19 to #37; §4.1, §4.2, §4.3, §4.4, §4.5 and §4.6 amended in place, marked **[0.2]**; a new §4.10 *Failures*; §5 R1's button name; AC-18, AC-19, AC-28, AC-31, AC-32, AC-38, AC-40, AC-51, AC-52 and AC-55 amended in place; AC-65 to AC-75 placed in their sections (6.1, 6.2, 6.3, 6.4, 6.5, 6.7, and a new 6.10); a changelog line naming this note.

## Carried to design

- None to a design step: the module has none (phase 4b skipped, founder, 2026-11-19). The layout findings (item 20) go to the wireframes' draft 2.

## `STALE`

| File | Cell | The sentence it marks |
|---|---|---|
| `03-journeys.md` 0.2 | column 3 | J3.11: "Two items left; G taps **Done for now**" and "AC-38: the step completes with them unanswered", which now leaves crossed items answered and names a renamed button; J1.6's first look-back over nothing (S1, now spec) |
| `04-wireframes.html` draft 1a | column 4 | Plate 5: "'Done for now' sits at the foot at all times (W17)", and the button drawn under that label on plates 5 and 6 |

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| Accepted Suggested items S3 to S12 marked "accepted at spec 0.2" | `journeys update --from-note 01` | before `build-plan` |
| The `.sugg` boxes for S1 to S12, now requirements, redrawn as plain UI | `wireframes` draft 2 | before `build-plan` |
| P1-F8 to F13, F16 to F18 | `wireframes` draft 2 | before `build-plan` |
| P1-F2's watch item: actions left on a past day with no fate | `eval-plan` | its full run |
| P1-F15 and W1 to W26 | `build-plan` | its §2 |

## What must not break

- Crossing never sets `done` (D-67, AC-18); the pre-fill rule of AC-32 sets it only when the look-back step completes.
- No counts, no red (§4.9): every new line (empty Today, "Not saved.", "Moves at your next session", "From the gap") holds no number.
- "From before" is still offered once (AC-52); "From the gap" copies that rule, not a new one.
- The record (§6.8) stays the only store of answers; AC-55 adds one field to it.

## Open

- P1-F15 (hit areas) and the wireframe calls W1 to W26: `build-plan` settles them.

## Owed by other skills

1. `journeys update tracker/modules/05-session-rhythm --from-note 01` (Opus, high): clears column 3's `STALE`.
2. `wireframes tracker/modules/05-session-rhythm`, draft 2 (Opus, medium): the label, S1 to S12 as plain UI, P1-F8 to F13 and F16 to F18; clears column 4's `STALE`.
3. `eval-plan tracker/modules/05-session-rhythm` (Opus, high), full mode, from spec 0.2: no plan exists yet, so no touch-up.
4. `build-plan tracker/modules/05-session-rhythm` (Opus, high).
