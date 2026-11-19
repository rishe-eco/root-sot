**SR2** · branch `sr2-today` · base `main @ 35bf320` · card `briefs/SR2.md` · landed 2026-11-19, next: `verify SR2`
**Measured at land:** +743 app · +487 tests · 0 moved · ~1.7 h (102 min) · ~523k tokens, against size L. App insertions sit above L's ~300–500 range but under 2×; net app code is −1915 (three wizards and the `showTodayOptions` branch deleted), and time is well under L's 4–6 h.

---

# SR2 · Today, with the gate retired: lane report

## 1. Branch and commit hashes

Branch `sr2-today`, from local `main @ 35bf320` (no upstream). Ten commits:

- `2c2c49e` SR2 api: remove the pre-day/after-day surface; dayList carries each action's project
- `6943496` SR2 api: ensureRhythm's create is atomic (upsert), closing a race two calls could hit
- `858f718` SR2 client: queries.ts — dayList, rhythmStatus, ensureRhythm, orderDay
- `90ab9b1` SR2 client: TodayRow and the session line
- `afc0b59` SR2 client: rebuild TodayPage on dayList/rhythmStatus; delete the wizards and TodayActionWidget
- `309ce12` SR2 client: ActionPreview drops showTodayOptions (TodayRow replaces its two callers)
- `79fc256` SR2 client: ensureRhythm fires once from the protected root (AC-1)
- `a013911` SR2 client: Concepts' day-state section and the today/pre-day/after-day copy, en and fa
- `3bb4517` SR2 e2e: rewrite today.spec.ts for the rebuilt Today
- `c79f4cf` SR2 tests: session-line forms, the fold's states, and the module's fences

