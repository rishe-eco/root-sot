# 8c B5 verify — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`), effort **medium**, as the founder stated. The trial table and config §8 say high for 8c; the founder set medium in the opening prompt, as at B4b. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c verify B5. Model: Opus, effort: medium." It ran beside an 8a/8b B8 session (slot B), which pushed `27acdb8` to root-sot during this one.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`, top block (8b B5); after the mid-session pull, the 8a B8 block above it.
- Inputs: `briefs/B5.report.md`; `git diff --stat origin/main...b5-entries-admin`; `briefs/B5.md`; build plan 0.6 §5 B5; `lifecycle/projects/imnstr/review-checklist.md` and `config.md`, whole.
- Code: the server diff whole (`lib/publish.ts`, `routes/admin-entries.ts`, the diffs of `lib/entries.ts`, `routes/admin-api.ts`, `shared/doc.ts`, `lib/escape.ts`, `lib/dates.ts`, `routes/test.ts`, `deploy/`), the admin diff whole (`admin/entries.tsx`, `admin/doc.tsx`, the diffs of `app.tsx`, `copy.ts`, `ui.tsx`, `passkeys.tsx`, `admin.css`, `tokens.css`), test names in `admin-entries.test.ts`, the `auth-guard` diff, and the head of `admin-entries.spec.ts` and `admin-support.ts` (to drive the screens).
- *Outside the read order:* the memory notes for this build; `docs/development/B4b.md` and the development README (the record's shape, the stage list); `imnstr/open-work.md`; `log/08c-CD1-verify.md` (this log's shape).

## Gate
Checked by hand:
- card, report and branch present (`b5-entries-admin` @ `e46ca71`, local, one commit, founder identity);
- plan §5 B5 present (0.6);
- status column 8 at `5/10`, nothing `STALE`;
- base `aa889cb` still `origin/main`, and local `main` equal to it;
- `user.email` the founder's in both repos.

**Gate passed.**

## Did
Mapped to `verify`'s eleven steps:
1. **Stat, then core files:** server first (publish, routes, entries, doc), then the admin, then the tests and the deploy check.
2. **Checklist §1–§3, §4 (the lines B5 touches), §5, §6.** The server held up: idempotency, validation order, S-11/S-12, no counts, no logs. Findings came from the screens and from reading:
   - (a) **At 200% zoom (180 px) the row overflowed by 61 px, and the name column collapsed to zero,** so titles vanished. The lane's e2e ran only at 360 px; the memory's "cards must require e2e at 180 px" didn't reach B5's card.
   - (b) An untitled **Persian row was quoted with English “ ”**, which read backwards in RTL.
   - (c) `--leading-read-fa: 1.8` **duplicated** the `:root:lang(fa)` value.
   - (d) `shared/doc.ts`'s regex held **literal U+FFFE/U+FFFF** where `escape.ts` had escapes. This is the Write-tool quirk the memory warns of.
