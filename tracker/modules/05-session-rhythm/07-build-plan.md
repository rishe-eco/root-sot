# Session rhythm, stage 1 — build plan

*Module `tracker/modules/05-session-rhythm/` · Track: Module · Phase 7 · `build-plan`. The order the code lands in and the shape it takes, to the level of tables, routes, refusal codes, screens and tests, so each stage's phase card is a transcription and not a design exercise. Inputs: `02-spec.md` 0.3, `03-journeys.md` 0.3, `04-wireframes.html` draft 2, no `04b-design/` (skipped at intake), `05-ux-review.md` 0.2, `06-eval-plan.md` 0.1, `changes/01-…` and `changes/02-…`, `lifecycle/projects/tracker/` (config 0.4, brief-common 0.6, review-checklist 0.4). Update the changelog; don't fork.*

**Version 0.5 · Status: plan · 2026-11-20 · Owner: _root**

**Where this file yields.** On *what* the module does, the spec wins. On what a person experiences, the journeys win. On how it looks, the wireframes (this module has no design pass). On what the code is, the repository.

**Grading.** Everything here is **proposal**. Facts about the code and infrastructure are **as-built**, read at `rishe-eco/tracker main @ eea1c59`. No item here is **[F]**: this plan was written in the founder's unattended run (`lifecycle/unattended.md`), and every choice the skill would have asked the founder is a call, logged in `calls.md` rows 15 to 26 and refusable on the diff. SR9 was added by `revise` (`changes/03-req-ms2-fix-stage.md`; `calls.md` rows 99 to 105). The [F] items cited are the spec's and the journeys'.

---

## 0. What this plan is written against

### 0.1 · What was read

