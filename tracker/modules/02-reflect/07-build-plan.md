# Reflect — build plan

*Module `tracker/modules/02-reflect/` · Track: Module · Phase 7 · `build-plan`. The order the code lands in and the shape it takes, to the level of tables, routes, refusal codes, screens and tests, so each stage's phase card is a transcription and not a design exercise. Inputs: `02-spec.md` 0.1, `03-journeys.md` 0.2, `04-wireframes.html` draft 1, `lifecycle/projects/tracker/` (config 0.3, brief-common 0.1, review-checklist 0.3). No `04b-design/`, `05-ux-review.md` or `06-eval-plan.md`: see the gate line below. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-10-21 · Owner: _root**

**Gate overridden.** `GATE OVERRIDDEN · phase 7`, reason: *"founder 2026-10-21: wireframes are final; no design step (4b) and no ux-review; eval-plan waived"*. Overridden: missing `05-ux-review.md`, missing `06-eval-plan.md`. Consequences carried here: no eval instrument places a precondition in the stage order (§4 P0-5); nothing reviewed the wireframes before this plan, so the defect pass (§0.4) is the only read of them against the code.

**Where this file yields.** On *what* the module does, the spec wins. On what a person experiences, the journeys win. On how it looks, the wireframes (there is no design step). On what the code is, the repository.

