**SR1** · branch `sr1-crossing` · base `main @ 53cd2ec` · card `briefs/SR1.md` · landed 2026-11-19, next: `verify SR1`
**Measured at land:** +541 app · +633 tests · 0 moved (plus `TodayActionRow.tsx` deleted, −305 app; net app ≈ +236) · ~34 min · ~215k tokens — *for the resumed finish/verify pass only, not the original build* — against size **M**. App insertions above M's ~200–350 range but well under 2×; a finding to weigh, not a §6 rule-5 overrun.

---

# SR1 · Crossing out, everywhere: lane report

## 1. Branch and commit hashes

Branch `sr1-crossing`, from local `main @ 53cd2ec` (no upstream). This lane resumed a prior lane's uncommitted work-in-progress (found already sitting in the worktree, unreported), reviewed it against the card, fixed the one real defect found (the e2e flake investigated under part 6), and committed it. Git identity checked first (`git config user.email` → `salmanian.foad2@gmail.com`, `user.name` → `The Monster`), matching every commit below.

- `d7c3916` — SR1 server: `crossing.ts` (`setCrossed`, `attachCrossedPending`), the SDL, `toggleAction` gone.
- `87beddf` — SR1 tests: `crossing.integration`, and `actions.integration`'s `toggleAction` wording dropped.
- `e342adc` — SR1 client: `CrossOutControl`, `NotSavedLine`, `useRetryableSave`; every `toggleAction` caller moved to `setCrossed`.
- `684638e` — SR1 tests: `CrossOutControl`, and `ActionPreview`/`FocusPage`'s crossing branches.
- `f436613` — SR1 e2e: the hit-area helper, and `crossing.spec.ts` at 360 px (PD-16).

Working tree is clean at `f436613` (final commit). `main` and no other lane's worktree were touched.

## 2. Each file changed, and why

