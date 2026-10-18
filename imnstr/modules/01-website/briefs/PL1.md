# PL1 · Live-review polish — phase card

*For the Sonnet lane building PL1. Read `lifecycle/projects/imnstr/brief-common.md` first; this card adds to it. Drafted by `build-phase changes/05-live-review-polish.md#PL1` (trial step 8a), 2026-10-18, from change note 05 **0.2** (its PL1 section stands in for plan §5) and the code as it is: `rishe-eco/i-monster` `main @ b894598` (B1–B9 and CD1 verified and deployed; a push to `main` deploys). `main` hasn't moved since the note was written, so its line numbers hold.*

## Your lane

| | |
|---|---|
| Worktree | `E:\_root\imnstr\.claude\worktrees\pl1-live-polish`. **Your Bash calls don't start there:** begin every command with `cd /e/_root/imnstr/.claude/worktrees/pl1-live-polish &&`, and use absolute paths with Read, Edit and Write. Run `npm install --ignore-scripts` first, and `npm run build` before any admin e2e. |
| Branch | `pl1-live-polish`, from `main`, already checked out, no upstream. `git config --local user.email` is set; don't change it. |
| Slot | **A**: port `4110`, database `.tmp/e2e.db`. Every e2e command: `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 npx playwright test <spec> -g <name> --workers=1` |
| Size | **M** (2–4 h, ~1,300 lines). Stop at 8 h, per the common brief, **at a commit boundary** (below). |
| root-sot | Read it at `E:\_root\root-sot-imnstr`. Paths below are relative to `imnstr/modules/01-website/` there. |

## Read, in this order

1. **The change note, `changes/05-live-review-polish.md`: all of it.** Its PL1 section is your spec: *Files* says where each change goes (with line numbers), *Tests* says what proves each criterion, *Traps* says what will bite. *Acceptance criteria* (PL-1 to PL-12) and *What must not break* are what the verify checks.
2. In your worktree: `CLAUDE.md`; `docs/development/README.md` (*Owed*); `docs/development/B9.md` (the sweeps, `sweep-support.ts`, the 180 px and 200% checks). Then every file the note's *Files* names for the commit you are on, in full, before you edit it.
3. Spec `02-spec.md`, by grep: **AC-25, AC-30, AC-35, AC-42, AC-43** (`\*\*AC-42`).
4. Review checklist `lifecycle/projects/imnstr/review-checklist.md`, **§2, §3 and §5**.

You don't need the design export. Where the note cites plate 9 (F5), the place is where `<FailureNotice>` already sits in the code.

## Order, and where you may stop

Three commits, in this order, each green on its own targeted tests before the next starts:
1. **Public pages:** P1, P2, P4, F4.
2. **Admin look:** D1, D2, P3, F5.
3. **Admin rules and words:** F1, F2, F3.

If you reach the budget, finish nothing half-way: leave the tree at the last finished commit, report, and stop. A continuation lane takes the rest on this branch.

## What this card settles

**Tests are targeted; the full run is the verify's.** The note's *Tests* ends with "the full run before the report". That contradicts the common brief: **don't run `npm test` or `npm run e2e` unfiltered.** Run the files you add or change, plus every file that asserts a rule you touched (below). The verify runs the full suites for PL-12.

**Tests that change on purpose** (say each one in report item 2):
- `editor.spec.ts:399` asserts the language control is disabled after Save draft. PL-8 ends that: assert it is usable, and that a switch then Publish lands on `/fa/log` (the note's first F2 e2e).
- `editor.spec.ts:194` and `admin-entries.spec.ts:296` assert `btn--solid`: replace as the note's D1 tests say.
- `sweep.spec.ts:104`: the wordmark now takes two Tabs.

**Tests that must still pass unchanged:** the two "lost answer, then another language" tests (`editor.spec.ts` ~`:669`, `admin-podcast.spec.ts` ~`:514`). They pin the lock while a send is unanswered, which PL-8 keeps. If either fails, your lock is wrong, not the test. `log.test.ts:199` and `entry.spec.ts:60` ban "newer" on the **entry** page, which gets no Newer row: leave them.

**Files that assert rules you touch, rerun after each commit:**
- commit 1: `pages.test.ts`, `log.test.ts`, `podcast.test.ts`, `headers.test.ts`, `house-rules.test.ts`; `landing`, `log`, `entry`, `podcast`, `not-found`, `sweep` specs;
- commit 2: `admin-copy.test.ts`; `editor`, `admin-entries`, `admin-podcast`, `admin-auth`, `admin-sweep` specs;
- commit 3: `excerpt.test.ts`, `admin-entries.test.ts`, `admin-episodes.test.ts`, `admin-copy.test.ts`, `dates.test.ts`; `editor`, `admin-entries`, `admin-podcast`, `admin-sweep` specs.

**Fixtures dated after the clock** (`admin-podcast.spec.ts:150`, `:467`; `podcast.spec.ts:101`; `podcast.test.ts:96`, `:176`, `:177`): **don't move them.** They are why PL-9's exception exists. A new test that types a date computes it from the clock.

**F5 at 360 × 400:** if the long "Published." notice in the dock leaves fewer than two editor lines in view, drop its URL line inside the dock and keep Open and Copy link, as the note allows. Say which in item 4.

**Persian placeholders** (F4's two `newer` strings, P4's `skip`, P1's owner line): list each key and its text in item 4, so the verify adds them to F-2.

**`npm run check`** clean before each commit.

## What the verify deploys

A push to `main`: no stop file, no `.env` line, no migration, no new dependency. If you find you need any of these, stop and say so in item 5.

## Done for PL1

- PL-1 to PL-11 built, each with the tests the note's *Tests* names, run targeted, both languages, both schemes, at 360 and 180 where the note says so.
- Three commits (or fewer, at a stop), each ending with the co-author line.
- **Also write your report to `.tmp/PL1.report.md`** in your worktree, then give it as your final message, all seven parts. In item 3, give the run time of any sweep spec you ran.

**Not here:** the spec edit (a later `revise`); scheduled publishing; a language change on a published or "was live" item; page numbers, first or last links, `?after=`; a skip link in the admin; real Persian copy (F-2); `base.css`'s `overflow-wrap`; `viewport-fit=cover`; colours in `tokens.css`; anything under `deploy/`, `migrations/`, `Dockerfile`, `package.json`.
