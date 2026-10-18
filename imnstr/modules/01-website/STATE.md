# STATE — imnstr / 01-website

*Newest block first. Written by `handoff`.*

## 2026-10-18 · `lifecycle-trial/imnstr` (step 9b, spec change: live-review polish) · imnstr `main @ b894598`

*Replaces the step-9 block's next step 1. Its steps 2–3 stand. Log: `log/09b-polish-change.md`. Note: `changes/05-live-review-polish.md` 0.1.*

**Lanes in flight:** none. No status cell: a mid-build Change has no column, as at 8e. Column 8 stays `10/10`, column 9 `done`.

**The founder decided** (one batch):
- **Pass 2 F2:** a never-published draft may change language; a published or "was live" one may not (PL-8).
- **F3:** an episode date after today is refused (PL-9). The note adds one exception, **accepted by the founder** (note 0.2): an edit that sends the date the episode already has passes. That keeps the 21 Oct episode on production editable and the seeded fixtures working.
- **The spec stays 0.4.** AC-42, §4.4's Episode row and AC-30 are listed in the note as stale after PL1, for a later `revise`.

**The Change:**
- one stage, **PL1 · Live-review polish (M, about 1,300 lines)**, branch `pl1-live-polish`, slot A (`4110`);
- criteria PL-1 to PL-12: D1, D2, P1–P4, F1–F5, plus the both-languages, both-schemes, 360/180 runs;
- three commit groups the lane can stop between: public pages; admin look; admin rules and words.

**For 8a to know:**
- No stop file, no `.env` line, no server step: the verify's push is the deploy.
- PL-4 is a container fit for `.big-row__title`. It is not a wrapping rule, and `base.css`'s `overflow-wrap` must not change.
- The skip link stays full size off-screen: the tap-target check flags a 1 × 1 box.
- `excerpt` moves to `shared/` for F1.
- Two new refusal codes: `LANG_FIXED` (409) and `DATE_FUTURE` (400).

**Next steps, in order**
1. **8a PL1** (Opus · medium): `build-phase changes/05-live-review-polish.md#PL1`. Draft the card from the note's PL1 section. Re-read it against `git log b894598..origin/main` first. Check `git config --local user.email` in the new worktree.
2. **The founder,** as before: a Persian entry on production, then V-5 with V-8; F-17 before V-9's cold runs; V-9 with V-7; F-19. V-3 is still owed. PL1 changes none of these, and MS3/MS4 stay open on them.
3. **Trial step 10a** (`learned --consolidate`) can run beside the PL1 lane. It reads logs only. **10b** waits for MS3, MS4 and PL1.

**Owed by the founder:** V-5 with V-8, F-17, V-9 (with V-7), V-3, V-4, F-19, F-11, F-14, F-7, F-2 (now also the new Persian strings: skip link, Newer).

## 2026-10-18 · `lifecycle-trial/imnstr` (step 9, live review) · imnstr `main @ b894598`

*Replaces the 8d MS4 block's next step 1. Its steps 2–3 stand. Log: `log/09-live-review.md`.*

**Lanes in flight:** none. **Status column 9 is `done`.** Column 8 stays `10/10`.

**How it was walked:** production's public pages read as a bot (`curl`; the reader record counts no bots and no HEAD, so no views were placed). Every journey state, and the admin, on a local server on `b894598` (port 4130, its own database, the fixture clock), in Edge through throwaway Playwright scripts with a virtual authenticator. The scripts are deleted; imnstr's tree is clean.

**UX, pass 2** (`05-ux-review.md` 0.2): of the 30 scores that compare with pass 1, 10 rose, 1 fell and 19 held. Persona F scored for the first time, M6 4 (Persian copy still placeholder). Every High and Medium from pass 1 is fixed. **No High.** Five new findings:
- **F1, Medium:** the "You left something here" offer doesn't say which text it holds.
- **F2, Low, question:** a saved draft's language is locked.
- **F3, Low, question:** future episode dates; production shows one dated 21 Oct.
- **F4, Low:** no "Newer" link past "Older".
- **F5, Low:** success notices sit in two places.

Nothing changes the spec.

**Design review** (`08-design-review.md` 0.1, against the 4b README):
- **D1:** HIG #5 reached Publish only. Save, Sign in, Create a passkey, New episode and the in-notice actions still use the highlighter fill.
- **D2:** confirm dialogs open mid-screen, not pinned to the bottom on phones.
- **P1–P4:** the 404's joke twice; a Persian heading split at a ZWNJ at 200%; Links › Link › Label; no skip link.

No blockers.

**Next steps, in order**
1. **The founder:** decide pass 2 F2 and F3. Decide whether one polish Change (UX F1, F4, F5; design D1, D2, P1–P4) goes in before launch. If yes, run `spec change`, then 8a/8c for its one stage.
2. **The founder,** as before: a Persian entry on production, then V-5 with V-8; F-17 before V-9's cold runs; V-9 with V-7; F-19. V-3 (screen readers, real 200%, other browsers) is still owed: step 9 couldn't reach it.
3. **Trial step 10a** (`learned --consolidate`, Opus · high) can start now. **10b close-out** waits for MS3 and MS4 to close (V-9, V-5).

**Owed by the founder:** pass 2 F2 and F3, the polish-Change call, V-5 with V-8, F-17, V-9 (with V-7), V-3, V-4, F-19, F-11, F-14, F-7, F-2.

## 2026-10-18 · `lifecycle-trial/imnstr` (step 8d, MS4 suites green) · imnstr `main @ b894598`

*Replaces the 8c B9 block's next step 1. Its steps 2–3 stand, with step 3 now open. Log: `log/08d-MS4-milestone.md`.*

**Lanes in flight:** none. Status column 8 stays `10/10`: a milestone verifies no stage.

**Suites, on `main @ e8a7b90`, one heavy runner at a time, all green on the first run:** `npm ci --ignore-scripts` 207 packages, 0 vulnerabilities; `check` clean; Vitest **46 files / 982**; e2e **563 passed, 9 skipped** (`auth.spec.ts`'s dark runs, by design), one worker, 22.9 min, no retry. **The access sweep passes:** `sweep.spec.ts` 78 and `admin-sweep.spec.ts` 40, inside that run; the B9 composer flake did not recur.

**Live, by `curl`** (bot agent; feeds by `HEAD`): every §6.1 page `200` with noindex, both `404`s, signed-out APIs `401`, `/__test/clock` `404`, B9's `wordmark.js` served. JS and CSS still uncompressed (F-17). **Production has no Persian entry.**

**Recorded:** an MS4 section in `docs/development/README.md`, imnstr **`b894598`**, pushed with the founder's word; run 39086241435 green (check, deploy). open-work **0.21**: V-5 holds MS4 open (needs a Persian entry first); V-8 rides along with it.

**MS4 is not closed:** V-5 (feed readers, plan §8 "MS4") is owed; the launch gate also needs MS3 closed (E1, V-9). The founder had no phone.

**Next steps, in order**
1. **Step 9, the live review** (Opus · high), `ux-review` (`live`) then `design-review`: it can start now.
2. **The founder:** publish one Persian entry with a Latin run in it, then V-5 and V-8 together (subscribe to both feeds in two aggregators, look at the Persian by eye, then read `record_feed`); F-17 before V-9's cold runs; V-9 with V-7; F-19.
3. After E1 and V-5: `reset-content` at the founder's word; MS3 and MS4 closed in the dev README.

**Owed by the founder:** V-5 with V-8, F-17, V-9 (with V-7), F-19, F-11, F-14, F-7, F-2. The empty `b9-motion-access` worktree folder is still held by a process.

## 2026-10-18 · `lifecycle-trial/imnstr` (step 8c, B9 verified and deployed) · imnstr `main @ e8a7b90`

*Replaces the 8b B9 block's lane table and its next step 1. Its steps 2–3 stand. Log: `log/08c-B9-verify.md`.*

**Lanes in flight:** none. **Every stage is verified and deployed: status column 8 is `10/10`.** The B9 worktree and branch are removed (an empty folder `E:\_root\imnstr\.claude\worktrees\b9-motion-access` stayed, held open by a process; delete it when free).

**B9 at review:** one fix, `fc5a46d`: a tap on the landing hero did nothing on an iPhone (the lane read `pointerType` from the click, which Safari omits before 18.2 and calls "mouse" after, WebKit bug 282988); it now comes from `pointerdown`, with a test that fails on the lane's code. Record `docs/development/B9.md`. Rerun at review: `check` clean; Vitest 9 files / 289; Playwright (both sweeps, `landing`, `not-found`, `entry`, `admin-auth`) 249 passed, 1 flaky (`admin-sweep`'s English composer in dark found no `<mark>`; 24/24 on repeat). Driven in Edge by screenshots, both languages and schemes, 360/180/1280 and the sign-in: nothing to fix.

**Deployed:** pushed with the founder's word; run 39083276917 green (record runs 39083476001, 39083502670 green). Live: CSP, noindex, no cookie on every page; root-app 200; `wordmark.ee17e9ae4b.js` served with the fix. **`Content-Encoding`: HTML gzip; JS and CSS none** (F-17 still open).

