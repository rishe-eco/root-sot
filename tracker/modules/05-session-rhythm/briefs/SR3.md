# SR3 · Quick capture and item settings — phase card

*For the Sonnet lane building SR3. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR3`, 2026-11-19, from `07-build-plan.md` §5 SR3, journeys J2.7–J2.10 and J5.1–J5.3, wireframes plates 3 and 9 (W1, W8–W12, W30, W39), open-work rows "Session rhythm SR0/SR1, from a second review on Opus 5.5" and "Session rhythm SR2: just to know on Today", and the code as it is: `rishe-eco/tracker` main @ 051afcc. Root-sot at `docs/root-os @ 105329c`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr3-capture` |
| Branch | `sr3-capture`, from local `main @ 051afcc`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | e2e API `4010`, web `5183` (slot A) — `E2E_API_PORT=4010 E2E_WEB_PORT=5183` |
| Size | M plus nine carried fixes, so budget as L: ~4–6 h, ~300–450 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `team/open-work.md` (root-sot), the *Owed* row "Session rhythm SR0/SR1, from a second review on Opus 5.5": nine items, each with the fix. Its `ActionPreview.tsx` line numbers are from `35bf320`, before SR2 shrank the file; find the code by name.
3. `07-build-plan.md` §5 **SR3**, all of it; §2 PD-4, PD-5, PD-6; §3 D-1, D-3, D-13; §7 (refusals the client prevents).
4. `03-journeys.md` J2.7–J2.10, J5.1–J5.3. Wireframes `04-wireframes.html` plates **3** and **9**, and the call table rows W1, W8–W12, W30, W39 (cite them, don't re-read all plates).
5. Stage records `docs/development/SR0.md` (`firstDueKey`, the estimate rule), `SR1.md` (crossing, `NotSavedLine`, `useRetryableSave`), `SR2.md` (Today, `TodayRow`).

## What to build

**First, the nine re-review items**, before any SR3 work. For each: a test that fails on the old code (run it and see it fail), then the fix, then one commit naming the item number. Item 3 (one interactive `$transaction` in `setCrossed`, P2002 caught) is the likely cause of the flaky `crossing.spec.ts` "uncrossing restores both": after it, run that spec 5 times alone and report the count. Item 5 applies to **every** crossing surface, not only `ActionPreview`: SR2's `TodayPage` also reverts on a null result (`TodayPage.tsx` near "shows NotSavedLine and reverts"); bring it, `ActionPreview` and `FocusCard` to SR1's trap (stays crossed, "Not saved." under it). Item 6: write the escape as `"\u0000any-time"` with the Edit tool so the file holds the six characters, not the byte.

**Then SR3**, as §5 says. What the code check found:

- **Interval and Routine have `reviewSetting` in `schema.prisma` but not in the SDL.** Add `reviewSetting: ReviewSetting!` to `type Interval` and `type Routine`, and the argument to `addInterval`, `updateInterval`, `addRoutine`, `updateRoutine`, as well as `addAction` and `updateAction`. Ownership as each resolver has it now.
- **`captureAction`** is a new mutation in its own service (`api/src/services/rhythm/capture.ts`), using `days.ts`'s `isValidDateKey` and `assertDateKey`. `dateKey` and `noDate` together is refused. It takes no `projectId` (standalone), so §5's "a stranger's project refused" test reads as: `addAction`'s `projectId` of another user's project is still refused — keep that test in `capture.integration` beside the others.
- **The top bar**: `AppTopBar` in `ProtectedAppLayout` (`client/app/root.tsx`), above `<Outlet />` inside `ResponsiveNavigation`'s content area. `/login` and `/register` render outside it already; assert it in e2e anyway.
- **Accessible names:** existing e2e finds `/Add action/i`, `/Add goal/i`, `/Add project/i`. The top bar's control is named "Add" (en) and its `fa` key, so none of them match twice.
- **`useCaptureKey`**: "a dialog is open" means any `[aria-modal="true"]` in the document (`ConfirmDialog` sets it; set it on any modal you find that lacks it, and say which).
- **Forms:** `ActionForm.tsx` makes the estimate required when a date is set (`actions.errors.estimatedRequiredWithDueDate`) and sends `done: false` on edit (≈ line 254). `focus/AddActionForm.tsx` refuses a dated add without minutes (`canAdd`). `ProjectPreview.tsx` validates estimates near `isValidEstimated`. Lift each requirement, keep the 0–1440 range. Remove the now-unused error key from both locales. `IntervalForm` keeps its required estimate (AC-26 covers actions only).

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | The "next named weekday" chip is the day after tomorrow, labelled by its weekday name | Never duplicates Tomorrow, always inside the look-ahead's window; plan §10 left W9's rule to this card |
| 2 | Focus trap is a small hook (`client/app/utils/useFocusTrap.ts`); no Radix Dialog | PD-5, D-13 |
| 3 | Capture's toast lives in `AppTopBar` as a `role="status"` line, 4 s, styled like Focus's `UndoToast`; no global toast system | Smallest change; one host, the only caller |
| 4 | Interval and Routine expose `reviewSetting` in the SDL | Columns exist since SR0; §5 needs the forms to save it |
| 5 | The nine items land first, one commit each | `calls.md` row 41; verify checks them one by one |
| 6 | e2e makes its own data through the UI and `authenticate`; no seed route | As `today.spec.ts` does |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `client/app/test/ActionPreview.test.tsx` | a failed crossing save reverts, if it asserts it | stays crossed with "Not saved." (item 5) |
| `client/app/test/TodayPage.test.tsx` | the same, if it asserts it | the same |

No other test asserts an estimate requirement or the top bar's absence (grepped `estimatedRequired`, `is required`, `KeyN`, `aria-modal`, `done: false` in `api/src/__tests__`, `client/app/test`, `client/e2e`).

## Proving it here

- e2e `capture.spec.ts` on slot A: J2.7–J2.10 (`fa` with `KeyN`, never `key`), J5.1–J5.3, `expectHitAreas`, reflow at 180 px; the top bar absent on `/login`. Also drive a `justToKnow` row on Today (no cross-out control, "just to know" in the project's place), owed to this stage by SR2.
- `crossing.spec.ts` ×5 alone after item 3.
- Capture's "today" is the client's key **at save**: test it with a clock moved across midnight between open and save.

## What the verify deploys

None. SR3 is not pushed or deployed before MS2 (PD-10). No migration, no image change.

## Done for SR3

- the nine items fixed, each with a test seen failing first
- AC-23, AC-24, AC-25, AC-26, AC-27, AC-71 met, with their tests
- targeted tests green: api `capture.integration`, `actions.integration`, `crossing.integration`, `dayList.integration`, `gathering.integration`; client capture, focus-trap and form tests plus the touched crossing tests; e2e `capture.spec`, `crossing.spec`, `today.spec`; `tsc --noEmit` in api and client; both i18n checks; no full suites
- the report written to `.tmp/SR3.report.md` in the seven parts and returned

## Not here

The top bar hidden on `/session` (SR6); the look-ahead refreshing on capture (SR7, but dispatch `tracker:captured`); the look-back's "Don't ask" propagation (SR4); a review setting in the capture sheet (new captures are "ask me").
