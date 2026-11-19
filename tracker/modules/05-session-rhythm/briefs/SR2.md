# SR2 · Today, with the gate retired — phase card

*For the Sonnet lane building SR2. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR2`, 2026-11-19, from `07-build-plan.md` §5 SR2, journeys §3–§4.1, wireframes plates 1, 2, 10, open-work rows for SR1→SR2 (AC-20/AC-75 on Today), and the code as it is: `rishe-eco/tracker` main @ 35bf320.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr2-today` |
| Branch | `sr2-today`, from local `main @ 35bf320`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | e2e API `4010`, web `5183` (slot A) — `E2E_API_PORT=4010 E2E_WEB_PORT=5183` |
| Size | L: ~6–9 h, ~300–500 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 **SR2** (the stage), plus its §2 PD-9 (skills line loses its number), PD-10 (must not deploy before MS2), PD-17 (helpers kept)
3. `03-journeys.md` §4.1 (the session line's five forms), §3 (states: empty Today, failed save, gathering); wireframes plates **1, 2, 10** (`04-wireframes.html`) — cite the plate index, don't re-read copy
4. Stage records `docs/development/SR0.md` (shapes of `dayList`, `orderDay`, `rhythmStatus`, `ensureRhythm`) and `SR1.md` (`setCrossed`, `CrossOutControl`, `crossedPending`/`reviewSetting`)

## What to build

Rebuild **Today** on SR0's server work, which no client screen reads yet. The server has `dayList(dateKey)`, `rhythmStatus(todayKey)`, `ensureRhythm(todayKey)`, `orderDay(dateKey, actionIds)` and SR1's `setCrossed` — but `client/app/api/queries.ts` has **no** query document for any of them. Add those documents; this is net-new client wiring, not new API.

- **The session line** under the date (plate 1/2, W2): its five forms from §4.1, link at the end to `/session` (SR6 route, not built — link may 404 for now), no number. `rhythmStatus` drives the form. "Plan your next days" (W3) with nothing else.
- **The list** from `dayList`: timed rows first, then "Any time". `TodayRow` (new): title, time, the amber start-edge "Overlaps" bar (W5) from the row's `overlaps`, project/source, the "just to know" slot (W4), `CrossOutControl` (reuse SR1's). The handle is a button for **Move up / Move down** and a hold-to-drag within its time group (W6, W27) — use the installed **@dnd-kit** (as `ManageGoal.tsx`/`IntervalForm.tsx` do); a refused drop (mixed group — `orderDay` returns `Boolean!` false) slides back silently.
- **States:** the "Crossed out" fold, closed, no count, hidden when empty; "Nothing on today." (AC-68); placeholder rows while loading or gathering (W7, retire `today.gatheringActions`); "Today didn't load." with **Try again** on a failed load, never the empty line (W28, D-6).
- **AC-20/AC-75 (owed from SR1):** the new `dayList` document must select `action { … crossedPending reviewSetting }` so a `justToKnow` control is hidden and a crossed control reads filled after reload on Today. This retires the `showTodayOptions` path (see Decided here).
- **First visit creates the rhythm state:** wire `ensureRhythm(todayKey)` into the protected root `ProtectedAppLayout` (`client/app/root.tsx`) in one `useEffect` gated on `isAuthenticated && ready`, so the first page of any kind sets the switch date (AC-1).
- **Remove** (client): `GET_PRE_DAY_STATUS`, `COMPLETE_PRE_DAY`, `COMPLETE_AFTER_DAY`, `PreDayWizard.tsx`, `AfterDayWizard.tsx`, `TodayActionWidget.tsx`. **Remove** (server): `getPreDayStatus`, `preDayStatus` query, `completePreDay`, `completeAfterDay`, their resolver entries and SDL (`PreDayStatus` type, the two mutations). Rewrite Concepts' day-state copy (`ConceptsPage.tsx` `concepts.dayState.*`; `common.json` en+fa), dropping the pre/after-day and "locked" wording.