**Founder at this verify:** push yes; **F-19 left in open-work** (CLAUDE.md container queries in rem; the colour table's 7.9 and 3.4; two design calls). open-work **0.20**: F-19, S-20 (deploy check for `wordmark.js`), V-2 closed, V-3 and V-9 widened.

**Next steps, in order**
1. **8d MS4** (Opus · high): the milestone script on `main @ e8a7b90`, one heavy runner at a time; watch `admin-sweep`'s composer flake. MS4 (and MS3) still wait on V-9 for E1.
2. **The founder:** F-17 (before V-9's cold runs), then V-9 with V-7 (now also a real tap on the hero); V-8 is due; F-19.
3. **Step 9** (live review) can start after MS4's suites.

**Owed by the founder:** F-17, V-9 (with V-7), V-8, F-19, F-11, F-14, F-7, F-2.

## 2026-10-18 · `lifecycle-trial/imnstr` (step 8b, B9 landed) · imnstr `main @ fdfda8b`

*Replaces the 8a B9 block's lane table and its next step 1. The card's calls there still stand. Run in the same session as 8a B9, because the report came back here. Log: `log/08b-B9-land.md`.*

**Lanes in flight:** none. The lane finished without a stop.

| Stage | Branch | Worktree | Report |
|---|---|---|---|
| B9 Motion, wordmark, access sweep (M) | `b9-motion-access` @ `1869e15` (2 commits: `f9ed1a4` public, `1869e15` admin), from `fdfda8b`, **local only**, no upstream | `E:\_root\imnstr\.claude\worktrees\b9-motion-access` (kept for the verify) | `briefs/B9.report.md` |

**What the lane says** (its report, not yet reviewed): +1,652 / −75 over 34 files, about a third in the two sweep specs. `npm run check` clean; Vitest 9 files / 289; `sweep.spec.ts` 76 and `admin-sweep.spec.ts` 40 green (about 6 min together, both schemes, one worker); the regression set 432 passed and 4 failed (`landing.spec.ts` pinned the hero's text), then `landing.spec.ts` alone 40 passed after the fix. New dev dependency `@axe-core/playwright ^4.14.0`. axe finds nothing at WCAG 2.2 AA once the lane's fixes are in.

**For verify to look at first** (from report items 4 and 5):
- **Real fault found and fixed:** at 200% text and 360 px, the admin's entries list ran 120 px off the edge on a row with a Persian pill; the rows now choose their layout by `@container (min-width: 17rem)`, **in rem, against `CLAUDE.md`'s em rule** for breakpoints.
- **The hero is fitted by container units** (`--fit-wordmark`): 50 px at 360, but 17 px at 180 px (the old cap gave 34), and about 2 px at 180 px with 200% text.
- Header wordmark 22/26 px (was 24) and nav gap 8 px on phones, to keep one row at 360; revealed, the nav wraps to a second row.
- A mouse click or Enter on the hero does nothing (`preventDefault`); only touch or pen toggles.
- Tap fixes: `padding-block` on inline links in running text, `min-inline-size` on the Persian Feed link; `.entry-page__date` counted as a 24 px date link.
- The date input's year at 180 px was checked by screenshot only; the test guards the padding.
- Canon drift for the founder: the design README's dark muted (7.9:1, not 8.3) and light field edge on the ground (3.4:1, not 3.6); plate 15's section rules (1 px soft) against the code's 1.5 px strong. `deploy/checks.sh` has no check for `wordmark.js`.
- The 200% emulation leaves `em` media queries alone, so real browser text size is for step 9.

**Next steps, in order**
1. **8c, verify B9** (Opus · high), fresh session. Ask the founder's word before the deploy push; read `Content-Encoding` on the live assets; then status column 8 → `10/10`, worktree and branch removed.
2. **8d MS4** (full suites and the sweep); MS3 and MS4 both wait on V-9 for E1.
3. **The founder:** F-17, then V-9 with V-7; V-8 is due.

**Owed by the founder:** F-17, V-9 (with V-7), V-8, F-11, F-14, F-7, F-2. Status column 8 stays `9/10`.

## 2026-10-18 · `lifecycle-trial/imnstr` (step 8a, B9 launched) · imnstr `main @ fdfda8b`

*Replaces the 8d MS3 block's next step 1. Its steps 2–3 (the founder: F-17, then V-9 with V-7; V-8 due) stand. Log: `log/08a-B9-launch.md`.*

**Founder, at this launch:** no question asked. B9's one check outside the suites (plan §8: the dark pairs' contrast) is measured in the sweep; screen readers and real zoom stay with step 9.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B9 Motion, wordmark, access sweep (M) | `b9-motion-access` from local `main @ fdfda8b`, no upstream | `E:\_root\imnstr\.claude\worktrees\b9-motion-access` | A: `4110`, `.tmp/e2e.db` | `briefs/B9.md` (`439a329`) | background Sonnet lane, launched; report also to `<worktree>/.tmp/B9.report.md` |

**What the card settled** (for verify to hold the lane to):
- **`assets/wordmark.js`**, plain JS, hashed by `lib/assets.ts`, `<script defer src>` in `views/layout.tsx` **and** the admin shell (`routes/admin.tsx`), so the sign-in's eyes follow too. Returns before binding under reduced motion. One `pointermove` on `window`, one update per frame, finds `[data-eye]` at move time. Pupils move through the CSSOM (CSP allows it), never a `style` attribute.
- **Reveal:** hidden letters are `aria-hidden` spans; the name stays "iMNSTR". CSS reveals on `:focus-visible`, `:hover` within `(hover: hover)`, and `.is-revealed`. JS runs the intro (0.9 s on, 2.9 s off; only where the hero has `data-intro`) and toggles on tap **on the landing hero only**; header wordmarks stay plain links. Wordmark colour stays B1's `--monster`; revealed letters weight 500.
- **Eyes placed** per the plates: every public header, the landing hero, the empty states of `/log`, `/fa/log`, `/podcast`, `/fa/podcast`, big on both 404s and the admin sign-in. All `aria-hidden`; B4b's sign-in slot loses `role="img"` and its label.
- **CSS motion:** the draw-in (landing intro; podcast lede scoped, but B7's lede has no `<mark>` and no copy is added: F-2), the rows' 0.35 s sweep, the reveal's transition. `base.css`'s kill-switch stays.
- **Carried:** `expectWithinColumn` into `tests/e2e/support.ts`; the date input's clip at 180 px (fix in CSS, or report); **V-2** as `tests/unit/contrast.test.ts` reading `tokens.css` (all pairs pass by the card's arithmetic; the README's dark muted "8.3:1" computes to 7.9).
- **The sweep:** `@axe-core/playwright` (plan §6.6, new dev dependency); `sweep.spec.ts` and `admin-sweep.spec.ts`, one test per page or state running every check (axe WCAG 2.2 AA tags; 360 with wordmarks forced revealed; 180 with the column check; root 200% at 360 and 1280 via `page.evaluate`; forced colours incl. the editor's `<mark>`; reduced motion by counting `animationstart`/`transitionrun`; tap targets; no `securitypolicyviolation`). Intro tested with `page.clock`.
- **Tests that change on purpose:** four tests that pin "no `<script` at all" on public pages narrow to "no inline script" and assert the one hashed `wordmark.js`; wordmark text checks become accessible-name checks.

**Next steps, in order**
1. **8b, land B9** when the lane reports: in this session if it comes back here.
2. **8c, verify B9** (Opus · high). Push `main` to deploy (ask the founder's word first). Read `Content-Encoding` on the live assets. Then status column 8 → `10/10`.
3. **8d MS4** (full suites and the sweep); MS3 and MS4 both wait on V-9 for E1.
4. **The founder:** F-17, then V-9 with V-7; V-8 is due.

**Owed by the founder:** F-17, V-9 (with V-7), V-8, F-11, F-14, F-7, F-2. Status column 8 stays `9/10`.

## 2026-10-18 · `lifecycle-trial/imnstr` (step 8d, MS3) · imnstr `main @ fdfda8b`

*Adds to the 8c B7 block; replaces its next step 1. Log: `log/08d-MS3-milestone.md`.*

**Lanes in flight:** none.

**MS3 suites green on `ca1b2aa`:** `check` clean; Vitest 45 files, 948 passed; Playwright 445 passed, 9 skipped, one worker. Every feature checked live by `curl`. **MS3 is not closed:** E1 (V-9) needs the founder's phone, and they had none. Record: dev README, MS3 (`fdfda8b`, CI run 39074234512). Status column 8 stays `9/10`.

**Next steps, in order**
1. **8a B9**, the last stage; its card carries the 8c B7 block's three items.
2. **The founder:** F-17, then the phone check (V-9 with V-7); MS3 closes when E1 passes, then `reset-content`.
3. V-8 is due (two aggregators).

**Owed by the founder:** F-17, V-9 (with V-7), V-8, F-11, F-14, F-7, F-2. open-work 0.19.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B7 deployed) · imnstr `main @ ca1b2aa`

*Replaces the 8c B7 block's lane table and its next step 1. Its steps 2–3 stand. Log: `log/08c-B7-verify.md`, addendum.*

**Lanes in flight:** none. No stage worktree is left; `b7-podcast` is merged and deleted.

**B7 is live**, pushed with the founder's word: run 39071916145 (the stage) and 39072108147 (the record) green. `curl -I` right on every page incl. `/podcast` and `/fa/podcast`; the episodes API answers 401 signed out; `/admin` serves the new bundle (310,540 B, uncompressed until F-17). Production has no episodes yet. Status column 8 is `9/10`.

**Next steps, in order**
1. **8d MS3** (suites, `main @ ca1b2aa`); MS3 can't close until V-9.
2. **8a B9**, the last stage (motion, wordmark, the access sweep). Its card should carry: move `expectWithinColumn` into `tests/e2e/support.ts`; the date input's clip at 180 px; contrast of B7's dark pairs.
3. **The founder:** F-17, then V-9 with V-7. *(Added 10-18: F-18 accepted, build plan 0.8; the founder published an episode on production and it worked.)*

**Owed by the founder:** F-17, V-9 (with V-7), F-11, F-14, F-7, F-2. open-work 0.17.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B7 verified, not yet deployed) · imnstr `main @ 7d82cc0`

*Replaces the 8b B7 block's next step 1. Its steps 2–3 stand. Log: `log/08c-B7-verify.md`.*

**Lanes in flight:** none.

| Stage | Branch | Worktree | Status |
|---|---|---|---|
| B7 Podcast (L) | `b7-podcast` @ `a7c6292` (lane's `d1b9c92`, `c0401f4`, then the review's fix and record), local only, on `7d82cc0` | `E:\_root\imnstr\.claude\worktrees\b7-podcast` | verified, **ready to fast-forward**; the push deploys and waits for the founder's word |

**The review:**
- **One fix:** in an edit, a cleared date showed today while Save kept the episode's own date; now it shows the episode's date again (test fails on the lane's code).
- **AC-6:** validator.schema.org on both pages with fixture episodes: 0 errors, 0 warnings.
- Suites: check clean; Vitest 17 files, 435; e2e four specs 230 on the lane's code, `admin-podcast` 64 with the fix.
- Seen, not changed: a Persian name's `C++` draws `++C` in the admin's plain `<input>` (V-4); the date input clips its year at 180 px (B9).
- No stop file, `.env` line, migration or package change in the diff.

**Next steps, in order**
1. **The founder's word, then the push:** `git push origin HEAD:main` from the B7 worktree; read the run through the API; `curl -I`; the record's deploy section in its own commit; remove the worktree and branch; status column 8 → `9/10`.
2. **8d MS3** (suites) once B7 is live; MS3 can't close until V-9.
3. **8a B9.**

**Owed by the founder:** F-18 (new: plan changelog for B7), F-17, V-9 (with V-7), F-11, F-14, F-7, F-2. open-work 0.17.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8b, B7 landed) · imnstr `main @ 7d82cc0`

*Replaces the 8a B7 block's lane table and its next step 1. The card's calls there still stand. Run in the same session as 8a B7, because the report came back here. Log: `08b-B7-land.md`.*

**Lanes in flight:** none. B7 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B7 Podcast (L) | `b7-podcast` @ `c0401f4` (two commits, founder identity), **local only**, based on `7d82cc0`; `main` hasn't moved | `E:\_root\imnstr\.claude\worktrees\b7-podcast` | `briefs/B7.report.md` | landed; 45 files, +5,291 / −300 (tests +2,418; about 280 of the rest is code moved out of `composer.tsx`); lane ~44 min wall, 539k tokens, 159 tool uses |

**Commits:** `d1b9c92` is the podcast page and the episodes API; `c0401f4` is the admin form, the shared writer, generic buffers and the e2e.

**What the lane says** (not reviewed):
- `npm run check` clean. Vitest, 23 targeted files: 555 passed. Playwright, slot A, both schemes: `podcast` + `admin-podcast` 126 passed; `editor` + `admin-entries` 104 passed.
- **S-9:** the largest episode request is 159,392 bytes, 15% of Nginx's `1m`. Pinned in `request-size.test.ts`; `imnstr.conf` untouched.
- **Bundle:** `admin.js` 285 → 310 KB raw, 88 → 93 KB gzip. Still sent uncompressed until F-17.
- **S-18:** `/podcast` now counts, with a test.
- No stop file, migration, `.env` line or dependency in the diff.

**For verify to decide** (report items 4–5):
- **Tests that said "B7 isn't here yet" were edited:** `record.test.ts` (`/podcast` expected 404), `admin-entries.test.ts` (its unknown-path example was `/admin/api/episodes`), `admin-entries.spec.ts` (the shell's headings).
- **Beyond the card:** the new-episode form **closes after Save draft**, where the entry's editor stays open; a third tag is `TAGS_ONE_OR_TWO` on any save; tag cap 100; a label with no URL is `LINK_NOT_HTTPS`; on `PUT`, an empty date keeps the episode's own; link positions use two bands (0 and 1000); the Podcast section opens itself when it has something to offer back; the confirmation copy where the plates have none; a "Persian" pill in the list.
- **Microdata:** `name`, `description`, `datePublished`, `keywords`, `url` per link, `inLanguage`, `partOfSeries` (`PodcastSeries`). Hono hoists `<meta>`/`<link>` into `<head>`, so the series markup is an escaped string: check it, and run validator.schema.org on both pages.
- **Show links** as `big-row` rows at title size; the intro is a locale string, not content; Persian `older` and `description` strings are the lane's placeholders (F-2).
- `<input type="date">` is drawn in the browser's locale, not plate 11's "10 Oct 2026". `admin/tsconfig.json`'s comment and `check_admin_entries_unauthenticated`'s name are now stale.
- **Unverified:** the validator, a real phone (keyboard, native date picker), screen readers, other browsers, a 159 KB request through the live Nginx.

**Next steps, in order**
1. **8c, verify B7** (Opus · high), a fresh session on this machine. Ask the founder's word before `git push origin HEAD:main` (it deploys). Run validator.schema.org on both pages; check S-18 live; the 180 px column check on every new screen.
2. **MS3's suites** can run once B7 is live, but MS3 can't close until V-9 passes.
3. **The founder:** F-17, then V-9 with V-7.

**Owed by the founder:** F-17, V-9 (with V-7), F-11, F-14, F-7, F-2. Status column 8 is not this step's to change.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8a, B7 launched) · imnstr `main @ 7d82cc0`

*Replaces the 8c B6 deployed block's next step 1. Its step 2 (the founder: F-17, then V-9 with V-7) stands. Log: `log/08a-B7-launch.md`.*

**Founder, at this launch:** no question asked. B7's one check outside the suites (plan §8: validator.schema.org on both pages) is the verify's, and needs no device.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B7 Podcast (L) | `b7-podcast` from local `main @ 7d82cc0`, no upstream | `E:\_root\imnstr\.claude\worktrees\b7-podcast` | A: `4110`, `.tmp/e2e.db` | `briefs/B7.md` (`a3c0dfd`) | background Sonnet lane, launched; report also to `<worktree>/.tmp/B7.report.md` |

**What the card settled** (for verify to hold the lane to):
- **S-3:** `createOrGet` gains an optional step inside its transaction, after the insert and before the publish, where episodes insert their links. Entries pass nothing.
- **Links travel whole in `PUT`**. The plan's `DELETE episodes/<id>/links/<n>` is **not built**: Remove is part of the edit, so Cancel undoes it. The server inserts new rows before deleting old ones, because `episode_last_link` fires otherwise. An empty list on a published episode is `LAST_LINK` (409). For the plan's changelog.
- PD-23's refusals in order at publish. `LINK_NOT_HTTPS` on every save (`https:` scheme). A blank label is `REQUEST_INVALID`. The triggers' `RAISE` messages map to the same codes.
- **New guards in `lib/limits.ts`** (name 1,000, description 10,000, label 100, URL 2,000, links 20), each `REQUEST_INVALID`, with `maxlength` to match. For the plan's §6.4.
- **The date is a calendar date.** The server fills today in `SITE_TZ`. A formatter never converts a zone. `GET episodes` returns `today` and `now`.
- **Order** `date DESC, id ASC`, public and admin. Cursors follow PD-25.
- **The show links sit under the intro on every page.** Plate 4's desktop "Listen wherever you like" block is not built. Every pill is the same: no icons yet.
- **S-19:** the shared writing pieces move out of `composer.tsx` unchanged; `buffers.ts` goes generic over what a buffer holds; `admin/episode-writes.ts` in `writes.ts`'s shape; the language fixed while a send is unanswered.
- Signed-out copy per F-16 ("You were signed out. … Your episode stays right here.").
- **S-9:** measured, not changed. `deploy/checks.sh` gains `/podcast`, `/fa/podcast` and the episodes 401. Every new screen is checked at 180 px against the column.

**Next steps, in order**
1. **8b, land B7** when the lane reports: in this session if it comes back here.
2. **8c, verify B7** (Opus · high). Push `main` to deploy (ask the founder's word first). Run validator.schema.org on both pages; check S-18 (`/podcast` counts). With B7 deployed, MS3's suites can run, but MS3 can't close until V-9 passes.
3. **The founder:** F-17, then V-9 with V-7, as the block below says.

**Owed by the founder:** F-17, V-9 (with V-7), F-11, F-14, F-7, F-2. Status column 8 stays `8/10`.

## 2026-10-17 · `lifecycle-trial/imnstr` (8c B6 follow-up: F-15, F-16) · imnstr `main @ 7d82cc0`

*Adds to the block below; its next steps stand. Log: `log/08c-B6-verify.md`, the addendum on F-15 and F-16.*

- **F-15 accepted:** build plan **0.7** (PD-11, §5 B6, §6.4).
- **F-16 decided, built and deployed:** the signed-out copy without a reason, and titles capped at 1,000. imnstr **`main @ 7d82cc0`**, run 39052633921 green; the live bundle `admin.f1b0275d39.js` carries the new copy. The worktree and branch are removed.
- open-work 0.16.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B6 deployed) · imnstr `main @ e3d492a`

*Replaces the block below's next step 1. Same session: the founder gave the word to push. Log: `log/08c-B6-verify.md`, *Addendum*.*

**B6 is live.** `f4b67d0` went out in run 39049852350 (green), and the record `e3d492a` in run 39050124433 (green). Headers are right, and `/admin` serves the new bundle with no CSP report. The worktree and branch `b6-editor` are removed. Status column 8 is `8/10`.

**Found after the deploy:** the bundle goes out **uncompressed**, at 285 KB, because Nginx gzips HTML only. The fix is open-work F-17, a stop file, so it is the founder's step. Do it before E1's cold runs.

**Next steps, in order**
1. **8a B7.** Its card carries S-19 (reuse the buffers; keep the language fixed while a send is unanswered) and the 180 px check against the column (log lesson 1).
2. **The founder:** F-17, ideally before the phone check. Sign in once and see the editor live (the review had no passkey). Then V-9 with V-7: E1, the phone keyboard, PD-7's fallback. M3 can't close without V-9.

**Owed by the founder:** F-15, F-16, F-17, V-9 (with V-7), F-11, F-14, F-7, F-2.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B6 verified, not yet deployed) · imnstr `main @ b831fd3`

*Replaces the 8b B6 block's next step 1. Its step 2 (8a B7) stands, after the deploy. Log: `log/08c-B6-verify.md`.*

**Where B6 is:** reviewed and fixed. It is `b6-editor` @ **`f4b67d0`** (the lane's four commits, then the review's), local only, in `E:_rootimnstr.claudeworktrees6-editor`. **Ready to fast-forward. Not deployed:** auto mode refused `git push origin HEAD:main` as a production deploy. The stage record `docs/development/B6.md` is on the branch. Its deploy section waits for the CI run.

**The review fixed** (each with a test that fails on the lane's code):
1. **A language switch after a lost answer published the same text twice** (a new key for the new language). Now the key stays, and the language is fixed while a send is unanswered.
2. **Leave over unsaved changes skipped "Back to your unsent entry."** and its Discard. Leave now drops only the changes.
3. **At 180 px, Highlight ran into the gutter.** The tools wrap. The test checks every control against the column, in the composer and in the frame.

**Accepted:** the lane's `localStorage` rule change (one file, three key shapes) and the "left" regex. The rest of item 4 is in the record.

**Suites at review:** `npm run check` clean; Vitest 15 files, 375 passed; Playwright `editor`, `admin-entries` and `admin-auth`: 134 passed, light and dark.

**Next steps, in order**
1. **The founder pushes `main`.** In `E:_rootimnstr.claudeworktrees6-editor`, run `git push origin HEAD:main`. The diff has no stop file and no `.env` line, only new npm dependencies. Then a session finishes 8c:
   - read the run at `api.github.com/repos/rishe-eco/i-monster/actions/runs`;
   - check that `/admin` serves the new bundle with no CSP report, the `curl -I` headers, and root-app's URL;
   - write the record's deploy section in its own commit and push it (also a deploy);
   - remove the worktree and the branch;
   - set status column 8 to `8/10`.
2. **8a B7.** Its card carries S-19 (reuse the buffers, and keep the language fixed while unanswered) and the 180 px column check (log lesson 1).

**Owed by the founder:** the push (above); F-15 (plan changelog for B6); F-16 (signed-out copy; title length); V-9 with V-7 (E1, the phone keyboard, PD-7's fallback). M3 can't close without V-9. Also F-11, F-14, F-7 and F-2. Status column 8 stays `7/10` until B6 is live.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8b, B6 landed) · imnstr `main @ b831fd3`

*Replaces the 8a B6 block's lane table and its next step 1. The card's calls there still stand. Run in the same session as 8a B6, because the report came back here. Log: `08b-B6-land.md`.*

**Lanes in flight:** none. B6 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B6 The editor (L) | `b6-editor` @ `d77565a` (four commits, founder identity), **local only**, based on `b831fd3`; `main` hasn't moved | `E:\_root\imnstr\.claude\worktrees\b6-editor` | `briefs/B6.report.md` | landed; 24 files, +3,884 / −276 (over L's ~3,000; `editor.spec.ts` alone is 1,122); lane ~83 min wall, 492k tokens, 135 tool uses |

**Commits:** `46b2628` is the bare editor on its own (deployable alone, per the founder's call); `899aa34` nothing lost; `9351c7b` its e2e; `d77565a` a toolbar selection flake.

**What the lane says** (not reviewed):
- `npm run check` clean. Vitest 10 targeted files, 230 passed (an earlier run of 15 files, 375). Playwright `editor`, `admin-entries`, `admin-auth`: 130 passed, light and dark.
- **S-9:** a body at `bodyMaxBytes` with a link on every word is a 65,550-byte request, 6% of Nginx's `1m`; pinned in `request-size.test.ts`. `imnstr.conf` untouched.
- **Bundle:** `admin.js` 17.6 KB → **87.7 KB gzipped** (284.7 KB raw), nearly all ProseMirror. E1's cold runs pay it.

**For verify to decide** (report items 4–6):
- **Rule changes to tests** (item 5): `house-rules.test.ts` and `assets.test.ts` banned `localStorage` outright (B4b); now it may be named only in `admin/browser-storage.ts`, with a key-shape test. `admin-copy.test.ts`'s "no count" regex no longer bans "left". ProseMirror's CSS rewritten with tokens and logical properties, the unreachable rules left out.
- **Beyond the card** (item 4): a "Leave without saving?" confirm on Cancel or another Edit with unsaved changes; kept text is a stack; an opened page sets unsent text aside to kept at once; the unsent buffer carries the row's `id`; a retry follows a stale `POST` answer with `PUT` (and publish); key regenerated if the language changes before a row exists; the edit-buffer offer's wording; a storage-refused variant; a sticky "dock" for tools and actions; a composition guard on bidi decorations (60 ms after `compositionend`, untested).
- **Plate 9's "after an hour idle"** against house rule 1; the title has no length cap (`readTitle`).
- **Test support changed:** `signedInAdmin` can run twice; `globalSetup.ts` now watches `shared/`, `lib/bidi.ts`, `lib/i18n.ts`.
- **Unverified:** real phone keyboards, the dock under an iOS keyboard, E1, a real clipboard prompt, screen readers, two tabs on one device.

**Next steps, in order**
1. **8c, verify B6** (Opus · high), a fresh session on this machine. Push `main` to deploy (new dependencies, no stop file). E1, the phone typing and PD-7's fallback go to V-7 (no phone yet), and the record says so.
2. **8a B7** after B6.

**Owed by the founder:** a phone (V-7, E1); F-11, F-14, F-7, F-2. Status column 8 is not this step's to change.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8a, B6 launched) · imnstr `main @ b831fd3`

*Replaces the 8c B8 block's next step 2. Its steps 3 and 4 stand. Log: `08a-B6-launch.md`.*

**Founder, at this launch:**
- **One lane, bare editor first.** The plan's "deploy the bare editor before the rest" is met inside the lane: its first commit is the editor working on its own. B6 is not split.
- **No phone yet.** E1 (AC-15's M3 runs), typing on real phone keyboards in both languages, and PD-7's fallback decision are owed to the phone check (V-7). B6's verify can deploy B6, but it can't close M3.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B6 The editor (L) | `b6-editor` from local `main @ b831fd3`, no upstream | `E:\_root\imnstr\.claude\worktrees\b6-editor` | A: `4110`, `.tmp/e2e.db` | `briefs/B6.md` (`8a34543`) | background Sonnet lane, launched; report also to `<worktree>/.tmp/B6.report.md` |

**What the card settled** (for verify to hold the lane to):
- the ProseMirror packages from §6.6 only;
- the schema imports `shared/doc.ts`'s rules, and highlight parses from `<mark>` only;
- the editor sits behind one component, so PD-7's fallback could swap it;
- bidi as `Decoration.inline` with `nodeName: 'bdi'`, and no `style` attribute (CSP);
- the publish key is made at the first keystroke; after the first answer the client works by id;
- only a tap retries;
- a 401 doesn't unmount the editor: `api()` gains an opt-out of `whenSignedOut`, and **Sign in and publish** runs `signIn()`, not `reauthenticate()`, then reruns once;
- S-9 and the bundle size are measured, not changed;
- e2e at 360 × 400 and at 180 px.

**Next steps, in order**
1. **8b, land B6** when the lane reports: in this session if it comes back here.
2. **8c, verify B6** (Opus · high). Push `main` to deploy. E1 and the phone typing go to V-7, and the record says so.
3. **8a B7** after B6, as the 8c B8 block says.

**Owed by the founder:** a phone, for V-7 and now E1 too. Also F-11, F-14, F-7 and F-2. Status column 8 stays `7/10`.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B8 verified and deployed) · imnstr `main @ b831fd3`

*Replaces the step-8b B8 block's lane table and its next step 1; its step 2 (R2 after MS3) is now V-8. The 8c B5 block's next steps 2 and 3 stand. Log: `08c-B8-verify.md`.*

**B8 is on `main` and live,** deployed by CI.
- Rebased onto `13d82dd` (one import line in `tests/unit/dates.test.ts`), then review fixes `d6da7f6`:
  - link-preview fetchers that don't say "bot" (Mastodon `http.rb`, Pleroma, Akkoma, Misskey, WhatsApp, Bluesky Cardyb, Iframely, Embedly, vkShare) are no longer views;
  - R3 drops local names (single label, `.local`, `.lan`, `.internal`, `.localhost`, `.home.arpa`);
  - AC-47's signed-in check enumerates every admin API `GET`, so B5's `settings` and `entries` reads are covered;
  - `app.ts`'s D-8 comment.
- Runs [39039416353](https://github.com/rishe-eco/i-monster/actions/runs/39039416353) (`d6da7f6`) and 39039616528 (record `b831fd3`): `check` and `deploy` green.
- Live: pages, both feeds and a 404 with the CSP, noindex and no `Set-Cookie`; a feed `304` through Nginx; root-app 200. One counted view placed: `/fa/log`, ~14:10 UTC.
- Record: `docs/development/B8.md`. Worktree and branch removed. Local `main` fast-forwarded.

**Lanes in flight:** none.

**Next steps, in order**
1. ~~F-12, F-13~~ **done the same day by the founder:** the record counts in production (en landing 3, log 1; fa log 3, landing 2), then a backup, the dry run and `reset-content --yes` (2 entries, 4 view rows). The live log and feeds are empty. The development README's owed row for running `reset-content` is now stale: the next verify strikes it.
2. **8a B6** (slot A). Its card takes S-17, the B5 lesson (e2e at 180 px), S-4/S-5 on the client, and S-9.
3. **8a B7** after B6; its verify checks S-18 (the podcast counts).
4. **V-8 after MS3's deploy:** two aggregator subscriptions, then correct R2's parser.

**Owed by the founder:** F-11, F-14 (plan changelog for B8), V-7, F-7, F-2. open-work 0.14. Status column 8: `7/10`.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8b, B8 landed) · imnstr `main @ 13d82dd`

*Replaces the step-8a B8 block's lane table and its next step 1. The card's calls there still stand. The 8c B5 block below stands as written. Run in the same session as 8a B8, because the report came back here. Log: `08b-B8-land.md`.*

**Lanes in flight:** none. B8 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B8 Reader record (M) | `b8-reader-record` @ `3b8cda2` (one commit, founder identity), **local only**, based on `aa889cb` | `E:\_root\imnstr\.claude\worktrees\b8-reader-record` | `briefs/B8.report.md` | landed; 14 files, +1,129 / −3 (under M); lane ~16 min wall, 154k tokens, 41 tool uses |

**What the lane says** (not reviewed):
- `npm run check` is clean.
- Vitest: 13 targeted files, 329 tests passed. The new `record.test.ts` has 27 tests and `record-cli.test.ts` has 10.
- No Playwright, as the card said.

**For verify to decide** (report items 4–6):
- **Rebase onto `main @ 13d82dd` first.** B5 also touched `lib/dates.ts`, `tests/unit/dates.test.ts` and `deploy/README.md`. Then rerun `dates`, the record tests and `house-rules`.
- **R2:**
  - `0 subscribers` counts nothing;
  - the unknown-aggregator fallback skips `Mozilla` and `compatible`;
  - BazQux, Miniflux and Tiny Tiny RSS have invented examples.
- **Bot pattern:** the card's list plus `scan`, `probe`, `libwww`, `httpclient`, `pingdom`.
- **The cap** applies to `record_feed` and `record_referrer` only, in one `INSERT … SELECT … ON CONFLICT`. `report` notes a month at 500 rows.
- **Referrer:** a trailing dot is stripped; a `Referer` over 8,192 characters is skipped; hex and decimal IP spellings are caught after `URL` normalises them.
- **AC-47's scan** allows the table names in `lib/record.ts`, the middleware, both CLIs, `migrations/` and `tests/`.
- **House rule 8:** both languages only. The lane says the colour scheme has no server branch.
- **The AC-46 column regex** would flag any future column with `ua` or `ip` inside a word.
- **Unverified:** that `checks.sh`'s curl goes uncounted once deployed; the CLIs in the container.

**Next steps, in order**
1. **8c, verify B8** (Opus · high), a fresh session on this machine; B5's verify is done, so nothing runs beside it. After the CI deploy:
   - open a page in a browser, then read `report` in the container;
   - `reset-content --yes` for MS2's seeds, only at the founder's word.
2. After MS3's deploy, the founder subscribes in two aggregators, and `record_feed` corrects the R2 parser (plan §5 B8, trap 1).

**Owed by the founder:** V-7 (phone); F-7; F-2. Status column 8 is not this step's to change.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8c, B5 verified and deployed) · imnstr `main @ 13d82dd`

*Replaces the step-8b B5 block's next step 1. Adds to the step-8a B8 block below, which ran beside this one; its lane table and its steps stand. Log: `08c-B5-verify.md`.*

**B5 is on `main` and live.** The first stage deployed by CI.
- Review fixes `0981ded`: the rows overflowed by 61 px at 200% zoom (180 px) and names vanished, so they now stack below `20em`. Untitled Persian rows are quoted «…». One Persian leading token. The regex holds escapes, not literal U+FFFE/U+FFFF.
- Run [39023965380](https://github.com/rishe-eco/i-monster/actions/runs/39023965380): `check` and `deploy` green. The record commit `13d82dd` deployed as run 39024319296, green.
- Live: `/admin/api/entries`, an unknown `/admin/api` path and `/admin/api/entries/x` answer 401 `UNAUTHENTICATED`, no cookie. `/`, `/fa/` and root-app answer 200. The shell names the new bundle.
- Record: `docs/development/B5.md`. Worktree and branch removed. Local `main` fast-forwarded.

**Lanes in flight:** B8, as in the block below. **B5 is now in `main`, so B8 rebases onto `13d82dd`** before its verify (shared: `lib/dates.ts`, `routes/test.ts`, maybe `lib/limits.ts`).

**Next steps, in order**
1. **8b / 8c B8**, as the block below says.
2. **F-12 (founder), before B8's `reset-content`:** sign in at `/admin`, open Entries, and check that the two MS2 seeds are listed and that Edit opens the frame.
3. **8a B6** (slot A) after B5. Its card takes S-17 (the clock-jump sign-in, `admin-support.ts`, `STATUS` stays put, Copy link and Save go in B5's frame), S-4/S-5 on the client, and S-9.

**Owed by the founder:** F-11 (plan changelog for B5; optional copy review), F-12, V-7, F-7, F-2. open-work 0.12. Status column 8: `6/10`.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8a, B8 launched) · imnstr `main @ aa889cb`

*Adds to the step-8b B5 block below; it replaces only that block's next step 2 (8a B8). Run beside the 8c B5 session, which may write its own block above or below this one. Log: `08a-B8-launch.md`.*

**Card:** `briefs/B8.md` (`ee54f61`), from build plan 0.6 §5 B8 and PD-20.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Status |
|---|---|---|---|---|
| B8 Reader record (M) | `b8-reader-record` from `aa889cb`, no upstream | `E:\_root\imnstr\.claude\worktrees\b8-reader-record` | B (`4120`, `.tmp/e2e.db`; no Playwright needed) | background Sonnet lane, running; report also to `<worktree>/.tmp/B8.report.md` |

**The card settles what PD-20 leaves open:**
- requests are classified by a path whitelist (landing, log, podcast, entry id, feed);
- the middleware sits inside the ETag middleware, so a 304 counts like its 200 (R2 would go stale otherwise);
- R2 ignores the bot pattern, keeps the month's MAX, and every user-agent format is marked a guess;
- R3 drops the own host, IP literals, non-http schemes;
- new limit `recordKeysPerMonth: 500` against hostile `Referer` and user-agent values (a plan §6.4 addition);
- the session-cookie check reads the name only;
- `reset-content` needs `--yes`, otherwise it prints row counts;
- `report --to` defaults to this month.

No stop file, no `.env` line, no migration.

**B5 is not in B8's base.** Whoever lands second rebases. The shared files are `lib/dates.ts`, `lib/limits.ts`, `package.json` and maybe `routes/test.ts`; the card says to append at the end.

**Next steps, in order**
1. **8b, land B8** when the lane reports (this session, if it comes back here).
2. **8c, verify B8** (Opus · high), after 8c B5 has pushed, rebased onto the new `main`. After the deploy: open a page in a browser, read `report` in the container, then `reset-content --yes` for MS2's seeds **at the founder's word**. After MS3's deploy, the founder subscribes in two aggregators, and `record_feed` corrects the R2 parser (plan §5 B8, trap 1).

**Owed by the founder:** V-7 (phone); F-7; F-2. Status column 8 is not this step's to change.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8b, B5 landed) · imnstr `main @ aa889cb`

*Replaces the step-8a B5 block's lane table and its next step 1. The founder's decision and the card's calls there still stand. Run in the same session as 8a, because the report came back here. Log: `08b-B5-land.md`.*

**Lanes in flight:** none. B5 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B5 Entries API, admin shell, list (M) | `b5-entries-admin` @ `e46ca71` (one commit, founder identity), **local only** | `E:\_root\imnstr\.claude\worktrees\b5-entries-admin` | `briefs/B5.report.md` | landed; 29 files, +2,634 / −33 (over M's ~1,500, under twice it); lane ~26 min wall, 336k tokens, 93 tool uses |

**What the lane says** (not reviewed):
- `npm run check` is clean.
- Vitest: 19 targeted files, 524 tests passed.
- e2e: `admin-entries.spec.ts` 54 passed over `--repeat-each=3`, after a fix to a race in its own year-turn test. `admin-auth.spec.ts` passed in the run before that fix and wasn't rerun.

**For verify to decide** (report items 4–6):
- **No `republish` route.** `publish` keeps the original date through `COALESCE`.
- **An existing `publishKey`** answers 200 with the same bytes as a new row, and writes nothing, not even `last_language`.
- **S-11:**
  - a known path with the wrong method answers `NOT_FOUND`;
  - an unknown `auth/*` path still gets the public HTML 404, signed in or out;
  - an unknown list cursor is `NOT_FOUND`.
- **Copy the lane wrote:** the empty state, three refusal messages, "Opening…". The `NOT_FOUND` message is now generic, so the passkeys screen changes too.
- **Other changes:**
  - `assets/css/tokens.css` gains `--leading-read-fa`;
  - `siteTimeZone` moved to `admin/ui.tsx`;
  - `lib/escape.ts` uses the new `stripXmlForbidden`, a public-side change; `log.spec.ts` and `entry.spec.ts` were not run.
- **`deploy/checks.sh` gains two 401 checks.** It isn't a stop file. `shellcheck` didn't run here (not installed), only `bash -n`, but CI's `check` job runs it before any deploy.
- Screenshots were looked at once, before the pill-stacking change, and not after.
- **Test note:** a clock jump over an hour ends the e2e session. Tests sign in after each jump.

**Next steps, in order**
1. **8c, verify B5** (Opus · high), a fresh session on this machine. Before the push, check the diff for stop files and `.env` lines (none expected). The push to `main` is the **first stage deployed by CI**: read the run through the API, then check the list on the live site with the MS2 seeds.
2. **8a B8** (slot B) may run beside 8c, or after it.
3. The phone check (V-7), as in the MS2 block.

**Owed by the founder:** V-7 (phone); F-7; F-2. Status column 8 stays `5/10`.

## 2026-10-17 · `lifecycle-trial/imnstr` (step 8a, B5 launched) · imnstr `main @ aa889cb`

*Replaces next step 1 of the step-8d MS2 block and next step 2 of the step-8c CD1 block (8a B5). Log: `08a-B5-launch.md`.*

**Card:** `briefs/B5.md` (`3bf1924`), from build plan 0.6 §5 B5 and design plate 8.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Status |
|---|---|---|---|---|
| B5 Entries API, admin shell, list (M) | `b5-entries-admin` from `aa889cb`, no upstream | `E:\_root\imnstr\.claude\worktrees\b5-entries-admin` | A (`4110`, `.tmp/e2e.db`) | background Sonnet lane, running; report also to `<worktree>/.tmp/B5.report.md` |

**The founder decided at launch: plate 8 wins over plan §5 B5's row actions.** Rows carry the date, the title or opening words, the pills and Edit, with "Older" below. Edit opens an edit-view frame in the editor slot: the entry read-only, Unpublish (outlined, with its confirm) or Publish again (naming the date). **B6** swaps the read-only body for the editor and adds Save and Copy link.

**The card also settles:**
- an existing `publishKey` changes nothing, and once a draft is saved the client works by id;
- every write moves `updated_at`;
- entry routes in `routes/admin-entries.ts`, inside `adminApiRoutes` (S-12), plus the catch-all `NOT_FOUND` (S-11);
- `normalizeDoc` drops empty paragraphs (S-4), and control characters are `DOC_INVALID` (S-5);
- the list is ordered by `COALESCE(first_published_at, created_at)`, pages with "Older", and carries the server's `now` for the year rule;
- a new list-date format ("2 Nov", "14 Dec 2025") in `lib/dates.ts`.

No stop file, no `.env` line, no migration.

**Next steps, in order**
1. **8b, land B5** when the lane reports (this session, if it comes back here).
2. **8c, verify B5** (Opus · high). Its push to `main` is the first stage deployed by CI.
3. **8a B8** (slot B) may run beside B5 or B6 (plan §3).
4. The phone check (V-7), as in the MS2 block.

**Owed by the founder:** V-7 (phone); F-7; F-2. Status column 8 stays `5/10`.

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8d, MS2) · imnstr `main @ aa889cb`, pushed and deployed (run 6 green)

*Adds to the step-8c CD1 block below, which ran beside this session. It replaces next step 1 of the step-8c B4b block (8d MS1/MS2). Log: `08d-MS2-milestone.md`.*

**Suites green** (counts in `docs/development/README.md`, *MS2*): `check` clean; Vitest **32 files, 599 tests**; Playwright **213 passed, 9 skipped**. The first full e2e failed 5 enrolment tests: two workers shared one server, database and clock. Fix `505be06`: `workers: 1` in `playwright.config.ts`.

**By hand:** one English and one Persian entry seeded on production by the CLI (cleared by B8's `reset-content`). Two real computers: the Windows desktop (Chrome, Google Password Manager) holds the first passkey. **It was the desktop, not a phone, at B4b**; record corrected in `aa889cb`. The Ubuntu laptop (Chrome, GPM, another Google account) was enrolled by code. Chrome's `excludeCredentials` case is done. **Not done (the founder has no phone now):** phone passkey, hybrid sign-in, S-15, camera QR, phone keyboard, and **AC-24**, which the founder deferred to the phone check (open-work 0.10, V-7).

**MS2 status:** suites done; by hand partly owed (V-7). Status column 8 stays `5/10`.

**Pushed and deployed.** The auto-mode permission check blocked the first push (as a production deploy). It went out later at the founder's word. CI run 6 was green on `aa889cb` (check, then deploy), and `/`, `/log`, `/fa/log` and `/admin` answer `200`.

**Next steps, in order**
1. As in the CD1 block: F-10, then **8a B5**.
2. **The phone check (V-7)**, when the founder has a phone. Use the steps in this session's log, *Next*.

**Owed by the founder:** V-7 (phone); F-10; F-7; F-2. **MS1's 8d** never ran on its own: MS2's suites cover its stages, and its by-hand checks were done at B2.

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8c, CD1 verified) · imnstr `main @ 60d30db`

*Replaces the step-8b CD1 block's next step 1. Adds to the 8e blocks and to any 8d block (an 8d MS2 session ran beside this one).*

**CD1 is verified, on `main` and switched on.** Record: `docs/development/CD1.md`. The review's fixes are in `faceda1`: the lock moved to `/run/imnstr-deploy.lock`; the harness stubs are executable for Linux; `shellcheck` runs in CI. The lane's "already current still builds" was accepted. The box has `imnstr-deploy` (no groups, one sudoers command with `""`, a root-owned `authorized_keys` with the forced command) and the script installed at `/usr/local/sbin/imnstr-deploy`. GitHub has the environment `production` with four secrets, and the **repository** variable `DEPLOY_ENABLED=true`. Run 4 deployed `0cbfdc1` on its own (CI-11). Worktree and branch `cd1-ci-deploy` removed.

**From now on, a push to `main` deploys.** Before a verify pushes:
- check the stage's diff for a stop file (`deploy/nginx/imnstr.conf`, `docker-compose.prod.yml`, `deploy/imnstr-deploy.sh`) or a new `.env` line;
- push `HEAD:main` from the stage worktree;
- read the run at `api.github.com/repos/rishe-eco/i-monster/actions/runs` (job logs need sign-in);
- a red run means not deployed.

**Next steps, in order**
1. ~~The founder answers F-10~~ **Done, same session:** config 0.4, checklist 0.4, build plan 0.6, brief-common 0.3, change note 0.4, open-work 0.11.
2. **8a B5** (slot A). Its verify is likely the first stage deployed by CI.
3. 8d as in its own block; its push of `main` now deploys too.

**Owed by the founder:** F-7; F-2. Status column 8 stays `5/10` (CD1 is a Change, not a plan stage).

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8b, CD1 landed) · imnstr `main @ 4c2b9b2`

*Replaces the step-8a CD1 block's lane table and its next step 1. Adds to the 8e blocks and to any 8d block.*

**Report:** `briefs/CD1.report.md`. **Branch** `cd1-ci-deploy` @ `8fd95a9` (2 commits on `4c2b9b2`, founder identity), **local only, not pushed**. Worktree kept: `E:\_root\imnstr\.claude\worktrees\cd1-ci-deploy`. +1,285 / −22 over 8 files, against the note's M estimate of ~700. **Lanes in flight:** none.

**What the lane says** (not reviewed): 50 new tests pass under Git Bash (31 text, 19 harness, ~96 s); `deploy.test.ts` 20/20; `npm run check` clean; `checks.sh 1` against the live site: 14 checks ok. **Not run:** `shellcheck` and the Linux `node:24` run, because Docker Desktop is down (`docker info` timed out).

**For verify to decide** (report item 5):
1. **"Already current" no longer skips build and up.** The lane found the note's version gives a false green after a failed build, since the checkout has already moved. It skips only the merge. Confirm, or go back to the note.
2. The text test bans `reset --hard` / unfiltered prune anywhere in the file, comments included.
3. The README's server setup (root-owned `authorized_keys`, `mktemp` sudoers file, `usermod -p '*'` fallback, the `nobody` run) is unproven on the box.
4. The workflow has never run. Its first `check` is the first Linux/UTC full suite.

**Next steps, in order**
1. **8c, verify CD1** (Opus · high), with the founder at the server: the note's *At the verify*. Before it: the GitHub environment `production`; Docker up if `shellcheck` should run locally.
2. 8a B5 (slot A) any time; 8d as in the B4b block.

**Owed by the founder:** `production` environment; F-7; F-2.

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8a, CD1 launched) · imnstr `main @ 4c2b9b2`

*Adds to the step-8e blocks below; replaces nothing. Run beside a step-8d session (milestones), which writes its own block.*

**Card:** `briefs/CD1.md` (`e3470f8`), from change note 0.3 *CD1*.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Status |
|---|---|---|---|---|
| CD1 | `cd1-ci-deploy` from `4c2b9b2`, no upstream | `E:\_root\imnstr\.claude\worktrees\cd1-ci-deploy` | B (`4120`, `.tmp/e2e.db`; no e2e server needed) | background Sonnet lane, running; report also to `<worktree>/.tmp/CD1.report.md` |

**The card settles:** actions pinned by `git ls-remote`; the harness stubs `flock` and `runuser` (Git Bash has neither) and resolves Git Bash explicitly on Windows (System32's `bash.exe` is WSL); `checks.sh` run against the live site with `PRELAUNCH=1`; Docker only if already up, and the Linux `node:24` full run only when no other heavy runner shows (8d may be running one), else CI does it at the verify.

**Next steps, in order**
1. **8b, land CD1** when the lane reports (this session, if it comes back here).
2. **8c, verify CD1** (Opus · high), with the founder at the server: the note's *At the verify* list. The `production` environment must exist first (CD-0).
3. 8a B5 (slot A) can start beside the CD1 lane; 8d MS1/MS2 as in the B4b block.

**Owed by the founder:** the GitHub environment `production` (before CD1's verify); F-7; F-2.

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8e, amended: CD-0 answers) · imnstr `main @ 4c2b9b2`

*Adds to the step-8c B4b block below and amends the step-8e block (10-14). The 8e block's CD1 plan stands, as amended by change note **0.2**. Same 8e session, continued after the founder pasted the CD-0 output.*

**CD-0, answered:** SSH is open to all on 22 (`ufw`: 22/80/443 from anywhere, IPv4 and IPv6), key-only (`passwordauthentication no`), with no `AllowUsers` or `AllowGroups`. GitHub's hosted runners can connect, and `sshd` needs no change. **Root-app's URL:** `https://m-root.com/`, which answers 200 (note 0.3). **Still open:** the GitHub environment `production` (note, CD-0).

**Note 0.2, brought up to `main @ 4c2b9b2`:**
- B4b was deployed by hand, so it is **not** the first CI deploy; likely B5 is. B4b's shell and bundle checks join CI-8.
- CI runs `npm run build`. The lockfile trap is retired: the VPS built Vite on Linux at B4b.
- The next `imnstr.conf` change (S-14) will stop a CI deploy with exit 2.
- The founder's sudo user on the box is `deploy`; CI's is `imnstr-deploy`, a separate account.

**Next steps** are unchanged from the B4b block: 8d MS1/MS2; **8a B5** (slot A) and/or **8a CD1** (slot B, from note 0.2's CD1 section).

**Owed by the founder:** the `production` environment, before CD1's verify; F-7; F-2.

## 2026-10-15 · `lifecycle-trial/imnstr` (step 8c, B4b verified and deployed) · imnstr `main @ 4c2b9b2`

*Replaces the step-8b B4b block: its lane table, its next step 1 and its "for verify to decide" list are settled in `docs/development/B4b.md`. Adds to the step-8e block, which still stands: CD1 and CD-0 as written there. Run as 8c at medium effort, at the founder's word: the opening prompt said "step 8a, review B4b" (log `08c-B4b-verify.md`, Session).*

**Code repo:** `rishe-eco/i-monster` `main @ 4c2b9b2`, pushed and deployed. The worktree and branch `b4b-auth-screens` are removed. **Lanes in flight:** none. Status column 8: `5/10`.

**Review fixes** (`7676c6c`): the passkey-name rule now lives in one file (`lib/passkey-name.ts`). Removing the passkey that opened the session, when it isn't this device's own, goes to sign-in, not "can't sign in any more". Sign-out keeps the shell unless the server confirmed it. Two new e2e tests.

**Deployed 2026-10-14 22:43 UTC:** the shell, bundle, API and public headers all as expected (record, *Verification*). The VPS built both stages with 1,209 MiB still available. **The founder's phone holds the first real passkey:** set up from a real token, then signed out and back in.

**Next steps, in order**
1. **8d MS1** any time; **MS2** is reachable now: the laptop by enrolment code with the QR, a hybrid sign-in, AC-24 (V-7, S-15).
2. **8a B5** (slot A, Opus · medium), and/or **8a CD1** (slot B) per the 8e block.

**Carry-overs**
- **This machine's `C:` drive has 0 GB free.** Docker Desktop's disk goes read-only when it grows: that's what broke the lane's image check. Free space before any Docker work.
- **B6 reuses `withReauth` / `ReauthHost`** from `admin/reauth.tsx`. B5 fills the empty editor, Entries and Podcast slots in `admin/app.tsx` (W1 order), and owes S-11 and S-12.
- Signed-out visits log one 401 in the console (`GET session`, by design). The e2e filters 4xx load lines only.

**Owed by the founder:** CD-0; F-7 (off-box backups); F-2 (content). Open-work 0.8.

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8b, B4b landed)

*Replaces the lane table and next step 1 of the step-8a B4b block. Its card calls and "what the verify deploys" still stand. Adds to the step-8e block, which it doesn't replace: CD1 and CD-0 stand as written there. Run in the same session as 8a, because the report came back here.*

**Lanes in flight:** none. B4b has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B4b Auth screens (M) | `b4b-auth-screens` @ `8cb1e99` (`8e0e524`, `fafa366`, `8cb1e99`), **local only** | `E:\_root\imnstr\.claude\worktrees\b4b-auth-screens` | `briefs/B4b.report.md` | landed; 40 files, +2,617 / −63 (over M's ~1,500, under L's); lane ~29 min wall, 341k tokens, 116 tool uses |

**Next steps, in order**
1. **8c, verify B4b** (Opus · high), a fresh session on this machine. Review checklist §4, §5 and §6. The card's image check was **not done**: see below. Then deploy with the founder, the first real setup token and phone passkey.
2. CD1 as in the 8e block, beside it. **8d MS1** any time; MS2 after B4b's verify.

**For verify to decide** (report items 4 to 6):
- **The image was never built.** Docker Desktop's VM disk went read-only (`meta.db: read-only file system`; `docker run` fails too). Both stages' `npm ci` ran first. The lane didn't restart Docker Desktop. Restarting it is the founder's call, or the verify builds the image after a restart. Vite's Linux binding in `node:24-slim` is unproven.
- **The VPS builds the image** (B2; and CD1's deploy). There's 1.2 GiB free and no swap, and the build stage now runs `npm ci` with dev deps plus `vite build`. Check that the box can do it.
- **CD1's check job** runs "build if present". B4b adds `npm run build` and `check` now also runs `tsc -p admin`.
- **A 401 console error on every signed-out visit:** the bundle probes `GET session`, which answers 401 by design (B4a). The e2e filters 4xx "failed to load" lines only. A `200 {signedIn:false}` would change `admin-api.ts`.
- **The bundle has no wall clock.** The code's 10 min, "Copied" and a new `signInPauseMs` (5 s after 3 failures) are timers from `limits.ts`. The ban on `Date.now()` holds everywhere.
- **No poll on the enrol panel,** because a poll would be a heartbeat. Plate 12's "waiting…" row isn't built.
- **Remove's button says "Remove",** not the design's "Sign in again and remove".
- **The name rule is duplicated** in `admin/passkey.ts` (checked before the ceremony); the server still decides.
- **Default name** `phone` / `tablet` / `computer` from the UA; "laptop" can't be detected.
- **`formatAdminDay` in `lib/dates.ts`,** with `define process.env = {}` in Vite; the zone comes from a `<meta>` in the shell.
- **The setup view picks enrolment code or token by shape.** The address becomes `/admin` after success.
- **`preact` is bundled** but listed as a runtime dependency (plan §6.6).
- **Not verified:** the image; real providers and their `excludeCredentials` wording; a real phone and keyboard; dark contrast.

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8e, spec change: CI deploy) · imnstr `main @ d29166b`

*Adds to the step-8a B4b block below; replaces nothing. B4b's lane, card calls and next steps 1–3 stand. Run as `spec change`, as the founder asked: the trial table has no row for a mid-build Change (log `08e-ci-deploy-change.md`, Spec gaps).*

**Change note:** `changes/04-ci-deploy.md` 0.1. A push to `main` on `rishe-eco/i-monster` runs check (`npm ci --ignore-scripts`, `npm run check`, build if present, Vitest), then deploys over SSH. The deploy user is forced-command-locked to `/usr/local/sbin/imnstr-deploy` and has one sudoers line with no arguments. The image builds on the VPS. Stop files (exit 2, nothing changed): `imnstr.conf` against the live copy, `docker-compose.prod.yml`, the installed script. A failed health check or `deploy/checks.sh` check exits 1 and doesn't roll back. Switched on by the repo variable `DEPLOY_ENABLED`. One stage, **CD1 (M)**.

**Founder decided:** no automatic rollback; compose is a stop file; checks split (the root script is fixed, the `curl` checks live in the repo and run as `nobody`). SSH reachability is not known yet: **CD-0**, founder pre-flight before CD1's verify.

**Lanes in flight:** B4b only (slot A), unchanged. CD1 is not launched.

**Next steps, in order** (B4b's 1–3 above still stand; CD1 can run beside them)
1. **8a CD1** (Opus · medium): `build-phase changes/04-ci-deploy.md#CD1`. Branch `cd1-ci-deploy`, **slot B** (`4120`), beside B4b. The card is drawn from the note's CD1 section, not plan §5.
2. **Founder, CD-0,** before CD1's verify: `ufw` and `sshd -T` output, `AllowUsers`, root-app's own URL; the GitHub environment `production`.
3. **8b, then 8c CD1** (Opus · high), with the founder at the box, following the note's *At the verify* steps 1–8.

**Carry-overs**
- **From `DEPLOY_ENABLED=true` on, a verify's push to `main` is the deploy.** Check for stop files, a new `.env` line or one-off server steps before pushing. Watch the run (public Actions page) and paste its URL into the record. A red run means not deployed (note, CD1 *Traps*).
- **B4b may be the first stage deployed this way,** if CD1 verifies first. Its `/admin` and bundle checks then go into `deploy/checks.sh`. Its `setup-token` step stays by hand.
- **Owed at CD1's verify (founder, as F-items):** what goes stale in config §7, review checklist §6, plan B2 and §7, and `brief-common` (note, last section). The status cell isn't touched: col 8 stays `4/10`, and whether CD1 counts in the total is the verify's call.

**Owed by the founder:** CD-0; F-7 (off-box backups); F-2 (content).

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8a, B4b launched) · imnstr `main @ d29166b`

*Replaces next step 1 of the step-8c B4a block. Its carry-overs, the owed founder items and step 2 (8d MS1) still stand. Run as 8a: the opening prompt said "step 8a, review B4b", but B4b had no card yet, so this session launched it.*

**Code repo:** `rishe-eco/i-monster` `main @ d29166b`. **Lanes in flight:** one.

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B4b Auth screens (M) | `b4b-auth-screens`, from `d29166b`, local, no upstream | `E:\_root\imnstr\.claude\worktrees\b4b-auth-screens` | A: `4110`, `.tmp/e2e.db` | `briefs/B4b.md` (`01b8233`) | running, background Sonnet lane; report to `<worktree>/.tmp/B4b.report.md` and its final message |

**Card calls the plan didn't make** (for verify to rule on, against plan §5 B4b and PD-21):
- **A build step, for the admin only.** `vite build` writes one fixed-name `admin.js` and `admin.css` to `dist/admin/`. `lib/assets.ts` hashes them like every other asset, so there is one scheme. Production boot refuses a missing bundle. Pages still render with no build (PD-4).
- **The Dockerfile becomes two stages:** build, then the current runtime stage copying `dist/admin`. The lane builds and runs the image once, since Docker Desktop is up. The routine deploy stays three lines.
- **Deps:** `preact` and `@simplewebauthn/browser` in dependencies, `vite` in dev, no `@preact/preset-vite`. `admin/` gets its own JSX setting (root tsconfig is `hono/jsx`).
- **Routes:** `routes/admin.tsx` serves one shell for `/admin` and `/admin/setup/:code`. The W1 sections B5–B7 fill are empty slots that render nothing.
- **Copy** in `admin/copy.ts`, keyed by refusal code. The code's 10 min is stated with no countdown, then "Expired. Make a new code." by the clock.
- **Re-authentication** is one dialog, run on `REAUTH_REQUIRED`, which retries the action once (for B6).
- **No change to `routes/admin-api.ts`'s behaviour.** If one is needed, the lane stops and says so.

**What the verify deploys:** an image rebuild (two stages), no conf change. `curl -I` on `/admin` and `/admin/setup/x` gives 200, CSP, `no-store` and no `Set-Cookie`; the bundle's hashed URL gives 200, immutable; the public headers are unchanged. Then the founder runs `setup-token` in the container and registers the real phone, the first real passkey (V-7 starts).

**Next steps, in order**
1. **8b, land B4b** (Opus · medium) when the lane reports, in this session if it comes back here.
2. **8c, verify B4b** (Opus · high), fresh, with review checklist §4, §5 and §6; the founder at the server and on the phone.
3. **8d MS1** any time; MS2 (B3, B4a, B4b) after B4b's verify.

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8c, B4a verified and deployed) · imnstr `main @ d29166b`

*Replaces the 8b B4a block's lanes and next steps. Its "for verify to decide" list is answered in `docs/development/B4a.md` (*Decided*). Run as 8c: the opening prompt said "step 8a, review B4a", and this block's predecessor named 8c verify B4a as next.*

**Lanes in flight:** none. The `b4a-auth-server` worktree and branch are gone; B4a is on `main` (`43cc2b3`, `2433e91`, review `39d363e`, `19c6202`; record `d29166b`).

**Live:** the admin API at `https://imnstr.com/admin/api`, with no screens. The image was rebuilt from `19c6202`, with no conf change. Pasted checks: `session` 401; foreign-Origin POST 403; own-Origin POST 200 with `rpId` `imnstr.com` and `timeout` 300000; `/__test/auth` 404; public headers unchanged, with no `Set-Cookie`. No setup token has been issued in production.

**Review fixed:** enrolling by code now ends the session the request arrived with; the ceremony timeout is 5 min, not the library's 60 s; the `auth/` prefix is pinned to its seven ceremonies, with 401 proven for the four that check a session; a correct-Origin deploy check.

**Founder decided:** F-9 accepted: build plan **0.5** (§5 B4a, §6.1, §6.2). Fast-forward, push and deploy now. Status col 8 `4/10`; open-work 0.7.

**Next steps, in order**
1. **8a B4b** (slot A), from build plan 0.5. The card carries S-13: `@simplewebauthn/browser`, the `/admin/setup/<code>` page, and the `excludeCredentials` refusal wording. B4b's verify issues the first real setup token, and MS2's real passkeys (V-7) follow.
2. **8d MS1** (full suites, one runner at a time), any time.

**Carry-overs:** server commands as before (a sudo user; one per line; plain `text` fences, since the founder couldn't see this session's first set until it was re-sent in a plain reply). Later routers go inside `adminApiRoutes`, never under `auth/` (S-12). Start Docker Desktop before a review that builds the image.

**Owed by the founder:** F-7 (off-box backups), F-2 (content).

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8b, B4a landed)

*Replaces the lane table and next step 1 of the step-8a B4a block. Its card calls and "what the verify deploys" still stand. Run in the same session as 8a, because the report came back here.*

**Lanes in flight:** none. B4a has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B4a Passkeys and sessions, server (L) | `b4a-auth-server` @ `2433e91` (`43cc2b3`, `2433e91`), **local only** | `E:\_root\imnstr\.claude\worktrees\b4a-auth-server` | `briefs/B4a.report.md` | landed; 29 files, +3,875 / −5 (over L's ~3,000, under budget); lane ~23 min, 277k tokens, 92 tool uses |

**Next steps, in order**
1. **8c, verify B4a** (Opus · high), a fresh session on this machine. Review checklist §4 line by line. Then deploy with the founder at the server: an image rebuild only (the lane kept the Nginx zone), and the card's `curl` checks.
2. **8a B4b** after B4a is verified. **8d MS1** any time.

**For verify to decide** (report items 4 and 5):
- **`__Host-` works on Edge over `http://localhost`.** The cookie is the same in every environment, so there's no development exception and no "production keeps it" test.
- **Three refusal codes are not in plan §6.2:** `REGISTRATION_FAILED`, `REQUEST_INVALID` (a name over 60 characters or with control characters), and `NAME_REQUIRED` reused from B7's list.
- **`auth/reauth/*`, `auth/register/*` (from a session) and `auth/signout`** check the session and CSRF themselves, inside the unguarded `auth/` prefix. Is the 401 enumeration still complete with them outside it?
- **The guard is one `use('*')`,** so an unregistered `/admin/api` path answers 401. Signed in, it gets the public HTML 404, not JSON `NOT_FOUND` (B5's to settle).
- **Issuing an enrolment code voids earlier unused ones,** and issuing any code sweeps used and expired rows. A used code then reads as unknown, with the same refusal.
- **Back-off:** a request inside the wait is refused unchecked and doesn't extend it. Reauth failures count.
- **Algorithms pinned** to ES256, RS256 and EdDSA. One user handle is kept in `setting.webauthn_user_handle`.
- **Delete order:** `REAUTH_REQUIRED`, then `NOT_FOUND`, then `LAST_PASSKEY`.
- **S-8:** zone kept at `30r/m burst=10`, so no conf change; `deploy.test.ts` pins it as a floor.
- **Not verified:** timing equality of `redeemCode` (by reading only); `npm run setup-token` inside the container; real providers (MS2).

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8a, B4a launched) · imnstr `main @ 76727e4`

*Replaces next step 2 of the step-8c B2 block. Its carry-overs, the owed founder items and step 3 (8d MS1) still stand.*

**Code repo:** `rishe-eco/i-monster` `main @ 76727e4`. **Lanes in flight:** one.

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B4a Passkeys and sessions, server (L) | `b4a-auth-server`, from `76727e4`, local | `E:\_root\imnstr\.claude\worktrees\b4a-auth-server` | A: `4110`, `.tmp/e2e.db` | `briefs/B4a.md` (`3df044f`) | running, background Sonnet lane; report to `<worktree>/.tmp/B4a.report.md` and its final message |

**Card calls the plan didn't make** (for verify to rule on, against plan §5 B4a):
- `ORIGIN` is a new env variable. It defaults to `https://imnstr.com` in production and `http://localhost:<PORT>` otherwise, and the RP ID comes from its hostname, so the server's `.env` needs no new line.
- `GET /admin/api/session` answers 401 when signed out. The plan says it reports "signed in or not"; a 401 keeps the AC-8 enumeration free of exceptions. Signed in, it also carries `independenceNoteDismissed` (AC-24).
- Routes go in `routes/admin-api.ts`. The software authenticator goes in `tests/`, not `test/` as the plan wrote.
- `@simplewebauthn/browser` waits for B4b; the e2e drives Edge's virtual authenticator on a bare page.
- S-8: the lane keeps or retunes `imnstr_auth` and says why.

**What the verify deploys:** image rebuild and restart, plus the conf only if S-8 changed it. Then `curl` checks: `/admin/api/session` 401, a foreign-Origin POST 403, `/__test/auth` 404, public headers unchanged. No setup token is issued in production until B4b.

**Next steps, in order**
1. **8b, land B4a** (Opus · medium) when the lane reports, in this session if it comes back here.
2. **8c, verify B4a** (Opus · high), fresh, with review checklist §4 line by line; the founder at the server for the deploy.
3. **8a B4b** after B4a lands. **8d MS1** any time.

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8c, B2 verified and deployed) · imnstr `main @ 10db886`

*Replaces the 8b B2 block's lanes and next steps. Its "for verify to decide" list is answered in `docs/development/B2.md`. The session ran 10-11 (review) and 10-14 (server).*

**Lanes in flight:** none. The `b2-deploy` worktree is gone; B2 is on `main`.

**Live:** `https://imnstr.com` (noindex). Compose project `imnstr` on `127.0.0.1:4100`, `/srv/imnstr` cloned from **`rishe-eco/i-monster`** (repo moved, history rewritten 10-14: B2 is `ddfb8af` + `ed83c99`). Nginx: a **copy** at `/etc/nginx/sites-available/imnstr`; certificate by `certbot certonly` with a reload deploy hook; `/etc/cron.d/imnstr-backup`, local only. root-app `main @ 46eeabf` carries the one co-tenant paragraph (plan §7).

**Review fixed:** backup sidecars (`-wal`/`-shm`); `http2` removed (per-socket in nginx 1.18, it would have reached every tenant); symlink → copy; deploy hook; README for a sudo user, one command per line.

**MS1's acceptance holds** (live, headers by `curl -I`, one restore). Status col 8 `3/10`.

**Next steps, in order**
1. ~~Founder: F-8~~ **done:** accepted and applied: build plan 0.4, review checklist 0.3, config 0.3, `CLAUDE.md`.
2. **8a B4a** (slot A). The card must say what its verify deploys, and write server commands for a sudo user. S-8 (tune `imnstr_auth`) is B4a's.
3. **8d MS1** (full suites, one runner at a time), any time.

**Carry-overs:** commands for the founder at the server: `sudo` on each line, `| sudo tee` for root-owned files, one command per line, no shell-tagged fences. Check `git config --local user.email` in every rishe-eco repo before committing.

**Owed by the founder:** F-7, off-box backups (`BACKUP_REMOTE` + ssh key), deferred at their word; daily local copies run, cron exits 1 until then. F-2 content.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8b, B2 landed)

*Replaces the lane table and next step 1 of the step-8a B2 block. Its card calls, founder's answers and the owed item still stand. Run in the same session as 8a, because the report came back here.*

**Lanes in flight:** none. B2 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B2 Deploy (S) | `b2-deploy` @ `7010775` (one commit), **local only** | `E:\_root\imnstr\.claude\worktrees\b2-deploy` | `briefs/B2.report.md` | landed; 13 files, +470 / −34; lane ~4 min, 90.5k tokens, 20 tool uses |

**Next steps, in order**
1. **8c, verify B2** (Opus · high), a fresh session on this machine, with the founder at the server. The branch is only in `E:\_root\imnstr`. Start Docker Desktop first, and build and run the image locally (report item 6) before anything touches the VPS. Then do the first deploy and MS1's checks: `nginx -t`, `curl -I` (V-1), root-app answering, `certbot renew --dry-run`, one restore. Last, root-app's README line (plan §7).
2. **8a for B4a** (slot A), once B2 is verified or at least landed (plan §3).

**For verify to decide** (report items 4 and 5):
- **The image was never built:** Docker Desktop wasn't running. `nginx -t` and `backup.sh` haven't run either. Linux prebuild `linux-x64.node` (glibc) confirmed in the package.
- **`sites-enabled/imnstr` links into the repo** (`/srv/imnstr/deploy/nginx/…`), instead of a copy in `sites-available` as plan §7 and config §7 say. The founder may prefer copies.
- **Numbers the card left open:**
  - zone `imnstr_auth:1m rate=30r/m`, `burst=10 nodelay`, 429 on refusal (B4a may tune them);
  - TLS session cache `imnstr_tls`;
  - `client_max_body_size 1m` (B5 and B7 may need more).
- **`backup.ts` opens the source through `openDb`,** so it runs pending migrations on the live database. It refuses an existing destination and checks the copy read-only. `npm run backup` added.
- **`backup.sh` keeps the local copy and exits 1** when `BACKUP_REMOTE` is unset. The cron line goes in `/etc/cron.d/imnstr-backup`, which sets `BACKUP_REMOTE`.
- **The unit test strips comment lines** before asserting. It also covers the bootstrap conf, the `http2` spelling, the Dockerfile, `package.json` and `.dockerignore`.
- **The README clones over `https://github.com/rishe-eco/imnstr`.** Confirm.
- **`package-lock.json`** changes only by `tsx`'s move and the dev flags. Check it isn't the stripped-`dev` noise brief-common warns about.

**Owed by the founder:** `BACKUP_REMOTE`, and an ssh key from the VPS to that host, before B2's verify.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8a, B2 launched)

*Replaces next steps 1 and 3 and the founder question of the step-8c B3 block; its carry-overs still stand. P0-2 and P0-3 are done, and P0-4 is answered, so B2 goes before B4a.*

**Code repo:** `rishe-eco/imnstr` `main @ 95d3311`. **Lanes in flight:** one.

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B2 Deploy (S) | `b2-deploy`, from `95d3311`, local | `E:\_root\imnstr\.claude\worktrees\b2-deploy` | B: `4120`, `.tmp/e2e.db` | `briefs/B2.md` (`7127642`) | running, background Sonnet lane; report to `<worktree>/.tmp/B2.report.md` and its final message |

**Founder's answers (2026-10-11):**
- P0-2 done: DNS for `imnstr.com` and `www` points at the VPS.
- P0-3 done: the output is in the card, under *The server*. Ubuntu 22.04, nginx 1.18.0, certbot 1.21.0, Docker 29.6.1, Compose v5.3.1. 1.2 GiB available and no swap. No `default_server` on the box. root-app runs `main @ 6179274`.
- P0-4: another host, over rsync/ssh. Its address is not named yet; `backup.sh` reads it from `BACKUP_REMOTE`.

**Card calls the plan didn't make** (for verify to rule on, against plan §5 B2):
- There is no toolchain and no build stage. The image runs `npm ci --omit=dev --ignore-scripts`, and `tsx` moves to `dependencies`, since the server runs through it.
- certbot runs `certonly` against a bootstrap port-80 conf, so it never edits `imnstr.conf`.
- `scripts/backup.ts` is new (plan §5 B2 assumed a `backup` CLI). There is a second volume for `/backups`. Compose has `mem_limit: 256m` and `restart: unless-stopped`.
- The lane may build the image locally if Docker Desktop is running; it wasn't when the card was written.

**Next steps, in order**
1. **8b, land B2** when the lane reports (Opus · medium), in this session if it comes back here.
2. **8c, verify B2** (Opus · high), fresh, with the founder at the server. That covers the first deploy, V-1 (`curl -I`), `nginx -t`, root-app answering, `certbot renew --dry-run`, one restore, and root-app's README line (plan §7, founder's go-ahead). Those make MS1.
3. **8a for B4a** (slot A), after B2 lands (plan §3: no B2 + B4a pair).

