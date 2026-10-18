# 8c PL1 verify — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated and as the trial table and config §8 say. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c PL1. Model: Opus, effort: high." Nothing ran beside it.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§6. `skills-plan.md` §0 and `verify`.
- `STATE.md`, the top four blocks (8b PL1, 10a, 8a PL1, 9b).
- Inputs: `briefs/PL1.report.md`; `git diff --stat b894598...pl1-live-polish`; `briefs/PL1.md`; change note 05 0.2, whole (its PL1 section stands in for plan §5); `lifecycle/projects/imnstr/review-checklist.md`, whole; `config.md` §1–§8.
- Code: the diffs of `lib/{entries,episodes}.ts`, `routes/{admin-entries,admin-episodes,admin-api,log,podcast}.ts(x)`, `shared/excerpt.ts`, `admin/{api,buffers,writes,episode-writes,composer,episode-form,episodes,writer,app,copy,passkeys}.ts(x)`, `admin/admin.css`, `assets/css/{components,tokens}.css`, `views/{layout,log,podcast,icons}.tsx`, `locales/*`; the PL-8 tests in `tests/integration/admin-entries.test.ts`; the lane's edits to the AC-13 and leap-day tests; `tests/e2e/polish.spec.ts` (head) and `polish-support.ts`.
- *Outside the read order:*
  - the memory notes for this build;
  - `lib/bidi.ts` (whole), when the lane's `guessLang` looked like a second script rule;
  - `assets/css/base.css`'s `:focus-visible`, for what the skip link's target draws;
  - `playwright.config.ts` `webServer`, and the e2e specs' imports, to know whether source edits could disturb the running full suite (they import no app source);
  - `docs/development/B9.md`, `B7.md` (head) and the development README, for the record's shape and owed rows; `log/08c-B9-verify.md` for this log's shape; `imnstr/open-work.md`;
  - build plan §6.2's heading, to cite the codes table.

## Gate
Checked by hand:
- card, report and branch present (`pl1-live-polish` @ `29d92c7`, three commits, all `TheMonster1995 <salmanian.foad2@gmail.com>`, local, no upstream);
- change note 05 at 0.2 with a PL1 section (Files, Tests, Traps, Not here);
- status: nothing `STALE`; column 8 `10/10` (a Change has no column);
- `origin/main` at `b894598`, the lane's base: nothing to merge in;
- the diff touches no stop file, `migrations/`, `Dockerfile`, `package.json` or `.env.example`.

**Gate passed.**


