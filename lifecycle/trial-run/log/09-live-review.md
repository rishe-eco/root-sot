# 09 Live review — 2026-10-18

## Session
Opus 5.5, effort high (stated by the founder). Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 9. Model: Opus, effort: high." One session ran `ux-review` (`live`), then `design-review`, as the phase table says.

## Read
In §1's order:
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `design-review` and `ux-review`.
- `STATE.md`'s top block (8d MS4), plus the two blocks under it, which fell inside the same read.
- `lifecycle/status.md`.

Inputs, per the phase row ("as in 5"):
- `05-ux-review.md` whole: the file this pass appends to, and pass 1's score table, for comparison.
- `lifecycle/review-instrument.md` 0.1.
- `lifecycle/personas.md` 0.2.
- `03-journeys.md` 0.3 whole.
- `02-spec.md` 0.4 §4 and §6.
- `04b-design/README.md` 0.2: the design review's rubric.

**Outside the read order, and why:**
- **Session memory** (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkout and the repo layout.
- **`log/05-ux-review.md`**, *Lessons* and *Next*, to see what step 5 left for step 9.
- **`imnstr/open-work.md` 0.21**, to avoid finding owed items again (F-2, F-17, F-19, V-3–V-9).
- **`lifecycle/projects/imnstr/config.md`**, for ports, the slot pattern and the deploy facts.
- **imnstr code:**
  - `playwright.config.ts`, `tests/e2e/support.ts`, `admin-support.ts` and `podcast-support.ts`, plus the titles and helpers of `editor.spec.ts`, `admin-podcast.spec.ts`, `admin-entries.spec.ts` and `admin-auth.spec.ts`: to drive the admin, which needs a passkey;
  - `routes/test.ts`, for the seeding routes;
  - `lib/record-middleware.ts`, to check that the walk counted no views;
  - `admin/admin.css` and the `btn--primary` uses, for D1;
  - `admin/composer.tsx`, for F2;
  - `lib/episodes.ts`, for F3.
- **`briefs/B5.report.md` and a grep of `07-build-plan.md`** for "solid ink", to see whether D1 was a decision. It wasn't.
- **`04b-design/imnstr-design.html`**, grepped for plate 3's 404 copy (P1).

## Gate
- **Phase gate, "UI stages verified":** status column 8 reads `10/10`, and the top `STATE.md` block says step 9 "can start now". **Pass.**
- **Inputs exist and are complete:** journeys 0.3, spec 0.4, personas 0.2, instrument 0.1 and design README 0.2. None is marked `STALE` in `status.md`.
- **Noted, not blocking:** MS3 and MS4 aren't closed (V-9, V-5). The gate doesn't name milestones (*Spec gaps* 6).

## Did
Mapped to `ux-review` (live), then `design-review`:
1. **Pulled.** `root-sot` was at `6833c67` and up to date. Fetched imnstr: `main @ b894598`, the commit that is live.
2. **Production, read-only, as a bot.** Every public page in both languages was fetched with `curl` (HEAD for status; GET with a `curl` user agent for the HTML). That counted no views: R1 skips bots, and HEAD isn't counted. The HTML was read as text. Production has two founder test entries, one English episode dated 21 Oct, and no Persian content.
3. **A local server on the same commit.** Port 4130, `.tmp/review.db`, `E2E_CLOCK=1`, started by Playwright's `webServer`. A throwaway `tests/e2e/zz-review*.spec.ts` seeded each journey's states through the e2e routes and walked J1–J6 in Edge, signing in with a CDP virtual authenticator. It captured about 70 screenshots:
   - 360 × 800, 360 × 400 (keyboard height), 180, 1280;
   - light and dark, both languages, and reduced motion;
   - DOM probes: switch targets, alternates, the Persian feed, tap sizes, Tab order, and the caret against the dock.

   Three runs: the first walk, a second for the parts the first missed (the passkeys toggle, a strict locator), and a 4× zoom on one mixed line. The scripts and the database were deleted afterwards: `git status` in imnstr is clean.
4. **Coverage first,** per instrument §3. Then each persona's journeys, scored with the same instrument as pass 1. M6 was scored for F only.
5. **Two suspected bugs checked below the UI** before writing (instrument §5):
   - "a second unsent text is lost" turned out to be a queue, so F1 is a clarity finding, not a loss;
   - "the dock hides the caret at keyboard height" was false: the caret probe put it above the toolbar.

   Also verified in code: the language lock (F2), future episode dates (F3) and the primary-button split (D1).
6. **Wrote pass 2** in `05-ux-review.md` 0.2: coverage, scores, five findings, heuristics, carried, worth keeping, not checked. Pass 1's findings were each marked fixed (seen), fixed (in the suites) or needing devices.
7. **`design-review`:** the 4b README was the rubric (the phase row says so, not Root's brand). Output `08-design-review.md` 0.1: two defects, four polish items, access gates, right to left, what holds.
8. **Handoff:** the `STATE.md` block, status column 9 `done`, this log, then commit and push.

Nothing skipped. One thing reordered: production was read before the local walk, so the seeded states could match what production lacks.

## Output
- `imnstr/modules/01-website/05-ux-review.md` 0.2: pass 2.
- `imnstr/modules/01-website/08-design-review.md` 0.1.
- `STATE.md`: a new top block.
- `lifecycle/status.md`: column 9 `done`.
- This log.
- Commit: see `git log` for "IMNSTR trial step 09". Nothing in imnstr changed.

## Spec gaps
1. **`ux-review` live doesn't say how to reach an admin behind passkeys.** "The running app" can't mean the founder's production admin: the reviewer has no passkey and mustn't use theirs. *Did:* public pages on production, read as a bot; every state, and the admin, on a local server built from the same commit, with the e2e fixture routes and a virtual authenticator. *Proposal:* live mode means "production read-only, plus a local server on the deployed commit". `config.md` names a review port (4130 here, as at B7's review) and the seed route.
2. **A live review can count itself.** IMNSTR keeps a reader record (spec §3.1), and a reviewer's GETs from a browser would be counted as views. *Did:* a bot user agent and HEAD only, after reading the record middleware. *Proposal:* `ux-review` live reads production as a bot wherever the project counts readers. The project config says whether it does.
3. **Finding IDs collide.** The instrument numbers findings "within the pass", so pass 2's F1 clashes with pass 1's F1, and with open-work's F-1. *Did:* "pass 2 F*n*" in the text. *Proposal:* pass-scoped IDs in the instrument (`L1…` for live, or `P2-F1`).
4. **The instrument's "Grade" field is one value.** Live mode makes the observation *as-built*, but the persona scores are still one reviewer's judgement. *Did:* graded observations as-built and scores simulated, and said so. *Proposal:* two grades in instrument §4, one for what was seen and one for the score.
5. **`design-review`'s inputs are Root's** (brand definition, `apps/web` tokens, root-website requirements). The trial row overrides them for IMNSTR. *Proposal:* the skill reads its rubric from `config.md` §1, "Design system", and Root's brand only when that row points there.
6. **The live gate is "UI stages verified" and says nothing of milestones.** MS3 and MS4 were open (V-9, V-5). *Did:* ran, as `STATE.md` said. *Proposal:* say whether open device checks block step 9 (they shouldn't), and list them under *Not checked*.
7. **Where live findings go once the build is done** isn't said. The routes `design` and `build` assume a design pass or stage still to come. *Did:* carried them as one proposed polish Change (`spec change`, then a stage), the founder's call. *Proposal:* live mode routes UI fixes to `spec change`.
8. **The skill doesn't say to read `open-work`.** Without it, a live pass finds owed items again (Persian copy, icons, compression). *Proposal:* inject open-work's V- and F- rows.
9. **`05-ux-review.md`'s top Summary described pass 1 only.** *Did:* added a pass 2 summary above pass 1's, newest first. *Proposal:* the template keeps one short summary per pass at the top.

## Template sample
**`05-ux-review.md`, live pass:** What was reviewed · Coverage (AC status table; states; the earlier pass's findings, live) · Scores (with the earlier pass in brackets) · Findings · Heuristics, in brief · For `revise` · Carried · Worth keeping · Not checked.

Required: What was reviewed, Coverage, Scores, Findings, Not checked.

**`08-design-review.md`:** Summary · Findings (What / Why / Fix, ranked) · Access gates · Right to left · What holds · Owed · Changelog · References.

Required: Summary, Findings, Access gates. Right to left is required when the project has an RTL language.

## Missing foundation
- **A review harness.** The e2e helpers (`signedInAdmin`, `resetLog`, `resetPodcast`, the `/__test/*` routes) made the walk possible, but each review writes its own throwaway capture script. A kept `tests/review/capture.spec.ts`, seeded from journeys §3's states, would make passes repeatable and comparable.
- **A review port** in `config.md` §4 (4130 by habit).
- **An image tool** for zooming a screenshot: there is no PIL on this machine. Used a `deviceScaleFactor: 4` clip instead.

## Founder Q&A
None asked: nothing blocked the review. Two questions are left in the file for the founder: pass 2 F2 (can a saved draft change language?) and F3 (future episode dates).

## Skill shape
- **Model:** Opus · high. The judgement as personas is the work.
- **Not forked, or forked with Bash and Playwright.** It needs a running server, Edge and the image Read.
- **Shape:** two halves, a mechanical capture and a judging read:
  - the capture could be a Sonnet subagent running a kept harness that writes screenshots and a probe JSON;
  - the judging, scoring and writing stay Opus;
  - most of this session's tokens went on viewing ~45 screenshots.
- **Inject:**
  - the status row and top `STATE.md` block;
  - `git log -1 origin/main` of the code repo;
  - the previous pass's score table;
  - journeys §3's AC map and states;
  - open-work's V- and F- rows;
  - the design-system path from `config.md`.
- **Reference file:** the live recipe:
  - bot user agent on production;
  - a local server on the deployed commit;
  - viewport, not full-page, shots for sticky docks and dialogs;
  - 360 × 400 as the keyboard;
  - 180 px for 200%;
  - a caret-versus-dock probe;
  - the tap-size probe;
  - Tab order;
  - follow a suspected loss through before reporting it.

## Lessons
1. **Rule:** a live review of a site that counts its readers reads production as a bot, and walks every state on a local server built from the deployed commit. **Event:** the first status probes used a browser-like user agent. The record middleware turned out to count only GET 200, so nothing was counted. Without that check, the review would have placed views in the founder's reader record. **Cost:** none this time. **Scope:** `ux-review` live, `verify`. **Destination:** `skills-plan.md` `ux-review` (live mode) and its reference file. `urgent: no`.
2. **Rule:** judge sticky docks, dialogs and the keyboard layout from viewport screenshots and a position probe, never from a full-page capture. **Event:** in full-page captures, the episode form's sticky actions sat mid-form over the Language field, and at 360 × 400 the editor's dock looked as if it hid the body. A caret probe showed the caret above the toolbar. **Cost:** a second capture run, and two near-false findings. **Scope:** `ux-review` live, `design-review`, `verify` screenshots. **Destination:** instrument §5 (rules) or the live recipe. `urgent: no`.
3. **Rule:** before reporting lost text, follow the text through every step: reload, put back, publish, and what is offered next. **Event:** two unsent texts and one "You left something here" offer looked like a loss. Following them showed AC-43's queue, so the finding became a Medium clarity item (pass 2 F1), not a High. **Cost:** five minutes; a wrong High would have sent a build stage chasing nothing. **Scope:** `ux-review` live. **Destination:** an example under instrument §5's "verify below the UI". `urgent: no`.

## Cost
*Founder fills in after the session.*

## Next
- **The founder decides:**
  - pass 2 F2 and F3;
  - whether the polish Change (UX F1, F4, F5; design D1, D2, P1–P4) goes in before launch. If yes: a `spec change` session, then 8a/8c for one stage.
- **Still owed by the founder,** unchanged: V-5 with V-8 (needs a Persian entry on production), F-17, V-9 with V-7, F-19, F-11, F-14, F-7, F-2, V-3, V-4.
- **Next trial step: 10a** (`learned --consolidate`, Opus · high). It can run now: it reads every log's *Lessons*, including these three.
- **10b close-out** needs every milestone green, and MS3 and MS4 still wait on V-9 and V-5.