**Owed by the founder:** `BACKUP_REMOTE` (user, host, path), and an ssh key from the VPS to that host, before B2's verify.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8c, B3 verified and merged)

*Replaces the lane table, next steps and "For verify to decide" of the step-8b B3 block; each call there is ruled on in the stage record. The step-8c B1 carry-overs still stand, except S-2, which is done, and the `npm install` line, which is now `npm install --ignore-scripts` (brief-common 0.2).*

**Code repo:** `rishe-eco/imnstr`, **`main @ 95d3311`, pushed.** B3 was fast-forwarded at the founder's word. The `b3-public-log` worktree is removed, and the branch remains locally, merged. **Lanes in flight:** none.

| Stage | Commits on `main` | Record | Status |
|---|---|---|---|
| B3 Public log and feed (L) | lane `ae521b1`, `83d8ce6`; review `b9e5e8a`; record `f830534`; founder's answers `95d3311` | `docs/development/B3.md` | **verified and merged.** check clean, Vitest 349/349, e2e 174/174 (log, entry, landing, 404); W3C Feed Validator: both feeds valid |

**The review fixed:**
- `C++`, `C#` and `.NET` were split in Persian, so `C++` was drawn `++C`.
- One pasted control character (U+000B) made the whole feed malformed.
- The owner line used a hand-written `<bdi>`.
- `CLAUDE.md` now says `npm install --ignore-scripts`. better-sqlite3's `binding.gyp` makes npm call `node-gyp`, and its prebuilt binaries need no compiling.