## Did
Mapped to `verify`'s eleven steps:
1. **The stat, then the core files:** the server first (`newerTarget`'s order and its rule; `LANG_FIXED` inside the transaction; `dateRefusal` and the PUT exception), then the admin writes and buffers, then the forms (`composer.tsx`, `episode-form.tsx`, `episodes.tsx`, `writer.tsx`), then the CSS and the views, then the tests the lane changed beyond the card.
2. **Against the checklist** (§1–§3, §5, §6's before-push lines). Found by reading: `guessLang` in `admin/writer.tsx` was a second script rule beside `lib/bidi.ts` (house rule 4); `episodes.tsx` copied `EpisodeName`'s rule; two comments described rules that don't exist. Found by eye (step 3's screenshots): the focus ring round all of `main` after the skip link. Found by the full run: the landing sweep's timing flake. Judged and left: the lost-answer-then-language case on a known row (safe: `LANG_FIXED`, text kept, no second row); the AC-13 and leap-day test edits (right); `new Date(Date.UTC(…))` in two helpers (arithmetic, not the clock).
3. **Fixed on the branch:** `2512cfe` (the ring, `guessLang` into `lib/bidi.ts` with four unit tests, one `EpisodeName`, two comments) and `ce31487` (the landing sweep plays the intro out and waits for the letters' transition). The ring's new assertion was run without the CSS rule and failed (`solid`), as was the flake's cause: a throwaway spec showed axe flagging `.wordmark` inside the intro window and just after it.
4. **Merge `main` in:** nothing to merge (`origin/main` still `b894598`).
5. **Reran:** the full suites three times, because the change note's PL-12 asks for them at this verify (the card moved them from the lane): run 1 on the lane's code (680 passed, 3 failed); run 2, light only, to get the cut-off errors (353 passed, 1 failed, a different test); run 3 on `2512cfe` (682 passed, 1 failed, now with its error). Then the fixed test 20 of 20 and the whole sweep file 126 of 126. Vitest 46 files, 1,013. Each run ~29 min; I edited source only while e2e ran, after checking the specs import no app code.
6. **Stage record** `docs/development/PL1.md`.
7. **Owed** to `imnstr/open-work.md` 0.22: F-2 gains four Persian keys; F-20 (the spec revise note 05 left for later); V-3 gains the skip link, the sheets, the named offers and the wordmark's revealed name.
8. **Flagged for close-out** in the record: spec AC-42, §4.4, AC-30; build plan §6.2's two codes; design README *Components*; note 05's PL-1 "row hover".
9. **Stage list:** a PL1 row in the development README, two owed rows.
10. Lessons, below (the trial has no inbox).
11. **"Ready to fast-forward"**, then pushed with the founder's word (below).

**By hand in Edge:** a throwaway `tests/e2e/zz-review.spec.ts` (deleted before commit) shot both schemes: the skip link focused and after Enter, the middle page at 180 px in both languages, both 404s, the Unpublish sheet at 360 × 800 and 1280, the dock notices at 360 × 400, a named Persian offer at 180, the date refusal, Link 1 and Link 2 at 180. It found fix 1.

**The deploy:** no stop file, `.env` line or migration in the diff. Pushed `b894598..f1eae8b` with the founder's word; run 39130183020 green (`check` 27 s, `deploy` 34 s, with `deploy/checks.sh` inside). `curl -I` on eight pages: exact CSP, noindex, no `Set-Cookie`; root-app 200. A `GET` with a curl user agent (a bot to the record) showed PL1 live: the skip link in both languages, `main` with `tabindex`, the 404's owner line said once, and the new CSS and admin codes in the served assets. The record's deploy section went out as `d886160`, run 39130411433 green. Worktree and branch removed (`rm -rf` after Permission denied, as at B8 and B9).

## Output
- imnstr **`main @ d886160`**: the lane's `d0778c2`, `49344a8`, `29d92c7`; the review's `2512cfe` (fixes 1–4 and 6) and `ce31487` (fix 5); the record and stage list `f1eae8b`; the record's deploy section `d886160`. **Deployed.** Worktree and branch removed.
- root-sot: this log; `imnstr/open-work.md` 0.22; a `STATE.md` block. **No status cell:** a Change has no column, and column 8 stays `10/10`.

## Spec gaps
- **A Change's verify runs the full suites, and the skill spec doesn't say so.** `verify` step 5 reruns "the affected test files"; full suites belong to `--milestone`. Note 05's PL-12 asked for the full run, and the card moved it from the lane to here. The skill should take "full run at verify" from the change note's criteria, and budget for it: three runs at ~29 min each were most of this session's wall time.
- **The milestone script, and my own commands, kept only the tail of the e2e output.** Run 1's `| tail -60` kept the summary and cut every error, so three failures had no message and a 15-minute rerun followed. The config's milestone script should write the whole output to a file and grep it after. (Lesson 1.)
- **A full run with flakes has no rule.** B9's log asked for one. Here three different tests failed across three runs, each passing alone. One had a real, findable cause (a timing window in a test), two had none found. I fixed the one, wrote the two up as flakes, and asked the founder with that stated. The checklist could say: a failure with a cause found is fixed in the test or the page; one without is repeated N times and recorded, and the push question says so.
- **Page-clock tests and CSS transitions.** `page.clock.runFor` moves the script's timers, not CSS transitions, which run on real time. B9's lesson (`clock.install()` doesn't freeze time) has a second half: after running a clock past a class change, wait for the CSS to settle too.
- **The review script** again lived in `tests/e2e/` and was deleted before commit (B6's and B9's gap, still open).

## Template sample
The record used B9's headings: Built (by commit, with "The review changed"), Decided (with "Where the note, card or brief was wrong" and "Seen at review, not changed"), Owed, Flagged for close-out, Verification (a table of the runs; "How the checklist was checked": by test / by reading / by hand; the ceiling; the deploy). For a Change, *Built* named the review findings it closes (F1–F5, D1, D2, P1–P4) instead of a plan section. Required: Built, Decided, Owed, Flagged for close-out, Verification.

## Missing foundation
- No helper that turns a full run's output into "these failed, with these errors": every run here was grepped by hand.
- The trial still has no learnings inbox (lessons stay below).

## Founder Q&A
- **Asked at the end of the review:** push `pl1-live-polish` to `main` (which deploys)? The option said that no full run was wholly green, and why. **Answer:** "Yes, push it."

## Skill shape
- Opus · high was right: the fixes were small, but deciding whether three intermittent failures were the stage's fault needed reading the harness and proving a cause.
- **Forked, with screenshots.** The screenshot pass found the one visible defect (the ring), which no test could have seen: the skip-link test checked focus, not what focus draws.
- **Inject:** the report, the stat, the STATE block's "for verify to look at first", the note's PL section, the checklist, `origin/main`'s hash. For a UI Change, a ready review script.
- **Run the full suites in the background from the first minute,** and review the diff while they run (the e2e specs import no app code, so source edits are safe mid-run). That saved about half an hour here.

## Lessons
1. **Rule:** a full suite's output goes whole to a file; grep it after, never pipe the run through `tail`. **Event:** PL1's first full run cut its three errors, so a 15-minute rerun went to recovering them, and it hit a different test. **Scope:** every verify and milestone on this machine. **Destination:** `config.md` §6's milestone script; `verify` skill step 5. `urgent: yes`.
2. **Rule:** look at what a focus or state change *draws*, not only where focus goes: a screenshot after each keyboard step. **Event:** after the skip link, `main` drew a 3 px ring round the whole page; 32 passing skip-link tests checked focus only. Found by the review's screenshots. **Scope:** UI reviews. **Destination:** review checklist §5 ("every action reachable by keyboard, and focus visible": add "and nothing but the control draws it").
3. **Rule:** a sweep or axe check on a page with timed motion runs on the page at rest: play the motion out on the page clock, then wait for CSS transitions. **Event:** B9's landing sweep passed at B9, B9's verify and MS4, then failed in two of PL1's three runs (a longer run hits the 0.9–2.9 s window more often). **Scope:** any test of a page with an intro or timed state. **Destination:** `sweep-support.ts` comment, review checklist §5.

## Cost
*Founder fills in after the session.* Wall time about 2 h 45 m, most of it three full e2e runs (~29 min each) and one light-only run (~14 min).

## Next
1. **10b close-out** can now count PL1 as verified; it still waits for MS3 (V-9) and MS4 (V-5).
2. **The founder:** V-5 with V-8 (a Persian entry first), F-17, V-9 with V-7, V-3 (now with the skip link, the sheets, the named offers and the wordmark's revealed name), F-19, F-20 (the spec revise), F-2 (four more Persian keys).
3. **10c** takes this log's spec gaps with the rest: the full run at a Change's verify, keeping whole output, a rule for flakes, the page clock against CSS transitions.