**Grading.** Everything here is **proposal**. Facts about the code and infrastructure are **as-built**, read at `rishe-eco/tracker main @ 5fd71c9`. Items marked **[F]** were decided by the founder (spec §2 #1–8, journeys §1 #1–4, and this run's override). Every other decision is Claude's, listed in §2 for veto.

---

## 0. What this plan is written against

### 0.1 · What was read

- **The module:** `02-spec.md` 0.1 whole; `03-journeys.md` 0.2 whole; `04-wireframes.html` draft 1 (all 11 plates' captions, *Calls made here* W1–W19, *Coverage*); `STATE.md` (the 1–4 blocks' carry-overs: R6, R7, R8, R9, G6).
- **The project:** `lifecycle/projects/tracker/config.md` 0.3, `brief-common.md` 0.1, `review-checklist.md` 0.3; `tracker/canon/02-architecture/04-conventions.md` 0.6.
- **The code, at `main @ 5fd71c9`:**
  - `api/prisma/schema.prisma` (the F&N block at :641, the Noticing block at :741 to end of file, `User` at :303);
  - `api/src/graphql/schema/typeDefs.ts` (the F&N banner at :1595, the Noticing banner at :1822, `type SkillOverview {` at :2135, `type Query` at :2162, `type AuthPayload` at :2295, `type Mutation` at :2330);
  - `api/src/index.ts` (`authenticate`, `enforceTokenScope`); `api/src/graphql/auth.ts`; `api/src/services/userLock.ts`;
  - `api/src/services/noticing/session.ts`, `catches.ts`; `api/src/services/feelingsNeeds/distinctions.ts`, `session.ts`; `api/src/content/feelings-needs/index.ts`, `types.ts`, `dials.ts`;
  - `api/src/__tests__/noticingFences.unit.test.ts`, `schema.unit.test.ts`; `api/package.json`;
  - `client/app/protectedRoutes.tsx`, `root.tsx` (:35), `components/auth/LoginPage.tsx` (:24), `components/tools/ToolsHomePage.tsx`, `components/learn/FeelingsNeedsPage.tsx` (:81–96), `api/useApi.ts`, `api/authSession.ts`, `vite.config.ts`;
  - `client/playwright.config.ts`, `client/e2e/globalSetup.ts`, `client/package.json`.

### 0.2 · What this plan must not break

- **The fences that exist.** `noticingFences.unit.test.ts` slices `schema.prisma` from `Impact · Noticing (Act 1)` to the end of the file, and `typeDefs.ts` from the same banner to `type SkillOverview {`. Anything Reflect adds inside either slice falls under Noticing's fences (R8, D-2).
- **`schema.unit.test.ts`:** every resolver has a field and the SDL builds.
- **The dead-session path** (convention 11): `root.tsx` alone decides where a signed-out person goes, matching the exact string `Unauthorized`. Reflect's token refusal must not throw that string (D-12).
- **Feelings & Needs and Noticing:** Reflect reads F&N's content pack and two pure functions, and touches none of either tool's tables, state, resolvers or screens (spec §2 #5, #18; AC-26).
- **The deploy.** A push to `main` deploys (`config.md` §7): every `verify` merge goes live, and B1's migration runs `prisma migrate deploy` on the box after a backup.
- **The e2e suite on the Windows build machine** keeps working with no new environment variables (B0's defaults).

### 0.3 · House rules this build is held to

The project's rules are set: `brief-common.md` (what a lane follows), `review-checklist.md` (what `verify` checks) and the thirteen conventions. Three apply with particular force here:

1. **Convention 13, written at the site.** Reflect spends it twice and says so in a comment and the decision log: `ReflectState.lastCatchAt` is stored, not derived (Noticing's reason: a dismissed catch is still a touch); and Reflect imports F&N's pack and pure functions across two rehearsals (spec R3). Reflect's interpretation matcher is **copied** from Noticing's `catches.ts`, not imported, so that Impact's code and Reflect's migrate apart cleanly.
2. **Text never leaves the row.** No Reflect body is logged, put in a URL, an error message, browser storage or the Apollo cache after a delete.
3. **Nothing counted on screen.** The only number a Reflect screen shows is a date (AC-44); no server field returns a count (fenced).

### 0.4 · Found while reading *(defects in the documents and code, each assigned)*

| # | Defect | Where | Assigned to |
|---|---|---|---|
| D-1 | **No account-deletion flow exists.** J5.11 and the wireframes' Coverage call it "the app's existing flow"; no mutation or screen deletes a user (grep `api/src`, `client/app`). AC-7's second half can only be proven by deleting the `User` row in an integration test and checking the cascade. | journeys J5.11; wireframes Coverage | B2 (the cascade test); flagged for `close-out` (known issues) |
| D-2 | **Noticing's fences slice to EOF and to `SkillOverview`** (R8). Reflect models appended to `schema.prisma`, or types put between `typeDefs.ts`:1822 and :2135, would be checked by Noticing's rules. | `noticingFences.unit.test.ts` | B1 (schema placed before the Noticing banner), B2 (types placed before the F&N banner); Reflect's fences assert both placements |
| D-3 | **AC-3 against Back to the pre-check.** The pre-check answers are never returned by the API (AC-3), so a pre-check reached again by Back would show blank chips over answers already stored. Plate 4 draws Back on the story; G2 itself says Back on steps 2–4 only. | wireframes plate 4; journeys G2 | B4: no Back on the story; the answers are committed only on leaving the pre-check (PD-6) |
| D-4 | **Kept but unreachable.** AC-37 lists only closed entries with story text, while the calm close promises that "what you wrote is kept and can be deleted". An entry stopped with a scene, moments or readings but no story is kept and can never be found again or deleted by its owner. | spec AC-14, AC-37, §4.9 | **Carried to `revise`**, needed by B6 (PD-12, §10) |
| D-5 | **The Past entries list has no bound.** Spec §4.10 sets no limit; Noticing's history silently caps at 200 (`session.ts`, `getHistory`). A silent cap would hide entries the person can no longer delete. | spec §4.10 | B2 (pages of 50, a `before` cursor), B6 (a *Show older* link) — PD-11 |
| D-6 | **F&N's palette selection is private and keyed on F&N's own sitting count** (`feelingsNeeds/session.ts:83`, `selectFeelingIds`). Calling it would mean counting `LoopSitting` rows, which AC-26 forbids. | spec §1.1, AC-22 | B2: Reflect's own pure selection (PD-8) |
| D-7 | **F&N's `maybeCatch` bundles `catchAllowed`**, which counts `LoopEntry` rows (`distinctions.ts:198`, `:239`). Only `detectFauxFeeling` and `composeCatch` may be imported. | spec §1.1, AC-26 | B3 (and the import fence) |
| D-8 | **Resuming only today's sitting.** F&N and Noticing resume an open sitting only if it began today (`startOfToday`). Reflect resumes an open entry of any age (J4: three weeks later). Copying the pattern would orphan the entry. | `noticing/session.ts`, `getActiveSitting` | B2 |
| D-9 | **Leaks of what is never shown back** (pre-check answers, the after-entry answer, the catches surfaced, whether an entry was stopped). Checked mechanisms: GraphQL types (fenced, AC-3); mutation results (the answer returns `Boolean`, saves return the entry type); error messages (only the owner can reach them); URLs (the entry id only, uuid; G14's not-found is the same for both cases); timing (one `findUnique` on every path); logs (as-built, nothing logs a request body; no Reflect `console.*`); browser storage (the PWA precaches only build assets, `vite.config.ts`; Apollo's cache is in memory). **Open:** the Apollo cache still holds a deleted entry until it is evicted. | spec AC-3, §2 #11, G10 | B2 (types, `outcome` kept out of the API), B4 and B6 (evict on delete) |
| D-10 | **Sign-in after expiry is as-built.** `root.tsx:35` sends a signed-out person to `/login` with `state.from`, and `LoginPage.tsx:24` returns there. G12 needs no new code; plate 4 draws `/signin?next=`, which doesn't exist. | wireframes plate 4 | B4 (verify only) |
| D-11 | **e2e is not lane-safe and won't start on Linux:** `channel: "msedge"`, web `5173` with `reuseExistingServer: true`, API fixed at `localhost:4000` in `globalSetup.ts`, users signed up in the running API's dev database (R9). | `client/playwright.config.ts`, `e2e/globalSetup.ts` | B0 |
| D-12 | **Convention 11's exact-string match.** A token refusal phrased "Unauthorized" would be treated by `authSession.ts` as a dead session. | `api/src/graphql/auth.ts`; convention 11 | B2 |
| D-13 | **The sentence for *Use this* drifts under normalization.** Matching runs on `normalizeForMatch` text (combining marks and tatweel removed, NFC), so offsets into the normalized story don't map back to what the person typed. | spec AC-30 | B3: split the original story into sentences first, then normalize and test each |
| D-14 | **A double tap on *Start a new one*** would close the entry it had just created and open another. | spec §2 #14, AC-10 | B2: `startReflectEntry(replacing: ID)` closes only that id |
| D-15 | **An autosave still in flight when Next, Back or Stop here is tapped** lets the reality check's catch read a stale story, or a save land on a closed entry. | journeys G1, G3 | B4 (the client flushes first); B2 (a write to a closed entry is refused) |
| D-16 | **Which locale Reflect asks F&N for.** F&N's own page serves the request's locale; Reflect serves the practice locale (`en`) whatever the interface language (spec §2 #7, G8). Passing `ctx.locale` would hand A F&N's Persian draft palettes and fire the `fa` faux-feeling lexicon on real Persian words. | `feelingsNeeds/session.ts`, `packFor` | B2 (palettes), B3 (catch) |
| D-17 | **The source of a hint word.** After *Use one*, the chosen hint replaces the feeling; AC-22 allows only `palette` or `own` as its source. | spec §4.5, AC-22 | B5 (PD-9) |
| D-18 | **"Shown once" across a reload.** After Finish the entry is closed, so a reload finds no open entry; G15 wants the done line, not the home or the question again. | spec AC-34, journeys G15 | B5 (history state, PD-14) |
| D-19 | **Rows created from request data.** Moments and readings are bounded at 3 per entry by a unique `(entryId, position)` key; text fields by §6.4; `ReflectState` at one per user. **Entries are bounded only by a person's pace:** each start creates at most one row, and only a signed-in session can call (tokens refused), as everywhere else in Tracker. Stated, not limited. | spec §2 #13 | B2 |
| D-20 | **The cooldown outlives a deleted entry.** `ReflectState.lastCatchAt` keeps the date of the last surfaced catch after the entry is deleted: a date, with no text or word. | spec AC-7, AC-29 | B3 (stated at the site) |

## 1. The shape at the end

- **Data:** four models in their own block of `schema.prisma`, placed before Noticing's banner: `ReflectEntry` (scene, story, close, the step it's at, the pre-check and after-entry answers, the outcome, the catch surfaces), `ReflectMoment` and `ReflectReading` (at most three each, by a unique position), and `ReflectState` (the pinned content versions and the catch cooldown). All cascade from `User`.
- **Content:** `api/src/content/reflect/`, versioned like F&N's: the step prompts, the interpretation lexicon in four families (`en` reviewed, `fa` draft), the interpretation offer's copy, and the dials (bounds, caps, cooldowns, the practice locale).
- **Services:** `api/src/services/reflect/` (`state.ts`, `entry.ts`, `catches.ts`, `palettes.ts`), with the API's rules: one open entry per person, steps committed as they go, the bounds, the two catches.
- **API:** 4 queries and 9 mutations (§6.1), each behind `requireAuth`, a session-only check and ownership. No type returns a hidden field (§6.5).
- **Client:** `client/app/components/reflect/`: the home, one entry page (a step bar, a footer and five step bodies, plus the calm close, the after-entry question and the done line), Past entries and one past entry; the Tools card last.
- **Tests:** two fences suites (schema and SDL as text, imports as text), a content suite, matcher unit tests, API integration tests per stage, thin component tests, and one e2e spec (`client/e2e/reflect.spec.ts`) that walks J1 and J3, run in the lane-safe e2e setup B0 builds.
- **Not built:** encryption at rest (PD-2), any eval instrument beyond the stored fields (P0-5), an account-deletion flow (D-1).

## 2. Planning decisions *(each the founder's to veto)*

**PD-1 · The spec's open items, settled.** Every journey gap and wireframe call is accepted, refused or carried below; none changes the spec's scope except G2's reach (narrowed, PD-6) and D-4 (carried).

| Item | Outcome | Stage |
|---|---|---|
| G1 autosave while typing [F] | accepted: 800 ms after typing pauses, and flushed on Next, Back and Stop here | B4 (hook), B5 (its steps) |
| G2 Back [F] | accepted **narrowed**: Back on Feelings and needs, Reality check and Looking at it now; none on the story or the pre-check (D-3, PD-6) | B4, B5 |
| G3 failed save [F] | accepted | B4 |
| G4 the *Start a new one* line [F] | accepted; the home is told whether the open entry has a story | B2, B4 |
| G5 no Delete for nothing | accepted: "nothing" means no written text in any field | B4 |
| G6 interface or content | accepted, with the full split in §6.5 (PD-7); the `fa` calm close is approved with the `en` (R6) | B1, B4 |
| G7 `dir="auto"` | accepted on every Reflect text field and every shown-back text | B4, B5, B6 |
| G8 the practice locale's pack for the faux-feeling catch | accepted (D-16) | B3 |
| G9 delete from the calm close lands on the home | accepted | B4 |
| G10 no stopped mark | accepted; `outcome` is not in the API, so nothing can mark it | B2, B6 |
| G11 once per entry from the server's record | accepted | B3 |
| G12 back to the step after sign-in | accepted **as-built** (D-10); verified | B4 |
| G13 the client side of the bounds | accepted; bounds served by the API, not duplicated | B2, B4, B5 |
| G14 one not-found screen | accepted | B6 |
| G15 the entry URL with nothing open; a reload after Finish | accepted (PD-14) | B4, B5 |
| G16 empty Past entries | accepted | B6 |
| G17 the banner on the entry screen | accepted: once per sitting, at the top of the first step shown | B4 |
| W1–W19 | accepted, except **W2's Back on plate 4** (refused, D-3) | as plated: W5, W6, W13, W16–W19 in B4; W1–W4 B4; W7–W12 B5; W14, W15 B6 |
| D-4 kept but unreachable | **carried to `revise`**, needed by B6 (PD-12) | — |

**PD-2 · No encryption at rest in this version (R7).** App-level field encryption would put the key in `api/.env` on the same box as `prod.db` and its pre-migration backups, so it protects only a backup copied off the box; it adds a key that, lost, loses every entry, and a deploy step (a new `.env` line before the push). The spec's other mitigations stand: no share path, tokens refused, no index on text, no body logged, hard delete. Revisit if backups leave the box (P0-3).

**PD-3 · An e2e prep stage, B0, rather than a waiver (R9).** `config.md` §4 asks the first module's plan to schedule it or have it waived. It is small, it lets B4 and B6 run e2e in two lanes, and it is what lets the one Reflect spec run on the Linux machine. Veto it and B0 goes; e2e then runs only in slot A, through `config.md` §2's scratch config.

**PD-4 · The whole schema in B1.** The spec fixes every table, so B1 alone touches `schema.prisma`, and every later pair of lanes is schema-free.

**PD-5 · The entry point lands last (B7).** Each `verify` merge deploys. Routes from B4 on are live but unlinked; the Tools card, the approved calm-close copy and the full e2e walk arrive together in B7, which waits on the founder's copy approval (R6). Someone typing `/tools/reflect` on production before B7 meets the draft copy: accepted.

**PD-6 · The pre-check is never returned to.** Its answers are written once, by `saveReflectEntry`, when the person leaves the pre-check (Next, Keep going, Not now or Stop here). A reload on the pre-check shows it blank, which loses nothing committed. The story has no Back.

**PD-7 · Practice locale fixed at `en`.** `DIALS.practiceLocale = "en"`: Reflect's own pack and F&N's palettes and lexicon are served in `en` whatever `Accept-Language` says. The `fa` surface ships complete and `draft`, and isn't served in this version. The banner shows when the interface language isn't the practice locale, or the served pack is `draft`.

**PD-8 · Reflect's palette selection.** A pure function in `services/reflect/palettes.ts`: the first two `early`-tier feelings and the first four `broaden`-tier feelings of the pinned F&N pack, and its first five needs. Static, not rotated, so nothing is counted to choose them, and it leans to the broaden tier because a Reflect scene is a hard one.

**PD-9 · A hint word's source.** After *Use one*, the hint is saved with source `palette` when it equals a label in the served feelings palette, otherwise `own`.

**PD-10 · Cooldowns.** `DIALS.catches`: the interpretation offer at most once per entry and then off for 2 days; the faux-feeling offer once per entry and off for 7 days. Both are dates in `ReflectState.lastCatchAt`, written when surfaced. The numbers are the founder's to change.

**PD-11 · Past entries in pages of 50.** `reflectPastEntries(before: ID)` returns 50 rows and `hasOlder: Boolean`; a plain *Show older* link under the last row loads the next page. No number, no total. A control the wireframes don't draw: veto it, and the list returns every entry, unpaged.

**PD-12 · Until `revise` rules on D-4, B6 builds AC-37 as written.** The proposal for `revise`: list every closed entry that holds any written text; the row shows the scene, or the story's first words, or the first moment's *when* line. If `revise` accepts it before B6's card is drafted, B6 builds that instead.
*Correction, 2026-10-22: `revise` accepted it, with a fallback for an entry holding only readings or a close (spec 0.2 §2.2 #19, AC-37; `changes/01-req-past-entries-and-journey-gaps.md`). B6 builds that, with §6.1's correction.*

**PD-13 · The interpretation offer returns the word and its sentence only.** The word is shown as the lexicon writes it; the sentence is the person's own, from the original story text (D-13). Nothing else of the lexicon leaves the server.

**PD-14 · The done line survives a reload by history state.** Finish replaces the entry route's history state with `{ finished: true }`. With no open entry, the entry route shows the done line when that state is set, and otherwise goes to the Reflect home. The after-entry question is shown only in the page that tapped Finish.

**PD-15 · Refusal messages are stable strings,** listed in §6.2 and matched by the tests. The client matches none of them; it stops at the bounds first and shows its own interface strings.

## 3. Stage order

| Stage | Name | Size | After | Parallel with | Milestone |
|---|---|---|---|---|---|
| B0 | e2e lanes prep | S | — | B1 | — |
| B1 | Schema, content pack and fences | M | — | B0 | — |
| B2 | The entry API | L | B1 | — | — |
| B3 | The two catches | M | B2 | B4 | MS1 |
| B4 | Home, entry shell, pre-check, story, calm close | L | B0, B2 | B3 | — |
| B5 | Feelings and needs, reality check, close, after the entry | L | B3, B4 | B6 | — |
| B6 | Past entries | M | B4 | B5 | — |
| B7 | Open the door | S | B5, B6, P0-1 | — | MS2 |

- **Lane slots** (`config.md` §4): B0 in A (it runs e2e), B1 in B. B3 in B, B4 in A. B5 in A, B6 in B (with e2e only if B0 has landed; otherwise B6's e2e runs at its `verify`, in the main checkout).
- **Never two lanes touching `schema.prisma`:** only B1 does.
- **Shared files between paired lanes:** B3 and B4 share nothing. B5 and B6 both add to `client/app/api/queries.ts` and both `common.json` files: each adds its keys under its own namespace (`reflect.entry.*`, `reflect.past.*`) at the end of the `reflect` block, and the second `verify` resolves the merge.
- **MS1** (after B3): the full API suite, both fences suites, the content suite; the API complete.
- **MS2** (after B7): the full API, client and e2e suites; the by-hand list (§8); the live site after the deploy.
- **Cost:** about 25 lane hours at the bands' midpoints and 8 Opus `verify` reviews; IMNSTR's lanes ran far under time and over lines (`skills/build-plan/reference.md`), so read the hours as a ceiling.

**Sizes** *(lane hours, and lines of new app code, with tests and moved code counted apart)*: **S** 1–2 h, up to ~400 lines · **M** 2–4 h, ~400–1,000 lines · **L** 4–6 h, ~1,000–2,000 lines. No Tracker stage record exists to recalibrate from; B0 and B1's records are the first.

## 4. P0 — pre-flight

**The foundation batch:** not asked; `lifecycle/projects/tracker/` exists (config 0.3).

**P0-1 · The calm-close copy, `en` and `fa`, approved by the founder (R6).** Open, **needed by B7**; B4 builds with draft copy under the same keys. Includes whether it names "a trusted person or a professional", and no phone numbers.

**P0-2 · The `fa` interface strings read by a Persian reader** (`review-checklist.md` §7). Open, needed by MS2; doesn't block a stage.

**P0-3 · Where `prod.db`'s backups go: on the box only, or off it.** Open, needed by nothing in this plan; it decides whether PD-2 is revisited.

**P0-4 · CD1's one-time setup is done and `DEPLOY_ENABLED` is `true`.** Open, as-built unknown (`config.md` status line). Needed by B1's `verify`: if deploys are live, B1's merge runs its migration on the production box.

**P0-5 · No eval instrument is placed.** The eval plan is waived [F]. The stored fields M1–M5 need are built (AC-1); nothing reads them, and no device, domain or real-data precondition enters the order. Locking the outcome above RFL-1 stays the founder's (§10).

**Unknowns per stage:**
- B0: whether `npx tsx` runs `api/src/index.ts` in a worktree as `nodemon` does (`api/package.json`, `dev`); the card checks before writing the web-server command.
- B4: `ConfirmDialog`'s props, and whether `InternalPageLayout` takes a slot for the step bar (read at the card).

## 5. The stages

### B0 · e2e lanes prep

**Goal.** One Playwright run per lane, on its own ports and its own scratch database, in Edge on Windows and Chrome on Linux, never touching a dev database or a server another checkout started.

**Schema** none.

**Logic** `client/playwright.config.ts`:
- `channel: process.env.PW_CHANNEL ?? "msedge"`, so the Windows machine is unchanged.
- Ports from `E2E_API_PORT` (default `4010`) and `E2E_WEB_PORT` (default `5183`): defaults distinct from the dev servers' `4000` and `5173`, so a running dev server is never reused by accident.
- `webServer` becomes two entries. The API: `prisma db push --skip-generate --force-reset` against `DATABASE_URL=file:./prisma/e2e.db`, then the API on `E2E_API_PORT` with `CORS_ORIGINS=http://localhost:<web port>` and `JWT_SECRET=e2e-secret`. The web: `vite --port <web port> --strictPort` with `VITE_API_URL=http://localhost:<api port>/graphql`.
- `reuseExistingServer: process.env.E2E_REUSE === "1"`.

`client/e2e/globalSetup.ts` reads the API URL from the same variables. `.gitignore` gains `api/prisma/e2e.db*`. `client/e2e/README.md` (new, short) gives the two slots' values: A `4010`/`5183`, B `4020`/`5193`.

**API or routes** none.

**Screens.** none.

**Tests** the existing `auth.spec.ts` and `goals.spec.ts` pass in the lane with `PW_CHANNEL=chrome`, and again with slot B's ports while slot A's servers run (two terminals, or one run after the other with A's servers left up). Recorded in the report with the exact commands.

**Image and deploy.** none: e2e isn't in CI or the image. `config.md` §2 and §4 go stale (the lane table, "e2e is not lane-safe", the scratch-config recipe); flagged for `verify`.

**Constraints from earlier stages.** none.

**Acceptance.** No spec criterion. Done when the two specs above pass in two slots at once on the Linux machine, and the Windows defaults are untouched.

**Size: S.**

**Traps.**
- **`--force-reset` is destructive.** The command is built only from a path ending `prisma/e2e.db`; the config throws before starting anything if `DATABASE_URL` would name `dev.db`, `test.db` or `prod.db`. Never pass the variable through from the shell.
- `vite`'s `--strictPort` matters: without it a taken port silently moves, and the tests drive another lane's app.
- `CORS_ORIGINS` must name the e2e web origin or every request fails as a network error that looks like a broken app.

**Not here:** Reflect's own spec (B4, B6, B7); CI e2e.

---

### B1 · Schema, content pack and fences

**Goal.** Reflect's tables migrated, its content pack authored in `en` (reviewed) and `fa` (draft), and the fences that hold the schema and the pack.

**Schema** migration `add_reflect`. A block headed `// ─── Reflect · the observer recount ───`, placed **between F&N's `LoopState` and Noticing's banner** (D-2), each model with a doc comment in the F&N and Noticing style:

```prisma
model ReflectEntry {
  id                       String    @id @default(uuid())
  userId                   String
  step                     String    @default("precheck") // precheck | story | feelings | reality | close
  scene                    String?
  story                    String?
  close                    String?
  precheckWhen             String?   // days | weeks | longer — never returned by the API
  precheckBefore           String?   // yes | no — never returned
  afterAnswer              String?   // differently | same | more_caught_up — set once, never returned
  outcome                  String?   // finished | stopped; null while open — never returned
  closedAt                 DateTime?
  fauxSurfacedAt           DateTime? // never returned
  interpretationSurfacedAt DateTime? // never returned
  createdAt                DateTime  @default(now())
  updatedAt                DateTime  @updatedAt
  user                     User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  moments                  ReflectMoment[]
  readings                 ReflectReading[]
  @@index([userId, closedAt])
}
model ReflectMoment  { id, entryId, position Int, whenText String?, feeling String?, feelingSource String?, need String?, needSource String?, met String? /* met | unmet | not_sure */, entry → Cascade, @@unique([entryId, position]) }
model ReflectReading { id, entryId, position Int, reading String?, camera String?, entry → Cascade, @@unique([entryId, position]) }
model ReflectState   { id, userId @unique, contentVersion String, fnContentVersion String, lastCatchAt String? /* JSON: { faux?, interpretation? } ISO dates */, createdAt, updatedAt, user → Cascade }
```

`User` gains `reflectEntries ReflectEntry[]` and `reflectState ReflectState?`. `lastCatchAt` carries convention 13's comment.

**Logic** `api/src/content/reflect/`: `index.ts` (`getReflectPack(version, locale)`, cached, `CURRENT_VERSION = "reflect/v1"`), `types.ts`, `dials.ts` (§6.4's bounds, `momentsCap: 3`, `readingsCap: 3`, `storySoftLine: 1500`, `practiceLocale: "en"`, PD-10's cooldowns), `v1/spec.ts` (the lexicon's four family ids: `absolute`, `mind_reading`, `label`, `verdict`), `v1/surface.en.ts` (`reviewStatus: "reviewed"`) and `v1/surface.fa.ts` (`"draft"`). The surface holds what §6.5 calls practice content: the story, feelings, reality-check and close prompts, the pair labels, the interpretation offer's line template and its two buttons, and the lexicon (at least 8 triggers per family per locale, `fa` with ZWNJ and Arabic-keyboard variants).

**API or routes** none.

**Screens.** none.

**Tests**
- `reflectContent.unit.test.ts`: every `en` key has a `fa` key (AC-42); no prompt contains "why" or "deepest", or `چرا` or `عمیق‌ترین` (AC-19); every family has triggers in both locales; no trigger nests across two families.
- `reflectFences.unit.test.ts`, schema half: the Reflect block sits before `Impact · Noticing (Act 1)`; no `@@index` or `@@unique` on `scene`, `story`, `close`, `whenText`, `feeling`, `need`, `reading` or `camera`; no field named `count`, `streak`, `total` or `tally`; no relation to `Journal`, `Goal`, `Project` or `JournalAccess`. Imports half: no file under `services/reflect` or `content/reflect` imports `@anthropic-ai/sdk` or reads `ANTHROPIC` (AC-45); no file under `client/app` imports from `api/src/content/reflect` (AC-28's browser half). Each check is seen to fail on a planted violation.

**Image and deploy.** none new. The migration runs on the box at B1's deploy, after the backup (P0-4).

**Constraints from earlier stages.** `noticingFences` still passes, unchanged.

**Acceptance.** AC-19, AC-42, AC-45.

**Size: M.**

**Traps.**
- **`prisma migrate dev` only against the worktree's own `dev.db`;** never `migrate reset`, never with `DATABASE_URL` pointing outside the worktree. Confirm the migration SQL creates and alters only Reflect's tables and `User`'s relation (no column change on `User`).
- The `fa` lexicon is a draft that never fires in this version (PD-7); author it complete anyway, to the conventions' 7a–7c.

**Not here:** the SDL and its fences (B2); the matcher (B3).

---

### B2 · The entry API

**Goal.** Every Reflect query and mutation except the catches: one open entry per person, every step committed as it goes, bounds refused, closed entries listed, read and deleted, tokens refused.

**Schema** none.

**Logic** `api/src/services/reflect/`:
- `state.ts`: `ensureReflectState` pins `contentVersion` and F&N's `CURRENT_VERSION` on first start.
- `palettes.ts`: PD-8's selection, from `getFeelingsNeedsPack(state.fnContentVersion, DIALS.practiceLocale)` (D-16).
- `entry.ts`:
  - `startEntry(userId, replacing?)` under `withUserLock("rfl-entry:" + userId)`. With an open entry: if `replacing` equals its id, close it (`outcome: "stopped"`, `closedAt`, its step kept) and create a new one; otherwise return it. The open entry is found at any age (D-8).
  - `save`, `saveMoment`, `saveReading`: omitted arguments untouched; empty strings stored as null.
  - `move`: rules in §6.1. `stop`, `finish` (only from `close`), `answer` (once, finished entries only), `remove` (any owned entry, open or closed), `listPast` (PD-11), `getPast`.

Session-only: a `requireSession` wrapper inside `requireAuth` throws §6.2's `REFLECT_SESSION_ONLY` when `ctx.auth?.kind !== "session"` (D-12). Ownership: `ensureOwned` on the entry, which carries `userId`.

**API or routes** §6.1's queries and mutations, except the catch fields on two results (B3 fills them, B2 returns `null`). Types in a `# ── Reflect` block placed **before `# ── Learn · Feelings & Needs`** in `typeDefs.ts` (D-2). Every field and argument name contains `Reflect` or `reflect`, so the fences can find them. Refusals in §6.2. `typeResolvers.ts` orders moments and readings by `position`.

**Screens.** none.

**Tests** `reflect.integration.test.ts`, on a fixed clock:
- Two concurrent starts give one entry (AC-9); `replacing` closes only its own id (D-14).
- Every bound one over is refused, and a 4th moment and reading (AC-6).
- Another user's id gives `Not found` for a read, a write and a delete (AC-2).
- A read-scope and a write-scope token are refused on `reflectHome` and `saveReflectEntry` (AC-4).
- The rows land in Reflect's tables and no others (AC-1).
- The answer is refused a second time and before Finish (AC-36).
- The list holds closed entries with story text only, newest first, with no field beyond `id`, `createdAt`, `scene`, `storyStart` (AC-46, AC-14's list half).
- Deleting an entry and deleting the `User` cascade (AC-7, D-1).

`reflectFences.unit.test.ts`, SDL half: no Reflect type has `precheck*`, `afterAnswer`, `outcome` or `*SurfacedAt` (AC-3); no Reflect argument named `search`, `query`, `filter` or `name` (AC-5); no Reflect type outside its block. A unit test calls every `Query`/`Mutation` resolver whose name contains `reflect` with a token context and expects the refusal. An import check: `services/reflect` names no `prisma.action`, `interval`, `goal`, `journal*`, `loop*` or `frameCompletion` (AC-47, AC-26's table half).

**Image and deploy.** none.

**Constraints from earlier stages.** B1's unique `(entryId, position)`: `saveMoment` refuses `position > existing count` and `position ≥ 3` before the write, and the key backs that under a race.

**Acceptance.** AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-9, AC-36, AC-46, AC-47.

**Size: L.**

**Traps.**
- Never `console.log` arguments or rows; an error message never echoes a field's text.
- `requireSession` throws its own message, never `Unauthorized` (convention 11).
- Don't copy `startOfToday` from F&N or Noticing (D-8).

**Not here:** the catch offers (B3); any screen.

---

### B3 · The two catches

**Goal.** The faux-feeling offer on a committed feeling, and the interpretation offer when the reality check opens: each at most once per entry, off its cooldown, recorded when surfaced, and never more of the lexicon than the word and its sentence.

**Schema** none.

**Logic** `api/src/services/reflect/catches.ts`:
- **Interpretation.** A matcher **copied** from `noticing/catches.ts` (`normalizeForMatch`, `ARABIC_FOLDS`, `LETTERISH` lookarounds, longest match wins), with a comment saying why it is a copy (§0.3). `detectInterpretation(pack, story)` splits the **original** story on `.`, `!`, `?`, `؟` and line breaks, normalizes each sentence, finds the longest trigger across the whole story, and returns `{ word, sentence }` from the first sentence holding it (D-13). Run by `move` when `to` is `reality`, the move is forward, `interpretationSurfacedAt` is null, the interpretation cooldown is off, and `pack` is the practice locale's (G8, PD-7). On a hit, one transaction sets `interpretationSurfacedAt` and `lastCatchAt.interpretation`; the result carries the offer. Never on a save (AC-21), never on any field but `story` (AC-32).
- **Faux feeling.** `saveMoment`, when its `feeling` argument is present and differs from the stored one, calls `detectFauxFeeling(fnPack, feeling)` with the pinned F&N pack in the practice locale. On a hit with `fauxSurfacedAt` null and the cooldown off, it calls `composeCatch`, sets `fauxSurfacedAt` and `lastCatchAt.faux` in one transaction, and returns the offer with the moment's `position`. Never `maybeCatch` or `catchAllowed` (D-7).
- **Neither** writes anything on *Use this*, *Not this one*, *Use one* or *Keep mine*: those are client-side only, and a hint used is an ordinary `saveMoment` (AC-25).

**API or routes** fills `ReflectMoveResult.interpretationOffer` and `ReflectMomentResult.fauxOffer` (§6.1). A reload, Back or Continue never returns an offer again: offers live only in the result of the move or save that surfaced them (G11).

**Screens.** none.

**Tests**
- `reflectCatches.unit.test.ts` (AC-31): "never" doesn't fire in "nevertheless"; a nested trigger picks the longer one; an `fa` trigger matches with and without ZWNJ and with Arabic-keyboard letters (against the draft `fa` lexicon); the sentence returned is the original text, on a story holding combining marks before the trigger.
- `reflectCatches.integration.test.ts`, fixed clock: one offer per entry across two forward moves and a Back (AC-29); the cooldown is written at surface and holds for a second entry within the window; a trigger in the scene, a moment or a reading surfaces nothing (AC-32); no save surfaces the interpretation offer (AC-21); a Persian story surfaces nothing; a faux feeling surfaces once and a second faux feeling in the same entry nothing; *Use one*'s follow-up save writes only the moment (AC-25's server half).
- The fences' import half: `services/reflect` imports only `detectFauxFeeling`, `composeCatch` and types from `feelingsNeeds/distinctions`, and nothing from `services/noticing` (AC-26).

**Image and deploy.** none.

**Constraints from earlier stages.** B2's `move` and `saveMoment` signatures; `fauxSurfacedAt` and `interpretationSurfacedAt` from B1.

**Acceptance.** AC-21, AC-26, AC-28, AC-29, AC-31, AC-32.

**Size: M.**

**Traps.**
- A cooldown computed with `Date.now()` is tested with `vi.setSystemTime`, never real time.
- The offer's `word` is the lexicon's form, and the `sentence` the person's: don't return the normalized sentence.
- `composeCatch` returns F&N's `en` copy; under PD-7 that is what A reads too. Expected, not a bug.

**Not here:** the offers on screen (B5).

---

### B4 · Home, entry shell, pre-check, story, calm close

**Goal.** A person can open Reflect at `/tools/reflect`, start or continue an entry, answer the pre-check, write the scene and story with autosave, stop at any of those steps, and meet the calm close, in both languages, with the frame every later step plugs into.

**Schema** none.

**Logic** client only.
- `client/app/components/reflect/useReflectAutosave.ts`: per field, 800 ms after typing pauses, and `flush()` before Next, Back and Stop here. On failure the text stays, the not-saved line and **Try again** show, and Next, Back and Stop here wait. Never browser storage (G1, G3, W6).
- Inputs stop at the bounds `reflectContent.limits` serves, with the one bound sentence (G13). The story shows the soft-line sentence past `storySoftLine` (AC-20).
- `dir="auto"` on every field (G7). After a delete, no Reflect read goes through Apollo, so there is nothing to evict (D-9).

**API or routes** client routes `/tools/reflect` and `/tools/reflect/entry` in `protectedRoutes.tsx`, beside F&N's and Noticing's. Documents in `queries.ts`: `reflectHome`, `reflectEntry`, `reflectContent`, `startReflectEntry`, `saveReflectEntry`, `moveReflectEntry`, `stopReflectEntry`, `deleteReflectEntry`.

**Screens.**
- **Plate 2, the home** (`ReflectHomePage`):
  - a placeholder while loading (W5);
  - *Start an entry*, or *Continue the entry you started on <date>* (`useAppDate`) with *Start a new one* under it and G4's line, chosen by `openEntry.hasStory` (W16);
  - *Past entries* as a text link when `hasPast` (W18);
  - the banner, with no dismiss (W19).
- **Plates 3, 4 and 9, the entry page** (`ReflectEntryPage`):
  - the step bar, named, with **Stop here** at its end (W1, W3), and the footer, Back at the start and Next at the end (W2), are the shell B5 reuses;
  - G17's banner at the top of the first step shown in a sitting;
  - the pre-check: chips that clear on a second tap; the advisory as a trigger chip is tapped, swapping Next for *Not now* and *Keep going* (W4); no Back;
  - the story: the scene line and the story field under the pack's prompts; no Back (PD-6);
  - **the calm close** (plate 9): the draft copy, *Back to Reflect* as the main button and *Delete what I wrote* as a link (W13), hidden with the "kept" line when nothing was written (G5); `ConfirmDialog` with Cancel at the start (W17); delete lands on the home (G9).
- **B4 owns** the bar, the footer, Stop here and the calm close on every step. B5 owns the step bodies of Feelings and needs, the Reality check and Looking at it now.
- An entry URL with no open entry goes to the home (G15's first half). After an expiry, `/login` returns here (D-10).

**Tests** component tests (mocked `useApi`): the home's three states; the advisory swap; G5's hidden delete. `client/e2e/reflect.spec.ts`: start → pre-check with a trigger → Not now → calm close → home; a second start → story → Stop here → calm close → delete → home; a reload on the story keeps the text.

**Image and deploy.** none. The routes go live, unlinked (PD-5).

**Constraints from earlier stages.** `replacing` on *Start a new one* (D-14); the pre-check's answers are sent once, by `saveReflectEntry`, before the move or the stop (PD-6).

**Acceptance.** AC-10, AC-12, AC-13, AC-14, AC-18, AC-20.

**Size: L.**

**Traps.**
- `flush()` must resolve before `moveReflectEntry` or `stopReflectEntry` is sent (D-15).
- The calm-close copy lives under its final keys, marked draft in a comment; B7 replaces the values, not the keys.
- Persian: mirror with logical properties; Stop here at the left end of the bar.

**Not here:** steps 2–4, the after-entry question, the done line (B5); Past entries (B6); the Tools card (B7).

---

### B5 · Feelings and needs, reality check, close, after the entry

**Goal.** The rest of the entry: moments with F&N's palettes and the faux-feeling offer, the reality check with the story shown back and the interpretation offer, the close and Finish, the after-entry question and the done line.

**Schema** none.

**Logic** client only. Back on these three steps goes to any earlier step from the story on (PD-6), after `flush()`. Folded moments are rebuilt from the entry on reload (AC-11).

**API or routes** `queries.ts` adds `saveReflectMoment`, `saveReflectReading`, `finishReflectEntry`, `answerReflectEntry`.

**Screens.**
- **Plate 5, Feelings and needs.**
  - One moment open as a card; earlier ones fold to *when · feeling · need* and reopen on tap (W7).
  - Six feelings and five needs from `reflectContent`, each with *other…* opening a one-line field; *Met · Unmet · Not sure*, clearable.
  - *Add another moment* is gone at three, with no message (AC-24).
  - The faux offer inside its moment, under the feeling (W8). *Use one* then a hint saves that hint with PD-9's source; *Keep mine* hides the offer, with nothing sent.
  - Next with no moment skips the step.
- **Plate 6, the Reality check.**
  - The pairs wait, dimmed, until the move returns.
  - The story is shown back read-only, folded to three lines on a phone with *Show all*; a tap anywhere toggles it, and nothing in it is a control (W9).
  - The offer sits above the pairs. *Use this* fills the first empty *reading* with the returned sentence and moves focus to that pair's camera half (W10); *Not this one* hides the offer, with nothing sent.
  - Pairs stack on a phone (W11), with *Add another* gone at three.
- **Plate 7, Looking at it now.** One field; *Finish* is never disabled.
- **Plate 8, after the entry.** Three equal full-width buttons in the spec's order, *Skip* as a link, no Stop here or Back (W12). Then the done line and *Back to Reflect*. PD-14's history state carries a reload to the done line.

**Tests** component tests: the fold and the cap; the offer's *Use this* fill and focus; the after-entry buttons send once. `reflect.spec.ts` gains J1 end to end, with both offers and a Back from the reality check, finishing on the done line; a reload on the reality check returns there with the pair half-written and no offer.

**Image and deploy.** none.

**Constraints from earlier stages.** B2's `position` rules (send the next free position only); B3's offers arrive only in a result, so they are held in page state and gone on reload (G11); B4's shell and autosave.

**Acceptance.** AC-11, AC-15, AC-17, AC-22, AC-23, AC-24, AC-25, AC-27, AC-30, AC-33, AC-34, AC-35.

**Size: L.**

**Traps.**
- The trigger word is never marked in the shown-back story (W9).
- `answerReflectEntry` is called at most once by the page; a double tap must not produce a second call (the server would refuse it, and the refusal would show as an error).
- Palette labels are English inside a Persian page: give them `dir="ltr"`, and the person's own words `dir="auto"`.

**Not here:** Past entries (B6); the approved copy and the card (B7).

---

### B6 · Past entries

**Goal.** The list of past entries and one entry read back, with delete, the not-found screen and the empty list.

**Schema** none.

**Logic** client only. PD-12 decides the list rule: AC-37 as written unless `revise` has ruled on D-4 before this card.

**API or routes** client routes `/tools/reflect/past` and `/tools/reflect/past/:id`; `queries.ts` adds `reflectPastEntries`, `reflectPastEntry`. `deleteReflectEntry` already exists, from B4.

**Screens.**
- **Plate 10, the list.**
  - Row placeholders while loading.
  - Each row: the date (`useAppDate`, Jalali in Persian, Western digits) above the scene, or the story's first words, cut to one line (W14). The whole row is a link and the only control (AC-38).
  - *Show older* under the last row when `hasOlder` (PD-11).
  - Empty: one plain line and *Back to Reflect*, no zero (G16).
- **Plate 11, one entry.**
  - A link back to Past entries at the top, and the date.
  - Short interface labels (*Scene*, *What happened*, *Moments*, *Readings*, *Looking at it now*) over each part that holds text; parts never written are left out, with no stopped mark (G10, W15).
  - *Delete* at the end, through `ConfirmDialog`, then back to the list (W17).
  - Another person's id and a deleted id show the same not-found line and *Back to Reflect* (G14).
- **B6 owns** everything on plates 10 and 11. The home's *Past entries* link is B4's.

**Tests** component tests: a row is one link; the empty line; the not-found screen. `reflect.spec.ts`: open a past entry, delete it, land on the list; delete the last, see the empty line; the home then has no Past entries link.

**Image and deploy.** none.

**Constraints from earlier stages.** B2's list returns `id`, `createdAt`, `scene`, `storyStart` only (AC-46): the view's full entry comes from `reflectPastEntry(id)`, one entry at a time.

**Acceptance.** AC-37, AC-38, AC-39, AC-40.

**Size: M.**

**Traps.**
- Evict the deleted entry and the list's cached page from Apollo, or Back shows it again (D-9).
- `storyStart` is cut by the server; don't fetch the full story for the list.

**Not here:** editing a closed entry (spec §7).

---

### B7 · Open the door

**Goal.** Reflect reachable from the Tools home, with the founder's approved calm-close copy, the whole flow walked in both languages, and every policy guard checked across every screen.

**Schema** none.

**Logic** the approved `en` and `fa` calm-close copy replaces the draft values under B4's keys (P0-1).

**API or routes** none.

**Screens.** **Plate 1:** a Reflect card on `ToolsHomePage.tsx` after Noticing's, the same shape as the cards beside it: a title, one line, *Open Reflect* to `/tools/reflect`. Nothing about entries.

**Tests**
- `reflect.spec.ts` gains the Persian walk (J2): the banner on the home and the entry screen; a Persian story with no offer; a past entry with its Jalali date.
- At 360 px and 180 px, the reflow check (`review-checklist.md` §4) on the home, each step, the calm close and both past-entry screens.
- A scan of each screen's text for digits outside the date (AC-44).
- Both `i18n:check-*` scripts (AC-41).

**Image and deploy.** none. The deploy after this `verify` is the launch: the founder signs in on the live site (§8).

**Constraints from earlier stages.** B4's copy keys; every earlier stage's e2e passing on the same run.

**Acceptance.** AC-8, AC-16, AC-41, AC-43, AC-44.

**Size: S.**

**Traps.**
- **Don't start the card without P0-1.** The lane can't approve copy; if the founder hasn't, B7 waits.
- The card mirrors in Persian with the others; no new layout.

**Not here:** anything the earlier stages own.

---

## 6. Cross-cutting catalogues

### 6.1 · Routes

**Client** (all behind the protected layout):

| Route | Screen | Stage |
|---|---|---|
| `/tools` (card) | Tools home, Reflect card | B7 |
| `/tools/reflect` | Reflect home | B4 |
| `/tools/reflect/entry` | the open entry, calm close, after-entry, done | B4, B5 |
| `/tools/reflect/past` | Past entries | B6 |
| `/tools/reflect/past/:id` | one past entry, or not found | B6 |

**GraphQL.** Every operation: `requireAuth` → `requireSession` → ownership.

| Operation | Returns | Rules | Stage |
|---|---|---|---|
| `reflectHome` | `ReflectHome { openEntry: { id, createdAt, hasStory } \| null, hasPast: Boolean!, practiceLocale, reviewStatus }` | `hasPast` true when a listable entry exists; no count | B2 |
| `reflectEntry` | `ReflectEntry` or null | the open entry, any age | B2 |
| `reflectContent` | `ReflectContent { locale, reviewStatus, prompts, feelings[6], needs[5], otherLabel, limits }` | practice locale only (PD-7); never the lexicon | B2 |
| `reflectPastEntries(before: ID)` | `{ rows: [{ id, createdAt, scene, storyStart }], hasOlder }` | closed, with story text, newest `createdAt` first, 50 a page | B2 |
| `reflectPastEntry(id: ID!)` | `ReflectEntry` or `Not found` | closed and listable only | B2 |
| `startReflectEntry(replacing: ID)` | `ReflectEntry` | the open one, or new; `replacing` closes only that id | B2 |
| `saveReflectEntry(entryId, scene, story, close, precheckWhen, precheckBefore)` | `ReflectEntry` | open only; pre-check arguments only while `step` is `precheck` | B2 |
| `saveReflectMoment(entryId, position, whenText, feeling, feelingSource, need, needSource, met)` | `ReflectMomentResult { moment, fauxOffer }` | position < 3 and ≤ the current count | B2, B3 |
| `saveReflectReading(entryId, position, reading, camera)` | `ReflectReading` | as moments | B2 |
| `moveReflectEntry(entryId, to: ReflectStep!)` | `ReflectMoveResult { entry, interpretationOffer }` | from `precheck` to `story` only; otherwise forward one step or back to any step from `story` on; never to `precheck` | B2, B3 |
| `stopReflectEntry(entryId)` | `ReflectEntry` | open only; `outcome: stopped`, step kept | B2 |
| `finishReflectEntry(entryId)` | `ReflectEntry` | open and at `close` only | B2 |
| `answerReflectEntry(entryId, answer: ReflectAfterAnswer!)` | `Boolean!` | finished and unanswered only | B2 |
| `deleteReflectEntry(entryId)` | `Boolean!` | any owned entry; hard delete | B2 |

`ReflectEntry { id, step, scene, story, close, createdAt, moments, readings }`. `ReflectStep`: `PRECHECK | STORY | FEELINGS | REALITY | CLOSE`. `ReflectAfterAnswer`: `DIFFERENTLY | SAME | MORE_CAUGHT_UP`.

**Correction, 2026-10-22** (`changes/01-req-past-entries-and-journey-gaps.md`, spec 0.2)**.** `reflectPastEntry` returns its own past-entry type, `ReflectEntry` less `step`, and the fences refuse `step` and `outcome` on it (spec AC-48). "Listable" is now *closed, with any written text*, for `reflectPastEntries`, `reflectPastEntry` and `hasPast`; a row's text is the entry's first writing in step order (scene, story, first moment's *when*, first reading, close), cut by the server, in place of `scene` and `storyStart` (spec AC-37, AC-46); `openEntry.hasStory` becomes whether the entry holds any written text (spec AC-53). B6 builds all of it, changing B2's `LISTABLE`, `hasStory`'s rule and `storyStart`; B4 builds the home against `hasStory` as B2 left it, and if B6 renames the field it changes B4's caller too.

### 6.2 · Refusal codes

| Message (exact) | When | Stage |
|---|---|---|
| `Unauthorized` | no session (as-built `requireAuth`) | as-built |
| `Reflect is only available in the app, not to API tokens.` | an API-token caller, any scope | B2 |
| `Not found` | missing, another person's, deleted, or (past view) open or unlisted | B2 |
| `This entry is closed.` | a save, move, stop or finish on a closed entry | B2 |
| `That is longer than a Reflect entry keeps.` | a field over its bound | B2 |
| `An entry holds at most three of those.` | a moment or reading at position ≥ 3, or past the next free position | B2 |
| `That step can't be reached from here.` | a move outside §6.1's rules; Finish off `close`; pre-check arguments off `precheck` | B2 |
| `This entry's question can't be answered now.` | an answer before Finish, after a stop, or a second time | B2 |

### 6.3 · Tables

| Model | Rows | Bounded by | Cascade | Stage |
|---|---|---|---|---|
| `ReflectEntry` | one per start | a person's pace (D-19); one open at a time | from `User` | B1 |
| `ReflectMoment` | ≤ 3 per entry | `@@unique([entryId, position])` and the cap | from entry | B1 |
| `ReflectReading` | ≤ 3 per entry | the same | from entry | B1 |
| `ReflectState` | 1 per user | `userId @unique` | from `User` | B1 |

### 6.4 · Limits

| Limit | Value | Where |
|---|---|---|
| Scene | 140 characters | `DIALS.limits`, server and client (B2, B4) |
| Story | 5,000; soft line 1,500 | the same |
| `whenText`, reading, camera | 280 | the same (B2, B5) |
| Own feeling or need | 60 | the same |
| Close | 1,000 | the same |
| Moments, readings | 3 each | `DIALS.momentsCap`, `readingsCap` |
| Past entries page | 50 | `listPast` (PD-11) |
| `storyStart` in the list | 80 characters | `listPast` |
| Interpretation cooldown | 2 days, and once per entry | `DIALS.catches` (PD-10) |
| Faux-feeling cooldown | 7 days, and once per entry | `DIALS.catches` |
| Autosave pause | 800 ms | `useReflectAutosave` |

### 6.5 · Never shown back, and interface against content

**Never in a GraphQL type** (fenced, B2): `precheckWhen`, `precheckBefore`, `afterAnswer`, `outcome`, `fauxSurfacedAt`, `interpretationSurfacedAt`, `lastCatchAt`, the lexicon.

**Interface strings, `common.json`, both locales (G6, PD-7):**
- the step names, Next, Back, Finish, **Stop here**;
- the pre-check questions and chips, and the advisory with its two buttons;
- the soft-line sentence, the bound sentence, the not-saved line and *Try again*;
- the calm close (P0-1);
- the three after-entry answers, *Skip*, the done line;
- the home: its lines, its buttons, G4's line;
- the banner;
- Past entries: its labels, the empty and not-found lines, *Show older*, the confirm dialogs;
- the Tools card.

**Practice content, Reflect's pack, served in `en`:** the story, feelings, reality-check and close prompts; the moment field labels; the pair labels; the interpretation offer's line and its two buttons; the lexicon. F&N's palettes and its faux-feeling copy come from F&N's pack, also in `en`.

### 6.6 · Runtime dependencies

None new. Reflect uses Prisma, Apollo and the F&N content pack, and on the client React Router, Apollo Client, Radix (through `ConfirmDialog`), i18next and `useAppDate`. B0 uses Playwright and `tsx` or `nodemon`, both already installed. No model call, no Anthropic key (AC-45).

### 6.7 · Every acceptance criterion, by stage

| Criterion | Stage |
|---|---|
| AC-1 | B2 |
| AC-2 | B2 |
| AC-3 | B2 |
| AC-4 | B2 |
| AC-5 | B2 |
| AC-6 | B2 |
| AC-7 | B2 |
| AC-8 | B7 |
| AC-9 | B2 |
| AC-10 | B4 |
| AC-11 | B5 |
| AC-12 | B4 |
| AC-13 | B4 |
| AC-14 | B4 |
| AC-15 | B5 |
| AC-16 | B7 |
| AC-17 | B5 |
| AC-18 | B4 |
| AC-19 | B1 |
| AC-20 | B4 |
| AC-21 | B3 |
| AC-22 | B5 |
| AC-23 | B5 |
| AC-24 | B5 |
| AC-25 | B5 |
| AC-26 | B3 |
| AC-27 | B5 |
| AC-28 | B3 |
| AC-29 | B3 |
| AC-30 | B5 |
| AC-31 | B3 |
| AC-32 | B3 |
| AC-33 | B5 |
| AC-34 | B5 |
| AC-35 | B5 |
| AC-36 | B2 |
| AC-37 | B6 |
| AC-38 | B6 |
| AC-39 | B6 |
| AC-40 | B6 |
| AC-41 | B7 |
| AC-42 | B1 |
| AC-43 | B7 |
| AC-44 | B7 |
| AC-45 | B1 |
| AC-46 | B2 |
| AC-47 | B2 |

*Where a criterion is built in one stage and finished in another, the later stage holds it, and the earlier one's tests are named in its section (AC-5's schema half in B1; AC-14's list half in B2; AC-25's and AC-30's server halves in B3; AC-16's screen in B4).*

## 7. What this plan changes in code that is already built

- **`api/prisma/schema.prisma`:** a new block before Noticing's banner; two relation fields on `User` (B1).
- **`api/src/graphql/schema/typeDefs.ts`:** a new block before F&N's banner, and Reflect fields in the shared `Query` and `Mutation` blocks (B2).
- **`api/src/graphql/resolvers/query.ts`, `mutations.ts`, `typeResolvers.ts`:** Reflect resolvers appended (B2, B3).
- **`api/src/graphql/auth.ts`:** `requireSession` added beside `requireAuth` (B2). No existing resolver changes.
- **`client/app/protectedRoutes.tsx`:** four routes (B4, B6). **`client/app/api/queries.ts`:** Reflect documents (B4–B6). **`client/app/locales/{en,fa}/common.json`:** a `reflect` block and `toolsHome.reflect*` keys (B4–B7). **`ToolsHomePage.tsx`:** one card (B7).
- **`client/playwright.config.ts`, `client/e2e/globalSetup.ts`, `.gitignore`:** B0. Every existing spec keeps passing.
- **Untouched:** F&N's and Noticing's services, content, resolvers, screens and fences; `noticingFences.unit.test.ts` (Reflect's placement keeps it honest; Reflect's own fences assert the placement).
- **Canon made stale**, flagged at each `verify` for `close-out`: `01-data-model.md` and a migration note in the decision log (B1, convention 12); `02-graphql-api.md` (B2, B3); `03-frontend.md` (B4–B7); the decision log for convention 13's two spendings (B1, B3); `config.md` §2, §4 (B0); known issues: D-1, the Persian silence of both catches (R5).

## 8. Verification, and its ceiling

**Done means:** every criterion in §6.7 demonstrated at its stage's `verify`; MS1 and MS2's full suites green, run one at a time in the main checkout; the by-hand list below done or recorded as owed; the live site signed into after B7's deploy.

**What the suites prove:**
- the API's rules (integration, on a fixed clock);
- the fences on the schema, SDL and imports (text tests, each seen to fail on a planted violation);
- the content invariants;
- the matcher's boundaries;
- the screens' states (thin component tests);
- one e2e spec walking J1, J2's Persian path, J3 and J4's deletes, at 360 and 180 px.

**By hand:**

| Check | Who | Needed by |
|---|---|---|
| The calm-close copy, `en` and `fa`, approved | founder | B7 (P0-1) |
| Each screen driven in a browser, both languages, light scheme, 360 px (`review-checklist.md` §4) | `verify` | each UI stage's `verify` (B4–B7) |
| The Persian strings read for register and glossary | founder or a Persian reader | MS2 (P0-2) |
| A first entry on the founder's phone, end to end, on the live site | founder | MS2 |
| Signing in on the live site after the deploy | founder | B1's and B7's deploys |

**The ceiling.** No suite or review can say whether the observer recount steadies or stirs someone (R1, the journeys' Personas paragraph); whether the after-entry tap reads as a rating (R4); or whether the Persian draft carries the observer stance (R2, RFL-1a.3). The eval plan that would have measured these is waived; they go to `team/open-work.md`'s *Past the verification ceiling* at MS2.

## 9. Where this is most likely to go wrong

1. **A catch that fires too often, or twice.** The offer is the place the journeys mark as the risk (J1.10–J1.12). It lives only in a move's result, and its record is written in the same transaction as the cooldown. Any path that re-runs `detectInterpretation` on a reload or a save breaks AC-29 quietly. B3's integration test walks forward, Back, forward and a reload.
2. **Lost words.** Autosave, a failed save and Stop here interact (D-15). A lane tempted to "simplify" by saving only on Next loses the story on a closed tab, the case G1 exists for. B4's e2e reloads mid-story.
3. **Hidden fields leaking through convenience.** An `outcome` added to the entry type "for the list", or a `count` for the home, is the easiest good-faith change to make. The SDL fence lists the hidden names explicitly.
4. **The deploy is the merge.** B1's migration goes to production at its `verify`; B4's routes go live unlinked with draft copy. If P0-4's setup is half done, a failed deploy at B1 blocks every later stage's deploy.
5. **Two client lanes in the same locale files** (B5 and B6): a JSON merge conflict resolved by hand can drop a key in one language. Both `i18n:check-*` scripts run after the second merge.
6. **D-4 unresolved.** Without `revise`, B6 ships a list that hides some stopped entries for good.
7. **Lane sizes.** B2, B4 and B5 are each L; IMNSTR's L stages ran past their line estimates. If a card runs past 1,000 words, the stage is two (B4a frame and home, B4b steps), decided at the card.

## 10. For the founder

**Facts owed:**
- **P0-1:** the calm-close copy in `en` and `fa` (needed by B7).
- **P0-4:** whether CD1's setup is done and deploys are live (needed by B1's `verify`).
- **P0-3:** where database backups go (needed by nothing yet; decides PD-2's revisit).
- **P0-2:** a Persian reading of the interface strings (needed by MS2).

**Decisions to veto** (§2): PD-2 no encryption at rest · PD-3 the B0 prep stage · PD-5 the entry point last, routes live unlinked before it · PD-6 no Back to the pre-check or from the story (narrows your G2 [F]) · PD-7 practice content served in `en` only · PD-8 a static palette selection · PD-10 cooldowns of 2 and 7 days · PD-11 a *Show older* link the wireframes don't draw · G6's split (§6.5).

**Carried:**
- **To `revise`:** D-4, AC-37 against the calm close's promise (PD-12's proposal), needed by B6. G1–G17 and the accepted W-calls still aren't in the spec; this plan builds them as listed in PD-1, and `revise` should write them in so that `close-out` traces them.
- **To the founder, from the waived eval plan:** locking the outcome above RFL-1 in `ecosystem/ost.md`; who reads M1–M6 from the database, and when.

**Open calls left to the card:**
- B0: `tsx` or `nodemon` for the e2e API.
- B1: the exact wording of every `en` prompt beyond the spec's story proposal, and the lexicon's triggers, to the four families.
- B2: the GraphQL type names inside the Reflect block, within §6.1's shape.
- B4: whether the step bar goes in `InternalPageLayout`'s header or the page body; the debounce's implementation.
- B4 or B5: whether the stage splits (§9.7).
- B6: whether `revise` has ruled on D-4 (PD-12).

## Changelog

- **0.1 · 2026-10-21** — Plan, from `02-spec.md` 0.1, `03-journeys.md` 0.2 and `04-wireframes.html` draft 1, against `rishe-eco/tracker main @ 5fd71c9`, under the gate override (ux-review and eval-plan waived by the founder). Eight stages (B0–B7), two milestones, twenty defects found, G1–G17 and W1–W19 settled, D-4 carried to `revise`, fifteen planning decisions.
- **0.1 · correction · 2026-10-22** — Two correction lines from `changes/01-req-past-entries-and-journey-gaps.md` (spec 0.2), written by `revise` at the founder's word instead of marking this file `STALE`: under PD-12 (D-4 accepted) and under §6.1's GraphQL table (the past-entry type without `step`; "listable" is any written text). No stage, size or order changes.
- **0.1 · correction · 2026-10-22** — §5 B4's Logic: "evicted from the Apollo cache" reads "no Reflect read goes through Apollo, so there is nothing to evict" (found at `verify B4`; the as-built reads use `useApi`, not Apollo's cache). Correction only, at the founder's word; no stage, size or order changes.