**Founder's answers (2026-10-11):**
- Merge B3: done.
- F-5: done, as brief-common **0.2** and config **0.2** (`--ignore-scripts` in setup, the milestone script and the image).
- F-6: done, as build plan **0.3** (§5 B3, §6.1, PD-7, PD-8).

**Next steps, in order**
1. **If P0-2 (DNS) and P0-3 (VPS facts) are done: 8a for B2** (Opus · medium), slot B. It is S, and it closes MS1. Its card must cover S-6 (`npm ci --ignore-scripts` in the image) and V-1.
2. **8a for B4a** (Opus · medium), slot A. It depends only on B1. It runs after B2, not beside it: plan §3 lists no B2 + B4a pair. If P0-2 or P0-3 is still open, B4a goes first, and B2 waits for it to land.
3. Founder, in parallel: P0-2, P0-3, P0-4, P0-6.

**Carry-overs for the next cards**
- **Every UI card:** e2e at 360 and 180 px (`expectNoSidewaysScroll`). Routes in `routes/<area>.ts`, with one line in `app.ts`.
- **B4a:** S-1 (the 401 test enumerating the router). Review checklist §4, line by line.
- **B2:** S-6, V-1.
- **B5 and B6:** S-4 (empty paragraphs), S-5 (control characters), and `docHasText` for `BODY_REQUIRED`.
- A lane's report must reach a committed file or the launching session (`.tmp/<stage>.report.md` in the worktree, as at B3).

