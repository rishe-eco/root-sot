# 8c B9 verify — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated and as the trial table and config §8 say. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c B9. Model: Opus, effort: high." Nothing ran beside it.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§6 (the first 150 lines). `skills-plan.md` §0 and `verify`.
- `STATE.md`, the top three blocks (8b B9, 8a B9, 8d MS3). The 8a block holds what the card settled; the 8b block what to look at first.
- Inputs: `briefs/B9.report.md`; `git diff --stat fdfda8b...b9-motion-access`; `briefs/B9.md`; build plan 0.8 §5 B9 and §6.6; `lifecycle/projects/imnstr/review-checklist.md` and `config.md`, whole.
- Code: the diffs of `assets/wordmark.js`, `views/*` (layout, landing, log, podcast, not-found, the new `wordmark.tsx`), `routes/admin.tsx`, `admin/{ui,signin,copy}.tsx|ts`, `admin/admin.css`, `assets/css/{components,tokens}.css`; `tests/e2e/sweep-support.ts` whole; the hero tests in `sweep.spec.ts`; `writeWithMark` in `admin-sweep.spec.ts`.
- *Outside the read order:*
  - the memory notes for this build;
  - `CLAUDE.md` (the em-breakpoint rule the lane broke) and `base.css`'s reduced-motion rule (does `transition: none` stop `transitionrun`?);
  - the design export's `WM` and `Eyes` script, to check the script's numbers and the pair gaps;
  - `locales/{en,fa}.ts` `owner`, to check label-in-name for the `aria-label`;
  - `playwright.config.ts` `webServer`, and `lib/assets.ts`, when the new test passed on the lane's code (see *Did*);
  - `editor.spec.ts`'s `write`/`selectBack`, to judge the composer flake;
  - `deploy/checks.sh`, to see whether an asset check had a pattern to copy (none);
  - `docs/development/B7.md` and the development README, for the record's shape and the owed rows; `log/08c-B7-verify.md` for this log's shape; `imnstr/open-work.md`;
  - one web search: Safari's `click` as a `PointerEvent` and its `pointerType` (WebKit bug 282988).

