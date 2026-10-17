# 8c B7 verify — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated and as the trial table and config §8 say. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c verify B7. Model: Opus, effort: high." Nothing ran beside it. The session paused once for the founder's usage limit and resumed in the same context.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `verify`.
- `STATE.md`, the top two blocks (8b B7, 8a B7). The 8a block holds what the card settled.
- Inputs: `briefs/B7.report.md`; `git diff --stat 7d82cc0...b7-podcast`; `briefs/B7.md`; build plan 0.7 §5 B7 and §8; `lifecycle/projects/imnstr/review-checklist.md` and `config.md`, whole.
- Code, whole: `lib/episodes.ts`, `routes/admin-episodes.ts`, `routes/podcast.tsx`, `views/podcast.tsx`, `shared/link.ts`, `admin/episode-writes.ts`, `admin/episode-form.tsx`, `admin/episodes.tsx`. Diffs: `lib/publish.ts`, `lib/dates.ts`, `lib/limits.ts`, `lib/render.ts`, `routes/admin-api.ts`, `app.ts`, `routes/test.ts`, `locales/*`, `views/icons.tsx`, `deploy/*`, `admin/buffers.ts`, `admin/copy.ts`, the CSS (scanned for literals and physical properties), and the four existing test files the lane edited. `admin/writer.tsx` compared line by line with the code removed from `composer.tsx`. Test names in `admin-episodes.test.ts`, `admin-podcast.spec.ts`, `podcast.spec.ts`; helpers in `admin-podcast.spec.ts`, `podcast-support.ts`, `admin-support.ts`, `support.ts`.
- *Outside the read order:*
  - the memory notes for this build;
  - `migrations/001_init.sql`'s episode tables and triggers, to check the insert-first link replace and the trigger-message mapping;
  - `routes/admin-entries.ts` `POST entries`, to compare the episode route's order of refusals;
  - `playwright.config.ts`'s `webServer` and `projects`, to plan the review script and avoid two servers on slot A;
  - `admin/tsconfig.json`, to judge the lane's "stale comment";
  - `docs/development/B6.md` and the development README, for the record's shape and the owed rows;
  - `log/08c-B6-verify.md`, for this log's shape;
  - `imnstr/open-work.md`.

## Gate
Checked by hand:
- card, report and branch present (`b7-podcast` @ `c0401f4`, two commits, founder identity, local, no upstream);
- plan §5 B7 present (0.7);
- status column 8 at `8/10`, nothing `STALE`;
- `origin/main` at `7d82cc0`, the lane's base: nothing to merge in;
- `user.email` the founder's in the worktree and in root-sot.

**Gate passed.**

## Did
Mapped to `verify`'s eleven steps:
1. **The stat, then the core files:** the server's write side first (`lib/episodes.ts` against the triggers and `createOrGet`), then the routes and the public view, then the client's writes, form and section, then S-19's move.
2. **Against the checklist** (§1–§3; §4's lines on admin routes; §5; §6's before-push lines). One defect:
   - **Fix 1, the date an edit shows.** The form's fallback for an unchosen date is the server's today. That's right for a new episode, but in an edit a cleared date is sent as none and the server keeps the episode's own date. So the field showed 10 Oct while Save kept 3 Oct, and the change counted as unsaved. Found by reading `fieldsOf` and the date input's `value` against `updateEpisode`.
   - Checked and found right: insert-first link replace with position bands; the PD-25 cursor against the order; a lost answer followed by POST, `holds`, PUT and publish (one episode); the language lock while unanswered; S-19's move (only exports and three parameters changed); the trigger-message mapping; the three edited "B7 isn't here" tests.
3. **Fixed on the branch** with an e2e test that fails on the lane's code ("Received: 2026-10-10") and passes now. The lane's file was swapped back in by copying the fixed file aside and restoring it, not by stashing.
4. **Merge `main` in:** nothing to merge.
5. **Reran:** `npm run check`; 17 Vitest files (435); four e2e specs on the lane's code (230), then `admin-podcast.spec.ts` with the fix (64).
6. **Stage record** `docs/development/B7.md`.
7. **Owed** to `imnstr/open-work.md` 0.17: F-18 (plan changelog); S-3, S-7, S-9, S-12, S-18, S-19 closed; V-4 and V-9 widened.
8. **Flagged for close-out** in the record: plan §5 B7 and §6.1 (the dropped `DELETE`), §6.4 (guards), `afterInsert`, the date input.
9. **Stage list** in the development README: B7 verified; seven owed rows struck, two added.
10. Lessons, below (the trial has no inbox).
11. **"Ready to fast-forward"**: imnstr `b7-podcast` @ `a7c6292`, three commits on `7d82cc0`. No stop file, `.env` line, migration or package change in the diff. **The push deploys, so it waits for the founder's word** (B6's lesson 3).