**Questions for the founder:** are P0-2 and P0-3 done? That decides whether B2 or B4a is next.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8b, B3 landed)

*Replaces the lane table and next step 1 of the step-8a B3 block; its card calls and the 8c carry-overs still stand. Run in the same session as 8a, because the report came back there.*

**Lanes in flight:** none. B3 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B3 Public log and feed (L) | `b3-public-log` @ `83d8ce6` (`ae521b1`, `83d8ce6`), **local only** | `E:\_root\imnstr\.claude\worktrees3-public-log` | `briefs/B3.report.md` | landed; 38 files, +2,303 / −20; lane ~28 min, 275k tokens, 92 tool uses |

**Next steps, in order**
1. **8c, verify B3** (Opus · high), a fresh session on this machine. The branch is only in `E:\_root\imnstr`. Run the W3C Feed Validator by paste on both feeds (plan §8).
2. **8a for B2** when P0-2 and P0-3 are done (slot B).

**For verify to decide** (report items 4 and 5):
- **`npm install` fails** on this machine (node-gyp, no Windows SDK); the lane used `npm install --ignore-scripts`, relying on better-sqlite3's prebuilt binary. Owed to `CLAUDE.md` and `brief-common.md`.
- **`latinName` removed** from `SiteContent`; `isolate` finds Latin runs itself, and the unit test that asserted it went too. The 404's owner line is still not routed through `lib/bidi.ts`.
- **Doc schema:** paragraphs need at least one non-empty text node; `docHasText` exported for B5.
- **Order** `first_published_at DESC, id ASC`; a cursor must be a published entry of the same language, else 404.
- **Bidi rules** as in report item 4 (URLs `<bdi dir="ltr">`, Latin runs in Persian `<bdi lang="en">`, Persian runs in English `<bdi lang="fa" dir="rtl">`, per text node).
- **Feed:** empty feed `<updated>` is `now()`; new `formatFeedTitleDate` for untitled titles (date without time); well-formedness by a hand-written checker in `tests/helpers.ts`.
- **Untitled entry page** has a visually hidden `<h1>` holding its date.
- **New files beyond plan and card:** `lib/escape.ts`, `views/fill.tsx`; B1's `pages.test.ts` lost `/log/feed.xml` from its unknown-paths list.
- **New Persian strings** are the lane's placeholders (V-4, F-2).
- **Not rerun after the last CSS edit:** `switch`, `i18n`, `boot`, `db` tests; dark contrast of new elements unchecked.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8a, B3 launched)

