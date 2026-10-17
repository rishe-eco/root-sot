# 8c B8 verify — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated and as the trial table and config §8 say. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c B8. Model: Opus, effort: high." Nothing ran beside it.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`, the top three blocks (8b B8, 8c B5, 8a B8): the top one alone didn't say what the card had settled.
- Inputs: `briefs/B8.report.md`; `git diff --stat aa889cb..b8-reader-record`; `briefs/B8.md`; build plan 0.6 §5 B8, PD-20, §6.3, §6.4; spec §3.1 and AC-5, AC-7, AC-46, AC-47; `lifecycle/projects/imnstr/review-checklist.md` and `config.md`, whole.
- Code: `lib/record.ts` and `lib/record-middleware.ts` whole; both CLIs whole; the diffs of `app.ts`, `lib/dates.ts`, `lib/limits.ts`, `package.json`, `deploy/README.md`; the test names in the three record test files, the setup, cookie, dropped-table, AC-46 and AC-47 tests whole; the bot and referrer unit tests.
- *Outside the read order:*
  - the memory notes for this build;
  - `log/08c-B5-verify.md`, for this log's and the record's shape;
  - `docs/development/B5.md` and the development README, for the record's shape, the stage list and the owed rows;
  - `scripts/seed-entry.ts`, for the CLI pattern;
  - `lib/sessions.ts` (the cookie's name);
  - `routes/admin-api.ts` and `routes/admin-entries.ts` (the `GET` routes), because B5 added reads that AC-47's check didn't name;
  - `auth-guard.test.ts`'s router enumeration, reused for AC-47;
  - `deploy/checks.sh` (its curl agent) and `deploy/README.md` (the `dc` shorthand);
  - `imnstr/open-work.md`.

## Gate
Checked by hand:
- card, report and branch present (`b8-reader-record` @ `3b8cda2`, local, one commit, founder identity);
- plan §5 B8 present (0.6);
- status column 8 at `6/10`, nothing `STALE`;
- `origin/main` at `13d82dd` (B5), local `main` equal, so a rebase was due;
- `user.email` the founder's in both repos.

**Gate passed.**

## Did
Mapped to `verify`'s eleven steps, with step 4 first. The block said to rebase before reviewing, so the review read the code it would ship.
4. **Rebase onto `main @ 13d82dd`.** One conflict, the `dates.test.ts` import line, where both stages added a name. `lib/dates.ts` and `deploy/README.md` merged cleanly.
1. **Stat, then core files:** the record, the middleware, the CLIs, then the tests.
2. **Checklist §1–§3** (§4 and §5 don't apply: no admin route, no UI; §6 for the deploy). The core held up: the path whitelist, the name-only cookie check, the 304 counted inside ETag, the single-statement cap, no logging of the request. Findings:
   - (a) **AC-47's signed-in check read a fixed list** (`session`, `passkeys`, `/admin`). B5 landed after the lane's base, so `settings`, `entries` and `entries/:id` were never read for the record's figures. A fixed list goes stale with each stage.
   - (b) **Link-preview fetchers counted as views.** Mastodon's (`http.rb … Mastodon/…`), WhatsApp's, Bluesky's Cardyb, Iframely and the like don't say "bot". One post shared on Mastodon is fetched by every server that receives it, so one share could read as dozens of views. That bends R1, the number spec §3.1 keeps.
   - (c) **R3 kept local names.** The card drops IP literals because they "could be a reader's own network", but `http://intranet/` or `nas.local` say the same and were kept.
   - (d) `app.ts`'s D-8 comment said nothing on a public route reads a cookie. The record now looks for the name.
3. **Fixed** (`d6da7f6`):
   - AC-47 enumerates the router's admin `GET`s and asserts each one answered 200;
   - ten fetcher names added to the bot pattern;
   - `isLocalName` in `refererDomain`;
   - the comment;
   - unit tests for each.

   The cap test used single-label hosts (`site7`), so it now uses `site7.example`.
5. **Reran:** `npm run check`; 14 Vitest files, 415 passed. These were the card's list and the lane's, plus `admin-entries`, because AC-47 now reads B5's routes. No Playwright: B8 renders nothing.
6. **Deployed:** checked the diff for a stop file, an `.env` line or a migration (none) and that every author was the founder. Then pushed `HEAD:main`. Run 39039416353 was green: `check` 27 s, `deploy` 48 s.
   - Live afterwards: pages, both feeds and a 404 carried the CSP and noindex, with no `Set-Cookie`. A conditional feed fetch got `304` through Nginx. root-app answered 200.
   - One counted view placed from the in-app browser (`/fa/log`; Chrome agent, no cookie, 200).
   - Stage record `docs/development/B8.md`, pushed as `b831fd3`; run 39039616528 green.
7. **Owed → `imnstr/open-work.md` 0.13:**
   - F-13: run `report` in the container; `reset-content` at the founder's word, after F-12;
   - F-14: the plan changelog for B8;
   - S-18: the podcast counts, at B7;
   - V-8: real aggregator formats, after MS3.
8. **Stale canon:** plan §6.4 (`recordKeysPerMonth`) and §5 B8 (`report(db, …)`, the bot pattern), in the record and as F-14.
9. **Stage list and owed rows** in the development README. Status column 8 is now `7/10`.
10. **Learnings:** below. Lane report item 7 (long heredocs with apostrophes fail in Bash; the Write tool works) is lesson 3.
11. **Done:** on `main`, deployed. The worktree and branch are removed. `git worktree remove` couldn't delete the folder (Permission denied) but unregistered it, and the empty folder was removed by hand. Local `main` fast-forwarded to `b831fd3`.

## Output
- imnstr: `c45d60a` (the lane's commit, rebased), `d6da7f6` (review), `b831fd3` (record). `main @ b831fd3`, deployed.
- root-sot: `imnstr/open-work.md` 0.13; a new `STATE.md` block; `lifecycle/status.md` column 8 `7/10`; this log.

## Spec gaps
- **`verify` can't read a server-side CLI's output.** The card asked the verify to read `report` in the container. The reviewer has no server access, so it became founder item F-13. `verify`'s reference file should say that a server CLI check belongs to the founder. Cards shouldn't promise it of the reviewer. (Same shape as B5's signed-in check.)
- **A destructive production command "at the founder's word"** has no place in the skill. `reset-content --yes` was in the card's *What the verify deploys*, but it also hangs on F-12 and on a backup. The verify ended without it, which was right, but the skill should say plainly that verify never runs destructive steps on production. It lists them for the founder.
- **Step 4 before step 1.** When the base has moved, rebasing first means the review reads what will ship, and finding (a) only showed after the rebase. The skill's order (read, check, fix, then merge `main`) would have reviewed code that no longer existed as such. The skill should say: if `main` moved, rebase or merge first.
- **A test that lists routes by hand goes stale across parallel lanes.** AC-47's fixed list was right at the lane's base and wrong at merge. Checklist §1 could say: "checks over 'every route' enumerate the router".

## Template sample
The stage record kept B5's headings: *Built* (with *The review changed*), *Decided* (with *Where the plan or card was wrong*), *Owed*, *Flagged for close-out*, *Verification* (*How the checklist was checked*: by test, by reading; the deploy; the ceiling). All should be required. *By hand in Edge* was dropped: B8 has no screen.

## Missing foundation
- No way for the reviewer to run a CLI in the production container. The founder runs it (F-13).
- No shared "list the app's routes" test helper: `auth-guard.test.ts` and now `record.test.ts` each filter `app.routes`. A `tests/routes.ts` helper would keep the two in step.

## Founder Q&A
None asked during the session. The push to `main` followed config §7. `reset-content --yes` was not run: it needs the founder's word and F-12 first. It is asked in the closing message as F-13.

After the wrap-up, the founder reported F-12 done (signed in and as a viewer) and ran F-13 at the server. Asked whether the outputs were needed, the review first checked the live log and feeds (empty, as expected after the reset), then asked only for the `report` output and the reset's lines; they were pasted and closed F-12 and F-13 (open-work 0.14). `report` showed en landing 3, log 1; fa log 3, landing 2: the record counts in production, and the CLI runs in the image.

## Skill shape
Opus, high. The server-only M stage had a clean core, but its edges were in the domain: who fetches a page (fediverse previews) and what a test's list misses after a rebase. Reasoning found those, not running suites. Forked, with the report, stat, card, plan §5 and checklist injected. The skill should also inject `git log origin/main` against the lane's base, so a moved `main` is seen first. Its reference file should hold the stop-file list, reading a CI run through the API, and which checks belong to the founder: signed-in screens, server CLIs, destructive production commands.

## Lessons
1. **Rule:** a test that claims "every route" or "every page" enumerates the router; it never holds a hand-written list. **Event:** AC-47's signed-in check named three paths. B5 landed in parallel and added three admin reads the check never touched. It was found only because the review rebased first (~5 min). **Scope:** IMNSTR tests and any parallel-lane build. **Destination:** `review-checklist.md` §1 (AC-47 line) and `brief-common.md`. **urgent: no** (B6/B7 cards can carry it).
2. **Rule:** a public-traffic count excludes link-preview fetchers by name, not only things that say "bot". Fediverse servers fetch a shared URL once per receiving server. **Event:** B8's pattern would have counted each Mastodon server's preview fetch as a view; fixed at review (~10 min). **Scope:** any analytics-like counting. **Destination:** the build plan's PD-20 at F-14; the lifecycle's research notes for similar modules.
3. **Rule:** write long or quote-heavy text (commit messages, multi-line files) with the Write tool or a quoted heredoc (`<<'EOF'`), never inline in a double-quoted Bash string. **Event:** the B8 lane's heredocs with apostrophes failed to parse; the review used quoted heredocs and Node scripts in the scratchpad without trouble. **Scope:** every session on this machine. **Destination:** the build-machine memory and `brief-common.md`.

## Cost
*Founder fills in.*

## Next
F-13 at the server (`report` now; `reset-content` after F-12, at the founder's word). Then 8a B6 (slot A), whose card takes S-17 and the B5 180 px lesson. Then B7, whose verify checks S-18. V-8 after MS3's deploy.