3. **Fixed** (`0981ded`): rows stack below `20em`; «…» for Persian openings; the token reused; escapes built in Node. New e2e test at 180 px in both schemes.
4. **Merge `main`:** a no-op (`origin/main` = base).
5. **Reran:**
   - `npm run check`;
   - the lane's 19 Vitest files: 524 passed;
   - e2e `admin-entries`, `admin-auth`, `log` and `entry`: 154 passed before the fixes (`log` and `entry` because `escape.ts` changed and the lane hadn't run them);
   - `admin-entries` after the fixes: 20 passed.

   Drove the screens with a throwaway Playwright script on Edge's virtual authenticator, light and dark, 360 and 180 px, and looked at the screenshots. That is how (a) and (b) were found. shellcheck was not run: Docker Desktop was down. CI's `check` runs it before the deploy.
6. **Stage record** `docs/development/B5.md`. **Pushed `HEAD:main`** after checking the diff had no stop file or `.env` line. Run 39023965380 was green, then the live checks. The record commit `13d82dd` deployed as run 39024319296, green.
7. **Owed → `imnstr/open-work.md` 0.12:**
   - S-11 done;
   - S-4, S-5 and S-12 done server-side and moved on;
   - S-9 moved to B6;
   - new: F-11 (the plan changelog for B5, and optional copy review), F-12 (the founder checks the live list signed in), S-17 (lines for B6's card).
8. **Stale canon:** plan §5 B5's row actions and `republish`, in the record and as F-11.
9. **Stage list** and owed rows in the development README. Status column 8 is now `6/10`.
10. **Learnings:** below.
11. **Done:** on `main`, deployed. Worktree and branch removed; local `main` fast-forwarded to `13d82dd`.

## Output
- imnstr: `0981ded` (review), `13d82dd` (record). `main @ 13d82dd`, deployed.
- root-sot: `imnstr/open-work.md` 0.12; `STATE.md` block; `lifecycle/status.md` column 8 `6/10`; this log.

## Spec gaps
- **`verify` can't check a signed-in live screen.** Passkeys keep the reviewer out of production, so "the list renders on the live site" (card, *What the verify deploys*) became founder item F-12. The skill should say a live check behind auth is the founder's. Cards shouldn't promise it of the reviewer.
- **The 180 px rule isn't in the review checklist.** It lives only in memory notes and some cards. Checklist §5 says "zoom to 200% doesn't clip (HIG #8)" but lists no width or test, so the lane didn't test it and the e2e suite didn't catch it. It should read "e2e at 180 px". Same for `brief-common`.
- **Effort.** The table says high; the founder ran medium. A medium pass still found four defects, all in the UI, by driving the screens. That is the step that earned its cost.

## Template sample
The stage record kept B4b's headings: *Built* (with *The review changed*), *Decided* (with *Where the plan or card was wrong*), *Owed*, *Flagged for close-out*, *Verification* (*How the checklist was checked*: by test, by reading, by hand; the deploy; the ceiling). All should be required.

## Missing foundation
- No shellcheck on the build machine, and Docker Desktop down. CI is the only shellcheck.
- No reusable "drive the admin as a reviewer" script. A throwaway spec in `tests/e2e/` reused `admin-support.ts` and was deleted before the commit. A `scripts/review-shots.ts` taking seeds and widths would save each UI review about ten minutes.

## Founder Q&A
None asked. The push to `main` followed config §7 ("verify deploys by pushing `main`").

## Skill shape
Opus. Medium was enough for an M stage whose server side was clean. Forked, with the inputs injected: the report, the stat, the card, plan §5 and the checklist. The UI pass (screenshots at 360 and 180 px, both schemes) belongs in the skill as a fixed step with a project script. Its reference file should hold: how to read a CI run through the API, which live checks need the founder, and the stop-file list.

## Lessons
1. **Rule:** every UI stage's e2e and every UI review include 180 px (200% zoom), not just 360 px. **Event:** B5's rows overflowed 61 px and lost their names at 180 px; the lane's 54 e2e runs at 360 px passed. Found only by the reviewer's screenshots, ~10 min. **Scope:** IMNSTR UI stages, and the lifecycle's UI checklist. **Destination:** `review-checklist.md` §5 and `brief-common.md`. **urgent: yes** (B6's card is next).
2. **Rule:** never put backticks inside a double-quoted `node -e` string in Bash; write the script to a file or a quoted heredoc. **Event:** the record edit ran the backticked words as commands. They were harmless, but the record had to be rewritten, ~3 min. **Scope:** every session on this machine. **Destination:** the build-machine memory.
3. **Rule:** a list name built from an excerpt takes the entry's language's quotation marks. **Event:** “…” around Persian read backwards. **Scope:** IMNSTR B6/B7 admin lists. **Destination:** the B6 and B7 cards (S-17).

Lane report item 7 (say on the card that `STATUS` is parsed by `admin-copy.test.ts`; a shared signed-in e2e helper) goes to S-17 for B6's card.

## Cost
*Founder fills in.*

## Next
8b/8c B8 as its block says, rebased onto `13d82dd`. F-12 before B8's `reset-content` removes the MS2 seeds. Then 8a B6, whose card takes S-17 and lesson 1.