- **Module files, whole:** `02-spec.md` 0.3 (75 criteria), `03-journeys.md` 0.3 (70 steps, S1–S13), `04-wireframes.html` draft 2 (ten plates, calls W1–W39, coverage), `05-ux-review.md` 0.2 (pass 1, P1-F15 carried here), `06-eval-plan.md` 0.1 (§3.A's query, §6 #5), both change requests, `calls.md` rows 1–14, `decisions.md` 0.2.
- **Project:** `config.md` 0.4, `brief-common.md` 0.6, `review-checklist.md` 0.4; Reflect's plan (`../02-reflect/07-build-plan.md`) and its stage records `docs/development/B0.md`–`B6.md` for sizes.
- **Code at `main @ eea1c59`:** `api/prisma/schema.prisma` (Action, DayState, Interval, Routine, enums); `api/src/services/todayPreDayAfterDay.ts`, `actionGathering.ts`, `skills/planning.ts`, `focusPeriods.ts`; `api/src/graphql/resolvers/mutations.ts` (addAction, addProject, updateAction, toggleAction, postponeAction, setActionStartTime), `typeDefs.ts`, `auth.ts`, `errorPolicy.ts`; `api/Dockerfile`, `api/package.json`; `client/app/api/useApi.ts`, `queries.ts`; `client/app/root.tsx`, `protectedRoutes.tsx`, `layout/ResponsiveNavigation.tsx`, `layout/InternalPageLayout.tsx`; `components/today/*`, `actions/ActionPreview.tsx`, `actions/ActionForm.tsx`, `focus/FocusCard.tsx`, `FocusPage.tsx`, `UndoToast.tsx`, `ui/confirm-dialog.tsx`, `calendar/CalendarEvent.tsx`, `lib/timeThemes.ts`; `client/vite.config.ts`, `client/package.json`; `client/e2e/` (specs and helpers); the API tests that pin the rules this module changes.

### 0.2 · What this plan must not break

- **Gathering's lock and dedup** (`actionGathering.ts:310-334`, D-55, D-57) and its tests, apart from the horizon and the dedup key changed on purpose (SR0).
- **Ownership:** every resolver `requireAuth` and `ensureOwned`; a stranger's id answers `Not found` (convention 1).
- **Every reader of `Action.done`** (Focus progress, project and goal status, the calendar's and Tools' filters, `skills/planning.ts`): they keep working; only *when* `done` moves changes.
- **Reflect, Noticing, Skills, Focus Periods, Time Themes:** untouched apart from the shared checkbox and Today's skills line (PD-9).
- **`DayState` rows** and `actionGatheringCompletedAt` (AC-5); every existing row of every table, apart from new fields' defaults (AC-6).
- **The deploy:** no stage touches the stop files (`api/docker-compose.yml`, `api/.env.example`, `deploy/`, `.github/`); no stage adds an environment variable.
- **The fences of §4.9:** no count, no red, on Today, the session and capture.

### 0.3 · House rules this build is held to

- `tracker/canon/02-architecture/04-conventions.md`: 1 (ownership), 2 (a list field is a JSON string; the gap's items), 6 (`useApi` and `queries.ts`), 7 (`en` and `fa`, informal, glossary; Western digits; `useAppDate` for read dates, `dateUtils` for wire dates), 8 (each step commits as made), 9 (`ConfirmDialog` for destructive actions: none here, every removal has an undo instead), 12 (schema change and the data model doc together; flagged for `close-out`).
- `brief-common.md` 0.6 in full, notably: no new dependency unless the card names one (none is named: `@dnd-kit/core` and `@dnd-kit/sortable` are already in `client/package.json`); `schema.prisma` is CRLF; targeted tests only.
- `lifecycle/README.md` §6: one stage per lane; Sonnet builds, Opus reviews; tests against a fixed clock (rule 8: here, fixed date keys, T0 = `2026-12-01`); no debugging through e2e.
- `review-checklist.md` §4 for every UI stage: both languages in a browser, 360 px with no horizontal scroll, the reflow rule at 180 px (`client/e2e/helpers/reflow.ts`), the light scheme.

### 0.4 · Found while reading *(defects in the documents and code, each assigned)*

| # | Defect | Where | Assigned to |
|---|---|---|---|
| D-1 | **There is no top bar.** Navigation is a sidebar at `md` and up and a bottom bar below it. The spec (§2.2 #14, AC-23, AC-73) and W1 assume a top bar that holds the add control and hides on `/session` | `layout/ResponsiveNavigation.tsx:39-63`; `root.tsx:50-56` | SR3 builds it (PD-4); SR6 hides it |
| D-2 | **Moving or retiming a gathered occurrence resurrects it.** Dedup keys on `forDate` and `startTimeOfDay`; `postponeAction` changes both; any template edit reopens gathered dates, which then recreates the occurrence on its old day and time. The module moves occurrences (crossing, Place the rest, look-ahead moves and times) and writes their sources (order, "Don't ask"), so this would fire daily | `actionGathering.ts:288-301`, :372-408; `mutations.ts` `postponeAction` | SR0 (PD-3) |
| D-3 | **Editing an action erases "happened".** `ActionForm` sends `done: false` on every edit, and `updateAction` writes it. AC-36 breaks the first time the person renames an item or sets its review setting | `ActionForm.tsx:249-260`; `mutations.ts` `updateAction` | SR0 (server ignores), SR3 (client stops sending) |
| D-4 | **Overlap marks rows with no estimate.** A missing estimate counts as 0, and a zero-length row inside another's span overlaps it; AC-15 says never | `todayPreDayAfterDay.ts:26-35`, :108 | SR0 |
| D-5 | **Failed saves are silent.** `useApi.call` returns null and never throws, so `handleToggle`'s `catch` never runs and the optimistic state sticks. Every save this module adds must test for null (AC-69) | `useApi.ts:62-90`; `ActionPreview.tsx:200-212` | SR1 (`useRetryableSave`), every later UI stage |
| D-6 | **Today draws a failed load as empty**, which would read "Nothing on today." (AC-68) instead of AC-70's line | `TodayPage.tsx:68-72` | SR2 |
| D-7 | **Today shows a count:** "{{count}} skill items due", against AC-61 | `TodayPage.tsx:217-224`; `common.json:412-413` | SR2 (PD-9) |
| D-8 | **AC-72 can't reach a bundle built before its handler.** An old tab runs old `useApi`, which drops the error. Only tabs loaded after a deploy that carries the handler can show "Tracker was updated. Reload" | spec §2.3 #29; `useApi.ts` | SR0 ships the handler; push order PD-10 |
| D-9 | **The switch must not reach production before the session exists.** Today (SR2) creates the rhythm state (AC-1) and links to `/session` (SR6–SR7); a push to `main` deploys (config §7); D-68's four weeks start at the switch | config §7; eval plan §2 | push order PD-10 |
| D-10 | **Skills replanning hard-deletes undone future skill actions;** a day-record foreign key would block it or lose the records | `skills/planning.ts:154-162` | SR0 (cascade; §9) |
| D-11 | **Legacy data meets the new invariants:** actions done before the switch have no day record (AC-36's "exactly when"), none has a first-due date (AC-54), and undated done actions would fill "No date yet" (AC-44 says "no fate", not "not done") | spec AC-36, AC-44, AC-54 | SR0, SR4, SR5 (PD-7) |
| D-12 | **Focus's undo toast says "Done: <title>"** and undoes with `toggleAction`; crossing claims nothing (D-67) | `UndoToast.tsx`; `FocusPage.tsx:56-62` | SR1 |
| D-13 | **No focus-trapping modal exists:** `ConfirmDialog` has none, and Radix Dialog isn't installed (AC-27) | `ui/confirm-dialog.tsx`; `client/package.json` | SR3 (PD-5) |
| D-14 | **"Calendar's band component" isn't a component:** bands are `tagColorClasses(…).band` classes inside `CalendarEvent`, plus Today's themes strip (§4.6, AC-42) | `CalendarEvent.tsx:27-29`; `lib/timeThemes.ts` | SR7 |
| D-15 | **API tokens with write scope** can call `toggleAction` and `updateAction(done)` today; afterwards nothing outside the look-back sets `done`. No caller in either repo | `auth.ts`; `ApiTokenScope` | §7; §10 |
| D-16 | **Date keys bound nothing but their format** (R5): a crafted switch date decades back makes the first look-back's range decades long, for the caller's own data only | spec R5 | SR0, SR4 (PD-8) |
| D-17 | **Growth.** Day records: one per action per day (unique key). Sessions: one open per user (unique `openForUserId`). Gaps: one per session. Rhythm state: one per user. Titles ≤ 200, place ≤ 80. "Don't ask" propagation: the gathered horizon, ≤ today+7. A gap's stored items: that day's "ask me" actions, capped at 200. Unbounded but read, not created: "No date yet" and "From before" list every matching action | spec §6.8 | SR0, SR4, SR5; §9 |
| D-18 | **Config 0.4 is stale:** §1 says stage records and the development README are planned (both exist since Reflect); §5 and §6 are empty; §6's milestone script `cd`s to the Linux path and runs `npm run typecheck`, which §3 says fails on this app | `lifecycle/projects/tracker/config.md` | SR0's `verify` (§10) |
| D-19 | **`notDoneActionsForDate` goes dead** when the After-day wizard does; AC-4 doesn't retire it | `typeDefs.ts:2394`; `AfterDayWizard.tsx` | SR2 leaves it (PD-17) |
| D-20 | **An `.ics` UID built from a session or user id** would carry an identifier into a third-party calendar (§2.2 #13: nothing personal leaves) | spec §2.2 #13 | SR7 |
| D-21 | **A gathered action's day is `forDate`, every other action's `tbd`.** Each new rule about "the day it is planned on" must read and write the right one | `todayPreDayAfterDay.ts:39-65` | SR0 (helpers) |
| D-22 | **"Never a count" leaks through i18n:** a `{{count}}` or `_one`/`_other` key is how a number reaches a surface | spec §4.9 | SR2 (fence), SR7 (extended) |

## 1. The shape at the end

The day gate is gone: Today is a list in time order with a quiet session line, a "Crossed out" fold and no wizard. A square control crosses an item out on Today, the project page, the actions list and Focus; it writes a day record and never `done`. Capture opens from a slim top bar or `N`. `/session` runs three steps that save as they go: the look-back (answers per item per day, with the gap block), the look-ahead (the next date and the days up to it, with "From before" and "From the gap"), and when and where (with an `.ics`). Four tables hold the rhythm state, sessions, day records and gaps; a read-only script on the box reads them for the four-week test. Nothing counts anything on screen.

## 2. Planning decisions *(each the founder's to veto)*

**PD-1 · Stage ids SR0 to SR8.** The tracker repo already has `docs/development/B0.md`–`B6.md` and `fix-B-15.md` from Reflect, so `B<n>` would collide. `SR` (session rhythm) is new; branches are `sr<n>-<slug>`. *Call row 15.*

**PD-2 · The whole schema lands in SR0.** The spec fixes every table and field (§1.2, §6.8), so later stages never touch `schema.prisma` and could run in pairs.

**PD-3 · Gathered occurrences get a stored identity.** New `Action.gatherKey`, written at gather time from today's key formula; dedup reads `gatherKey ?? <the formula on the row's fields>`, so old rows need no backfill (AC-6) and a moved or retimed occurrence is never recreated (D-2). The lock is unchanged. *Call row 16.*

**PD-4 · A slim top bar is built.** Spec, journeys and wireframes all name one, and the app has none (D-1). `AppTopBar` sits above the page in `root.tsx`, holds only the add control (W1: "+" at its end on a phone, "+ Add" on desktop) and is hidden, with the navigation, on `/session`. Nothing else moves into it. *Call row 17.*

**PD-5 · No new dependency.** Capture's focus trap is written by hand (D-13), drag uses the installed `@dnd-kit`, and the `.ics` is a small string builder.

**PD-6 · `updateAction` keeps its `done` argument and ignores it.** Removing it would break every tab open across the deploy on its next edit; ignoring it closes D-3 on the server. `ActionForm` stops sending it in SR3. *Call row 18.*

**PD-7 · Legacy data.** (a) `firstDueKey` is written when an action first gets a date, and, for an action dated before the module, frozen to its current day on its first move, so AC-54 holds from the switch on. (b) The look-back skips an action that is `done` with no answered day record (done before the switch). (c) "No date yet" lists undated actions with no fate **and not done**, reading AC-44 as AC-51 reads "open". The reading goes to `revise` as a wording fix at close-out. *Call row 19.*

**PD-8 · Date keys are trusted, as the spec's R5 accepts.** The server validates format, sets the switch date once, refuses a session continued on a day before its own date, and computes ranges from stored keys. No server-clock bound, so tests drive days by key (T0 = `2026-12-01`) and e2e by `page.clock`. *Call row 20.*

**PD-9 · Today's skills line stays, without its number.** "Skill practice is due" replaces "{{count}} skill items due" (D-7, AC-61). The line and its link are unchanged otherwise. *Call row 21.*

**PD-10 · Push order.** Nothing in this run is pushed. When the founder pushes: first SR0's merge commit alone (`git push origin <SR0 merge>:main`), which deploys the reload handler and changes nothing visible; open tabs then reload on their own (`vite-plugin-pwa` `autoUpdate`). Nothing after SR0 is pushed until MS2 passes, so the switch and the removals (SR1, SR2) land with the whole session (D-8, D-9). *Call row 22.*

**PD-11 · One reload rule.** Any GraphQL error with `extensions.code` `GRAPHQL_VALIDATION_FAILED` shows the app-wide line "Tracker was updated." with **Reload**, and the call writes nothing. A validation failure only happens when client and server disagree, which is exactly the old tab of AC-72.

**PD-12 · The API follows the screens' save boundaries** (§6.1): one mutation per thing the person saves (a crossing, an order, a capture, an answer with its follow-up, a gap choice, a next date, a planned item, a block let go, when and where, Finish), each idempotent where a retry can repeat it.

**PD-13 · The look-back's items are computed live from a fixed range.** The range (and the gap block) are fixed when the session starts; the items are the "ask me", fateless actions planned on its days, plus any action with a day record in the range answered in this session (so a "no longer matters" row stays dimmed, W16), less legacy done (PD-7b). No item snapshot is stored.

**PD-14 · "Shown" is marked by the client.** "From before" and "From the gap" count as offered when their block renders: the look-ahead calls `markShown` once. Within that session the block keeps showing; afterwards it is gone (AC-52, AC-67).

**PD-15 · The query script is a stage of its own, SR8,** after the last stage that writes the record. The eval plan asks for it "in the record's stage"; the record is written by SR1, SR4 and SR5, and a separate S stage keeps those in bounds. *Call row 23.*

**PD-16 · 44 px hit areas, checked by a test (P1-F15, accepted).** Every new control has a hit area of at least 44 × 44 px (padding or a `::before`), whatever it draws. SR1 adds `client/e2e/helpers/hitArea.ts` (`expectHitAreas`), and each UI stage's e2e runs it at 360 px.

**PD-17 · `notDoneActionsForDate` is left in place, unused** (D-19), and flagged for `close-out`'s known issues. AC-4 doesn't name it.

**PD-18 · Every wireframe call is accepted as drawn (W1–W39).** W14's "once" is read as "each time a crossing moves an item". W1 sits on the top bar of PD-4. Each lands in the stage the table below names. *Call row 23.*

**PD-19 · Crossing a fated action is refused.** The control is not shown on a row with a fate (Backlog, Postponed, …), and the server refuses it. Crossing is about today's plate, and a fated item isn't on it. *Call row 24.*

**PD-20 · One lane at a time.** §3 allows pairs; the unattended run takes the stages one by one in §3's order (`unattended.md` rule 8).

**The open items, settled** (step 3 of the skill):

| Item | Source | Outcome |
|---|---|---|
| S1–S12 | journeys §4 | Accepted at spec 0.2; built where §6.7 puts their criteria |
| S13 (the session's own saves fail visibly) | journeys §4; change 02 #1 | Accepted at spec 0.3; built in SR6 (look-back steps) and SR7 (next date, when and where, Finish); not drawn, so the cards draw it from W29 |
| W1, W8, W9, W10, W11, W12, W30 | wireframes | Accepted: SR3 |
| W2, W3, W4, W5, W6, W7, W27, W28 | wireframes | Accepted: SR2 (W5, W27, W28 also SR7) |
| W13, W14, W26, W29, W31 | wireframes | Accepted: SR1 (W29's line is shared) |
| W15–W21, W25, W32–W35 | wireframes | Accepted: SR6 |
| W22, W23, W24, W36, W37, W38 | wireframes | Accepted: SR7 |
| W39 | wireframes | Accepted: SR3 |
| P1-F15 (hit areas) | UX review, carried; change 01 *Open* | Accepted: PD-16, every UI stage |
| P1-F7 to F14, F16 to F18 | UX review | Settled before this plan (spec 0.2, wireframes draft 2); nothing open |
| P1-F2, P1-F5 | UX review | Answered as calls 6 and 7 (spec §2.3 #35, #36); nothing open |
| Query script card (eval plan §6 #5) | change 02 *Open* | Accepted: SR8 (PD-15) |
| Design *Beyond the spec* | — | None: no design pass |

## 3. Stage order

| Stage | Name | Size | After | Parallel with | Milestone |
|---|---|---|---|---|---|
| SR0 | Schema and the shared day rules | L | — | — | — |
| SR1 | Crossing out, everywhere | M | SR0 | SR4 | — |
| SR2 | Today, with the gate retired | L | SR1 | SR4, SR5 | — |
| SR3 | Quick capture and item settings | M | SR0 | SR4, SR5 | — |
| SR4 | Session API: shell, look-back, gap | L | SR0 | SR1, SR2, SR3 | — |
| SR5 | Session API: look-ahead, next session, Finish | M | SR4 | SR2, SR3 | MS1 |
| SR6 | Session screens: shell and look-back | L | SR2, SR4 | SR5 | — |
| SR7 | Session screens: look-ahead, when and where | L | SR3, SR5, SR6 | SR8 | — |
| SR8 | The record query, `rhythmGate` | S | SR5 | SR7 | — |
| SR9 | MS2's fixes: hit areas and the rows due | M | SR8 | — | MS2 |

- **The unattended run's order:** SR0, SR1, SR2, SR3, SR4, SR5 (then MS1), SR6, SR7, SR8, SR9 (then MS2). One lane at a time (PD-20).
- **Schema:** only SR0 changes `schema.prisma` (PD-2), so any pair above is schema-safe. Pairs that share `mutations.ts`, `typeDefs.ts`, `queries.ts` and both `common.json` add under their own namespaces (`rhythm.today`, `rhythm.capture`, `rhythm.session`, …), and the second `verify` resolves the merge.
- **Lane slots** (config §4): one lane at a time takes slot A; a pair would take A and B.
- **MS1** (after SR5): the full API suite; the API complete; Today, crossing and capture driven end to end. **Needs config §6's milestone script fixed first** (D-18).
- **MS2** (after SR9; first run after SR8 found the controls SR9 fixes): the full API, client and e2e suites; the by-hand list (§8); then the push of PD-10's second half, the deploy, and the founder's sign-in. The switch date is set by that deploy's first visit.
- **Cost:** about 36 lane hours at the bands' midpoints, 10 Opus `verify` reviews and 2 milestones (MS2 run twice). Reflect ran under its hours; read them as a ceiling.

**Sizes** *(lane hours, and lines of new app code, with tests and moved code counted apart)*: **S** 1–2 h, up to ~300 lines · **M** 2–4 h, ~300–700 lines · **L** 4–6 h, ~700–1,300 lines. Recalibrated from Reflect's records: its L stages added 810 (B2), 1,187 (B4) and 1,161 (B5) lines of app code; its M stages 234 (B3) and 515 (B6).

## 4. P0 — pre-flight

**P0-1 · The Persian terms of §2.2 #17.** Answered [F] at journeys §1 #3: kept as proposed.

**P0-2 · The push order of PD-10.** Open; the founder's, at the end of this run. Needed by: the first push.

**P0-3 · Config 0.4's stale facts** (D-18): the milestone script's path and its `npm run typecheck`, §1's "planned" stage records and README, §5 and §6's empty tables. Open; SR0's `verify` applies the edits in this run (`unattended.md` rule 7). Needed by: MS1. Not needed by SR0, which runs no milestone and no review script.

**P0-4 · A phone and a calendar app for the by-hand checks** (§8): the `.ics` imported into the founder's calendar, Today and the session at phone width in `fa`. Open; the founder's devices aren't recorded (config §2). Needed by: MS2.

**P0-5 · The eval plan's preconditions, placed.** The record's tables: SR0. The query, tested on a fixture: SR8. Present in the deployed image: the MS2 deploy (`dist/scripts/rhythmGate.js`). The switch date stored: the founder's first visit after that deploy (AC-1). Read access to `api/data/prod.db` on the box: answered (config §7). E1 at `close-out`; E2 and E3 are the founder's, never unattended (eval plan §2).

**P0-6 · A stray worktree** in the tracker checkout: `.claude/worktrees/xenodochial-ramanujan-376dc8` on `bbd57a3`, not from this module. Lanes make fresh worktrees and don't touch it. Open for the founder; needed by nothing.

## 5. The stages

### SR0 · Schema and the shared day rules

**Goal.** Every table and field the module needs, and the server rules later stages build on: an action's planned day and first-due date, gathering that survives moves and reaches the session's horizon, one order and one overlap rule per day, the rhythm state, and the client's reload line. Nothing else visible changes.

**Schema** One migration, `add_session_rhythm`, adding only (AC-6):
- enums `ReviewSetting { ask dontAsk justToKnow }`, `RhythmAnswer { happened partly didntHappen noLongerMatters }`, `RhythmFollowUp { moved setAside letGo }`, `GapChoice { notTracked fillIn }`;
- `Action`: `reviewSetting @default(ask)`, `sortOrder Int?`, `firstDueKey String?`, `gatherKey String?`; indexes `(userId, tbd)`, `(userId, forDate)`. `Interval`, `Routine`: `reviewSetting`, `sortOrder Int?`;
- `RhythmState`, `RhythmSession`, `DayRecord`, `RhythmGap` as §6.3.

**Logic**
- `services/rhythm/days.ts`: `plannedDayKey(action)` (`forDate` if gathered, else `tbd`) and `plannedDayData(action, key | null)` (D-21); `freezeFirstDue(action)` before any date change (PD-7a). `addAction`, `addProject`'s actions and gathering set `firstDueKey` when dated; `updateAction` and `postponeAction` freeze it first.
- Gathering: `gatherKey` on create; dedup on `gatherKey ?? gatheredActionKey(row)` (PD-3); `getGatheringDateKeys(today, endKey?)` gives today through max(today+2, endKey), at most today+7 (AC-48); `runActionGathering(todayDate, endDate?)`. Copies `reviewSetting` and `sortOrder` from the source.
- `services/rhythm/dayList.ts`: `dayList(dateKey)` — actions planned that day with no fate, each with `crossed` and `overlaps` (timed rows with an estimate only, D-4), ordered per §2.2 #8 (`sortOrder` nulls last, then `createdAt`).
- `orderDay(dateKey, actionIds)`: one group only (one start time, or all untimed); writes `sortOrder` 1000, 2000, …, and on a gathered row its source's too (AC-12's server half).
- `ensureRhythm(todayKey)` creates the state (switch date, spacing 3) once; `rhythmStatus(todayKey)` returns the line (`first`, `next`, `dueToday`, `wasDue`, `inProgress`) and dates.
- `updateAction` ignores `done` (PD-6); no resolver requires an estimate (AC-26's server half).
- Client `useApi`: a `GRAPHQL_VALIDATION_FAILED` error sets an app-wide store; `root.tsx` shows "Tracker was updated." with **Reload** (PD-11).

**API or routes** query `dayList`, `rhythmStatus`; mutations `orderDay`, `ensureRhythm`; `runActionGathering` gains `endDate`. Refusals: §6.2 (`orderDay`, date format).

**Screens.** The reload line only (W28's neutral style).

**Tests** `schema.unit`: the new fields and unique keys. `gathering.integration`: a moved and a retimed occurrence aren't recreated after a template edit; the horizon at no due date, due +5, due +9 (`:33` and `recurrence.unit.test.ts:32` change on purpose). `dayList.integration`: order, overlap with and without estimate, fates excluded. `orderDay` refusals. `rhythm.integration`: `ensureRhythm` idempotent; each line form. `actions.integration`: `done` ignored; dated without estimate saves; `firstDueKey` set and frozen. Client: the validation error raises the line.

**Image and deploy.** No variable. The migration runs at boot; the deploy backs up first.

**Constraints from earlier stages.** `withUserLock`; `DayState`'s `(userId, dateKey)`; `ensureOwned`'s `Not found`.

**Acceptance.** AC-5, AC-6, AC-48, AC-54, AC-72.

**Size: L.**

**Traps.**
- Columns and tables only: no `UPDATE` of an existing row in the migration (AC-6).
- Prisma's `@updatedAt` moves on every source write and reopens gathered dates; harmless once dedup reads `gatherKey`, so test edit-after-move, not the timestamp.
- Don't call `ensureRhythm` from the client here: SR2 sets the switch (D-9).
- `toggleAction`, `preDayStatus` and the wizards keep working; SR1 and SR2 retire them.

**Not here:** crossing (SR1), Today's screen (SR2), sessions (SR4).

---

### SR1 · Crossing out, everywhere

**Goal.** The cross-out control on the project page, the actions list and Focus, the crossing API, "Moves at your next session", and `toggleAction` gone. Also the shared failure line and the hit-area helper every later UI stage uses.

**Schema** none.

**Logic** `services/rhythm/crossing.ts`, `setCrossed(actionId, todayKey, crossed)`:
- refuses a "just to know" or fated action (PD-19); `Not found` for a stranger's;
- **cross:** if the planned day isn't `todayKey` (past, future or none), freeze `firstDueKey`, move it to today and note `crossMoved` and `movedFromKey` (null = had no date); upsert the day record for `todayKey` with `crossedAt`;
- **uncross:** clear `crossedAt`; if `crossMoved` and the record's day is `todayKey`, restore the day or no date (AC-18); delete the record when it holds no answer;
- never touches `done`.
- `crossedPending` on `Action` (a crossed record with no answer, not done), batched in the Focus and project queries, drives AC-75.

**API or routes** mutation `setCrossed(id, todayKey, crossed): CrossResult { action, moved }`. `toggleAction` removed from the SDL, the resolver, `queries.ts` and every caller (AC-17).

**Screens.** Plate 4. `CrossOutControl` (W26): a square in the checkbox's slot, filled when crossed, `aria-pressed`, labelled; the title strikes through, animated unless reduced motion (AC-22); `stopPropagation` inside link rows (AC-21). In `ActionPreview` (project page, actions list, activities) and `FocusCard`: a crossed row stays in place (W13); a moving crossing toasts "Moved to today and crossed out" (W14). Focus's undo toast reads "Crossed out: <title>", **Undo** uncrosses (D-12). "Moves at your next session", muted, under the progress on Focus and the project page (W31). Shared: `NotSavedLine` (amber "Not saved." and **Try again**, W29) and `useRetryableSave`, which treats a null `call()` as failure (D-5).

**Tests** `crossing.integration`: today; future, past and undated moved with first-due unchanged; a gathered one moved by `forDate`; uncross same day restores (date, no date); a later day doesn't; refusals; `done` unchanged. `actions.integration.test.ts:123-131` replaced. Client: the control in a link doesn't navigate; reduced motion; `FocusPage.test.tsx:235` and `ActionPreview.test.tsx:105` change on purpose. `client/e2e/helpers/hitArea.ts`. e2e `crossing.spec.ts`: J2.11, J2.11a, J2.12 at 360 px with `expectHitAreas`; `fa` once.

**Image and deploy.** none.

**Constraints from earlier stages.** SR0's `plannedDayData`, `freezeFirstDue`, the day record's `(actionId, dateKey)`.

**Acceptance.** AC-17, AC-18, AC-19, AC-20, AC-21, AC-22, AC-55, AC-75.

**Size: M.**

**Traps.**
- `ToolsPage.tsx`'s local `toggleAction` is a selection helper: leave it.
- `ActivitiesPage` hides done rows; crossing sets no `done`, so crossed rows stay visible there, as W13 wants.
- The control on a failed save stays crossed with the line under it; it doesn't snap back.
- This stage's removal must deploy after SR0's (PD-10).

**Not here:** Today's rows (SR2).

---

### SR2 · Today, with the gate retired

**Goal.** Today opens with its list: the session line, time order, the fold, ordering by drag or Move up/down, the empty and failed states. The wizards, the buttons, the pre-day operations, their intros and the "locked" copy are gone. The first visit creates the rhythm state.

**Schema** none.

**Logic** Removed: `getPreDayStatus`, the `preDayStatus` query, `completePreDay`, `completeAfterDay`, their SDL types and `queries.ts` entries; `PreDayWizard.tsx`, `AfterDayWizard.tsx`, `TodayActionRow.tsx`, `TodayActionWidget.tsx` and their tests. Kept: `DayState`, `getTodayActions`, `overlaps`, `notDoneActionsForDate` (PD-17). `ensureRhythm(todayKey)` runs once per app load from the protected root, so the first page of any kind sets the switch date (AC-1).

**API or routes** none new: SR0's `dayList`, `orderDay`, `rhythmStatus`, `runActionGathering(endDate = day before the due date)`; SR1's `setCrossed`. Client route `/today` unchanged.

**Screens.** Plates 1, 2, 10. `TodayPage` rebuilt:
- the session line under the date, its link at the end (W2), its five forms (§4.1), no number; "Plan your next days" with nothing else (W3). Links go to `/session` (SR6);
- the themes strip and the journal quick-add stay; the skills line loses its number (PD-9);
- timed rows, then "Any time"; `TodayRow`: title, time, the amber start-edge bar labelled "Overlaps" (W5), project or source, the "just to know" slot (W4), `CrossOutControl`; the handle is a button for Move up/Move down and a hold to drag within its group (W6, W27); a refused drop slides back silently;
- the "Crossed out" fold, closed, no count, hidden when empty; "Nothing on today." (AC-68); placeholder rows while loading or gathering (W7, retiring `today.gatheringActions`); "Today didn't load." with **Try again** on a failed load, never the empty line (W28, D-6).
- Copy: the today intro without "locked"; the pre-day and after-day intros removed; Concepts' day-state section rewritten (`ConceptsPage.tsx:125-134`; `common.json:478`, :900-907, :995-1018), `en` and `fa`.

**Tests** Client: line forms; fold hidden when empty; failed load shows the line. `rhythmFences.unit.test.ts` (client): no `{{count}}` or plural key under the module's namespaces; no `red-` or `destructive` class in its files (D-22). e2e `today.spec.ts` rewritten (`:24` and `:58` go on purpose): J1.1–J1.3, J2.1–J2.6, J2.13a at 360 and 1200 px; order survives reload; refused drop; `expectHitAreas`; reflow at 180 px.

**Image and deploy.** none.

**Constraints from earlier stages.** `orderDay` refuses a mixed group; `ensureRhythm` never moves a switch date; `setCrossed` refuses "just to know".

**Acceptance.** AC-1, AC-2, AC-3, AC-4, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-14, AC-15, AC-16, AC-53, AC-68.

**Size: L.**

**Traps.**
- StrictMode fires mount effects twice: `ensureRhythm` is idempotent and gathering locked; don't add a client guard that hides a real failure.
- Drag uses a pointer sensor on the handle only; keyboard order is Move up/Move down.
- Removing intro keys leaves `ModuleIntroViewed` rows in the database: harmless, don't migrate them.
- This stage switches the founder on first load: it must not deploy before MS2 (PD-10).

**Not here:** capture (SR3), `/session` (SR6).

---

### SR3 · Quick capture and item settings

**Goal.** The top bar with its add control, `N`, the capture sheet and its API; the review setting on the action, interval and routine forms; no form requires an estimate or a start time.

**Schema** none.

**Logic** `captureAction`: trims the title, refuses empty or over 200, refuses a date before `todayKey` (AC-71); creates a standalone "ask me" action on the date, today when none is given, or with no date; sets `firstDueKey`. Review setting on a source affects new gathers only; the look-back's "Don't ask" propagation is SR4's.

**API or routes** mutation `captureAction(title, todayKey, dateKey, noDate, startTimeOfDay)`. `addAction`, `updateAction`, the interval and routine mutations gain `reviewSetting`.

**Screens.** Plates 3, 9.
- `AppTopBar` (PD-4) in `root.tsx`, on every protected page: "+" at the end on a phone, "+ Add" on desktop (W1).
- `useCaptureKey`: `event.code === "KeyN"`, no modifier, not `isComposing` or repeat, not in an input, textarea, select or contenteditable, not while a dialog is open (AC-23).
- `CaptureSheet`: a bottom sheet on a phone, a small centred modal on desktop (W8); focus on the title, trapped, restored on close; Escape or outside closes without asking (W12, AC-27). Day chips: Today (selected), Tomorrow, the next named weekday, "Pick a date…" (`DateField`, min today), "No date yet"; a time chip opening `HH:mm` (W9); on desktop the chips show at once, with **Cancel** (W30). No counter; the title refused on Enter with a message (W11). Toasts "Added to today", "Added to <weekday>", "Added, no date" (W10). A failed save keeps the text, with `NotSavedLine` in the sheet. On success it dispatches `tracker:captured` with the day (for SR7).
- Forms: the review setting (Ask me, Don't ask, Just to know) with W39's help lines on `ActionForm` and `IntervalForm` (interval and routine); estimate and start time no longer required (`ActionForm.tsx:212-236`, `focus/AddActionForm.tsx:38-49`, `ProjectPreview.tsx:238-242`); `ActionForm` stops sending `done` (D-3).

**Tests** `capture.integration`: today default, no date, a future date, past refused, title bounds, a stranger's project refused. `actions.integration`: `reviewSetting` saved on each form's mutation. Client: focus trap and return; `n` in a field types `n`. e2e `capture.spec.ts`: J2.7–J2.10 (`fa` with `KeyN`), J5.1–J5.3; `expectHitAreas`; reflow.

**Image and deploy.** none.

**Constraints from earlier stages.** SR0's `firstDueKey` rule and the estimate rule removed on the server.

**Acceptance.** AC-23, AC-24, AC-25, AC-26, AC-27, AC-71.

**Size: M.**

**Traps.**
- Capture's "today" is the client's key at save, not at open (midnight).
- The top bar must not appear on the sign-in pages.
- Persian layout: test `code`, never `key` (د).

**Not here:** the top bar hidden on `/session` (SR6); the look-ahead refreshing on capture (SR7).

---

### SR4 · Session API: shell, look-back, gap

**Goal.** Starting and continuing a session, the look-back's fixed range and its items, answers with follow-ups, Confirm these, Skip the rest, "Don't ask", the gap block, and the look-back's times.

**Schema** none.

**Logic** `services/rhythm/session.ts`:
- `startSession(todayKey)`: an open session is returned (continue); otherwise one is created with `openForUserId = userId` (a duplicate-key error reads the open one, AC-29), `dateKey = todayKey`, range from the last completed session's date, or the switch date, to `todayKey − 1`; the gap block is the range's days before `todayKey − spacing`. Range and block are stored (AC-31). `lookBackStartedAt` is set now (AC-39). A continue on a day before the session's date is refused (PD-8).
- Items: PD-13, grouped by day, oldest first; crossed ones pre-filled "happened".
- `answerItem(sessionId, actionId, dateKey, answer, followUp?, moveToKey?)`: one transaction; stores answer, time, session and `priorFate`; "happened" sets `done`; away from it, `done` = another record says happened (AC-36); "no longer matters" and let go set `PassedArchived`, set aside `Backlog`; a move goes through `plannedDayData`, to a day from today to the day before the pre-filled next date (AC-65); changing away from a fate-setting answer restores `priorFate`, a move stays (AC-66).
- `confirmCrossed`: every pre-filled item recorded happened (AC-32). `completeLookBack`: the remaining pre-filled ones recorded happened, `lookBackFinishedAt` set; the rest stay unanswered (AC-38).
- `setDontAsk(sessionId, actionId, on)`: the action; for a gathered one also its source and every occurrence planned after today; `on: false` is the undo (AC-37).
- `setGapChoice(sessionId, choice | null)`: `notTracked` writes the gap with its dates and the first day's "ask me" ids and titles (≤ 200); `fillIn` or null deletes it (W20's change).
- Every write refuses a completed session; every id goes through `ensureOwned` (AC-63).

**API or routes** query `rhythmSession(todayKey)`: step, dates, gap block, days with items and records; no totals. Mutations as above. Refusals: §6.2.

**Screens.** none.

**Tests** `session.integration`, keys from T0: first range from the switch date (J1.6); later ranges; a continued session keeps its range (J4.11); two concurrent starts give one session (J5.8); each answer and follow-up; `done` across two days; AC-66's restore; confirm, complete, skip; propagation (J3.9); the gap block and both choices (J4.3–J4.6); "don't ask", "just to know" and legacy done absent; a second account refused on every operation (J5.7).

**Image and deploy.** none.

**Constraints from earlier stages.** SR0's unique keys (`openForUserId`, `(actionId, dateKey)`, gap `sessionId`), `plannedDayData`; SR1's crossing records.

**Acceptance.** AC-28, AC-29, AC-31, AC-32, AC-33, AC-34, AC-35, AC-36, AC-37, AC-38, AC-39, AC-49, AC-50, AC-57, AC-63, AC-65, AC-66.

**Size: L.**

**Traps.**
- In SQLite a unique-key error aborts its transaction: catch it outside, then read.
- "Today" in AC-37 and AC-65 is the request's `todayKey`, the day the session is continued.
- The view carries no count field, so no screen can show one.

**Not here:** the look-ahead and Finish (SR5); screens (SR6).

---

### SR5 · Session API: look-ahead, next session, Finish

**Goal.** The next date and the days up to it, planning on them, "No date yet", "From before" and "From the gap", when and where, and Finish.

**Schema** none.

**Logic** `services/rhythm/lookAhead.ts`:
- View: next date (stored, or pre-filled `todayKey + spacing`); the days `todayKey` to the day before it, each from SR0's `dayList`; "No date yet" (PD-7c); "From before" while the state's `fromBeforeShownSessionId` is null or this session: open, fateless, not-done actions planned before the switch date (AC-51); "From the gap" while the gap's `shownAt` is null or set in this session: the gap's stored items still fateless and not done (AC-67).
- `setNextDate(sessionId, todayKey, dateKey)`: `todayKey + 2` to `+ 7` (AC-40); stored on the session; gathering runs to the day before it (AC-41). Items on days it hides keep their dates (W36).
- `markShown(sessionId, block)` (PD-14). `letAllGo(sessionId, block, actionIds, undo)`: `PassedArchived` on the block's items, or back to none.
- `planItem(actionId, sessionId, dateKey | null, startTimeOfDay?)`: a shown day, a later date ("Later…", W24) or no date; a time. `removeItem(actionId, sessionId, removed)`: `PassedArchived`, or back (undo) (AC-43).
- `completeLookAhead`: stores the pre-filled date if none was picked. `setWhenWhere(sessionId, whenTime?, place?)`: `HH:mm`, place ≤ 80.
- `finishSession(sessionId)`: needs both earlier steps; sets `completedAt`, clears `openForUserId`, writes the state's `nextDueKey`, and its spacing when the session's date to the next date is 2 to 7 days (AC-46, AC-56).

**API or routes** query `rhythmLookAhead(sessionId, todayKey)`; the mutations above. Refusals: §6.2.

**Screens.** none.

**Tests** `lookAhead.integration`: pre-fill at spacing 3 and after a spacing of 2; out-of-range dates refused (J5.4); new days gathered; a continued session's limits (J4.11); "From before" shown once across sessions and not spent by a session left earlier (AC-52); "From the gap"; let go and its undo; place over 80 refused (J5.5); Finish sets due date and spacing; "No date yet" without done ones; move, time, remove and undo.

**Image and deploy.** none.

**Constraints from earlier stages.** SR4's open session and step times; SR0's horizon and `dayList`.

**Acceptance.** AC-40, AC-41, AC-43, AC-44, AC-46, AC-51, AC-52, AC-56, AC-67.

**Size: M.**

**Traps.**
- The draft next date never moves the state's due date before Finish; Today's gathering keeps its own horizon.
- A session continued days later can set a next date more than 7 days from its own date: then the spacing is unchanged.
- "Later…" must be after the last shown day.

**Not here:** screens and the `.ics` (SR7).

**MS1** follows this stage.

---

### SR6 · Session screens: shell and look-back

**Goal.** `/session` without the app's navigation, its header and resume, and the look-back with the gap block, every state and every failure.

**Schema** none.

**Logic** client only.

**API or routes** client route `/session`; SR4's operations.

**Screens.** Plates 5, 6 (and plate 2's Continue).
- `root.tsx` hides the navigation on `/session` and draws no top bar there; `AppTopBar` stays mounted, `barless`, for N, so the capture key stays global (AC-73's top-bar half).
- `SessionPage` calls `startSession(todayKey)` on mount, then opens at the first unfinished step, with no notice (W21). Header: "← Today", the three step names, completed ones as links until Finish (W25); "Saved as you go", muted (W32). A failed load: "The session didn't load." and **Try again** (W28).
- Look back: the gap card, dates only, one quiet line, **Not tracked** and **Fill in**, shrinking to a dimmed line with "change" (W20, W35); "Crossed out" by day with chevrons, **Confirm these** with no number (W33); "Not crossed"; four equal answers, two by two on a phone, one row on desktop, none pre-selected (W15); follow-ups inline, with day chips from today to the day before the pre-filled next date; "no longer matters" as a dimmed line with "change" (W16); "Don't ask about this" under every unanswered row, its undo toast for five seconds with the row dimmed (W18, W34); **Skip the rest** always at the foot, replaced by **Look ahead** when all are answered (W17); "Nothing to look back on." with **Continue** (W19).
- Every save through `useRetryableSave`; a failed step save (Confirm these, Skip the rest, "Don't ask", completing) keeps the step with `NotSavedLine` (S13).
- The terms of §2.2 #17 in `fa`, with «بقیه رو رد کن».

**Tests** Client: the answers, the gap card, a failed complete keeps the step. e2e `session.spec.ts`, part 1: J1.6–J1.7, J3.2–J3.11, J4.3–J4.7, J5.8, J5.9 (offline by `page.route`), at 360 and 1200 px, `fa` once, `expectHitAreas`, reflow.

**Image and deploy.** none.

**Constraints from earlier stages.** SR4's one open session; SR2's line and its links.

**Acceptance.** AC-30, AC-60; on screen, SR4's AC-28, AC-29, AC-31 to AC-39, AC-49, AC-50, AC-65, AC-66.

**Size: L.**

**Traps.**
- Walk days with `page.clock.setFixedTime` and seed earlier sessions through the API with explicit keys; never the real date. A clock set past the real date also needs a login token that outlasts it: the seven-day token expires against the moved clock.
- No `beforeunload`: leaving never asks.
- StrictMode's double `startSession` is safe by SR4's unique key.

**Not here:** the look-ahead and when and where (SR7).

---

### SR7 · Session screens: look-ahead, when and where

**Goal.** The look-ahead, when and where with the `.ics`, Finish, capture onto a shown day, and the module's fences, languages and failures checked end to end.

**Schema** none.

**Logic** client only; `client/app/lib/ics.ts`.

**API or routes** SR5's operations; SR3's capture.

**Screens.** Plates 7, 8.
- The next date as six chips, today+2 to today+7, the pre-fill selected (W22).
- One column of days at every width (W23), read on open, gathered to the next date − 1, then read again: a composed `LookAheadRow` (`TodayRow` untouched), without the cross-out control; a "⋯" menu with a day, "Later…", "No date yet" (W24), a time, Move up, Move down (W27) and Remove with undo; the handle; "+ Add to <day>" opening `CaptureSheet` with the day fixed; "Nothing planned."; overlaps (W5); Time Theme bands from `tagColorClasses(…).band` and `themesCoveringTime`, a band being the row's classes plus the day's theme strip, with no band component (D-14). A move is drawn once it is saved. Moving the date earlier hides days silently (W36).
- "No date yet" with "Place on…"; "From before" and "From the gap" under the next date, `markShown` on render, "Let them all go" collapsing to "Let them go. Undo" (W37).
- "These days didn't load." with **Try again** (W28). On `tracker:captured` for a shown day, that day refetches (AC-73).
- When and where: the prompt; a time; a place that stops at 80 with "That's as long as a place can be." (W38); **Add to my calendar** downloads the `.ics` with a toast (W10); **Finish** returns to Today. A failed next date, when and where or Finish keeps the step (S13).
- `ics.ts`: one `VEVENT`, random `UID` (D-20), `DTSTAMP` in UTC, `DTSTART` floating local time with `DURATION:PT30M`, or `VALUE=DATE` all day; `SUMMARY` in the person's language; `LOCATION` escaped; CRLF; lines folded at 75 octets.
- Fences: `rhythmFences.unit.test.ts` extended to every file and key of the module (AC-61, AC-62); both i18n checks (AC-59); `fa` RTL (AC-64).

**Tests** `ics.unit`: timed, all-day, escaping, a Persian place folded by octets, no item data, two UIDs differ. e2e `session.spec.ts`, part 2: J1.8–J1.12, J3.12–J3.15, J4.8–J4.10, J5.4, J5.5, J5.9a–J5.9c, J5.10 (a route answering a validation error), J5.11 in `fa`; the download by `waitForEvent("download")`; `expectHitAreas`; reflow.

**Image and deploy.** none.

**Constraints from earlier stages.** SR5's limits and `markShown`; SR3's `CaptureSheet` and event; SR2's `TodayRow`.

**Acceptance.** AC-42, AC-45, AC-47, AC-59, AC-61, AC-62, AC-64, AC-69, AC-70, AC-73, AC-74.

**Size: L.**

**Traps.**
- Fold by octets, not characters: Persian is two bytes a letter.
- No `Z` and no `TZID` on a timed `DTSTART`, so the calendar reads local time.
- The look-ahead's "today" is the day the session is continued.

**Not here:** the query script (SR8).

---

### SR8 · The record query, `rhythmGate`

**Goal.** The eval plan's read-only record query (§3.A, AC-58), tested on a fixture, with its command on the box.

**Schema** none.

**Logic** `api/src/services/rhythm/gateReport.ts` (pure, testable): from one user's rhythm state, sessions, day records, gaps and actions over the 28 day keys from `--from`: M1 and the sessions started and not completed; M2's stretches, each over 7 days marked gap stored, filled in, or neither; M3 per session, paused when finished on a later date or over 30 minutes, and the median of the unpaused; items per look-back; sessions begun after their due date; M6 out of 28; W1's left-behind actions (no answer after Skip the rest, or "didn't happen" with no follow-up, no fate, not done), outside stored gaps. `api/src/scripts/rhythmGate.ts` parses `--email` and `--from`, reads, prints plain text, writes nothing.

**API or routes** none: no resolver exposes any of it.

**Screens.** none.

**Tests** `rhythmGate.integration.test.ts`: a 28-day fixture with a paused look-back, a stored gap, a filled-in return, left-behind items, and another user's rows that don't count; an even-count median. A text fence: the script and `gateReport.ts` call no `create`, `update`, `upsert` or `delete`, planted once.

**Image and deploy.** `npm run build` compiles it to `dist/scripts/rhythmGate.js`; `api/package.json` gains `"rhythm:gate": "node dist/scripts/rhythmGate.js"`. On the box, run by the founder only: `docker exec api-api-1 node dist/scripts/rhythmGate.js --email <email> --from <switch date>`. No variable.

**Constraints from earlier stages.** SR0's tables; SR4 and SR5's meaning of each timestamp.

**Acceptance.** AC-58.

**Size: S.**

**Traps.**
- The window is 28 keys from `--from` inclusive.
- Read-only means read-only: no "fix-up" write, even for a missing state row.
- Never run against production in a lane or unattended (`unattended.md` rule 3).

**Not here:** reading the results (the founder, at E2 and E3).

**SR9** follows this stage, then MS2.

### SR9 · MS2's fixes: hit areas and the rows due

**Goal.** Close what the first MS2 run left open: the three controls under 44 px that the strict hit-area helper found, the helper itself merged, and the six lane items due at MS2 (`changes/03-req-ms2-fix-stage.md`). No new behaviour; nothing the spec doesn't already ask.

**Base.** Local `main @ 7f86a93` or later. First, merge the local branch `ms2/strict-hit-areas` (`92cd028`, `client/e2e/helpers/hitArea.ts` only) into the lane's branch, and run its four specs (`capture`, `crossing`, `session`, `today`): 5 of 53 fail. Those are this stage's failing tests.

**Schema** none.

**Logic and screens**, each with its open-work row in `team/open-work.md`:
1. **The cross-out control** on Focus, the actions list and Today: its `::before` (`-inset-[14px]` on a 14 px box) is 42 px. Make the area at least 44 px in both directions without moving the row's layout.
2. **Today's Reorder handle:** the strict probe misses it 21 px to the left, on the row. Its hit area reaches 44 px.
3. **The look-back row's sixth button in `fa`:** missed 21 px to the left (the row's end in RTL). Its hit area reaches 44 px in both languages.
4. **The `gatherKey` dedup read** (SR0 row): bound it to the keys a gather run generates, plus legacy rows with a null `gatherKey`, whatever their `forDate`. Same results on every existing test.
5. **The cross-out control at 180 px** (SR1 row): add 180 px to the reflow check on the actions list, Focus and the project page, `en` and `fa`. Fix any overflow found; a layout *change* beyond that is the founder's (the cramped-row row).
6. **The drag handle's screen-reader instructions** (SR2 row): `DndContext` gets its own `en` and `fa` instructions and announcements, saying Enter opens Move up and Move down; no claim of a keyboard pick-up that doesn't exist. Applies to Today and the look-ahead.
7. **The calendar's page scroll at 360 × 800** (SR3 row): the top bar makes `TrackerCalendar.tsx`'s `min-h-[60vh]` list scroll the page by 20 px. Make the page fit with no page scroll in `en` and `fa`; trace the routine form's 48 px and the time map's 2 px and fix them if they are the same cause, else report them.
8. **`IntervalForm`'s review setting** (SR3 row): a client test with `useApi` mocked, for routine and interval modes, reading the saved setting back.
9. **"Later…" commits once** (SR7 row): the look-ahead's date field sends `planItem` on Enter or on leaving the field, not on every change; the Jalali field (one change, on a click) still saves on that click. No visible change (no Move button: `calls.md` row 102).

**API or routes** none new. **Strings** the instructions of item 6 only, in both `common.json` files.

**Tests.** The four strict specs pass in full. Item 4: an integration test that a long-lived daily interval's dedup read is bounded, and that a moved row still dedupes (D-2). Item 5: the reflow cases. Item 6: a client test that the instructions are the locale's. Item 8 as above. Item 9: an e2e that an ArrowUp in the date field doesn't move the row until Enter or blur, and a client test for the Jalali click.

**Constraints from earlier stages.** AC-17's control and AC-74's Move up and Move down stay as they are; no count, no red; PD-2 (no schema change).

**Acceptance.** No new criterion. AC-17, AC-74 and the review checklist's 44 px and reflow rules, now measured strictly; the open-work rows above settled.

**Size: M.** Slot A, with e2e (config §4).

**Traps.**
- Each strict test stops at its first miss: a fix reruns all four specs, not the one that failed.
- A larger `::before` must not overlap the next control's area; the strict helper names what it hit.
- Item 4 must still read legacy rows with a null `gatherKey`, whatever their `forDate`, or a moved row duplicates (§9 item 1).

**Not here:** the four design calls (the error text's contrast, the Focus toast slot, `todayKey` at mount, the cramped 180 px row). They are the founder's, after MS2 (`changes/03-req-ms2-fix-stage.md`).

**MS2** follows this stage.

---

## 6. Cross-cutting catalogues

### 6.1 · Routes

| Operation or route | Kind | Stage |
|---|---|---|
| `dayList(dateKey)` | query | SR0 |
| `rhythmStatus(todayKey)` | query | SR0 |
| `ensureRhythm(todayKey)` | mutation | SR0 (called from SR2) |
| `orderDay(dateKey, actionIds)` | mutation | SR0 |
| `runActionGathering(todayDate, endDate?)` | mutation, changed | SR0 |
| `updateAction(…, done ignored, reviewSetting)` | mutation, changed | SR0, SR3 |
| `setCrossed(id, todayKey, crossed)` | mutation | SR1 |
| `toggleAction` | **removed** | SR1 |
| `preDayStatus`, `completePreDay`, `completeAfterDay` | **removed** | SR2 |
| `captureAction(title, todayKey, dateKey, noDate, startTimeOfDay)` | mutation | SR3 |
| `addAction`, interval and routine mutations `+ reviewSetting` | changed | SR3 |
| `rhythmSession(todayKey)` | query | SR4 |
| `startSession`, `answerItem`, `confirmCrossed`, `completeLookBack`, `setDontAsk`, `setGapChoice` | mutations | SR4 |
| `rhythmLookAhead(sessionId, todayKey)` | query | SR5 |
| `setNextDate`, `markShown`, `letAllGo`, `planItem`, `removeItem`, `completeLookAhead`, `setWhenWhere`, `finishSession` | mutations | SR5 |
| `/today` | client route, rebuilt | SR2 |
| `/session` | client route, new | SR6 |

### 6.2 · Refusal codes

| Message (exact) | When | Stage |
|---|---|---|
| `Unauthorized` | no session (as-built) | as-built |
| `Not found` | missing, or another person's: action, session, record, gap | SR0 onward |
| `Date must be YYYY-MM-DD` / `Time must be HH:mm` | a malformed key or time | SR0 onward |
| `Order applies within one start time.` | `orderDay` ids across start times or days | SR0 |
| `A "just to know" item can't be crossed out.` | `setCrossed` on one | SR1 |
| `That item is set aside.` | `setCrossed` on a fated action (PD-19) | SR1 |
| `A title needs at least one character.` / `A title can be at most 200 characters.` | capture | SR3 |
| `Capture can't date an item before today.` | capture's date before `todayKey` | SR3 |
| `A session can't continue before the day it started.` | `startSession` with a key before an open session's date | SR4 |
| `This session is finished.` | any session write after Finish | SR4, SR5 |
| `That day isn't one of the days being planned.` | a follow-up's move outside today to the day before the pre-filled next date | SR4 |
| `The next session must be 2 to 7 days from today.` | `setNextDate` out of range | SR5 |
| `A place can be at most 80 characters.` | `setWhenWhere` | SR5 |
| `That step isn't open yet.` | Finish before the look-back and look-ahead are done; a look-ahead write before the look-back is | SR5 |

The client never shows these words: it prevents each case (chips, field limits, hidden controls) and shows "Not saved." if one gets through. Capture's title messages are the client's own keys (AC-25).

### 6.3 · Tables

| Table | Fields | Keys | Stage |
|---|---|---|---|
| `RhythmState` | userId, switchDateKey, spacingDays (3), nextDueKey?, fromBeforeShownSessionId?, createdAt | userId unique | SR0 |
| `RhythmSession` | userId, dateKey, startedAt, lookBackFromKey, lookBackToKey, gapFromKey?, gapToKey?, gapChoice?, lookBackStartedAt?, lookBackFinishedAt?, lookAheadDoneAt?, nextDateKey?, whenTime?, place?, completedAt?, openForUserId? | openForUserId unique; (userId, completedAt) | SR0 |
| `DayRecord` | actionId (cascade), userId, dateKey, crossedAt?, crossMoved, movedFromKey?, answer?, answeredAt?, answerSessionId?, followUp?, priorFate? | (actionId, dateKey) unique; (userId, dateKey) | SR0 |
| `RhythmGap` | sessionId (cascade), userId, fromKey, toKey, plannedItems (JSON `[{id,title}]`, ≤ 200), shownAt?, createdAt | sessionId unique | SR0 |
| `Action` + | reviewSetting (ask), sortOrder?, firstDueKey?, gatherKey? | (userId, tbd), (userId, forDate) | SR0 |
| `Interval`, `Routine` + | reviewSetting (ask), sortOrder? | — | SR0 |

### 6.4 · Limits

| Limit | Value | Where |
|---|---|---|
| Capture title | 1–200 after trim | SR3 |
| Place | ≤ 80 | SR5, SR7 |
| Spacing | 2–7 whole days, default 3 | SR0, SR5 |
| Next date | today+2 to today+7 | SR5, SR7 |
| Gathering horizon | today to max(today+2, day before due), ≤ today+7 | SR0 |
| Gap block | the range's days before today − spacing | SR4 |
| Gap items stored | ≤ 200 | SR4 |
| Undo window | 5 s (`UNDO_MS`) | SR1, SR6, SR7 |
| Hit area | ≥ 44 × 44 px | SR1–SR3, SR6, SR7 |
| Paused look-back (script) | later date, or over 30 min | SR8 |

### 6.5 · Never shown, and what guards it

| Never shown | The mechanism that could leak it | Guard | Stage |
|---|---|---|---|
| A count of items or days | an i18n `{{count}}` or plural key; a view field holding a total | `rhythmFences` on keys; views carry no totals | SR2, SR4, SR7 |
| Red | a `red-` or `destructive` class, `ConfirmDialog`'s destructive variant | `rhythmFences` on classes; undo instead of confirm | SR2, SR7 |
| Days late | the session line's text | five fixed forms, a date and no number | SR2 |
| Item data in the calendar | the `.ics` summary, location, UID, filename | fixed summary, the person's place only, random UID | SR7 |
| The record as numbers | a resolver over the record | the script is offline and has no resolver | SR8 |
| A raw GraphQL error | an old tab's removed call | the reload line (PD-11, PD-10) | SR0 |

### 6.6 · Runtime dependencies

None new. Used: `@dnd-kit/core` and `@dnd-kit/sortable` (installed), `vite-plugin-pwa` with `autoUpdate` (installed; PD-10 relies on it), Prisma and SQLite as built.

### 6.7 · Every acceptance criterion, by stage

| Criterion | Stage |
|---|---|
| AC-1 | SR2 |
| AC-2 | SR2 |
| AC-3 | SR2 |
| AC-4 | SR2 |
| AC-5 | SR0 |
| AC-6 | SR0 |
| AC-7 | SR2 |
| AC-8 | SR2 |
| AC-9 | SR2 |
| AC-10 | SR2 |
| AC-11 | SR2 |
| AC-12 | SR2 |
| AC-13 | SR2 |
| AC-14 | SR2 |
| AC-15 | SR2 |
| AC-16 | SR2 |
| AC-17 | SR1 |
| AC-18 | SR1 |
| AC-19 | SR1 |
| AC-20 | SR1 |
| AC-21 | SR1 |
| AC-22 | SR1 |
| AC-23 | SR3 |
| AC-24 | SR3 |
| AC-25 | SR3 |
| AC-26 | SR3 (server half in SR0) |
| AC-27 | SR3 |
| AC-28 | SR4 (on screen SR6) |
| AC-29 | SR4 |
| AC-30 | SR6 |
| AC-31 | SR4 |
| AC-32 | SR4 |
| AC-33 | SR4 |
| AC-34 | SR4 |
| AC-35 | SR4 |
| AC-36 | SR4 |
| AC-37 | SR4 |
| AC-38 | SR4 |
| AC-39 | SR4 |
| AC-40 | SR5 |
| AC-41 | SR5 |
| AC-42 | SR7 |
| AC-43 | SR5 |
| AC-44 | SR5 |
| AC-45 | SR7 |
| AC-46 | SR5 |
| AC-47 | SR7 |
| AC-48 | SR0 |
| AC-49 | SR4 |
| AC-50 | SR4 |
| AC-51 | SR5 |
| AC-52 | SR5 |
| AC-53 | SR2 |
| AC-54 | SR0 |
| AC-55 | SR1 |
| AC-56 | SR5 |
| AC-57 | SR4 |
| AC-58 | SR8 |
| AC-59 | SR7 |
| AC-60 | SR6 |
| AC-61 | SR7 |
| AC-62 | SR7 |
| AC-63 | SR4 |
| AC-64 | SR7 |
| AC-65 | SR4 |
| AC-66 | SR4 |
| AC-67 | SR5 |
| AC-68 | SR2 |
| AC-69 | SR7 (each surface's half in SR1, SR3, SR6) |
| AC-70 | SR7 (Today's half in SR2, `/session`'s in SR6) |
| AC-71 | SR3 |
| AC-72 | SR0 |
| AC-73 | SR7 (the top bar's half in SR6) |
| AC-74 | SR7 (Today's half in SR2) |
| AC-75 | SR1 |

## 7. What this plan changes in code that is already built

- **Today:** `TodayPage.tsx` rebuilt; `PreDayWizard.tsx`, `AfterDayWizard.tsx`, `TodayActionRow.tsx`, `TodayActionWidget.tsx` deleted; `preDayStatus`, `completePreDay`, `completeAfterDay`, `toggleAction` removed (SR1, SR2).
- **The done checkbox** becomes the cross-out control in `ActionPreview`, `FocusCard` and Focus's undo (SR1). `done` moves only in the look-back.
- **`updateAction`** ignores `done`; `ActionForm` stops sending it (SR0, SR3). API-token scripts lose every way to set `done` (D-15).
- **The estimate rule** is gone from the server and the client forms (SR0, SR3); a start time is no longer required for today.
- **Gathering:** `gatherKey` identity, a horizon up to today+7, review setting and order copied from the source (SR0). Its tests at `gathering.integration.test.ts:33` and `recurrence.unit.test.ts:32` change on purpose.
- **Overlap:** rows without an estimate are never marked (SR0); `today.integration.test.ts:219-260` moves to `dayList`.
- **`useApi`:** the validation-error line (SR0).
- **Layout:** `AppTopBar` on every protected page; navigation hidden on `/session` (SR3, SR6).
- **Copy:** today intro, pre-day and after-day intros, Concepts' day-state section, the skills line, Focus's toast (SR1, SR2).
- **Tests changed on purpose** (spec R3): `actions.integration.test.ts:123-131`, `client/e2e/today.spec.ts:24,58`, `ActionPreview.test.tsx:105`, `FocusPage.test.tsx:235`, the wizards' own tests.
- **Canon flagged for `close-out`:** `01-data-model.md` (four tables, six fields; convention 12), `02-graphql-api.md` (§6.1), `03-frontend.md` (the top bar, the session route), `04-roadmap/01-known-issues-and-debt.md` (`notDoneActionsForDate` dead, PD-17; skill-action deletes take their records, D-10), the decision log (D-5's gate retired in code).

## 8. Verification, and its ceiling

**Done means:** every stage verified with its acceptance shown, MS1 and MS2 green, the by-hand list done or owed with a date, the canon flagged, and, after the founder's push, the live site signed in.

**What the suites prove.** API integration tests prove every server rule and refusal on fixed keys: the record, ranges, answers and `done`, ownership, gathering. Client tests prove the components' states. The e2e walks every journey step that has a screen, at 360 and 1200 px with hit areas and reflow, and J5.11 in `fa`. Fence tests prove no count key, no red class and no write in the script.

**By hand** (to the open-work file's *Past the verification ceiling*, each with *needed by*):

| Check | Who | Needed by |
|---|---|---|
| The `.ics` imports into the founder's own calendar at the right local time, and all-day without one | the founder | MS2 |
| Persian copy read by a Persian reader: the §2.2 #17 terms, every new string | the founder | MS2 |
| Today, capture and the session on a real phone in `fa`: bidi, mirrored icons, the bottom sheet over the keyboard | the founder | MS2 |
| `N` on a physical Persian keyboard | the founder | MS2 |
| Reduced motion from the operating system's setting | the founder | MS2 |
| The live site after the MS2 deploy: sign in, the switch line "Plan your next days" | the founder | after the push |
| E2: the day-7 record check with `rhythmGate` | the founder | launch + 7 days |

**The ceiling.** No suite can tell whether the rhythm holds, whether crossing feels owed, or whether paper wins: that is the eval plan's four weeks, read by the founder. e2e on the Linux machine stays as `review-checklist.md` §7 says.

## 9. Where this is most likely to go wrong

1. **Gathering's identity change (SR0).** A mistake here duplicates or loses recurring items every day. Its tests must cover move-then-edit for intervals and routines with two time blocks.
2. **The `done` invariant.** Any path that writes `done` outside `answerItem` (a form, a token, an old tab) undoes the look-back. SR0 and SR3 close the two known ones; `verify` greps for `done:` writes at every stage.
3. **Pushing early.** One push after SR2 switches the founder into a rhythm whose session isn't built, and starts D-68's four weeks on a broken day. PD-10 is the guard; every `verify` in this run lists the push as owed, never takes it.
4. **The look-back's item rule (PD-13).** Items moved, crossed, fated or answered in another tab must neither vanish nor appear twice; SR4's tests take each case.
5. **Long lists.** "No date yet" and "From before" show every matching action, and the founder's gate-era backlog is unknown. If the first session shows hundreds, that is a `revise` item (a cap or a fold), not a lane's call.
6. **Skill actions:** replanning deletes undone future skill actions and, by cascade, their day records (D-10). It loses only crossings of skill items not yet reviewed; noted for the eval's M6.

## 10. For the founder

**Config 0.4 needs no settling before the first stage.** SR0 is API and schema work with one small client change: it needs the lane slots, the API suites, `tsc` and the migration recipe, all correct in config 0.4 and brief-common 0.6, and no review script or milestone. So SR0 can run unattended. Config's stale facts (D-18: the milestone script's Linux path and its failing `npm run typecheck`, the "planned" stage records and README, the empty §5 and §6) must be fixed **before MS1**; SR0's `verify` applies them under `unattended.md` rule 7, logged in `calls.md`.

**Facts owed:** the push order (P0-2); your phone and calendar for the by-hand list (P0-4); the stray worktree (P0-6).

**Decisions to veto:** PD-1 to PD-20, especially PD-3 (gathered identity), PD-4 (a new top bar), PD-7 (legacy data and AC-44's reading), PD-8 (no server clock bound), PD-9 (the skills line loses its number), PD-10 (push order) and PD-19 (fated items can't be crossed). Each is a row in `calls.md` (15 to 26).

**Left to the card** (open calls each card settles and logs):
- SR0: the exact `rhythmStatus` shape; whether `todayActions` stays beside `dayList` (nothing in the spec retires it).
- SR1: the toast wording on a moved crossing in `fa`.
- SR2: the skills line's wording in both languages; Concepts' rewritten section's words.
- SR3: the next named weekday chip's rule near the week's end (W9).
- SR4: how a day's "ask me" items are capped in the view if a day holds more than 200.
- SR6: the look-back's layout of follow-ups at 180 px.
- SR7: the `.ics` file name (no item data, no id).
- SR8: the report's line format.

**Owed by other skills:** `journeys update --from-note 02` and `eval-plan --touch-up` (change 02), before `close-out`; PD-7c's wording fix to AC-44, through `revise` at `close-out`.

## Changelog

- **0.5 · 2026-11-20** — Correction only, from `verify SR9` (record `docs/development/SR9.md` @ `72acbdd`), applied unattended (`calls.md` row 111): §5 SR9 item 4 and its third Trap say the legacy rows are those with a null `gatherKey`, whatever their `forDate`, as built. No scope change.

- **0.4 · 2026-11-20** — `revise`, `changes/03-req-ms2-fix-stage.md`: stage SR9 added after SR8 for MS2's three controls under 44 px, the strict hit-area helper's merge (`ms2/strict-hit-areas`) and six open-work lane items due at MS2; MS2 moves after SR9; §3's order and cost. Scope change through `revise` (README §4). Calls in the unattended run, `calls.md` rows 99 to 105.

- **0.3 · 2026-11-19** — Correction only, from `verify SR7` (record `docs/development/SR7.md` @ `da6b5e0`), applied unattended (`calls.md` row 84): §5 SR7's screens say the look-ahead reads, gathers to the next date − 1 and reads again; the row is a composed `LookAheadRow`, not `TodayRow`; a band is the row's classes plus the day's theme strip, with no band component; a move is drawn once saved. No scope change.

- **0.2 · 2026-11-19** — Correction only, from `verify SR6` (record `docs/development/SR6.md` @ `4a32e9f`), applied unattended (`calls.md` row 72): §5 SR6's screens say `AppTopBar` stays mounted `barless` for N rather than hidden; its `page.clock` trap adds the token expiry. No scope change.
- **0.1 · 2026-11-19** — Plan, from spec 0.3, journeys 0.3, wireframes draft 2, UX review 0.2, eval plan 0.1, change requests 01 and 02, and the tracker project files (config 0.4, brief-common 0.6, review-checklist 0.4); code read at `rishe-eco/tracker main @ eea1c59`. Nine stages, SR0 to SR8, two milestones; 22 defects; W1–W39, S13, P1-F15 and the query script settled. Written by Claude (Opus 5.5) following `build-plan` by hand in the founder's unattended run; every founder question answered as a call (`calls.md` rows 15 to 26), none [F].
