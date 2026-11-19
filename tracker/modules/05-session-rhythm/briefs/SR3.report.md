**SR3** · branch `sr3-capture` · base `main @ 051afcc` · card `briefs/SR3.md` · landed 2026-11-19 · next: `verify SR3`
**Measured at land:** +928 app (−136; locales +72) · +1137 tests · 0 moved · ~45 min (2,712 s) · ~380k tokens, against size M (card budget L, ~300–450 app lines)

---

# SR3 · Quick capture and item settings: lane report

## 1. Branch and commit hashes

Branch `sr3-capture` in `E:/_root/tracker/.claude/worktrees/sr3-capture`, from `main @ 051afcc`. Commit identity checked (`git config user.email` = `salmanian.foad2@gmail.com`) before the first and the last commit. Nothing pushed, merged or rebased. 13 commits, in order:

| Hash | What it holds |
|---|---|
| `74164d1` | Re-review item 1: a later day's uncross clears the earlier open crossing (no date restored) |
| `c9a02ae` | Item 2: uncross restores the old date only if the item is still on the crossing's day |
| `527978a` | Item 3: `setCrossed` in one interactive `$transaction`, P2002 retried, calls queued per action |
| `bbcad7b` | Item 8: a crossing writes a legacy gathered row's `gatherKey` before it moves |
| `2494b61` | Item 9: `runActionGathering` checks `todayDate` and `endDate` with `isValidDateKey` |
| `0af83ff` | Item 7: the `actions` query batches `crossedPending` |
| `e39de34` | Item 6: `dayList.ts` holds `"\u0000any-time"` (six characters), plus a NUL-byte fence |
| `ffee5af` | Items 4 and 5 for `ActionPreview` (in-flight guard; failed save stays crossed with "Not saved.") |
| `b3ff67c` | Item 5 for Today, the Focus card and Focus's Undo |
| `3cd9e89` | SR3 API: `captureAction`, `reviewSetting` in the SDL and on six mutations |
| `18487d7` | SR3 client: `AppTopBar`, `CaptureSheet`, `useCaptureKey`, `useFocusTrap`, `aria-modal` on modals, queries, locale keys |
| `3f535c3` | SR3 client: review setting on the action, interval and routine forms; estimate and start time no longer required; `ActionForm` stops sending `done` |
| `693f8d0` | SR3 e2e: `capture.spec.ts` |


## 2. Each file changed, and why

API (`api/src`):
- `services/rhythm/crossing.ts`: items 1, 2, 3, 8 (uncross clears earlier open records; restore only if still on the crossing day; one interactive transaction behind a per-action `withUserLock`, P2002 retried twice; legacy `gatherKey` frozen before a move).
- `services/rhythm/dayList.ts`: item 6, the NUL byte is now the six-character escape.
- `services/rhythm/capture.ts` (new): `captureAction`.
- `graphql/resolvers/mutations.ts`: item 9 (`isValidDateKey`); `captureAction` resolver; `reviewSetting` on `addAction`, `updateAction`, `addInterval`, `updateInterval`, `addRoutine`, `updateRoutine`.
- `graphql/resolvers/query.ts`: item 7, `actions` calls `attachCrossedPending`.
- `graphql/schema/typeDefs.ts`: `reviewSetting: ReviewSetting!` on `Interval` and `Routine`; the argument on the six mutations; `captureAction`.
- `__tests__/crossing.integration.test.ts`: tests for items 1, 2, 3, 7, 8; the "later day's uncross is a no-op" test is replaced on purpose by item 1's rule.
- `__tests__/gathering.integration.test.ts`: item 9's test.
- `__tests__/sourceText.unit.test.ts` (new): item 6's fence (no NUL byte in `services/rhythm/*.ts`).
- `__tests__/capture.integration.test.ts` (new): capture's rules, plus `addAction` still refusing a stranger's project.
- `__tests__/actions.integration.test.ts`: `reviewSetting` on each mutation and in the SDL; an edit sending `done: false` leaves `done` alone.