Identity checked before the first commit: `git config user.email` → `salmanian.foad2@gmail.com` (matches every commit's author). Working tree is clean after the last commit.

## 2. Each file changed, and why

**api**
- `src/graphql/schema/typeDefs.ts` — removed `PreDayStatus`, `ActionWithOverlap`, the `preDayStatus` query and `completeAfterDay`/`completePreDay` mutations.
- `src/graphql/resolvers/query.ts` — removed the `preDayStatus` resolver and its import.
- `src/graphql/resolvers/mutations.ts` — removed `completeAfterDay`/`completePreDay`.
- `src/graphql/resolvers/typeResolvers.ts` — removed the now-orphaned `ActionWithOverlap` resolver.
- `src/services/todayPreDayAfterDay.ts` — removed `getPreDayStatus`; kept `getTodayActions`, `overlaps`, `timeToMinutes`, `getNotDoneActionsForDate` (PD-17, mismatch 1 in the card).
- `src/services/rhythm/dayList.ts` — both Prisma queries now `include: { project: true }` (bug found driving the page; see item 5), and `DayListItem.action` is typed to match.
- `src/services/rhythm/rhythmState.ts` — `ensureRhythm`'s find-then-create replaced with an atomic `upsert` (bug found at e2e verify; see item 5).
- `src/__tests__/today.integration.test.ts` — deleted the `getPreDayStatus` describe and its import (card's instruction).
- `src/__tests__/dayList.integration.test.ts` — added a regression test for the `project` include.
- `src/__tests__/rhythm.integration.test.ts` — strengthened the racing-`ensureRhythm` test to assert neither call throws (was `.catch(() => null)`).

**client**
- `app/api/queries.ts` — added `GET_DAY_LIST`, `GET_RHYTHM_STATUS`, `ENSURE_RHYTHM`, `ORDER_DAY`; widened `RUN_ACTION_GATHERING` with `$endDate`; removed `GET_PRE_DAY_STATUS`, `COMPLETE_PRE_DAY`, `COMPLETE_AFTER_DAY`.
- `app/components/today/TodayRow.tsx` (new) — one row: cross control, time, the amber Overlaps mark, project/source or "just to know", the handle (tap = Move up/down menu, hold = drag).
- `app/components/today/SessionLine.tsx` (new) — the session line's five forms.
- `app/components/today/TodayPage.tsx` — rebuilt on `dayList`/`rhythmStatus`: the session line, ordered list with drag/Move up/down, the fold, empty and failed-load states, gathering to the next session's due date.
- `app/components/today/PreDayWizard.tsx`, `AfterDayWizard.tsx`, `TodayActionWidget.tsx` — deleted (card's instruction; TodayRow replaces their callers).
- `app/components/actions/ActionPreview.tsx` — removed the `showTodayOptions` branch, its prop, and the state/handlers only it used (SR1's carried-over scaffolding; card's Decision 2).
- `app/root.tsx` — `ProtectedAppLayout` fires `ensureRhythm` once, gated on `isAuthenticated && ready` (AC-1).
- `app/components/concepts/ConceptsPage.tsx` — the day-state section now has two states (crossing, the session), not four; no pre-day/after-day/locked wording.
- `app/locales/en/common.json`, `app/locales/fa/common.json` — the Concepts and today-intro copy; `today.skillsDue_one/_other` → `today.skillsDuePlain` (PD-9); new `rhythm.today.*` keys; removed the now-dead `onboarding.modules["pre-day"]`/`["after-day"]` and a handful of keys only the old TodayPage used (`organize`, `review`, `addActionPlaceholder`, `estimatedTimeMin`, `goodMorning`, `afterDay`, `linkedActions`, `standaloneActions`, `noLinkedActions`, `noStandaloneActions`, `gatheringActions` — the last one by the card's own instruction, "retire `today.gatheringActions`").
- `app/test/SessionLine.test.tsx`, `TodayPage.test.tsx`, `rhythmFences.unit.test.ts` (new) — the three client tests the card names.
- `e2e/today.spec.ts` — rewritten for the rebuilt page.
- `e2e/helpers/moduleKeys.ts` — dropped `"pre-day"`/`"after-day"` (no overlay names them anymore).

## 3. Every suite or test file run

All targeted (`vitest run <file>`, one file at a time where the card asked for exact counts); no full suite.

**api**
- `today.integration.test.ts` — part of a 9-file run below.
- `overlap.unit.test.ts`, `schema.unit.test.ts`, `rhythmSchema.unit.test.ts`, `dayList.integration.test.ts`, `orderDay.integration.test.ts`, `rhythm.integration.test.ts`, `crossing.integration.test.ts`, `actions.integration.test.ts` — shared-rule reruns (`dayList.ts` and `rhythmState.ts` both changed) plus the card's named files.
- Combined: **9 files, 108 passed.**
- `npx tsc --noEmit` in `api/`: clean.

**client**
- `SessionLine.test.tsx`, `TodayPage.test.tsx`, `rhythmFences.unit.test.ts` (new), `CrossOutControl.test.tsx`, `ActionPreview.test.tsx` (shared rule: `ActionPreview.tsx` changed), `FocusPage.test.tsx` (shared rule: crosses actions through the same control), `staleBuild.test.tsx`, `authSession.test.tsx` — **8 files, 68 passed.**
- `npx tsc --noEmit` in `client/`: clean.
- `npm run i18n:check-missing`: "All translations look good!"
- `npm run i18n:check-hardcoded`: "No hardcoded UI strings found."

**e2e** (slot A, `E2E_API_PORT=4010 E2E_WEB_PORT=5183`, `msedge`)
- `today.spec.ts`: **7 passed**, cold, twice in a row (no flake seen).
- `crossing.spec.ts` (SR1's, rerun because `ActionPreview.tsx` and `root.tsx` changed): **4 passed** on the last full run; one failure seen once, in the "Actions list … uncrossing restores both" test, isolated and confirmed **pre-existing** — see item 5 and item 6.

## 4. Decisions the card didn't make

1. **`TodayRow` carries no Settings, Notes, or the postpone/outsource/ignore/pass menu.** Spec §4.1 lists the row as title, time, the overlap mark, project/source, and the cross-out control — nothing else — and no wireframe plate draws more. The old `showTodayOptions` branch had all of that; I read its absence from the new row's spec as intentional (Today becomes a pure read/cross/reorder surface) rather than an oversight, and removed it with `ActionPreview`'s dead branch. Those actions stay reachable from the Actions list and the project page, which keep the full `ActionPreview`.
2. **The handle's tap-vs-hold split uses `PointerSensor`'s `activationConstraint: { delay: 150, tolerance: 5 }`**, not a distance threshold. W27 calls it "a hold drags"; a time-based delay is the literal reading, and it leaves a plain click free to open the Move up/down menu.
3. **A refused cross-group drop is enforced client-side**, not by calling `orderDay` and reading its refusal. Each visible row's group (one start time, or "Any time") is computed locally; `onDragEnd` simply does nothing when the dragged row's group differs from the drop target's — no API call, no error, the row returns to place by never having left it in state. This matches W6/W27's "slides back silently" more directly than a round trip that always succeeds at the server (`orderDay` only refuses a genuinely mixed *request*, which the client never sends).
4. **Today's own date line (`fmt(new Date(), "weekdayDayMonth")`) is new** — the old page had no date under "Today" at all. Plates 1 and 2 draw one; I added it rather than reading its absence as a second screen.
5. **A loading skeleton row is shown while `gatherRunning`, appended after the real rows** — one `<Skeleton>`, no spinner text — reading W7's "placeholder rows … gathering's new rows slot in when it returns" as wanting some visible sign during the background gather, not only on the very first load.
6. **Now-orphaned locale keys only the old `TodayPage` used were removed**, not left as dead weight — except `today.skillsDue_one/_other`, which the card named explicitly, and `onboarding.modules["pre-day"]`/`["after-day"]`, which I also removed since nothing renders them. `today.addActionForToday` was already dead before this stage (unrelated) and I left it alone.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. **The build plan and the card disagree on the 180 px reflow.** `07-build-plan.md` §5 SR2's Tests line says the e2e rewrite covers "reflow at 180 px"; the card's own "Proving it here" section says the opposite — "Not drivable by the lane, leave for verify: the 180 px reflow …". I followed the card (the more specific, most recently drafted instruction, and brief-common's "who wins" doesn't resolve a disagreement between the plan and the card itself) and did not drive 180 px here. Flagging so `verify` knows which one it's reconciling against, and so the 180 px pass is still owed, not silently dropped by either document.
2. **`dayList` was shipped without `include: { project: true }` at SR0**, and nothing caught it until this stage's e2e: no SR0/SR1 test reads a dayList row's `action.project`, and `Action.project`'s resolver (unlike `.tags`/`.crossedPending`) has no lazy fallback — it reads straight off what Prisma included. The card didn't ask me to re-verify SR0's query shape, but a row with a project and no project label is wrong, so I fixed it here and added `dayList.integration.test.ts`'s regression test.
3. **`ensureRhythm`'s find-then-create had a live race**, surfaced only because this stage is the first to call it from a real page load under StrictMode's double-mount effect. SR0's own test defended against the symptom (`.catch(() => null)`, asserting only "exactly one row") rather than the cause. The card's trap ("StrictMode fires mount effects twice … don't add a client guard") told me not to hide this client-side, which is right — the real fix had to be server-side, and I made it atomic.
4. **"Just to know" (W4) can't be driven in e2e yet.** `addAction` doesn't accept `reviewSetting` — SR3 adds that. `TodayRow`'s display logic for it is implemented and will light up once a fixture can set it; I could not exercise it end-to-end here. Noted again in item 6.
5. **The card's SDL instruction ("their SDL types") matched the code exactly** — `PreDayStatus`, `ActionWithOverlap`, both mutations, both queries — so there was nothing to interpret there; recorded only because the card's *Mismatches found* section asked me to flag anything not matching 1:1, and this one did.

## 6. What I couldn't verify

- **"Just to know" end to end** (item 5.4): no current mutation sets `reviewSetting`. `TodayRow`'s hiding of the control and the "just to know" label are covered by reading the code, not by a browser. Verified by SR3's e2e once capture/forms can set it.
- **180 px reflow** (item 5.1): left to `verify` per the card, not driven here.
- **Both-languages and light-scheme hand pass of `CrossOutControl`/`TodayRow`**: owed since SR1, the card repeats it as open-work; not driven here either (the e2e spec's one `fa` pass is `crossing.spec.ts`'s, not new in this stage — Today itself has no dedicated `fa` e2e test in this rewrite, since the card's named coverage was J1.1–J1.3, J2.1–J2.6, J2.13a, order/refusal/hit-areas, not a Persian pass).
- **The `crossing.spec.ts` "Actions list … uncrossing restores both" flake** (item 5's item on it, and 4's related finding): confirmed pre-existing by isolation — it still fails intermittently (3/5 under `--repeat-each=5`) with my `root.tsx` change fully disabled, so it is not something this stage introduced. It is the same flake SR1's own stage record named ("an Actions-list uncross not restoring on a cold first run … recorded as a cold-boot flake, not reproduced") — this run reproduces it more often, which is itself new information, but the cause sits in `crossing.ts`/`ActionsListPage.tsx`, SR1's files, not anything SR2 touched. Owed to whoever next touches crossing: it looks like two near-simultaneous mutations on different actions occasionally lose one write, not the single-action repeat-cross bug SR1 already fixed.
- **A real deploy.** PD-10 holds this: nothing here is pushed, per the card's "What the verify deploys: None."

## 7. One thing that would have made this stage faster

A regression harness (even a short one) that drives `dayList`/`ensureRhythm` through an actual running server rather than only through unit/integration calls would have caught both server bugs (item 5.2, 5.3) before the e2e pass, instead of at it. Both were one-line fixes once found, but finding them cost most of this stage's debugging time.