**Mismatches found, flagged for verify:**
1. **Keep `GET_TODAY_ACTIONS`** (client) and `getTodayActions`/`todayActions` (server): `ToolsPage.tsx:280` (Time Map) still reads it. The plan removes only the pre/after-day surface, not this.
2. **Keep `overlaps` and `timeToMinutes`** — they live in `api/src/services/todayPreDayAfterDay.ts` alongside the removed `getPreDayStatus`. Strip the pre/after-day functions; keep the file (or move the two helpers and fix `overlap.unit.test.ts`'s import). Don't delete the module wholesale.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | AC-20/AC-75 ride on `dayList`'s `action { crossedPending reviewSetting }`, not on patching `GET_TODAY_ACTIONS` | `dayList` is Today's new source; `GET_TODAY_ACTIONS` stays only for Tools (mismatch 1) |
| 2 | Remove `ActionPreview`'s `showTodayOptions` prop/branch (`ActionPreview.tsx:405`) and `TodayActionWidget.tsx` | `TodayRow` replaces the only two callers (`TodayPage.tsx:250,331`); SR1 left them as compile scaffolding. Clears the SR1 carry-over |
| 3 | `ensureRhythm` fires from `ProtectedAppLayout`, once, idempotent, no client guard | Card trap: a client guard hides a real gather failure; server `ensureRhythm` is idempotent and gathering-locked |
| 4 | Drag via installed `@dnd-kit` (PointerSensor on the handle); keyboard order is Move up/Move down | No new dependency; matches the existing sortable pattern |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `api/src/__tests__/today.integration.test.ts` | `describe("getPreDayStatus")` (overlap, actionsWithoutTime) | Delete that describe and its `getPreDayStatus` import; keep `getTodayActions` and `getNotDoneActionsForDate` describes |
| `client/e2e/today.spec.ts` | `:24` renders old heading + "Organize"/"Review" buttons; `:58` toggles the old checkbox row | Rewrite to J1.1–J1.3, J2.1–J2.6, J2.13a at 360 and 1200 px; order survives reload; refused drop; `expectHitAreas`; reflow at 180 px |
| `api/src/__tests__/overlap.unit.test.ts` | imports `overlaps`/`timeToMinutes` from `todayPreDayAfterDay` | Keep as-is if the helpers stay in that file; if moved, update the import only |

New tests to add — client: session-line forms; fold hidden when empty; failed load shows the line, not the empty state. `rhythmFences.unit.test.ts` (client): no `{{count}}`/plural key under the module's namespaces; no `red-` or `destructive` class in its files (D-22).

## What the verify deploys

None. SR2 is not pushed or deployed (PD-10): it switches the founder on first load (`ensureRhythm` sets the switch date) and must land only in the MS2 deploy. No image, no migration.

## Proving it here

- e2e `today.spec.ts` at 360 and 1200 px (slot A); run cold at least once. Report counts, don't assert outcomes you didn't run.
- Not drivable by the lane, leave for verify: the **180 px** reflow and a both-languages / light-scheme hand pass of `CrossOutControl` and `TodayRow` (open-work, owed from SR1).

## Done for SR2

- AC-1, AC-2, AC-3, AC-4, AC-7–AC-16, AC-53, AC-68 met, with their tests; AC-20/AC-75 now hold on Today
- targeted tests green (api `today.integration`, `overlap.unit`, `rhythm.integration`; client Today + `rhythmFences`; e2e `today.spec`), counts in the report; both i18n checks green; `tsc --noEmit` clean in api and client; no full suites
- the report written to `.tmp/SR2.report.md` in the seven parts and returned

## Not here

Capture (SR3), the `/session` screen (SR6), the session line's deep behaviour beyond its five display forms. Don't migrate stale `ModuleIntroViewed` rows left by the removed intros (harmless).