Client (`client/app`):
- `components/actions/ActionPreview.tsx`: items 4, 5; `aria-modal` on the postpone modal.
- `components/today/TodayPage.tsx`: item 5 (a failed row stays as set and is shown on the open list, not the closed fold); listens to `tracker:captured` and re-reads today's list.
- `components/focus/FocusCard.tsx`, `components/focus/FocusPage.tsx`: item 5 (a failed cross stays crossed with `NotSavedLine`; a failed Undo shows `NotSavedLine` with Try again instead of ignoring null).
- `components/capture/AppTopBar.tsx`, `CaptureSheet.tsx`, `events.ts` (new): the top bar, the sheet, the toast, the event constants.
- `utils/useCaptureKey.ts`, `utils/useFocusTrap.ts` (new): `N`, and the trap.
- `root.tsx`: renders `AppTopBar` above `<Outlet />` when authenticated and not on `/login`/`/register`.
- `components/rhythm/ReviewSettingField.tsx` (new): the three radios with W39's help lines.
- `components/actions/ActionForm.tsx`: review setting; no estimate or start-time requirement; no `done` on edit.
- `components/intervals/IntervalForm.tsx`: review setting (interval and routine).
- `components/actions/AddActionWidget.tsx`, `components/projects/ProjectPreview.tsx`, `components/projects/ProjectForm.tsx`, `components/focus/AddActionForm.tsx`, `components/focus/ReschedulePopover.tsx`: estimate optional, range kept.
- `components/goals/DodClarityWizard.tsx`, `components/notes/NotesModal.tsx`, `components/onboarding/ModuleIntroOverlay.tsx`, `components/projects/ProjectPreview.tsx` (x4), `components/actions/ActionPreview.tsx`: `role="dialog" aria-modal="true"` on the modal that lacked it.
- `api/queries.ts`: `CAPTURE_ACTION`; `reviewSetting` on add/update action, interval, routine and the three `GET_*` reads.
- `locales/en/common.json`, `locales/fa/common.json`: `rhythm.topBar`, `rhythm.capture`, `rhythm.reviewSetting`; `focus.minutesNeeded` replaced by `focus.minutesOptional`; `actions.errors.estimatedRequiredWithDueDate` and `timeRequiredToday` removed from both.
- Tests: `test/Capture.test.tsx`, `test/ActionFormSettings.test.tsx` (new); `test/ActionPreview.test.tsx`, `test/TodayPage.test.tsx`, `test/FocusPage.test.tsx` (items 4/5; the two Focus tests that asserted the minutes requirement are rewritten); `e2e/capture.spec.ts` (new).

## 3. Every suite or test file run

Targeted only; no full suite.

API (`cd api && npx vitest run <files>`): one run of 11 files:
`capture.integration`, `actions.integration`, `crossing.integration`, `dayList.integration`, `gathering.integration`, `sourceText.unit`, `today.integration`, `orderDay.integration`, `rhythm.integration`, `schema.unit`, `rhythmSchema.unit`: **`Test Files  11 passed (11)` / `Tests  144 passed (144)`**.

Client vitest (`cd client && npx vitest run <files>`), one run of 9 files: `Capture.test`, `ActionFormSettings.test`, `ActionFormTags.test`, `FocusPage.test`, `TodayPage.test`, `ActionPreview.test`, `CrossOutControl.test`, `rhythmFences.unit.test`, `FocusLookback.test`: **`Test Files  9 passed (9)` / `Tests  86 passed (86)`**.

Type and i18n: `npx tsc --noEmit` in `api/` and in `client/`: no output (clean). `npm run i18n:check-missing`: "All translations look good!". `npm run i18n:check-hardcoded`: "No hardcoded UI strings found."

e2e, slot A (`E2E_API_PORT=4010 E2E_WEB_PORT=5183`, `PW_CHANNEL` default `msedge`, which this machine has):
- `e2e/capture.spec.ts`: **12 passed (3.0m)**.
- `e2e/crossing.spec.ts --repeat-each=5`, alone: **20 passed (2.5m)** (4 tests x 5; "Actions list: ... uncrossing restores both" passed 5 of 5).
- `e2e/today.spec.ts`: **11 passed (1.9m)** (includes the 180 and 360 px reflow runs in en and fa, now with the top bar above the column).

Not run: the other API/client suites and the other e2e specs (actions, goals, projects, navigation...), which the card keeps for milestones. `ProjectPreview`, `ProjectForm`, `IntervalForm` and `AddActionWidget` have no client test file and I added none (see part 6).

## 4. Decisions the card didn't make