*Adds to the step-8c block below and replaces only its next step 1. Its carry-overs still stand; the B3 card applies all of those that are B3's (180 px, `app.ts`, S-2, `npm install`, plan 0.2).*

**Code repo:** `rishe-eco/imnstr`, `main @ 7ebc220`, unchanged.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B3 Public log and feed (L) | `b3-public-log` from `main @ 7ebc220`, **local only** | `E:\_root\imnstr\.claude\worktrees3-public-log` (made by hand with `git worktree add`) | A: port `4110`, `.tmp/e2e.db` | `briefs/B3.md` (`403fdf0`) | running, background Sonnet lane launched from this session |

**Next steps, in order**
1. **8b, land B3**, in this same session when the lane reports (the report comes back only here). If the session has ended first, the lane also writes its report to `<worktree>/.tmp/B3.report.md`, uncommitted: 8b copies it from there to `briefs/B3.report.md`. If neither exists, check `b3-public-log` for commits and relaunch from the card with "continue from the branch".
2. **8c, verify B3** (Opus · high), fresh session, on this machine. It runs the W3C Feed Validator by paste (plan §8).
3. **8a for B2** when P0-2 and P0-3 are done, in slot B. **8a for B4a** may run beside B3 only after B2 is in (plan §3).

**Card calls verify should know about** (beyond plan §5 B3): seeding goes through one `insertPublished()` shared by the CLI (`scripts/seed-entry.ts`) and new test-only routes `POST`/`DELETE /__test/entries`; `shared/doc.ts` imports nothing from `lib/`; the feed is built by hand, with no XML dependency; the lane reads root-sot from `E:\_root
oot-sot-imnstr`.

**Questions for the founder:** none.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8c, B1 verified and merged)

*Replaces the lane table, next steps and "For verify to decide" of the step-8b block; each call there is ruled on in the stage record. The step-8a and 7b carry-overs still stand, with three changes: `root-sot/imnstr/open-work.md` now exists, P0-5 is confirmed, and the B1 worktree is gone.*

**Code repo:** `rishe-eco/imnstr`, **`main @ 7ebc220`, pushed.** B1 was fast-forwarded at the founder's word. The `b1-foundation` worktree is removed, and the branch remains locally, merged. **Lanes in flight:** none.

| Stage | Commits on `main` | Record | Status |
|---|---|---|---|
| B1 Foundation (L) | lane `bc745c5`; review `e49a27c`; record `8b52ea7`; founder's answers `7ebc220` | `docs/development/B1.md` | **verified and merged.** check clean, Vitest 220/220, e2e 68/68 |

**Founder's answers (2026-10-11):**
- Merge B1: done.
- P0-5: `Asia/Tehran` confirmed.
- HSTS: no `includeSubDomains` and no preload, for now.
- Plan changelog: done, as build plan **0.2** and review checklist **0.2**.

In `open-work.md`, F-1, F-3 and F-4 are closed and F-2 (content) stays open.

**Next steps, in order**
1. **8a for B3** (Opus · medium), public log and feed. It needs only B1 on `main`, so it can start now. It runs in slot A.
2. **8a for B2** when P0-2 (DNS) and P0-3 (VPS facts) are done. It can run beside B3, in slot B.
3. Founder, in parallel: P0-2, P0-3, P0-4, P0-6.

**Carry-overs for the next cards**
- **Every UI card requires e2e at 360 px and at 180 px** (200% zoom): `expectNoSidewaysScroll(page, 180)` in `tests/e2e/support.ts`. It waits for fonts.
- Routes mount in `routes/<area>.ts`, with one line in `app.ts` (plan 0.2 §3).
- Owed to stages:
  - **S-2** (B3): bidi in the Persian placeholder copy.
  - **S-1** (B4a): the 401 enumeration test.
  - **S-3** (B7): draft → link → publish, and the episode date.
  - **V-1** (B2): headers through Nginx.
  - **V-2** (B9): dark contrast.
- A fresh lane worktree needs `npm install`. The main checkout has no `node_modules`.
- The lane's report must reach a committed file or the launching session (8b lesson, urgent).

**Questions for the founder:** none open from 8c.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 8b, B1 landed)

*Replaces the lane table and item 1 of the step-8a block; its carry-overs still stand. Run in the same session as 8a, because the report came back only there (8a log, Spec gaps).*

**Lanes in flight:** none. B1 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B1 Foundation (L) | `b1-foundation` @ `bc745c5`, **local only, not pushed** | `E:\_root\imnstr\.claude\worktrees1-foundation` | `briefs/B1.report.md` | landed; 79 files, +7,612 lines (2,994 of them `package-lock.json`) |

**Next steps, in order**
1. **8c, verify B1** (Opus · high), a fresh session on this machine. The branch exists only here, in `E:\_root\imnstr`.
2. Founder, in parallel: P0-2 to P0-5 (B2 needs P0-2 and P0-3).

