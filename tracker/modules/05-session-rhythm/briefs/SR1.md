# SR1 · Crossing out, everywhere — phase card

*For the Sonnet lane building SR1. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR1`, 2026-11-19, from `07-build-plan.md` §5 SR1 (with §2 PD-6/PD-10/PD-19, §1 D-5/D-12/D-15, §6 "the `done` invariant"), `03-journeys.md` J2 and J5, `04-wireframes.html` plate 4 (W13/W14/W26/W29/W31/W39), `docs/development/SR0.md`, and the code as it is: `rishe-eco/tracker` main @ 53cd2ec.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr1-crossing` |
| Branch | `sr1-crossing`, from local `main @ 53cd2ec`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` (pushed fresh by Vitest) |
| Ports | slot A, e2e API `4010` / web `5183` — SR1 runs e2e (`crossing.spec.ts`) |
| Size | M: 2–4 h, ~200–350 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 SR1 **in full**; then §2 PD-6 (`done` arg kept and ignored), PD-10 (push order), PD-19 (fated/just-to-know can't be crossed); §1 rows D-5, D-12, D-15; and §6 "The `done` invariant".
3. `docs/development/SR0.md` (the stage record) for the schema SR1 rests on: `firstDueKey`, `freezeFirstDue`, `plannedDayData`/`plannedDayKey`, and the day record keyed `(actionId, dateKey)` with `crossedAt`, `crossMoved`, `movedFromKey`. Read `api/src/services/rhythm/days.ts` and `rhythmState.ts` before writing `crossing.ts`.
4. `03-journeys.md` J2 (steps 2, 2a, 11, 11a, 12) and J5 (refusals); `04-wireframes.html` plate 4; `02-spec.md` AC-17 to AC-22, AC-55, AC-75.
5. Canon by section: `02-architecture/02-graphql-api.md` (the mutation and batched field) and `03-frontend.md` (the control and toasts).

## What to build

Everything in §5 SR1's *Logic*, *API*, *Screens*: new `api/src/services/rhythm/crossing.ts` with `setCrossed(actionId, todayKey, crossed)` (the move-to-today, freeze and day-record rules exactly as §5 states; refuse a "just to know" or fated action, PD-19, and a stranger's → `Not found`; never touch `done`); the `setCrossed(id, todayKey, crossed): CrossResult { action, moved }` mutation; `crossedPending` on `Action`, batched into the Focus and project queries, driving AC-75; and the client controls. The code check found more than the plan lists — do all of it:

- **`toggleAction` removal is wider than one line.** Remove the resolver (`mutations.ts:929-936`), the SDL field (`typeDefs.ts:2676`), the client op (`queries.ts` `TOGGLE_ACTION`, ~:131-139) and every caller: the Focus undo (`FocusPage.tsx:56-62` → uncross, D-12) and `ActionPreview.tsx`'s checkbox → the cross-out control. **Leave `ToolsPage.tsx`'s local `toggleAction`** — it is a selection helper (trap).
- **The plan's test line `actions.integration.test.ts:123-131` is stale** — those are `updateAction` title tests. The toggleAction-dependent tests are `:137-149` and `:216-227` (see the table). Flag the stale reference in report item 5.
- **`done` has no writer after this stage** until SR4's `answerItem`. This is intended (D-15, §6). Don't add a replacement and don't keep `toggleAction` alive for it.

Shared UI, used by every later stage: `NotSavedLine` (amber "Not saved." + **Try again**, W29) and `useRetryableSave` (treats a null `call()` as failure, D-5); `CrossOutControl` (W26): a square in the checkbox's slot, filled when crossed, `aria-pressed`, labelled, title strikes through (animated unless reduced motion, AC-22), `stopPropagation` in link rows (AC-21). A crossed row stays in place (W13); a moving crossing toasts "Moved to today and crossed out" (W14); Focus's undo toast reads "Crossed out: <title>". "Moves at your next session", muted, under progress on Focus and the project page (W31).

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | New-file homes: `useRetryableSave` in `client/app/utils/` beside `useSubmitGuard.ts`; `NotSavedLine` and `CrossOutControl` in a shared `client/app/components/` folder consistent with their siblings. There is no central hooks dir. | The plan names no path; colocation matches the repo. Verify confirms the homes. |
| 2 | `CrossResult` is `{ action: Action!, moved: Boolean! }`; `moved` is true only when the crossing changed the planned day, and drives W14's toast. | §5 names the shape but not `moved`'s nullability; keep it non-null like SR0's `orderDay`. |
| 3 | `crossedPending` is batched in the Focus and project queries the way SR0 batched its rhythm reads, not resolved per row. | Avoids an N+1 on every list; matches SR0's pattern. |

## Tests that change on purpose

The lane changes these and no others; probe each new rule with inputs the tests don't hold.

| Test file | Asserts today | New rule |
|---|---|---|
| `api/src/__tests__/actions.integration.test.ts` | `:137-149` uses `toggleAction` to set `done`, wording "only toggleAction flips it"; `:216-227` `describe("toggleAction")` tests the resolver | rewrite `:137-149` to set `done` via `prisma.action.update` and drop the toggleAction wording — the `updateAction` ignores-`done` assertion stays (PD-6); **delete** `:216-227` (resolver gone) |
| `client/app/test/ActionPreview.test.tsx` | `:104-118` the checkbox calls `TOGGLE_ACTION` and `onToggle` | the cross-out control calls `setCrossed`; activating it in a link row never navigates (AC-21) |
| `client/app/test/FocusPage.test.tsx` | `:24-28` mock harness `ToggleAction` branch; `:235` "completes through ToggleAction … (AC-17)" | crossing-mutation branch; the control crosses out, undo uncrosses (D-12), toast reads "Crossed out: <title>" |
| `client/app/test/staleBuild.test.tsx` | `:56` uses `toggleAction` as an example of an operation the server no longer has | **leave** — `toggleAction` is now literally removed, so the example holds |

New test files: `api/src/__tests__/crossing.integration.test.ts` (today; future, past and undated moved with first-due unchanged; a gathered one moved by `forDate`; uncross same day restores date and no-date; a later day doesn't restore; refusals PD-19 and `Not found`; `done` unchanged); a `CrossOutControl` client test (no navigation in a link row, reduced motion); `client/e2e/helpers/hitArea.ts` (the `expectHitAreas` helper); e2e `client/e2e/crossing.spec.ts` (J2.11, J2.11a, J2.12 at 360 px with `expectHitAreas`; `fa` once).

## Proving it here

Slot A has e2e (ports 4010/5183). Export `E2E_API_PORT=4010 E2E_WEB_PORT=5183` in every spec command and run **`crossing.spec.ts` only** — never the full e2e suite. Reduced-motion and link-navigation are proven by the `CrossOutControl` component test; the move-and-restore rules by `crossing.integration` against your test database.

## What the verify deploys

Nothing. SR1 is not pushed (PD-10); the first deploy is at MS2. The `toggleAction` removal must deploy **after** SR0's migration (trap), which that single MS2 deploy satisfies.

## Done for SR1

- AC-17, AC-18, AC-19, AC-20, AC-21, AC-22, AC-55, AC-75 met, each with its test named in the report.
- Targeted tests green with counts in the report; `npx tsc --noEmit` in `api/` and `client/`, and both `client` `i18n:check-*`, green. No full suites.
- The report written to `.tmp/SR1.report.md` and returned as your last message.

## Not here

Today's rows and the "Crossed out" fold (SR2); the session look-back and `answerItem` that writes `done` (SR4); `ToolsPage.tsx`'s selection `toggleAction` (leave it). Don't write a stage record or touch `main`.
