# SR6 · Session screens: shell and look-back — phase card

*For the Sonnet lane building SR6. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR6`, 2026-11-19, from `07-build-plan.md` §5 SR6, §2 PD-11, PD-16, PD-18, §6.2, §6.4, §6.5, design plates 2, 5, 6, open-work rows "Session rhythm MS1: at 180 px…", "SR4: a gap day's answer survives a switch…" and "SR5: SR4's `setGapChoice` is accepted after the look-back…", and the code as it is: `rishe-eco/tracker` main @ 5581a1c. Root-sot at `docs/root-os @ eb8f3df`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr6-session-look-back` |
| Branch | `sr6-session-look-back`, from local `main @ 5581a1c`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | slot A: `E2E_API_PORT=4010 E2E_WEB_PORT=5183` (check Windows' excluded ranges first, config §2) |
| Size | L: ~4–7 h, ~700–1,000 lines of app code, client only |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 **SR6**, all of it; §2 PD-11, PD-16, PD-18; §6.2's last paragraph (the client never shows refusal words), §6.4, §6.5.
3. `02-spec.md` §2.2 #17 (Persian terms), §4.4, §4.5, §4.9, §4.10; AC-28 to AC-39, AC-49, AC-50, AC-60, AC-65, AC-66.
4. `03-journeys.md` J1.6–J1.7, J3.2–J3.11, J4.3–J4.7, J5.8, J5.9, J5.11.
5. `04-wireframes.html` plates 2 (Continue), 5 and 6, and the calls table rows W15–W21, W25, W32–W35.
6. Code: `api/src/graphql/schema/typeDefs.ts` (`RhythmSession` and the six SR4 mutations), `api/src/services/rhythm/session.ts` (what each write refuses), `docs/development/SR2.md`, `SR4.md`; client `root.tsx`, `protectedRoutes.tsx`, `layout/pathUtils.ts`, `components/today/SessionLine.tsx`, `components/focus/UndoToast.tsx` (`UNDO_MS`), `components/rhythm/NotSavedLine.tsx`, `utils/useRetryableSave.ts`, `api/queries.ts`; e2e `helpers/hitArea.ts`, `helpers/reflow.ts`, `helpers/freshUser.ts`, `today.spec.ts` (the day-walking pattern).

## What to build

`components/session/SessionPage.tsx` with its parts (header, gap card, look-back list, answer row), the six SR4 operations and `rhythmSession`/`rhythmStatus` in `api/queries.ts`, the `/session` route, `rhythm.session.*` keys in `en` and `fa`, `app/test/SessionPage.test.tsx`, and `e2e/session.spec.ts` part 1. No API change.

What the code check found:

- **Chrome.** `root.tsx` renders `ResponsiveNavigation` and `AppTopBar` on every protected page; on `/session` render neither (and no bottom-bar padding). **Mismatch, flagged for verify:** `useCaptureKey` and the capture sheet live *inside* `AppTopBar`, so hiding the bar would drop N (AC-73). Give `AppTopBar` a `barless` prop that keeps the key and the sheet and draws no bar, and use it on `/session`. `/session` is not in `BOTTOM_NAV_PATHS`; leave that set alone.
- **Load.** On mount call `startSession(todayKey)`; its answer is the view. A null answer (D-5) is the failed load: "The session didn't load." and **Try again**, with the header still drawn (W28). The step comes from `view.step`.
- **Step header.** Only Look back is built; Look ahead and When and where show as names, and Look back becomes a link once `step` is past it. SR7 builds the other two steps; until then **Look ahead** (the foot's primary and "Continue" from the empty state) calls `completeLookBack` and, on success, shows the Look ahead step as an empty placeholder. Flag the placeholder in the report.
- **Day chips** for a moved follow-up run from `todayKey` to `todayKey + spacingDays − 1`, `spacingDays` from `rhythmStatus(todayKey)`. That is exactly `answerItem`'s server bound; in the look-back step no next date is stored yet.
- **Pre-filled rows** (`prefilled: true`) show "happened" without counting as selected: W15's "none pre-selected" applies to unanswered, uncrossed rows.
- **The Persian terms** are §2.2 #17's, with «بقیه رو رد کن» for Skip the rest. The terms the spec doesn't fix (Look back, Look ahead, Saved as you go, the gap line) are yours, informal (D-20); list them in the report.
- **Open-work row "MS1: at 180 px…"**: Today's `JournalQuickAdd.tsx` row overflows at 180 px. Let its row wrap (`flex-wrap`, the input taking a full line below the picker under `sm`), so `today.spec.ts`'s two 180 px reflow tests pass unchanged.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | After **Fill in** the gap card is gone and its days open; only the Not tracked line has "change". A gap answered day by day can't be switched to Not tracked | Plate 6 draws no card after Fill in; closes open-work row "SR4: a gap day's answer survives a switch" |
| 2 | The gap line's "change" stays reachable until Finish (through the Look back link); `setGapChoice` after `lookBackFinishedAt` is left as built | W20 says "until the session completes"; closes open-work row "SR5: SR4's `setGapChoice` is accepted after the look-back" by that reading |
| 3 | e2e seeds through the API with `gqlAs` on a fresh user and walks days with `page.clock.setFixedTime`, T0 = `2026-12-01` | Plan's trap; SR2's pattern |
| 4 | The Look ahead step is a placeholder until SR7 | The plan splits the screens at the look-back |
| 5 | No new dependency | PD-5 |

## Tests that change on purpose

None. Grepped `/session`, `AppTopBar`, `isInternalPage`, `session-line` and the six operation names in `client/app/test` and `client/e2e`: `SessionLine.test.tsx` asserts the link's `href` is `/session`, which stays true; nothing asserts the route's absence. `rhythmFences.unit.test.ts` scans the whole `rhythm` namespace, so the new keys must hold no `{{count}}` and no plural key, and no `red-` or `destructive` class.

## Proving it here

The 360 and 1200 px e2e runs, `expectHitAreas` at 360 px on every new control, and `expectReflow` on `/session` at 360 px in `en` and `fa` (pass its column selector if the page's padded box isn't `main > div:last-child`). Offline (J5.9) by `page.route` aborting the GraphQL call for one save.

## Done for SR6

- AC-30, AC-60, and on screen AC-28, AC-29, AC-31 to AC-39, AC-49, AC-50, AC-65, AC-66, each with its test named in the report
- a failed Confirm these, Skip the rest, Don't ask and completing each keep the step with `NotSavedLine`; no `beforeunload`
- targeted tests green: `SessionPage.test`, `rhythmFences.unit`, `SessionLine.test`, `TodayPage.test`, client `tsc --noEmit` and both i18n checks; e2e `session.spec.ts` and `today.spec.ts` in slot A; no full suites
- the report written to `.tmp/SR6.report.md` in the seven parts and returned

## Not here

The look-ahead, when and where, Finish (SR7); Today's row at 180 px and Focus's stacked toasts (open-work rows for SR2 and SR3, by MS2); the five rows moved to MS2 (`calls.md` row 65).