**For verify to decide** (the lane's calls, report item 4):
- **Fonts:** the Arabic subsets lack «», the space, punctuation and Latin digits. The lane went on without stopping, and ships the Arabic and Latin subsets of Estedad and Vazirmatn. PD-26 says "Arabic subsets" only.
- An extra trigger refuses inserting an already-published episode. B7 must create the draft, add a link, then publish.
- Schema beyond §6.3: `auth_throttle` holds one row; `episode.date` is not null with a format CHECK; episode columns are read from "like `entry`".
- `SITE_ORIGIN` is a constant, not an environment variable; `/fa` redirects to `/fa/` with 308; HSTS has no `includeSubDomains`; `CLOCK_INVALID` is test-only.
- Owed to later stages (report item 5): B4a creates the 401 enumeration test; B3 does bidi in the Persian placeholder copy; `.gitattributes` for line endings.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 8a, B1 launched)

*Adds to the blocks below and replaces none. Item 2 of the step-7b block is done; the founder did P0-1.*

**Code repo:** `rishe-eco/imnstr`, `main @ 6e5a915` (a one-line `README.md`), cloned by this session to `E:\_root\imnstr`.

**Lanes in flight**

| Stage | Branch | Worktree | Slot · port · database | Card | Status |
|---|---|---|---|---|---|
| B1 Foundation (L) | `b1-foundation` | `E:\_root\imnstr\.claude\worktrees1-foundation` | A · `4110` · `.tmp/e2e.db` | `briefs/B1.md` (`1e00bce`) | running: background Sonnet 5.5 lane, launched 2026-10-10 from this session |

**Next steps, in order**
1. **8b, B1 land** (Opus · medium) when the lane reports: save the report as `briefs/B1.report.md`. If this session has ended before the lane reports, the report is lost with it; check the branch for commits and relaunch a continuation lane from the card.
2. **8c, verify B1** (Opus · high), fresh session.
3. Founder, in parallel: P0-2 to P0-5 (B2 needs P0-2 and P0-3).

**Carry-overs**
- The card settles what the plan left open: `lib/env.ts` with `PORT`, `DB_PATH`, `SITE_TZ`, `E2E_CLOCK`, `PRELAUNCH`, `NODE_ENV`; dev dependencies `@types/node`, `@types/better-sqlite3`, `eslint`, `typescript-eslint` beyond §6.6; fonts from `@fontsource` by `npm pack`, not as dependencies; the hashing mechanism is the lane's choice. Verify should check each against the report.
- `SITE_TZ` defaults to `Asia/Tehran`; P0-5 is still unconfirmed.
- Owed items still go to `root-sot/imnstr/open-work.md` (not yet created).

**Questions for the founder:** as in the step-7b block.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 7b, project config)

*Adds to the blocks below and replaces none. Item 1 of the step-7 block is done.*

**Lanes in flight:** none.

**Done:** `lifecycle/projects/imnstr/`, all 0.1, none yet used:
- `brief-common.md`: role, read order, environment, git, style, the lane budget, debug rules, targeted tests only, and the seven-part report.
- `review-checklist.md`: plan §0.2 and §0.3; every stage; auth (spec §4.3 line by line); UI; deploy and the shared VPS; done means (§8); the verification ceiling.
- `config.md`: paths, suites, lane slots A (`4110`) and B (`4120`) with a `.tmp/e2e.db` per worktree, branch names, stages, the milestone script, deploy.
- **Founder [F]:** the org is `rishe-eco`. Closes the step-7 carry-over.

**Next steps, in order**
1. **Founder, P0** (plan §4): **P0-1, create `rishe-eco/imnstr`**, public, empty, with `main`. Needed before 8a. Then P0-2 to P0-5.
2. **8a, B1** (Opus · medium) once P0-1 exists: the card from plan §5 B1, slot A, branch `b1-foundation`.

**Carry-overs**
- `config.md` names the lane variables `PORT` and `DB_PATH`. They are planned, not built: B1's card must tell the lane to use them, and B1's stage record wins if they change.
- B1 must gitignore `.claude/worktrees/` and `.tmp/`, and write `CLAUDE.md` with the house rules and the environment (config §2). `brief-common.md` reads `CLAUDE.md` first.
- Owed items go to `root-sot/imnstr/open-work.md`, not Root's `team/open-work.md`. The first verify that owes something creates it.

**Questions for the founder:** still open from step 7: the PD vetoes in plan §10; the Persian show's name and channels; real copy; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 7, build plan)

*Adds to the blocks below and replaces none. Item 1 of the 05f block (step 7) is done.*

**Lanes in flight:** none.

**Done:** `07-build-plan.md` **0.1**, against spec 0.4.
- **Founder decisions [F]:**
  - the repo is `rishe-eco/imnstr`, public;
  - the host is root-app's VPS, as a co-tenant;
  - the stack is Hono SSR, SQLite and a Preact admin;
  - `imnstr.com` is registered, and the founder controls its DNS.
- **The plan:**
  - 27 PDs. PD-10 answers change note 03's open choice: **the last language is per account, on the server.**
  - Ten stages, B1–B9 (B4 split into a and b), in four milestones, MS1–MS4.
  - E1 (M3) runs at B6's verify.
  - Defects D-1 to D-8 are found and assigned.
  - Every AC and every carried build item is mapped to a stage (§6.7).

**Next steps, in order**
1. **Step 7b, project config** (Opus · medium): `lifecycle/projects/imnstr/`. The house rules come from plan §0.3, the done means from §8; lane ports `4110` and `4120`; a temporary SQLite file per lane.
2. **Founder, P0** (plan §4):
   - P0-1: create `rishe-eco/imnstr`, public. **Needed before 8a launches B1.**
   - P0-2: DNS records.
   - P0-3: the VPS commands.
   - P0-4: a backup target.
   - P0-5: confirm `Asia/Tehran`.
3. **8a, B1** once P0-1 exists. Then B2 ∥ B3, as in plan §3.

**Carry-overs**
- The founder wrote "risheh-eco". The plan reads it as `rishe-eco` (§10); to confirm.
- root-app's `deploy/` on `wp-dashboards` differs from `origin/main`. Which is live on the VPS is P0-3.
- The only edit to root-app is one line in its `deploy/README.md`, at B2's verify, with the founder's go-ahead (plan §7).

**Questions for the founder:**
- **New:** the PDs flagged for veto in plan §10, which are PD-7's fallback, PD-10, PD-12, PD-15, PD-22, PD-23 and PD-24.
- **Still open:** the Persian show's name and channels; real copy in both languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05f, revise)

*Adds to the blocks below and replaces none. Item 2 of the 05e Claude Design block, and item 2 of the 05d block, are done.*

**Lanes in flight:** none.

**Done:** `02-spec.md` is at **0.4**. Change note `changes/03-journeys-gaps-design-0-2.md`; decision-log entry L-5. The founder decided all twelve items as recommended:
- **G10–G16 accepted.** The changes are in AC-28, AC-29, AC-40, AC-41 and AC-42, and there's a new **AC-48** for mixed-direction text. Both shows' links are edited in the code repo.
- **From the 05e design, accepted:**
  - "was live" (AC-14);
  - the year in admin lists only when it isn't the current one (AC-31);
  - the independence note, until dismissed (AC-24);
  - one refusal message for codes (AC-20, AC-21).
- **"Copied" refused** as a criterion and carried to the build.

**Next steps, in order**
1. **Step 7, build plan** (Opus · high), against spec 0.4. Change notes 02 and 03 each have a "Build plan" list. Note 03 leaves the build plan one choice: whether the last-language default is kept per device or per account.
2. **M6 at step 9:** F scores it, walking J6 against plates 13–14, as before.

**Carry-overs**
- **No `STALE` set.** 05f has no status column.
- Journeys 0.3 still mark G10–G16 *Suggested*. That is wording only; the next `journeys gap` can mark them accepted.
- AC-29 can't be checked for `/fa/podcast` until the Persian show has a name and channels.

**Questions for the founder:** none new. Still open: the Persian show's name and channels; real copy in two languages, with a Persian reader checking the placeholders; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05e, import)

*Adds to the blocks below and replaces none. Item 1 of the 05e Claude Design block (the import) is done.*

**Lanes in flight:** none.

**Done:** `04b-design/` **0.2** is in git: the export, `source/`, the README with *What didn't survive* refilled, and the 05e log. Checked in the browser pane:
- no requests leave the page;
- all four families, including Estedad and Vazirmatn, load from the bundle;
- the right-to-left frames mirror, and `<mark>` shows the highlighter;
- plates 1–15 render, with no console errors.

The eye-follow now respects reduced motion, which closes the 4b import's build gap for the eyes.

**Next steps, in order:** as in the 05e Claude Design block, items 2 and 3:
- `revise` for G10–G16, plus the README's new beyond-the-spec items;
- M6 at step 9.

Then step 7.

**Carry-overs:** no `STALE` set; 05e has no status column. Not checked by eye: the dark frames, and the Persian frames other than plate 13's landing page. Step 9 sees them in the running app.

**Questions for the founder:** none new. Still open: as in the block below.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05e, Claude Design)

*Adds to the blocks below and replaces none. Item 1 of the 05d block (05e, design second pass) is drawn; the import is owed.*

**Lanes in flight:** none.

**Done (in Claude Design, not yet in git):** `04b-design/` **0.2**, design system kept.
- Plates 1–11 carry the HIG review's fixes (#1–#12) and the UX review's design findings (F2, F3, F5, F7, F8, F10, F12–F17, F19), plus Save draft and the language field.
- New plates:
  - 12, admin states from spec 0.3;
  - 13, the Persian public pages;
  - 14, writing in Persian;
  - 15, the admin in dark.
- G10 and G12 drawn, flagged Suggested; `/fa/podcast` links the Persian show (placeholders).
- The founder chose:
  - Persian type: Estedad for UI, Vazirmatn for body;
  - the Latin wordmark, unchanged, on Persian pages;
  - the switch in the header;
  - dark admin as a token sheet plus three screens;
  - fixes in place and new plates from 12;
  - Persian at phone and desktop;
  - placeholder Persian copy.

**Next steps, in order**
1. **05e import session** (Opus · medium):
   - copy the handoff folder in: `04b-design/imnstr-design.html`, `source/IMNSTR Design.dc.html`, `README.md`, this block, and `lifecycle/trial-run/log/05e-design.md`;
   - refill the README's *What didn't survive*;
   - log as `05e-design-import.md`;
   - commit and push.

   `imnstr-directions.html` is unchanged and not in the folder.
2. **`revise` for G10–G16** (journeys §4), as in the 05d block. It can also take the README's new beyond-the-spec items: "was live", the year rule, one message for used or expired codes, and the independence note.
3. **M6 at step 9:** F scores it, walking J6 against plates 13–14.

Then step 7.

**Carry-overs**
- **No `STALE` set.** 05e has no status column.
- The wireframes still predate J6; the design now covers it.
- Gaps are listed in the README: some desktop counterparts, the rest of the admin in dark, platform marks, real copy in both languages, the Persian show's channels, the Persian feed (G11).

**Questions for the founder:** still open: the Persian show's name and channels; real copy in two languages, with a Persian reader checking the placeholders; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 06b)

*Adds to the blocks below and replaces none. Item 3 of the 05d block and item 2 of the 05b block (the eval-plan touch-up) are done.*

**Lanes in flight:** none.

**Done:** `06-eval-plan.md` **0.2**, matching spec 0.3:
- the reader record is read at the check's step 9, after M2 (§3.C, §3.D);
- "not measured", F4 and §8 now match spec §3.1;
- §6's five items are marked settled.

The founder made two decisions:
- §4.1's cold-ambiguous row is dropped; cold M3 is report-only and gives no reading;
- a conflict between the record and Q5 is resolved in a second line, after the record.

§4.2's rules are unchanged.

**Next steps, in order:** as in the 05d block, items 1, 2 and 4:
- 05e;
- `revise` for G10–G16;
- M6 at step 9.

Then step 7. Nothing in eval plan 0.2 adds build work: the M3 runs (warm and cold, reported) and AC-47's report command are already listed for step 7 in the 05b block.

**Carry-overs:** 06b has no status column, so `status.md` is unchanged. **No `STALE` set.**

**Questions for the founder:** none new. Still open: the Persian show's channels; real copy in two languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05d)

*Adds to the blocks below and replaces none. Item 1 of the 05c block is done.*

**Lanes in flight:** none.

**Done:** `03-journeys.md` **0.3**.
- J6 is persona F's journey; C writes in Persian.
- J1–J5 are amended for AC-20 to AC-47. 0.2 step numbers are kept; new steps are J1.5a, J2.6a, J2.11–12, J3.11, J5.5a and J5.8a, and changes are marked **[0.3]**.
- Coverage maps AC-1 to AC-47. AC-46, and AC-47's report command, have no screen.
- The founder took four decisions (§1, rows 4–7):
  - a new entry starts in the last language used;
  - **the Persian podcast is a separate show** with its own channels;
  - an English id under `/fa/` returns the Persian 404;
  - the 404's switch goes to the other landing page.

**Next steps, in order**
1. **05e, design second pass:**
   - draw the *0.3* rows of journeys §3 ("States the design must draw"), alongside everything carried in the 05b block's item 3 and the change notes;
   - draw G10 (the switch names the other language in that language) and G12 (mixed-direction text) as the journeys describe them, flagged Suggested;
   - `/fa/podcast` links the Persian show.
2. **`revise` for G10–G16** (journeys §4) before step 7 reads the spec; it can run beside 05e. G13, G14 and G16 carry decisions the founder has already taken; they need only an AC each.
3. 06b, as in the 05b block.
4. Step 5's M6 stays "not scorable" until 05e draws Persian. F scores it at step 9, walking J6.

**Carry-overs**
- `status.md` is unchanged: 05d has no column.
- **No `STALE` set.**
- The wireframes predate J6 and the 0.3 steps. Following 4c's precedent, they are carried to the design pass, not marked stale.

**Questions for the founder:** the Persian show's platform channels (names and URLs), needed by 05e or the build. Still open from earlier: real copy in two languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05c)

*Adds to the blocks below and replaces none. Item 4 of the 05b block ("`personas`, before step 9") is done.*

**Lanes in flight:** none.

**Done:** persona **F, Persian follower** (hypothesis) registered in `lifecycle/personas.md` 0.2 and selected in the `03-journeys.md` header; decision-log entry L-4. No existing persona changed. Founder accepted.

**Next steps, in order**
1. **05d, journeys gap** (Opus · high): a journey for F (arrive at a `/fa/` entry or feed, read, find the switch, thin Persian stream, `/fa/podcast`), plus everything owed since 3b (spec 0.2/0.3 criteria, Coverage, Suggested). F's header row already says which journeys it should anchor.
2. 05e design second pass, 06b eval-plan touch-up, as in the 05b block.
3. Step 5's M6 stays "not scorable" until Persian is drawn (05e); then F scores it at step 9.

**Carry-overs:** journeys' version bump and changelog are 05d's; the header was edited here without a bump. **No `STALE` set.**

**Questions for the founder:** none open.

## 2026-10-10 · `lifecycle-trial/imnstr` @ d770211 (+ step 05b)

*Replaces step 1 (`revise`) of both the step-6 and step-5 blocks below. Their other items still hold, amended here.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 7, build plan** (Opus · high) against **spec 0.3**. New for it:
   - the reader record §3.1: counting, bot filter, R2 from feed fetches, the report command (AC-46, AC-47);
   - the host's raw-log retention (§5);
   - Save draft on the server (AC-44), beside the local unsent buffer (AC-43);
   - the 5-min fresh sign-in (AC-11);
   - removing this device's passkey (AC-45);
   - the server refusing removal of a published episode's last link (AC-17);
   - M3 runs in the admin stage: warm gated, cold reported (AC-15).
