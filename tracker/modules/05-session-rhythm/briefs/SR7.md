# SR7 · Session screens: look-ahead, when and where — phase card

*For the Sonnet lane building SR7. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR7`, 2026-11-19 (unattended), from `07-build-plan.md` 0.2 §5 SR7, design plates 7 and 8, open-work rows "Session rhythm SR2: a failed `orderDay` isn't drawn", "SR5: the look-ahead query only reads", "SR6: the gap choice can change from the Look back link" and "SR6: `session.spec.ts` has no 180 px reflow run", and the code as it is: `rishe-eco/tracker` main @ 9bf3e1b. Root-sot at `docs/root-os @ eb8d43d`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr7-session-look-ahead` |
| Branch | `sr7-session-look-ahead`, from local `main @ 9bf3e1b`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | slot A: `E2E_API_PORT=4010 E2E_WEB_PORT=5183` (free at drafting; check Windows' excluded ranges again, config §2) |
| Size | L: ~4–7 h, ~700–1,000 lines of app code, client only |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 **SR7**, all of it, and its traps; §2 PD-12, PD-14, PD-16; §6.2's last paragraph, §6.4, §6.5.
3. `02-spec.md` §2.3 #27, §4.6–§4.10; AC-42, AC-45, AC-47, AC-59, AC-61, AC-62, AC-64, AC-69, AC-70, AC-73, AC-74.
4. `03-journeys.md` J1.8–J1.12, J3.12–J3.15, J4.8–J4.10, J5.4, J5.5, J5.9a–J5.9c, J5.10, J5.11.
5. `04-wireframes.html` plates 7 and 8, and the calls rows W5, W10, W22–W24, W27, W28, W36–W38.
6. Code: `docs/development/SR5.md` (the look-ahead API, its refusals, *Owed*) and `SR6.md`; `api/src/graphql/schema/typeDefs.ts` (`RhythmLookAhead` and the eight SR5 mutations); client `components/session/*` (the Look ahead placeholder in `SessionPage.tsx`), `components/today/TodayRow.tsx`, `TodayPage.tsx` (the gather on mount, `orderDay`), `components/capture/CaptureSheet.tsx`, `capture/events.ts`, `lib/tagPalette.ts`, `lib/timeThemes.ts`, `components/rhythm/NotSavedLine.tsx`, `utils/useRetryableSave.ts`; `test/rhythmFences.unit.test.ts`; e2e `session.spec.ts` (part 1), `helpers/*`.

## What to build

Replace SR6's placeholder with the Look ahead and When and where steps, `client/app/lib/ics.ts`, the keys in `en` and `fa`, unit tests, and `session.spec.ts` part 2. No API change.

What the code check found:

- **Gather on open** (SR5 *Owed*). `rhythmLookAhead` only reads. When the look-ahead opens, call `runActionGathering(todayKey, nextDateKey − 1)` as `TodayPage` does on mount, *then* read the view; when gathering fails, read anyway. `setNextDate` gathers on the server itself.
- **"From the gap" is re-read** whenever the look-ahead step is shown, including after a return from the Look back link (SR6 decision 2 lets the gap choice change until Finish). Don't cache the view across steps.
- **"Today"** is the day the session is continued: every `todayKey` is `toLocalDateString(new Date())` at the call, never the session's `dateKey`.
- **`CaptureSheet` has no fixed day.** Add an optional `fixedDateKey` prop: the sheet shows that day as its only placement and saves to it; with no prop it is unchanged. The `tracker:captured` event already carries the date; refetch the view when it names a shown day.
- **`TodayRow`** needs the cross-out control hidden (an optional prop, default as today) and its menu's items supplied by the caller, or a look-ahead row composed from its parts. Your choice; keep Today's behaviour and its tests unchanged.
- **Ordering** uses SR2's `orderDay`. A failed Move up/down or drag shows `NotSavedLine` and puts the order back (spec §2.3 #27, open-work row "SR2: a failed `orderDay` isn't drawn"); do the same on Today, where the shared code makes it a few lines.
- **When and where** saves time and place together (`setWhenWhere`; an omitted field clears it, SR5 call 10). It is reached after `completeLookAhead`. **Finish** calls `finishSession(sessionId, todayKey)` and navigates to `/`. The `.ics` reads the view's `nextDateKey`, which is what Finish writes.
- **`ics.ts`**, pure: `buildIcs({ dateKey, time?, place?, summary, now, uid? })` returning a string; the download is a `Blob` and an `<a download>`. Fold by UTF-8 octets with `TextEncoder`, never splitting a multi-byte character. Escape `\`, `;`, `,` and newlines in `SUMMARY` and `LOCATION`. No item data.
- **Fences** (AC-61, AC-62): extend `rhythmFences.unit.test.ts` so the no-count and no-red scans cover every module file and key, `lib/ics.ts` and `components/capture` included.
- Persian terms the spec doesn't fix are yours, informal (D-20); list them in the report.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | The client gathers to the day before the shown next date when the look-ahead opens, and reads the view after | SR5 card decision 1; open-work row "SR5: …only reads" |
| 2 | The look-ahead view is fetched fresh on each showing of the step | Open-work row "SR6: the gap choice can change…" |
| 3 | A failed `orderDay` is drawn on the look-ahead and on Today | Spec §2.3 #27; closes open-work row "SR2: a failed `orderDay`…" without `revise` |
| 4 | The look-back foot label stays as SR6 built it | The founder hasn't answered SR6's question 1; not in this card |
| 5 | e2e seeds with `gqlAs` on a fresh user and `page.clock.setFixedTime`, T0 = `2026-12-01`; the e2e token outlasts the clock (SR6's re-signed token) | SR6's pattern; build plan 0.2's trap |
| 6 | No new dependency | PD-5 |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `client/e2e/session.spec.ts`, `client/app/test/SessionPage.test.tsx` | the Look ahead step shows `step-placeholder` | the step shows the look-ahead; drop the placeholder assertions |
| `client/app/test/rhythmFences.unit.test.ts` | scans `components/today`, `rhythm`, `session` | also scans `components/capture`, `lib/ics.ts`, and every `rhythm.*` key |

Nothing else asserts the look-ahead's absence (grepped `placeholder`, `lookAhead`, `finishSession`, `CaptureSheet`, `orderDay` in `client/app/test` and `client/e2e`).

## Proving it here

360 and 1200 px e2e runs; `expectHitAreas` at 360 px on every new control; `expectReflow` on `/session` at 180 and 360 px in `en` and `fa`, the look-back and look-ahead both (open-work row "SR6: … no 180 px reflow run"); the `.ics` by `waitForEvent("download")`, its text read and checked; failures by `page.route` (J5.9a–c), and J5.10 by a route answering a validation error.

## Done for SR7

- AC-42, AC-45, AC-47, AC-59, AC-61, AC-62, AC-64, AC-69, AC-70, AC-73, AC-74 met, each with its test named in the report
- `ics.unit`: timed, all-day, escaping, a Persian place folded by octets, no item data, two UIDs differ
- targeted tests green: `ics.unit`, `SessionPage.test`, `rhythmFences.unit`, `TodayPage.test`, `Capture.test`, client `tsc --noEmit`, both i18n checks; e2e `session.spec.ts`, `today.spec.ts`, `capture.spec.ts` in slot A; counts in the report; no full suites
- the report written to `.tmp/SR7.report.md` and returned

## Not here

The query script (SR8); the look-back foot label (SR6's founder question 1); the five rows moved to MS2 (`calls.md` row 65); any API change.