**Plan §8's check, AC-6:** both podcast pages, rendered by a throwaway server on port 4130 with fixture episodes (two English; one Persian with `C++` and `.NET`), were submitted as code to `validator.schema.org/validate`: **0 errors, 0 warnings** each. Each `PodcastEpisode` carries `datePublished`, `keywords`, `name`, `description`, `inLanguage`, a `url` per link and a nested `PodcastSeries` (`name`, `url`). Only fixture text was sent.

**By hand in Edge:** a throwaway `tests/e2e/zz-review.spec.ts` (deleted before commit) signed in with the virtual authenticator and took element screenshots of the Podcast section in both schemes at 360 and 180 px: the list, a new Persian episode with an http-less address refused, a published Persian episode's frame, a was-live draft's frame. In the browser pane, signed out: `/podcast` at 180 px light, `/fa/podcast` at 360 px dark. Two things seen and not changed (the record's *Seen at review*): a plain `<input>` draws `C++` as `++C` in a Persian name (no `<bdi>` possible; B6's title has it too), and the native date input clips its year at 180 px. The dark run's first pass checked the entry form's "فارسی" radio before the episode form had drawn (the form waits for `GET settings`); that was the script, not the page.

## Output
- imnstr `b7-podcast` @ **`a7c6292`** (fix 1, `docs/development/B7.md`, development README), on the lane's `c0401f4`. **Not on `main` yet, not deployed.**
- root-sot: this log; `imnstr/open-work.md` 0.17; a `STATE.md` block. Status column 8 stays `8/10` until B7 is live.

## Spec gaps
- **The card's "Done" list named tests that had to change** (`record`, `admin-entries`) as tests that "still pass". A card should list the tests that pin the stage's absence, so the lane edits them on purpose and the verify checks each edit (the lane's item 7 says the same).
- **Display fallbacks for omitted fields.** When a client omits a field so the server fills it, the server's rule differs by verb (POST: today; PUT: keep). The plan says what the server does but not what the form shows meanwhile, and the lane used one fallback for both. The plan's PD for a server-filled field should say what the screen shows for each verb.
- **Plan §8's validator check** says "by hand". With a fixture-seeded server it's a `curl` POST to `validator.schema.org/validate` and a JSON read. The skill could carry that script (as with the W3C feed check at B3).
- **The review script** again had to live in `tests/e2e/` and be deleted before the commit (B6's gap, still open).

## Template sample
The record used B6's headings: Built (with "The review changed"), Decided (with "Where the plan or card was wrong" and "Seen at review, not changed"), Owed, Flagged for close-out, Verification ("How the checklist was checked": by test / by reading / by hand; the deploy; the ceiling). Required: Built, Decided, Owed, Flagged for close-out, Verification.

## Missing foundation
- No permission rule for the deploy push (B6's gap, still open): the push waits on the founder's word in chat.
- `expectWithinColumn` is now copied in two specs (`editor.spec.ts`, `admin-podcast.spec.ts`); it belongs in `tests/e2e/support.ts` (B6 lesson 1; B9 can move it).

## Founder Q&A
- **Asked at the wrap-up:** may I push `b7-podcast` to `main` (which deploys)? *Answer: below, in the addendum.*

## Skill shape
- Opus · high was right. The one defect needed the form's display read against the server's PUT semantics, which a lane at Sonnet reasoning about one verb missed.
- **Forked, with screenshots.** The screenshot pass found nothing to fix this time, but it found the two "seen" items. A ready review script (sign in, seed, shoot each new view in both languages and schemes at 360 and 180 px) should be injected rather than written each time.
- **Inject:** the report, the stat, the card's "What the card settled" list from STATE, the checklist, `origin/main`'s hash, and for B7-like stages the validator script.
- **End:** ask for the founder's word on the push in the same question as the review's result.

## Lessons
1. **Rule:** when a client may omit a field so the server fills it, check what the form shows for each verb: the fallback must be the value the server will keep. **Event:** B7's edit showed today for a cleared date while Save kept the episode's date. Found by reading, ~15 min with the test. **Scope:** any form with server-filled defaults. **Destination:** review checklist §1 (nothing lost / what you see is saved) and the plan's PD for defaults.
2. **Rule:** a card's "Done" section lists the existing tests that pin the stage's absence. **Event:** three tests said "B7 isn't here yet"; the lane spent a full run on each to find them (lane item 7). **Scope:** every card for a stage that fills a placeholder. **Destination:** `build-phase`'s card template.

## Cost
*Founder fills in after the session.*

## Next
1. **The founder's word on the push** (the closing question). Then: `git push origin HEAD:main` from `E:\_root\imnstr\.claude\worktrees\b7-podcast`; read the run at `api.github.com/repos/rishe-eco/i-monster/actions/runs`; `curl -I` the pages; fill the record's deploy section in a commit of its own; remove the worktree and branch; status column 8 → `9/10`.
2. **8d MS3** once B7 is live (suites), though MS3 can't close until V-9.
3. **8a B9** after that.
4. **The founder:** F-18, F-17, then V-9 with V-7.