2. **Eval plan touch-up** before close-out (10b), or folded into step 7 if the founder prefers. §2's "Not measured: visits, reads" and §1 F4's "no reader signal" are out of date; §3.D's analytics branch now applies. The rules in §4 don't change.
3. **The Claude Design pass**, before the UI stages, also takes: Save draft and F6's draft row; F1's kept-text notice; F9's failure states; F10's remove control; F15's Remove on this device; the owner as iMNSTR.
4. **`personas`, before step 9:** a Persian-reading follower (F11).

**Carry-overs**
- **Spec 0.3:** AC-43 to AC-47; §2.2 decisions 17–28; change note `changes/02-ux-review-eval-plan.md`; L-3.
- **No `STALE` set.** The cells are unchanged.
- **The reader record is never shown on the site.** It is read by command at each check, after M1's answers.

**Questions for the founder:** none open. Still from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** the eval-plan touch-up (step 2).

## 2026-10-10 · `lifecycle-trial/imnstr` @ ac06ddb (+ step 6)

*Step 6 ran beside step 5. This block adds to the step-5 block below and replaces none of it. Read both.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` (`05b-revise-spec.md`)** also takes `06-eval-plan.md` §6, five items, alongside step 5's:
   - **analytics:** the founder would accept them; they contradict AC-7, §3 and §7;
   - M3: warm only, or including sign-in;
   - AC-15 read as the warm median of five runs per language;
   - M1 asked every 6 months after the 6-month check;
   - M1's format is now five questions.
2. **Step 7, build plan.** Place in the admin stage's verification:
   - the M3 runs: warm and cold, both languages, screen-recorded;
   - off production, or before launch, then a database reset.
   Name "launch" as the first real entry on the production domain.
3. Close-out (10b) judges E1 (M3) only. It writes the E2 dates into this file: launch + 2 weeks (friction note), + 3 months, + 6 months, then every 6 months.

**Carry-overs**
- **Eval plan 0.1:** four failures with the same data (lull or end, quota, friction, unread).
- **The check:** five private questions in a fixed order, with M2 read last. M2 never triggers a drop.
- **Ambiguous:** "yes" with no entry for 6 weeks. Two ambiguous readings in a row count as a drop reading.
- **Decided by the founder:**
  - what a drop removes is decided at the time;
  - one check for both languages, with a pressure question that can name a stream;
  - every 6 months after the 6-month check.
- **Reminders for the checks** live in the founder's calendar, never in the admin (AC-5).

**Questions for the founder:** analytics, at `revise`. What limits would they need (§3.D)?

**Owed:** none from 6.

## 2026-10-10 · `lifecycle-trial/imnstr` @ e8c9c97 (+ step 5)

*Replaces step 1 ("Step 5, UX review") of the 4c block below. Its other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** (log as `05b-revise-spec.md`), from `05-ux-review.md`, "For `revise`":
   - F1: editing never discards unsent text;
   - F4: a "fresh sign-in" is one within 5 min (proposal);
   - F9: the episode form loses nothing either;
   - F10: links can be removed from an episode, and a published one keeps one.
   - Questions: F6 (server drafts for entries?), F11 (a Persian-reading persona), F15 (removing this device's passkey), F18 (the founder's name beside iMNSTR).
2. **Step 6** (eval plan) is running in parallel.
3. **The Claude Design pass** (the 4c block's step 2) also takes F2, F3, F5, F7, F8, F12–F14, F16, F17 and F19.
4. **Step 7, build plan:** read the routes column in `05-ux-review.md`. Build items: F1's draft handling and F2's server refusal of a used or expired code.

**Carry-overs**
- **Pass 1 scores** (simulated, 1–5) are mostly 4–5, with 3s on C·J2 (use, data) and on C·J3 and C·J5 recovery. M6 is not scorable. Step 9 scores against the same instrument.
- **Two High findings:** F1, unsent text versus Edit; F2, the enrolment code's error sends the founder to the server.
- **New:** `lifecycle/review-instrument.md` 0.1, a stub. It adds 1–5 anchors, the finding fields and routes, and the "not scorable" rule for M6.
- **Coverage:** 28 / 42 ACs drawn in full; 6 partly; 5 gaps owed by design (Persian, the switch, dark admin); 3 have no screen.

**Questions for the founder:** F6, F11, F15, F18 (through `revise`). Also, from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** none from step 5.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 6b3b42a (+ step 4c)

*Replaces the "`revise` on `02-spec.md`" step in the blocks below; their other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 5, UX review** (`ux-review wireframes`, Opus · high), against `04b-design/imnstr-design.html` and **spec 0.2**: §4, §6 (AC-1 to AC-42). Persian, the language switch, the admin's language field and the dark admin states aren't designed yet. Score them as coverage gaps, not design defects (change note, "Carried to the build"). Step 6 (eval plan) can run beside it; nothing in 0.2 changes §3 Metrics.
2. **A Claude Design pass (the founder), before the UI stages:**
   - Persian type that covers the script;
   - mirrored (RTL) layouts;
   - the language switch;
   - dark admin states;
   - the review fixes.
   The build plan places it. It isn't a redo of 4b.
3. Step 7, build plan: `/fa/` routing, per-language feeds and `hreflang`; the auth stage now holds G1–G3, W8 and W9.

**Carry-overs**
- **Spec 0.2:** G1–G9 accepted; the 10-min enrolment code, the 30-min setup token and no removal of the last passkey; date and time shown; light and dark; links in a new tab; 20 per page.
- **New: English and Persian** (§4.5): independent streams, not translations, on one site. English is at `/` and Persian at `/fa/`, with Solar Hijri dates in Persian digits (settled). One admin, in English. Nothing compares or counts the two streams.
- Access criteria from the 4b review (§4.6, AC-35 to AC-38): 44/24 px targets, no horizontal scroll at 360 px, `<mark>`, 3:1 field edges, and reduced motion stopping the eyes.
- Design and copy items (review #5, #6, #9, #11, #12; admin styling; names) are carried to the build, not the spec.
- **No `STALE` set:** steps 3–4b are silent on 0.2, not contradicting it. The change note lists what each owes.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:**
- Real copy, now in two languages.
- YouTube/Castbox marks.

**Owed:** none from 4c.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 88dde2f (+ step 4b import)

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also route the following:
   - emphasis renders as the highlighter;
   - the G1 enrolment code lasts 10 min (proposal);
   - the eye-follow must stop under reduced motion (found in the import);
   - the findings in `04b-design/review/README.md` that `revise` accepts. The Critical one: text links on phones need tap areas of 44 px, or 24 px for inline dates. The High ones: the phone wordmark overflows; field edges are 1.8:1; emphasis must be a `<mark>`.
2. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- **4b is in the repo:** `04b-design/` and `log/04b-design.md`, with the import log at `log/04b-design-import.md`.
- **A HIG design review** is in `04b-design/review/`: 12 findings with before/after images. It's an early read, not step 5. Step 5 can use it as input, but should score on its own.
- The README's "What didn't survive" is filled in: nothing that the design depends on was lost. The export is self-contained (fonts and React are bundled, no network requests).
- `imnstr-design.html` needs JavaScript and was checked over `http://127.0.0.1`. `file://` is untested.
- Everything in the 4b block below still holds: its own design system, the decisions, the design gaps and the hard lines.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks; cost for both 4b logs.

**Owed:** none from 4b.

## 2026-10-10 · `lifecycle-trial/imnstr` (+ step 4b)

**Lanes in flight:** none.

**Next steps, in order**
1. **Import session (Opus · medium)**: copy `04b-design/` and `lifecycle/trial-run/log/04b-design.md` from the Claude Design project into the repo, commit and push. Claude Design can't write to git. Then fill in the README's "What didn't survive the move" section by opening `04b-design/imnstr-design.html` and checking it against the Claude Design preview.
2. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also: emphasis renders as the highlighter; the G1 enrolment code lasts 10 min (proposal).
3. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- IMNSTR has its **own design system**, settled in `04b-design/README.md`: Bricolage Grotesque + Newsreader, green on green-tinted paper, the highlighter, and the iMNSTR wordmark (i-monster) with eyes. Classical was tried and dropped. Step 9's `design-review` reviews against this README.
- Decided in 4b: entries show date **and time**; platform links open in a **new tab**; W11 reads "Episodes will be listed here"; light and dark modes.
- Design gaps (README §Coverage): some desktop counterparts, dark admin states, platform icons (marks not supplied), real copy.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks.

**Owed:** the import commit (step 1 above).

## 2026-10-10 · `lifecycle-trial/imnstr` @ 0cd2ed1 (+ step 4)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4b, Claude Design (the founder): design from `02-spec.md`, `03-journeys.md` and `04-wireframes.html`. Plate 12 lists the layout calls (W1–W11); dashed purple boxes are Suggested G-items, options only. Then an import session (Opus · medium) writes `04b-design/` and its `README.md`.
2. Step 5, UX review, against 4b's design (wireframes as fallback). Step 6 (eval plan) can run beside 4b–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; needed before step 7.

**Carry-overs**
- Admin layout settled in wireframes (W1): editor first and empty; Entries, Podcast, Passkeys collapsed below; no counts in any heading or pager (W2); "Older" paging at 20 per page (W3).
- Behaviour proposals beyond the spec, for the build plan's auth stage alongside G1–G4: setup token also expires unused after 30 min (W9); no Remove on the last passkey (W8).
- Open: podcast empty-state wording, "will be listed" vs "nothing here at the moment" (W11).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** W11; G1–G9 through `revise` (before step 7).

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 29f9342 (+ step 3b)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4, Wireframes (`wireframes`, Opus · medium): read `03-journeys.md` §2 (J1–J5, every step) and §3 (the states table: empty, not enough data, error, loading, admin setup). Draw every journey step and every state; low fidelity only. Steps marked **Suggested** (G1–G9, §4) are not requirements: draw them only as marked options, or leave them out and say so.
2. Step 4b, Claude Design (the founder). Step 6 (eval plan) can run beside 4–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; nothing is waiting on it before wireframes.

**Carry-overs**
- Founder decided at journeys: landing content is edited in the code repo (spec §4.1 assumption now settled); passkeys on **phone + laptop**; an episode goes up with its first link, more links added later.
- The admin must open ready to write, not on the dated list (J2.2): the top date would show the gap.
- Security gaps for the build plan's auth stage: G1 enrolling a second/replacement passkey, G2 naming passkeys and ending their sessions on removal, G3 synced passkeys may be one credential, G4 idempotent publish.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** accept or refuse G1–G9 (`03-journeys.md` §4), through `revise` on the spec; not needed before step 4.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ c6fcb79 (+ step 3a)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6 and the `03-journeys.md` header (personas C Writer, D Follower, E Listener; A and B not selected). Anchors per persona are in the header table. 3–5 journeys of ~10 steps: first day (C), return after a gap (C), not enough data (D, E), error (C: failed save, expired session, lost passkey), plus the listener's path (E).
2. Step 4 wireframes, 4b Claude Design. Step 6 (eval plan) can run beside 3–5.

**Carry-overs**
- `lifecycle/personas.md` now exists (A, B grounded; C, D, E hypotheses). `lifecycle/decision-log.md` holds only L-1 (the persona proposal).
- Column 3 of `status.md` is left blank on purpose: 3b marks it done.
- Open assumption for the founder, still unconfirmed: landing content is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 68e2cb8 (+ step 2)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3a, Personas (`personas`, Sonnet · medium): read `00-intake.md` §4 and `lifecycle/personas.md` (doesn't exist yet; seed it from `tracker/canon/05-reviews/00-persona-review-method.md` §2). Three audiences in order: the founder, followers, podcast listeners.
2. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6. First day = first entry, on a phone, after the passkey bootstrap. Return after a gap lands on an easy new entry with no gap shown. Not enough data = 0–3 entries and an empty podcast page. Errors: failed save, expired session mid-write, lost passkey.
3. Step 6 (eval plan) can run beside 3–5: decision rule from spec §3 (M1 at 3 and 6 months, M2 only supporting fact).

**Carry-overs**
- Founder chose **admin shape A** (own passkey login). Spec §4.3 and AC-8 to AC-11 carry the OWASP/NIST floor; auth is the build's risk stage. Site needs a server and database.
- Entries: optional title, automatic date-time, no tags. Silent edit and unpublish. Podcast: one link per platform, platforms free text (mostly YouTube, Castbox). No now line. Atom feed. Admin editor phone-first.
- Open assumption for the founder: landing content (who, projects) is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ b7318ac (+ step 1, three passes integrated)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §5–§6). Ask in one batch: admin shape **A own login / B files in git / C git CMS / D Access-gated editor** (research §5; the names are now fixed, and earlier blocks used other letters); entry fields (title, tags, shown date) and prompt wording that invites explaining (§2.1); quiet edit and unpublish (§2.4); podcast: one link or one per platform, and the empty state (§4); a dated "now" line, yes or no (§3, §2.2); a feed; the drop review as a private question at 3 and 6 months (§6).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` now integrates all three passes; claims found by only one pass are tagged [P1]/[P2]/[P3]. Every pass is archived in `lifecycle/trial-run/archive/01-research/`, and the comparison is in `log/01-research-integration.md` (for 10a/10c). **The two blocks below are stale on research findings and on admin-shape letters.**
- Hard lines: no streaks, counters or gap markers on the site; the log publishes what was learned, never public plans.
- The admin pulls against "design matters": C's editor can't be designed. D gives a designed editor without owning auth. If A, research §5.3 becomes acceptance criteria and auth gets its own stage.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the seven in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ f087846 (+ step 1, second pass)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §4–§5). In the one batch of questions, ask: admin shape A / B / C / D (research §4); entry titles, tags, shown date; one link or several per podcast episode; how "still of use" is measured privately and over what period (research §2: not before ~2–3 months).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` was redone on Opus and supersedes the morning's Sonnet pass; the block below is out of date on research findings.
- Hard lines from research: no streaks, counters or gap markers on the site; the log records what was learned, not public intentions.
- If shape A: passkeys (two devices), per-account throttling, `__Host-` Secure/HttpOnly/SameSite=Strict cookies, no tokens in localStorage (OWASP). Auth is the risk stage.
- Not researched (network): `/now` pages, Cloudflare Access limits, Decap backends.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the four in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ b3155c5 (+ step 1)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, `01-research.md`. Ask clarifying questions in one batch. Decide admin shape A (live login) vs B (files in git); define "still of use" (intake §6) as the founder's own measure.
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design.

**Carry-overs**
- Research found nothing in Root's evidence summary beyond self-tracking: no streaks, counters or visible stats on the log; a gap must not be punished.
- Cloudflare Access was not researched (no sources); passkey leaning is blog-grade evidence, check against the WebAuthn spec before the build plan.
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from 4b.
- Code repo doesn't exist; needed by step 7.

**Questions for the founder:** admin as live login (A) or files in git (B)? (for spec)

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ 5c13321 (+ step 0)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 1, Research (`research`, Opus · high): read `00-intake.md` and `ecosystem/canon/04-research/00-evidence-summary.md` first. Scope is narrow: comparable personal learning-log and podcast-link sites; how a one-user admin is best secured and kept simple.
2. Step 2, Spec (`spec full`, Opus · high): turn the drop rule ("no more use for it") into something testable.

**Carry-overs**
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from step 4b (Claude Design), not Root's tokens.
- The founder finishes design in Claude Design after wireframes; steps 5 and 9 review against that output.
- Code repo doesn't exist; needed by step 7.
- Out of scope in v1: per-project pages, projects page, comments, visitor accounts, search, analytics, newsletter, audio hosting.

**Questions for the founder:** none open.

**Owed:** nothing.