## Gate
Checked by hand:
- card, report and branch present (`b9-motion-access` @ `1869e15`, two commits, the founder's identity, local, no upstream);
- plan §5 B9 present (0.8);
- status column 8 at `9/10`, nothing `STALE`;
- `origin/main` at `fdfda8b`, the lane's base: nothing to merge in;
- `user.email` the founder's in the worktree and in root-sot.

**Gate passed.**

## Did
Mapped to `verify`'s eleven steps:
1. **The stat, then the core files:** the script first (against the export's `WM`/`Eyes`), then the markup, then the CSS, then the sweep's harness (are its checks real?), then the hero tests.
2. **Against the checklist** (§1–§3; §5; §6's before-push lines). One defect:
   - **Fix 1, the hero tap on an iPhone.** The script toggled only when the `click` event's `pointerType` was `touch` or `pen`. Safari before 18.2 dispatches a plain `MouseEvent` click (no `pointerType`), and from 18.2 a `PointerEvent` click that reports a tap as `"mouse"` (WebKit bug 282988, from a web search: graded *evidence*, not tried on a device). So the founder's likely phone would never toggle the reveal. Found by reading, then confirmed by search. Now the type is taken from the link's `pointerdown` and cleared at each click.
   - Checked and found right: CSSOM writes only (CSP); `transition: none` in the kill-switch (so no `transitionrun`); `cqi` resolved where `var()` lands (inside `.wrap`); the `aria-label` equals the visible resting text in both locales (label-in-name holds); eye sizes and gaps against the export's `pair()` calls (desktop header gap 8 vs 9 px, not worth a token); the desktop nav gap restored at 48em; the harness's "checks catch" tests.
   - The lane's rem container query against `CLAUDE.md`'s em rule: accepted as within the rule's intent (in a container query em is the container's font size, here the 17 px body); proposed to the founder as F-19.
3. **Fixed on the branch** with an e2e test (synthetic touch `pointerdown`, then a `MouseEvent` click, then a `PointerEvent` click typed `"mouse"`; Enter after them doesn't toggle). **Its first draft passed on the lane's code:** the intro's own timers flipped the class while `toHaveClass` waited, and `page.clock.install()` doesn't stop time. A throwaway debug spec showed the class unchanged after the dispatch, and the test now plays the intro out with `clock.runFor(3000)` first: fails on the lane's code, passes with the fix. The lane's file was swapped in by copying the fix aside, never by stashing.
4. **Merge `main` in:** nothing to merge.
5. **Reran:** `npm run check`; the lane's 9 Vitest files (289); one Playwright run of both sweeps plus `landing`, `not-found`, `entry`, `admin-auth`: **249 passed, 1 failed** (8.8 min). The failure (`admin-sweep`'s English composer, dark: no `<mark>` after Highlight) passed 24/24 with `--repeat-each=4`: a rare flake in the helper's selection, left for MS4 to watch.
6. **Stage record** `docs/development/B9.md`.
7. **Owed** to `imnstr/open-work.md` 0.20: F-19, S-20; V-2 closed; V-3 and V-9 widened.
8. **Flagged for close-out** in the record: the design README's two ratios and *Components* sizes, `CLAUDE.md` (if F-19), plan §5 B9's podcast draw-in.
9. **Stage list** in the development README: B9 verified; four owed rows struck, two added.
10. Lessons, below (the trial has no inbox).
11. **"Ready to fast-forward"**, then deployed at the founder's word (below).

**By hand in Edge:** a throwaway `tests/e2e/zz-review.spec.ts` (deleted before commit) took screenshots in both schemes: `/` and `/fa/` resting and revealed at 360, at 180 and 1280; `/log` and `/fa/log` revealed; both podcast empty states; both 404s; the admin sign-in; and the header brand at ×4 device scale with the pointer moved, to see the pupils follow. Nothing to fix. The browser pane wasn't used (the review script covers both schemes at once).

**The deploy:** no stop file, `.env` line or migration in the diff. Pushed `fdfda8b..fc5a46d` with the founder's word; run 39083276917 green. `curl -I` on seven pages: exact CSP, noindex, no `Set-Cookie`; root-app 200. `wordmark.ee17e9ae4b.js` served (3,586 B, immutable) with the fix. **`Content-Encoding`:** HTML gzip; `wordmark.js`, `site.css` (35,402 B) and `admin.js` (310,699 B) uncompressed (F-17). The record's deploy section went out as `7f2b233`, **with its code spans stripped**: the text was passed through a double-quoted `node -e`, so Bash ran each backtick span as a command (all failed harmlessly, as "command not found" or "No such file"). Restored with the Edit tool in `e8a7b90`. Runs 39083476001 and 39083502670 green. Local main fast-forwarded; worktree and branch removed (`git worktree remove` hit Permission denied again; the emptied folder is still held by a process).

## Output
- imnstr **`main @ e8a7b90`**: `fc5a46d` (fix 1, the record, development README), `7f2b233` and `e8a7b90` (the record's deploy section). **Deployed.**
- root-sot: this log; `imnstr/open-work.md` 0.20; a `STATE.md` block; status column 8 → **`10/10`**.

## Spec gaps
- **A test of an event handler can pass for the wrong reason when the page has its own timers.** The card asked for the intro to be tested with `page.clock`, but nothing said `clock.install()` keeps time running; a fix's test must be shown to fail on the old code (the B7 log did; here it caught a false pass).
- **Platform behaviour of input events** (Safari's click `pointerType`) is outside what the Edge-only suite can see. The card's tap rule ("toggle on touch or pen") was right in intent and wrong in mechanism; the card or design README could say "read the pointer type from `pointerdown`".
- **"Flaky" has no rule in the checklist.** One failure in a 250-test run that then passes 24/24: the review recorded it and moved on. The checklist could say how many repeats make a flake, and that a flake is written in the record, not retried away.
- **The review script** again lived in `tests/e2e/` and was deleted before the commit (B6's gap, still open).

## Template sample
The record used B7's headings: Built (with "The review changed"), Decided (with "Where the plan, card or brief was wrong" and "Seen at review, not changed"), Owed, Flagged for close-out, Verification ("How the checklist was checked": by test / by reading / by hand; the deploy; the ceiling). Required: Built, Decided, Owed, Flagged for close-out, Verification.

## Missing foundation
- No safe way to put Markdown with backticks into a file from Bash (memory had the warning; it was missed once). The skill should write prose with the Edit/Write tools only.
- No permission rule for the deploy push (B6's gap, still open): the push waited on the founder's word, asked with the review's result.

## Founder Q&A
- **Asked at the end of the review:** may I push `b9-motion-access` to `main` (which deploys)? **Answer:** "Yes, push it."
- **Asked with it:** F-19, change `CLAUDE.md` (container queries in rem) and the design README's two ratios now, or leave it in open-work? **Answer:** "Leave it in open-work."

## Skill shape
- Opus · high was right: the one defect needed knowledge outside the repo (Safari's event model) and a search to grade it.
- **Forked, with screenshots.** The screenshot pass found nothing, as at B7; it is still what checks the eyes, the reveal and the RTL brand by eye.
- **Inject:** the report, the stat, the card's settled list from STATE, the checklist, `origin/main`'s hash. For UI stages, a ready review script (seed, shoot each page in both languages and schemes at 360/180/1280).
- **End:** ask the push word and any founder call (here F-19) in one question.

## Lessons
1. **Rule:** a test that proves a fix must be run against the unfixed code and seen to fail; if the page has timers, stop or exhaust them first (`clock.install()` doesn't freeze time). **Event:** B9's hero-tap test passed on the lane's code twice, because the intro's timers toggled the class while the assertion waited; ~10 min to find. **Scope:** every verify fix with an e2e test. **Destination:** `verify` skill step 3; review checklist §7.
2. **Rule:** a touch-only handler reads the pointer type from `pointerdown`/`pointerup`, never from `click` (Safari omits it before 18.2 and reports taps as "mouse" after). **Event:** B9's hero reveal never toggled on an iPhone; found by reading. **Scope:** any tap behaviour. **Destination:** design README *Components* (wordmark) or the house checklist §5.
3. **Rule:** never pass Markdown through a double-quoted shell string; write prose files with Edit/Write. **Event:** the B9 record's deploy section shipped to `main` with its code spans stripped, and needed a second deploy to repair. **Scope:** every session on this machine. **Destination:** `brief-common.md` and the verify skill. `urgent: yes`.

## Cost
*Founder fills in after the session.*

## Next
1. **8d MS4** (Opus · high) on `main @ e8a7b90`: the milestone script; watch the `admin-sweep` composer flake. MS3 and MS4 both wait on V-9 for E1.
2. **The founder:** F-17 (before V-9's cold runs), then V-9 with V-7 (now with a real tap on the hero); V-8 is due; F-19 when convenient.
3. **Step 9** (live review) after MS4's suites.