1. **Items 4 and 5 share a commit** for `ActionPreview` (same function). Items 1, 2, 3, 8 are one commit each. Items 6, 7, 9 likewise.
2. **Item 5's "stays crossed" is "stays as the person set it".** A failed cross stays crossed; a failed uncross stays uncrossed, each with "Not saved." and Try again repeating that intent. On Today a failed row would have gone into the *closed* fold where its line could not be seen, so a row whose save failed is kept on the open list (still drawn crossed) until a save succeeds.
3. **Item 3's lock.** The interactive transaction alone did not stop concurrent calls failing: on SQLite two deferred transactions that read then write answer each other with `SQLITE_BUSY` (Prisma `P1008`, 8 of 10 calls in my test). I queue calls per action with the repo's existing `withUserLock` (`cross:<actionId>`) around the transaction, and keep the P2002 retry (twice) as the card says. The test that fails on the old code uses 40 concurrent calls; 12 did not fail on the old code, so the test is a 40-call stress test (passes in about 4 s on the new code), not a deterministic repro.
4. **Item 1 also deletes earlier open records on any uncross,** not only when today has none: `deleteMany` of this action's records on other days with `crossedAt` set and no `answer`. A record that holds an answer is kept (a test asserts it).
5. **Item 9 also fixes `todayDate`,** which used the same regex; both now read "must be YYYY-MM-DD" via `isValidDateKey`.
6. **Capture refusal text for a day and no-date together** is mine: `Choose a day or no date, not both.` (plan §6.2 lists none). Time check is `HH:mm` with `Time must be HH:mm`. **A start time sent with `noDate` is dropped** by the server (an undated item with a start time has no day to be timed on); the client also hides the Time chip under "No date yet".
7. **Day chips.** "Next named weekday" = the day after tomorrow, labelled by its weekday name (card decision 1). The Today chip sends **no** `dateKey` (server uses the key at save); Tomorrow/weekday/picked days are fixed at open but are moved up to the key at save if that has passed (midnight). A typed picker date before today snaps to today (the native `min` only blocks the popup). On a phone only the selected chip shows until the day is tapped; `md` and up shows all (CSS `hidden md:inline-flex`).
8. **Top bar contents.** A `<header data-testid="app-top-bar">` with only the add button, `aria-label` "Add" (`rhythm.topBar.add`), "+" icon, label shown from `md`. No title or menu button, since W1's "Tracker ☰" belongs to the existing nav. The sheet's own dialog name is "New action" and its submit is "Add" (scoped by the dialog in tests); the sheet's dialog label avoids "Add action" so the existing `/Add action/i` selectors still match once.
9. **Toast** lives in `AppTopBar`, `role="status"`, 4 s, one at a time, as decided. The sheet dispatches nothing itself; `AppTopBar` dispatches `tracker:captured` (`detail: { dateKey }`, null for no date) from `components/capture/events.ts`. **Today listens** and re-reads its list when the day is today (J2.7 "appears in its place at once"); SR7's look-ahead is not wired.
10. **`aria-modal` was missing on eight modals**, so `useCaptureKey` would have opened capture over them. Added `role="dialog" aria-modal="true"` to: `ActionPreview`'s postpone modal, `ProjectPreview`'s four modals, `DodClarityWizard`, `NotesModal`, `ModuleIntroOverlay`. (`ConfirmDialog`, `CalendarPage`, `CalendarManageActionModal`, `OnboardingSlideshow` already had it.) None carries an `aria-labelledby`.
11. **AC-26 reaches further than the card's list.** The card named three forms; AC-26 says "the four client forms" and the code has more estimate checks. Lifted too: `AddActionWidget` (its `*`/`aria-required` and `canAdd`, used by `ProjectPreview` and `ProjectForm`), `ProjectForm`'s `isValidEstimated`, and **`ReschedulePopover`** (Focus Periods' AC-18, "a day needs minutes"). `ActionForm`'s *start time on today* requirement (`timeRequiredToday`) is lifted as well, since AC-26 names it; I removed that key too. Range 0-1440 kept everywhere; typed minutes must still be valid. `IntervalForm` keeps its required estimate (card).
12. **Locale:** `focus.minutesNeeded` ("needed to schedule") became `focus.minutesOptional` in both languages, used by `AddActionForm` and `ReschedulePopover`. Persian strings are mine, informal register, glossary words kept (کار, روز), Western digits ("200"); a Persian reader should look at them (see part 6).
13. **`updateAction` ignores `done`** already (SR0, PD-6); `ActionForm` just stops sending it. A test pins that an edit sending `done: false` leaves a done action done.

**Canon this makes stale** (reviewer edits root-sot): `02-graphql-api.md` (`captureAction`; `reviewSetting` on `Interval`, `Routine` and six mutations); `03-frontend.md` (top bar, capture sheet, `useCaptureKey`, `useFocusTrap`, `ReviewSettingField`; the estimate and start-time requirements on `ActionForm`, `AddActionWidget`, Focus's add form and reschedule popover); Focus Periods' spec AC-18 and AC-19 (day needs minutes), superseded by AC-26 - its tests changed here; the stage list. No schema change, no migration, so `01-data-model.md` and convention 12 are untouched.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. **The card's "Tests that change on purpose" is incomplete.** Its grep missed `FocusPage.test.tsx`: "asks for minutes when the action has no estimate, and never sends a day without them (AC-18)" and "adds an action ... and a day needs minutes (AC-19)" both assert the requirement AC-26 removes. I rewrote both. It also lists `ActionPreview.test` and `TodayPage.test` as maybe asserting a revert; neither did, so I added new tests there instead. `crossing.integration`'s "a later day's uncross is a no-op" is also changed on purpose (item 1).
2. **"The four client forms" (AC-26) is not four named forms anywhere;** the card lists three and the code has five estimate checks (see part 4, item 11). Verify should confirm `ReschedulePopover` is meant to be included.
3. **Item 3 as written ("one interactive `$transaction`, P2002 caught") does not fix the race on SQLite;** it needs the in-process queue (part 4, item 3). Also, `P2002` could not be provoked in my runs after the queue; the catch is defence in depth and untested.
4. **The card says `/login` and `/register` "render outside" the layout.** True of the router (`index.tsx`), but `ProtectedAppLayout` also has an `isPublic` branch; I gated the bar on `isAuthenticated && !isPublic` and e2e asserts both pages have none.
5. **Item 6:** the row's line number in `dayList.ts` was 92; the NUL was at line 101 by the time of this branch (it is found by name, as the card said). Git still shows the old blob as binary in `git diff --stat` for that commit.
6. **`calls.md` row 41 / W-table:** W9's "next named weekday" has no rule; I used the card's. The plan's `captureAction` signature has no `projectId` (matches the card); the plan's "stranger's project refused" test is `addAction`'s, kept in `capture.integration`.
7. **Item 5 on `FocusCard`:** the card says "bring `FocusCard` to SR1's trap", but its control is driven by the server read, not local state. I added a local intent map cleared when the project prop is replaced by a refetch; Focus's older generic `focus.saveError` line is no longer shown for a failed cross (it is still used for the other Focus saves).
8. **brief-common:** backslashes in Bash heredocs and `node -e '...'` bit me three times (regexes in an edit script were halved; an apostrophe ended a single-quoted block). The brief covers `sed` and heredocs but not `node -e`. Editing CRLF files with a script needs to preserve CRLF (`schema.prisma` is warned about, but every source file here is CRLF in the working copy with LF in the index).

## 6. What I couldn't verify

- **A real phone and a real keyboard layout.** `N` on a Persian layout is proven by dispatching `key: "د", code: "KeyN"`; the bottom sheet over a software keyboard is not checked. Needs the founder's phone in `fa`.
- **A real screen reader** on the sheet (focus trap, `role="dialog"`, `aria-pressed` chips) and on the review-setting radios. Needs the by-hand list at MS2.
- **Persian copy** for `rhythm.capture.*`, `rhythm.reviewSetting.*`, `rhythm.topBar.add` and `focus.minutesOptional`: written by me, not read by a Persian speaker. It belongs on the existing "Persian reader's pass" row.
- **`IntervalForm`'s review setting** (interval and routine): proven on the API (`actions.integration`) and by `tsc`, but there is no client or e2e test that opens `IntervalForm`, picks a setting and checks the saved value. `ProjectPreview`, `ProjectForm` and `AddActionWidget`'s lifted estimate likewise have no test of their own (they have none today). A one-hour client test with `useApi` mocked would close it.
- **The Jalali date picker** inside capture (`DateField` in `jalali` mode): the sheet passes `min` and a Gregorian value as `DateField` documents, but I only drove the Gregorian native input.
- **Item 3's P2002 path** is never hit after the queue; **multi-process** safety is not covered (the queue is in-process, as `userLock.ts` says of itself).
- **The top bar's effect on every other page's height** (it adds a 48 px row above `<Outlet />`): `today.spec` reflow (180/360, en/fa), `capture.spec` and `crossing.spec` pass, but pages that size themselves to `h-screen` (calendar, tools) were not looked at. Verify should open a few with the bar.
- **No stop under Budget.** All nine items and all of SR3 are done; no usage limit was hit.

## 7. One thing that would have made this stage faster

A line in `brief-common.md` that the e2e log is block-buffered when a run is started in the background (the list reporter's output only lands in the file when the process exits), plus a ready `scripts/e2e-slot-a` that starts the servers once and keeps them for `E2E_REUSE=1`. I spent most of the wall-clock waiting on three cold server starts of 2-3 minutes each, and polling a log that looked empty.