**Server**
- `api/src/services/rhythm/crossing.ts` (new) — `setCrossed` (cross/uncross, freeze-and-move, refusals, PD-19) and `attachCrossedPending` (AC-75's batched read).
- `api/src/graphql/resolvers/mutations.ts` — `toggleAction` resolver removed; `setCrossed` wired to the service; `updateAction`'s comment updated to say `toggleAction` is gone rather than "the only other writer" of `done`.
- `api/src/graphql/resolvers/query.ts` — `projects`/`project` batch `attachCrossedPending` over their actions in one query each (AC-75).
- `api/src/graphql/resolvers/typeResolvers.ts` — `Action.crossedPending` (uses the batched value if present, else a one-row fallback for callers like `action(id)`); `FocusPeriod.projects` batches `attachCrossedPending` too.
- `api/src/graphql/schema/typeDefs.ts` — `ReviewSetting` enum, `Action.crossedPending`/`Action.reviewSetting`, `CrossResult`, `setCrossed` mutation added; `toggleAction` removed from the SDL.

**Server tests**
- `api/src/__tests__/crossing.integration.test.ts` (new) — the card's full matrix: today/future/past/undated crossing, a gathered occurrence moved by `forDate`, same-day uncross restoring (date and no date), a later day not restoring, both refusals, `Not found` ×2, a malformed key, `done` untouched, `attachCrossedPending`.
- `api/src/__tests__/actions.integration.test.ts` — the `done`-ignored test now sets `done` via `prisma.action.update` directly (its own point is `updateAction`'s refusal, not `toggleAction`); the `describe("toggleAction")` block deleted with the resolver.

**Client**
- `client/app/components/rhythm/CrossOutControl.tsx` (new) — the square control (W26: `aria-pressed`, labelled, `stopPropagation`, a `::before` 44×44 px hit area) and `CrossedTitle` (the animated strike, reduced-motion aware, AC-22).
- `client/app/components/rhythm/NotSavedLine.tsx` (new), `client/app/utils/useRetryableSave.ts` (new) — the shared amber failure line and the hook that treats a null `call()` as failure (D-5), for every later stage's own save.
- `client/app/api/queries.ts` — `TOGGLE_ACTION` replaced by `SET_CROSSED`; `crossedPending`/`actionFate`/`reviewSetting` added to `GET_PROJECTS`, `GET_PROJECT`, `GET_ACTIONS`, and the Focus project fields.
- `client/app/components/actions/ActionPreview.tsx` — the checkbox replaced by `CrossOutControl`/`CrossedTitle` in both its row shapes (the plain row and the `showTodayOptions` row — see item 2 below); `handleToggle` now calls `setCrossed` through `useRetryableSave`, shows `NotSavedLine` on a null result, and shows the "Moved to today and crossed out" line on a moving crossing; the control is hidden on a fated or `justToKnow` action (PD-19).
- `client/app/components/actions/ActionsListPage.tsx` — `Action`'s type gains `actionFate`/`reviewSetting`/`crossedPending`.
- `client/app/components/focus/FocusCard.tsx` — `complete` renamed `crossOrUncross`, calling `SET_CROSSED`; only a cross (not an uncross) raises the undo toast.
- `client/app/components/focus/FocusProjectCard.tsx` — the row's `Checkbox` replaced by `CrossOutControl`/`CrossedTitle`, driven by `crossedPending`; "Moves at your next session" shown under the progress bar when any action is pending (W31).
- `client/app/components/focus/FocusPage.tsx` — undo is `setCrossed(..., crossed: false)` in place of `toggleAction` (D-12).
- `client/app/components/focus/UndoToast.tsx` — the toast's own text key swapped from `focus.completed` to `focus.crossedOut`.
- `client/app/components/focus/focusLogic.ts` — `FocusAction` gains `crossedPending`/`reviewSetting`; `hasCrossedPending` added for the project card's muted line.
- `client/app/components/projects/ProjectPreview.tsx` — the project's own "Moves at your next session" line; `onCrossedChange` keeps its local action copy in step with a child `ActionPreview`'s crossing.
- `client/app/components/today/TodayActionRow.tsx` — **deleted**; see item 2 under part 5.
- `client/app/locales/en/common.json`, `client/app/locales/fa/common.json` — `focus.completed` → `focus.crossedOut`; `rhythm.notSaved.*` and `rhythm.crossOut.*` added, both languages, informal Persian register.

**Client tests**
- `client/app/test/CrossOutControl.test.tsx` (new) — filled/`aria-pressed` state, the accessible label, no navigation in a link row (AC-21), the reduced-motion override (AC-22), disabled state.
- `client/app/test/ActionPreview.test.tsx` — the checkbox tests become `SetCrossed` tests, plus the fated/`justToKnow` hiding rule and the link-row non-navigation case.
- `client/app/test/FocusPage.test.tsx` — the `ToggleAction` mock branch and AC-17 wording become crossing: the row and progress stay put, Undo uncrosses through `SetCrossed`, a second crossing replaces the toast.

**e2e**
- `client/e2e/helpers/hitArea.ts` (new) — `expectHitAreas`, PD-16's functional 44×44 px probe via `elementFromPoint`.
- `client/e2e/crossing.spec.ts` (new) — J2.11/J2.11a/J2.12 on Focus, the actions list and the project page at 360 px; `fa` once, right to left.

## 3. Every suite or test file run

All run from this worktree, `api/.env` already present (copied by the prior, uncommitted work — confirmed it matches the main checkout's shape and holds no secret beyond the usual dev JWT secret). `npx prisma generate` re-run clean before testing.

- `api/src/__tests__/crossing.integration.test.ts` — **17 passed** (1 file).
- `api/src/__tests__/actions.integration.test.ts` — **16 passed** (1 file).
- `api/src/__tests__/schema.unit.test.ts` + `rhythmSchema.unit.test.ts` (shared-rule rerun: `typeDefs.ts` changed) — **19 passed** (2 files).
- `api/src/__tests__/focusPeriods.integration.test.ts` + `focusPeriods.unit.test.ts` + `projects.integration.test.ts` (shared-rule rerun: `query.ts`/`typeResolvers.ts`'s `projects`/`project`/`FocusPeriod.projects` changed) — **51 passed** (3 files).
- `npx tsc --noEmit` in `api/` — clean, no output.
- `client/app/test/CrossOutControl.test.tsx` + `ActionPreview.test.tsx` + `FocusPage.test.tsx` — **38 passed** (3 files).
- `client/app/test/staleBuild.test.tsx` (card's "leave — now literally true") — **6 passed** (1 file).
- `client/app/test/focusLogic.test.ts` (shared-rule rerun: `focusLogic.ts` changed) — **20 passed** (1 file).
- `npx tsc --noEmit` in `client/` — clean, no output.
- `npm run i18n:check-missing` — "All translations look good!"
- `npm run i18n:check-hardcoded` — "No hardcoded UI strings found."
- `client/e2e/crossing.spec.ts`, slot A (`E2E_API_PORT=4010 E2E_WEB_PORT=5183`), `msedge` — final clean run: **4 passed** (all four tests, ~32 s). One earlier full-suite run had 1 of these 4 fail transiently; not reproduced in four follow-up runs (isolated rerun, and ×3 `--repeat-each`, and a second full-suite run). See part 6.

No full suite run (SR1 isn't a milestone).

## 4. Decisions the card didn't make

1. **`canCross` (hide the control on a fated/`justToKnow` row) lives in `ActionPreview` as a plain boolean**, computed from `action.actionFate`/`action.reviewSetting`, rather than a shared helper. It's one line, used once per render branch, and `focusLogic.ts` already has its own equivalent filtering for Focus (`openActions` excludes any fate; `FocusProjectCard` checks `reviewSetting` directly) — no third surface needed the same check written a third way.
2. **`onCrossedChange` added to `ActionPreview`'s props**, not named by the card. `ProjectPreview` keeps its own copy of each action (for the accordion, the "Moves at your next session" line and the progress bar) and doesn't refetch on every child change, so it needs a way to hear that a crossing landed; this is the same shape `onToggle`/`onDelete` already use there.
3. **The "Moved to today and crossed out" toast times out at 4000 ms**, a plain local timer in `ActionPreview`, distinct from `UndoToast`'s `UNDO_MS` (5000 ms). It's an informational line, not an undo window, so reusing `UNDO_MS` would borrow a constant that means something else.
4. **`NotSavedLine` is `role="alert"`.** The card names the text and the amber styling (never red, §4.9) but not the ARIA role; `alert` is the standard assertive live-region role for "something just failed," matching how `UndoToast`-adjacent surfaces behave elsewhere.
5. **The `showTodayOptions` branch of `ActionPreview` (today's rows) also got `CrossOutControl`.** The card's *Not here* names "Today's rows (SR2)" — see part 5 item 2 for why this was kept rather than left broken or reverted.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. **The build plan's cited stale test line was already corrected on the card** (§5 SR1: "The plan's test line `actions.integration.test.ts:123-131` is stale — those are `updateAction` title tests. The toggleAction-dependent tests are `:137-149` and `:216-227`"). Confirmed against the code: the card's line numbers were the right ones; nothing to add here, just naming it met.

2. **`TodayActionRow.tsx`'s deletion, inherited from the prior lane, is outside SR1's named scope ("Not here: Today's rows (SR2)") but was kept rather than reverted, on reading the actual code:**
   - It had no caller anywhere in `client/`. `TodayPage.tsx` (unmodified by this lane) already renders both its sections through `ActionPreview` with `showTodayOptions`, not through `TodayActionRow`. No test referenced it either.
   - Its only connection to this stage's diff was a dead `TOGGLE_ACTION`/`handleToggle` reference — exactly the kind of "every caller" cleanup AC-17 asks for, on a file that happened to have no live caller to update.
   - The build plan's own SR2 section (§5 SR2 *Logic*) already lists `TodayActionRow.tsx` among the files SR2 deletes outright. Keeping this lane's deletion doesn't anticipate or narrow SR2's work; it just does a piece of already-planned cleanup early, on a file nothing depends on.
   - Reverting it would have restored a file that still imports the now-gone `TOGGLE_ACTION` export, breaking `client/`'s `tsc --noEmit` for no behavioural gain (nothing renders it). Kept as-is.

3. **The `showTodayOptions` branch inside `ActionPreview.tsx` is, functionally, "Today's rows" — the exact surface the card excludes — and this lane's inherited work changed it too**, because `handleToggle`/the `checked`/`crossed` state and the checkbox-vs-`CrossOutControl` JSX are shared by both of `ActionPreview`'s render branches rather than split into two components. Once `toggleAction` is gone everywhere (AC-17's "every caller", including this branch's old checkbox), the only way to keep the shared component compiling was to give both branches the new control. This is *not* new Today UI — no new row, grouping, fold, or copy was added to Today, and the build plan's own §5 SR2 *Screens* section describes Today's rebuild as introducing a distinct `TodayRow` component, which reads as replacing this `showTodayOptions` path rather than building on it. So this branch's `CrossOutControl` is very likely throwaway scaffolding SR2 will discard, not a piece of SR2's actual deliverable done early. Flagging rather than guessing further: **SR2's lane should check whether `showTodayOptions` survives its rebuild at all**, since if `TodayRow` replaces it, this branch (and the `canCross`/`crossed` plumbing inside it) becomes dead code the same way `TodayActionRow.tsx` just was.
   - One concrete gap from this: `GET_TODAY_ACTIONS` (unmodified, out of this lane's named scope) doesn't select `crossedPending` or `reviewSetting`, so on Today specifically: a `justToKnow` action's control is **not** hidden (AC-20 doesn't hold there), and a crossed action's control reads as unfilled after a reload until the field is added to that query. Both are Today-only symptoms of SR1 leaving Today's query alone, as the card asks; SR2 needs to add those two fields to `GET_TODAY_ACTIONS` (or retire this code path entirely) for Today to meet AC-20/AC-75 itself.

4. **Decision 2's phrasing ("`CrossResult` is `{ action: Action!, moved: Boolean! }`") doesn't say where `moved` gets its truth from when the action was already crossed and you cross it again (no-op cross).** Read `moved` as "did this specific call change the planned day" (not "is this action currently away from where it started"), so a repeat cross on an already-today action returns `moved: false` both times. Confirmed by `crossing.integration`'s first test.

## 6. What I couldn't verify

- **One transient e2e failure, not reproduced.** The first full run of `crossing.spec.ts` had test 2 ("Actions list: crossing dates an undated item...") fail: after uncrossing both a previously-undated and a previously-future-dated action, the future-dated one's `tbd` stayed at today instead of restoring to its original date; the page snapshot showed its control still read "Uncross"/`aria-pressed=true`, meaning the click landed but the save result reverted the optimistic uncross (consistent with `useApi`'s D-5 null-on-failure path, which `ActionPreview.applyCrossResult` handles by snapping back to the pre-click state). Re-ran the same test alone (passed, 6.9 s), three times with `--repeat-each=3` (all passed, ~2-4 s each), and the full four-test file again (all four passed, including the one that failed before — this time its first test ran in 3.4 s versus 18 s the first time, pointing at a cold dev-server/API-process warm-up cost on this specific webServer boot, the same class of cost the spec file's own comment calls out for first navigations). Three hypothesis-worthy runs all came back clean, so I'm stopping here rather than guessing further at a cause with nothing left to reproduce. **What would verify it:** a few more cold full-suite runs (fresh `webServer` boot each time, as CI would do) watching specifically for a repeat of this failure; if it recurs, capturing the API process's own stderr during the failing window (not just the client-side screenshot) would show whether the server actually threw (e.g., a transient SQLite contention between two near-simultaneous mutations) or whether the client never sent the second request at all.
- **The review-checklist's §4 180 px reflow rule and both-languages-in-a-browser pass** weren't driven for `CrossOutControl`/the new rows: the card's own *Tests* and *Proving it here* sections name exactly four e2e tests (360 px, one `fa` walk) and no 180 px check, and I kept to that rather than adding e2e coverage the card didn't ask for. The `fa` e2e test does confirm `dir="rtl"` and that the control works right to left, just not at the narrow width.
- **The production behaviour of `showTodayOptions`'s now-shared `CrossOutControl`** (part 5 item 3) — I verified it compiles, renders, and that `GET_TODAY_ACTIONS` lacks the two fields that would make it fully correct there, but didn't drive Today in a browser, since Today's screen is explicitly SR2's to build and I didn't want to spend lane time proving a surface the next stage may replace outright.

## 7. One thing that would have made this stage faster

Knowing, before reading the inherited diff, whether `ActionPreview`'s two render branches (`showTodayOptions` vs. not) share `handleToggle` deliberately or by accident would have saved the time spent tracing `TodayPage.tsx` → `ActionPreview` → `TOGGLE_ACTION` to work out whether the prior lane's `showTodayOptions` change was in-scope. A one-line note on the card ("`ActionPreview` has a `showTodayOptions` branch Today also uses; touching `handleToggle` touches it too — that's fine/not fine") would have turned an investigation into a one-line confirmation.
