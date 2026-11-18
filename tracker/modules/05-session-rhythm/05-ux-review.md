# Session rhythm, stage 1 — UX review

*Module `tracker/modules/05-session-rhythm/` · Phase 5 (and 9, live) · UX review (`ux-review`). Each journey walked as each selected persona and scored against `lifecycle/review-instrument.md`. Passes are appended, newest last; the summary at the top is newest first.*

**Version 0.1 · Status: review · 2026-11-19 · Owner: _root**

**Grading.** Observations are **simulated** on a static design and **as-built** on the running app. Every score is **simulated**: one reviewer's judgement. Personas marked *hypothesis* in `lifecycle/personas.md` stay so until a pass or real-user data grounds them.

---

## Summary

**Pass 1 — 2026-11-19 · design:** (1) The wireframes cover every journey step and every acceptance criterion with a user-visible path; the fences (no counts, no red, no days-late) hold on every plate. (2) One high finding: crossed items pre-filled "happened" but not confirmed are left unanswered by **Done for now** and never become done (P1-F1). (3) Items left behind by the look-back (unanswered, or "didn't happen" with no follow-up) drop off every planning surface, and "Done for now" promises a return that never comes (P1-F2, P1-F3). (4) Recoverability is the weakest metric: uncrossing doesn't restore a date that crossing moved, "Let them all go" has no undo, and only session answers and capture have a failure state (P1-F4, F6, F7). (5) 18 findings: high 1, medium 8, low 9; routed revise 5, question 2, design 10, build 1. Language parity isn't scorable: G doesn't read Persian.

## Pass 1 — 2026-11-19 · design mode, against the wireframes

### What was reviewed

- `04-wireframes.html` draft 1a (root-sot `docs/root-os @ bd6a6fb`), ten plates, Suggested items S1 to S12 and calls W1 to W26. There is no 4b design (skipped by the founder), so the wireframes are what is reviewed.
- Rendered with headless Microsoft Edge at 360 px wide (19 viewport slices of 1400 px) and at 1200 px (7 slices of 1100 px), light scheme; one slice also in dark (forced dark mode) to confirm the frames draw in both. The `fa` frames were read in the same renders (they are bars apart from §2.2 #17's fixed terms). Screenshots were kept outside the repo.
- Read whole: `03-journeys.md` 0.2. Read in part: `02-spec.md` 0.1, §4 (interface) and §6 (acceptance) only. Persona: G — Sitting planner (*hypothesis*, L-50).
- Gate at phase 5: `GATE OK`. Walked with S1 and S2 as taken (founder-decided, awaiting `revise`); every other Suggested item as an option, not as the design (logged in `calls.md`).
- The wireframe kit draws each "phone" as a card in a grid, so the 360 px render shows the frames at about 330 px; that is the phone check here. Sticky docks, the keyboard and animation can't be judged from these stills.

### Coverage

Every acceptance criterion with a user-visible path has a frame; the journeys' Coverage and the wireframes' Coverage tables agree. Earlier passes: none (this pass creates the file).

| Criterion | Screen | States | Status |
|---|---|---|---|
| AC-1, AC-2 | plate 2 (switch line) | not enough data | no screen by nature beyond the line; covered |
| AC-3, AC-8, AC-9, AC-10 | plate 1 | default · loading · empty (S8 only) | covered; Today has no error state (P1-F6) |
| AC-4 | plate 4 (old tab) | error (S11 only) | covered as an option |
| AC-5, AC-6 | — | — | no screen by nature (migration) |
| AC-7 | plate 10 | copy | covered; new words are the build's |
| AC-11, AC-12 | plate 1 (dragging), plate 7 | revealed state drawn | covered; refused drop and a non-drag alternative missing (P1-F14) |
| AC-13 | plate 2, all five forms | notices | covered |
| AC-14, AC-15, AC-16 | plate 1 | fold open and closed | covered |
| AC-17, AC-18, AC-19, AC-21, AC-22 | plates 1, 4 | default · notice (W14) | covered; crossing has no failure state (P1-F6); uncrossing a moved item (P1-F4) |
| AC-20 | — | — | no screen (API refusal) |
| AC-23 to AC-27 | plate 3 | default · day · saved · refused · not saved (S9) · RTL | covered; desktop modal not drawn (P1-F18) |
| AC-28, AC-29, AC-30 | plates 5, 6 | loading → resumed | covered; load failure of `/session` not drawn (P1-F6) |
| AC-31 to AC-39 | plate 5 | default · follow-ups · changed · empty · not saved (S9) · complete · RTL | covered |
| AC-40 to AC-45 | plate 7 | default · empty day · fold open · next date changed (loading) · desktop | covered; gathering failure not drawn (P1-F6); shrinking the next date not drawn (P1-F17) |
| AC-46, AC-47 | plate 8 | empty · filled · limit | covered |
| AC-48 | plates 1, 7 | loading | covered |
| AC-49, AC-50 | plate 6 | default · not tracked · fill in | covered |
| AC-51, AC-52 | plate 7 (first session) | not enough data | covered; "Let them all go" has no undo (P1-F7) |
| AC-53 | plate 2 (past due), plate 4 | — | covered |
| AC-54 to AC-58 | — | — | no screen by nature (the record) |
| AC-59, AC-60, AC-64 | plates 1, 3, 5 (RTL) | RTL | drawn as structure only; no persona reads `fa` |
| AC-61, AC-62 | every plate | — | held on every plate: no count, no progress bar, no red |
| AC-63 | — | — | no screen (API) |

**States.** Empty, not-enough-data, loading and notices are drawn wherever they occur. Error is drawn for capture's refusals and the place limit; every save failure is drawn only as S9, and load failures (Today, `/session`, look-ahead gathering) and crossing failures are not drawn at all (P1-F6).
**Phone width.** Every screen has a phone frame. **Tap targets** at 360 px: several controls draw well under 44 px (P1-F15). **Reflow at 180 px:** not checkable on the wireframe kit (*Not checked*). **Colour modes:** the kit draws both; the spec fixes none beyond "no red". **Languages:** `en` in full; `fa` as RTL structure with §2.2 #17's terms only.

### Scores

G only. M6 is not scorable for any journey: G reads English only, the `fa` frames are bars apart from the fixed terms, and no selected persona reads Persian (the journeys' Personas say so). Speed is never scored.

| Journey · persona | M1 Purpose | M2 Use | M3 Data | M4 Feedback | M5 Recover | M6 Language |
|---|---|---|---|---|---|---|
| J1 · G | 4 | 3 | 4 | 4 | 3 | not scorable |
| J2 · G | 5 | 4 | 4 | 3 | 3 | not scorable |
| J3 · G | 4 | 3 | 4 | 4 | 2 | not scorable |
| J4 · G | 4 | 3 | 4 | 4 | 3 | not scorable |
| J5 · G | 5 | 4 | 5 | 3 | 3 | not scorable |

- **J1:** M2 3 at "Done for now" and the crossed rows' fixed-looking tags (P1-F3, F11); M5 3 at "Let them all go" (P1-F7).
- **J2:** M4 3 at Focus, where a "ticked" item doesn't move progress (P1-F5); M5 3 where uncrossing leaves a moved date moved, and a failed crossing shows nothing (P1-F4, F6).
- **J3:** M5 2: a sitting planner who taps **Done for now** without first tapping **Confirm these** loses the record that crossed items happened (P1-F1), and anything left unanswered leaves every planning surface (P1-F2).
- **J4:** M2 3 at the gap block, whose two buttons don't say what happens to the days' items (P1-F8).
- **J5:** M4 3: failure states exist only as Suggested options, and the place field cuts text silently (P1-F6, F16).

### Findings

All observations *simulated*; every fix a *proposal*.

| # | Finding | Where | Severity | Route | Status |
|---|---|---|---|---|---|
| P1-F1 | **Crossed items can be lost to "Done for now".** Crossed items arrive pre-filled "happened" (AC-32), but only **Confirm these** records the answer. If G taps **Done for now**, or answers the rest and moves on without confirming, they stay unanswered (AC-38): never asked again, `done` never set, Focus and project progress never move. The pre-fill looks like an answer, so G has no reason to think it isn't one. G · M5, M3 · H5. **Fix:** a pre-filled "happened" counts as the answer when the step completes, unless G changed it; **Confirm these** stays as the quick way to collapse the group. Amend AC-32 and AC-38 | J1.7, J3.3, J3.11 · plate 5 | High | revise | open |
| P1-F2 | **Items left behind by the look-back leave every planning surface.** An item left unanswered by **Done for now**, or answered "didn't happen" with no follow-up, stays on a past day with no fate: off Today (AC-10), never asked again (AC-38), not undated, so not in "No date yet". Only the project page and the actions list still show it. This is the same hole S7 closes for a gap. G · M5 · H3. **Fix (for the founder):** offer them once in the next session's look-ahead, shaped like "From before"; or accept that the project page and actions list are where they live | J3.6, J3.11, J4.7 · plates 5, 7 | Medium | question | open |
| P1-F3 | **"Done for now" says the opposite of what it does.** "For now" promises the items will be asked again; AC-38 says they won't. It also reads as leaving the session, while **← Today** is the exit and this button moves on to Look ahead. G · M2 · H2. **Fix:** rename it in §4.5 to say it moves on and skips the rest (for example "Skip the rest"), and keep it at the foot (W17) | J3.11, J4.7 · plates 5, 6 | Medium | revise | open |
| P1-F4 | **Uncrossing doesn't undo the move that crossing made.** Crossing a Saturday or undated item moves it to today (AC-19; S6 for past dates). Uncrossing removes the crossing (AC-18) but leaves it on today, so a mis-tap on the actions list re-dates an item for good; the notice (W14) shows the move but offers no way back. G · M5 · H3, H5. **Fix:** uncrossing on the same day returns the item to the date (or no date) the crossing replaced. Amend AC-18 and AC-19 | J2.11, J2.12 · plate 4 | Medium | revise | open |
| P1-F5 | **Focus shows a ticked box and unmoved progress.** By design, crossing doesn't set `done` and Focus and project progress move only at review (§4.3). The control fills like a checked checkbox (W26), so G sees "ticked" next to progress that didn't move and guesses the tick failed. G · M4 · H1, H2. **Fix (for the founder):** keep it as drawn; or add one quiet line where progress shows ("Moves at your next session"); or draw the crossing as a strike mark rather than a filling box, which also answers W26 | J2.11 · plate 4 | Medium | question | open |
| P1-F6 | **Most failures have no drawn state.** S9 covers a failed session answer and a failed capture. Nothing covers a failed crossing (Today, Focus, actions, project), a failed look-ahead edit or "From before" keep, or a failed load of Today, `/session` or the look-ahead's gathering. A crossing that silently doesn't save is crossed on screen and absent from the next look-back. G · coverage, M5 · H9. **Fix:** extend S9 to every save on these surfaces (amber "Not saved" and **Try again** on the row, what was entered kept), and add a load-failure line with **Try again** for Today and `/session`; no red | J2.2, J3.13, J5.9 · plates 1, 4, 5, 7 | Medium | revise | open |
| P1-F7 | **"Let them all go" has no undo.** One tap archives every listed "From before" item (and S7's "From the gap" copies it), while removing one item on a day has an undo. A full-width button just above the days is easy to hit while scrolling. G · M5 · H3, H5. **Fix:** the same undo toast as remove, for a few seconds | J1.9, J4.8 · plate 7 | Medium | design | open |
| P1-F8 | **The gap block doesn't say what its buttons do.** "1 December – 12 December" with **Not tracked** and **Fill in**: G can't tell that Not tracked takes those days' items out of the look-back, or that Fill in may open a long list. G · M2 · H6, H10. **Fix:** one quiet line under the dates, no count, saying what each does (for example "Skip these days, or answer them one by one") | J4.3 to J4.6 · plate 6 | Medium | design | open |
| P1-F9 | **Going back a step depends on a guess.** W25 makes a completed step's name a link back, but the frames draw it as muted plain text, so changing a look-back answer from Look ahead (AC-36) is hidden. G · M2 · H6. **Fix:** draw completed step names as links | J3.8, J3.12 · plates 7, 8 | Low | design | open |
| P1-F10 | **Nothing says the session is saved as G goes.** Every answer saves as made (AC-30), but no frame shows it, and **← Today** doesn't say it keeps the work. A planner who left other tools over upkeep may hesitate to leave. G · M4 · H1. **Fix:** a quiet "Saved as you go" in the step header, or "← Today (kept)"; no per-row tick | J3.10 · plates 5 to 8 | Low | design | open |
| P1-F11 | **Crossed rows look fixed, and the second group has no heading.** The crossed rows' "happened" tags look like static labels, though tapping a row opens its four answers; the uncrossed items start under a date with no heading, so they can read as part of "Crossed out". G · M2, M3 · H4. **Fix:** a chevron or similar on crossed rows, and a heading for the rest (for example "Not crossed") | J1.7, J3.3 · plate 5 | Low | design | open |
| P1-F12 | **"Don't ask about this" appears under one row only.** §4.5 puts it on each row; plate 5 draws it under the first item and nowhere else. G · M2 · H4. **Fix:** draw it on every unanswered row, or say where it lives (for example, on the row in focus) | J3.9 · plate 5 | Low | design | open |
| P1-F13 | **Capture's two day layouts aren't joined.** The open frame shows "Today" and "Time" chips; the day frame shows a "Day" label and five chips. Which tap turns one into the other isn't drawn or captioned. G · M2 · H6. **Fix:** caption it (for example, tapping "Today" opens the day chips) | J2.9 · plate 3 | Low | design | open |
| P1-F14 | **Drag to order has no non-drag way, and a refused drop isn't drawn.** Today and the look-ahead order by drag only (§4.1, §4.6); WCAG 2.2 SC 2.5.7 asks for a single-pointer alternative. W6 refuses a drop across start times, but no frame shows what G sees then. G · M2, M5 · H5, H7. **Fix:** a "Move up / Move down" choice (Today has no row menu yet; the look-ahead's "⋯" could hold it), and draw the refused drop (the row slides back, no message). Amend §4.1 | J2.5 · plates 1, 7 | Medium | revise | open |
| P1-F15 | **Tap targets are drawn well under 44 px at 360 px.** The cross-out square is 16 px, the answer and day chips about 22 px high, the "⋯" and the handle a few pixels, and Start, Done for now, change and Undo are inline text links. Plate 4's own note asks for ≥ 44 px on the control. G · coverage · H5. **Fix:** build every control with a hit area of at least 44 × 44 px, and check at 360 px | plates 1, 2, 5, 7 | Low | build | open |
| P1-F16 | **The place field cuts pasted text without a word.** It stops at 80 characters with no counter and no message (W11); a pasted place is cut and G may not notice. G · M4 · H1. **Fix:** a quiet line when the limit is reached, still no counter | J5.5 · plate 8 | Low | design | open |
| P1-F17 | **The changed next date frame contradicts its caption, and shrinking isn't drawn.** The caption says Thursday was chosen from Tuesday's pre-fill; the chips show Tuesday chosen and Thursday marked "←". Moving the date earlier, which hides days G already planned, has no frame. G · coverage · H1. **Fix:** redraw the frame to match J3.12, and draw the shrink (the hidden days' items keep their dates, nothing is said) | J3.12 · plate 7 | Low | design | open |
| P1-F18 | **Desktop and the setting's help are only partly drawn.** The desktop capture modal (W8) and the desktop look-back with its four answers in one row (W15) have no frame. The review setting's three help lines are placeholders, so whether G can tell "Don't ask" from "Just to know" can't be judged. G · coverage · H10. **Fix:** draw the two desktop frames, and write the three help lines | plates 3, 5, 9 | Low | design | open |

### Heuristics, in brief

- **H1 Visibility of system status:** the session line is clear in all five forms; saving and failures are invisible (P1-F5, F6, F10, F16, F17).
- **H2 Match with the real world:** "Done for now" promises a return that never comes (P1-F3); a filling box reads as done (P1-F5).
- **H3 User control and freedom:** answers can be changed, Not tracked can be changed, remove has undo; uncrossing and "Let them all go" can't be undone (P1-F4, F7, F2).
- **H4 Consistency and standards:** "Don't ask" and the crossed rows are drawn inconsistently (P1-F11, F12).
- **H5 Error prevention:** chips make out-of-range dates impossible (W22); confirming crossed items and the hit areas are the risks (P1-F1, F14, F15).
- **H6 Recognition rather than recall:** step links and the capture's day chips rely on a guess (P1-F9, F13); the gap block's buttons too (P1-F8).
- **H7 Flexibility and efficiency:** `N`, Confirm these and Done for now are good accelerators; drag has no alternative (P1-F14).
- **H8 Aesthetic and minimalist design:** strong: one line for the session, no counts, no summary, one column (W3, W23).
- **H9 Recognise, diagnose, recover from errors:** capture's refusals are well worded; most failures aren't drawn (P1-F6).
- **H10 Help and documentation:** intro and Concepts copy change (plate 10); the gap block and the review setting need their one line each (P1-F8, F18).

### For `revise`

- **P1-F1** — a pre-filled "happened" counts as the answer when the look-back completes (AC-32, AC-38).
- **P1-F3** — rename **Done for now** in §4.5 to say it moves on and skips the rest.
- **P1-F4** — uncrossing on the same day restores the date crossing replaced (AC-18, AC-19).
- **P1-F6** — extend S9 to every save on Today, Focus, the actions list, the project page, the look-ahead and "From before", and add load-failure states for Today and `/session`.
- **P1-F14** — a non-drag way to order rows, and the refused drop (§4.1, §4.6).
- And the founder's answers to P1-F2 and P1-F5, which may each add a criterion.
- Of the Suggested items, this pass supports taking S3 to S11 as written; S7 and S9 close the two holes it found worst after P1-F1. S12 is sound: on a phone the look-ahead's "+ Add to <day>" already covers capture inside the session.

### Carried

- P1-F15 (hit areas) to `build-plan`: a build requirement for every new control.
- The design findings (P1-F7 to F13, F16 to F18) to `revise`, which redraws the affected frames or carries them to the build as captions.
- P1-F2 and P1-F5 to the founder, through the main session.

### Worth keeping

- The session line: one line, five forms, never a number, a link not a button (plate 2, W2, W3).
- No count anywhere, including the fold, "Confirm these" and the gap block (AC-61 held on every plate).
- The next date as six chips: an out-of-range date can't be picked (W22).
- "No longer matters" and Not tracked staying as one dimmed line with "change" until the session completes (W16, W20).
- The look-ahead as one column at every width, so it never reads as a week calendar (W23).
- Capture's refusals: amber, under the title, the text kept (plate 3).

### Not checked

- Reflow at 180 px: the wireframe kit lays frames in a grid of fixed cards, so a 180 px render tests the kit, not the screens. For the live pass.
- Sticky docks (is "Done for now" always in view, W17), the sheet over the on-screen keyboard (W8), the crossing animation and reduced motion (AC-22): not judgeable from stills. For the live pass.
- Persian copy, bidi defects and the §2.2 #17 terms as read (AC-59, AC-60, AC-64): no persona reads Persian, and the `fa` frames are bars.
- Contrast and forced colours: the wireframes make no colour decisions.
- Keyboard order inside the session and the capture modal's focus trap (AC-27): stated in captions, checkable only live.
- A team member new to the rhythm: no persona walks it (the founder refused persona H).

## Changelog

- **0.1 · 2026-11-19** — Pass 1, design mode, against `04-wireframes.html` draft 1a: 18 findings (high 1, medium 8, low 9). Written by Claude (Opus 5.5), forked, high effort, unattended.

## References

- `03-journeys.md` 0.2; `02-spec.md` 0.1 (interface and acceptance sections); `04-wireframes.html` draft 1a; `lifecycle/review-instrument.md` 0.2; `lifecycle/personas.md` 0.3 (G); `calls.md`
