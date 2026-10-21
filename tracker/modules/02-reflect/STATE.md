# Reflect — state

*Newest block first. Written by handoff, and by build-phase when it launches or lands a lane.*

## 2026-10-22 · 8a launch B3 · main @ 5fb16f3 · rishe-eco/tracker main @ 8644681

*Replaces the 9 revise block's next step 1, because B3 is launched. That block's carry-overs, questions and owed items still stand. Its carry-over on the past-entry `step` is settled: B6 fixes it (`07-build-plan.md` §6.1 correction), and B3's card names it under Not here.*

**What was done**
- The card is `tracker/modules/02-reflect/briefs/B3.md` (`8ce393b`). Its body is about 800 words, a little over the 500–700 range. B3 needs no P0 item. The code check found the SDL and resolvers already in place, so B3 is services and tests only.
- The card decided four things for verify to confirm. Matching is per sentence, so a trigger that spans a sentence break doesn't match. The returned sentence is trimmed and drops its terminator. The nested-trigger test uses a fixture pack, because `en` v1 has no nested pair. The lane runs on branch `reflect-b3-catches` in slot A.
- One test changes on purpose: B2's "offer is null until B3" in `api/src/__tests__/reflect.integration.test.ts`. It now surfaces an offer, because `betrayed` is a faux feeling.
- The worktree was made with `git worktree add` from local `main @ 8644681`, and the Sonnet lane is running in the background.

**Lanes in flight**
| Stage | Branch (base) | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| B3 (M) | `reflect-b3-catches` (`main @ 8644681`) | A: test database `<worktree>/api/prisma/test.db`; no ports (no e2e) | `<checkout>/.claude/worktrees/reflect-b3-catches` | `briefs/B3.md` | running |

**Next steps, in order**
1. Opus, medium effort, from the tracker checkout on `main`, once the lane's report is at `<checkout>/.claude/worktrees/reflect-b3-catches/.tmp/B3.report.md`: `/build-phase tracker/modules/02-reflect B3 --land`

**Carry-overs**
- The open-work row on the fold copy belongs to B3's verify. The card holds the lane to `ARABIC_FOLDS` and `normalizeForMatch` byte-identical to the copy in `reflectContent.unit.test.ts`.
- A proposal for `brief-common.md` at the next verify: every cooldown test uses a fixed clock (`vi.useFakeTimers({ toFake: ["Date"] })`).

## 2026-10-22 · 9 revise (change request 01) · main @ 53a6bcb · rishe-eco/tracker main @ 8644681

*Replaces the 8c verify B2 block's next step 1 (`/revise` is done) and its question on `step` in a past entry (decided below). Its next step 2, carry-overs, remaining questions and owed cleanup stand, and are copied below. The 8c verify B1 block's carry-overs still stand.*

**What was done**
- `/revise` ran on the spec from change request `changes/01-req-past-entries-and-journey-gaps.md` (`53a6bcb`). Spec `02-spec.md` goes 0.1 to 0.2.
- D-4 is accepted: any closed entry with written text is listed as a past entry. A past-entry type carries no `step` or outcome (AC-48). AC-48 to AC-65 are new, and AC-14, AC-37 and AC-46 are amended. G1 to G17 and the rule-setting W-calls are written into the spec. Decisions are in `decisions.md`.
- The journeys' column 3 is marked STALE. `07-build-plan.md` has correction lines in place of a STALE column 7, at the founder's word.
- root-sot: `team/open-work.md` 0.13 strikes the `step` row, and `lifecycle/status.md` is updated.

**Next steps, in order**
1. Opus, medium effort, from the tracker checkout on `main`, slot A: `/build-phase tracker/modules/02-reflect B3`

**Carry-overs**
- Persian is the open research gap (spec R2). Every push to the code repo's `main` deploys. Tracker `main` and `origin/main` are level.
- B2 shipped `reflectPastEntry` returning `step`, which AC-48 now forbids. Check the build plan's correction lines for which stage fixes it, and have B3's card, or the first card that touches the past-entry type, name it.
- Open-work in `team/open-work.md`: B3 owes the fold copy. Past the ceiling: the founder's sign-in after B2's deploy, after B1's, a Persian reader's pass on the `fa` surface, and B0's Linux Chrome run.
- Stale canon for `close-out`: `docs/development/B0.md`, `B1.md` and `B2.md` (B2: `02-graphql-api.md`, convention 11's second guard message, D-1 no account deletion, the plan's "every field and argument name" wording).
- `config.md`'s *Lane worktrees* row says the Agent tool's isolation makes them. `build-phase` uses `git worktree add`, so the row is to correct. Proposals for `brief-common.md`, not applied: fresh-worktree setup order, no backticks in SDL doc strings, write long files with the Write tool.

**Questions for the founder**
- Approve the calm-close copy, `en` and `fa`, and whether it names a trusted person or a professional? Owed by: B7 (P0-1).
- Veto any of PD-2, PD-3, PD-5, PD-6, PD-7, PD-8, PD-10, PD-11 or G6's split (`07-build-plan.md` §10)? Owed by: the card for the stage each touches. B2 built PD-7, PD-8 and PD-11.
- Lock the outcome above RFL-1 in `ecosystem/ost.md`, and who reads M1–M6? Where do database backups go, the box only or off it? Owed by: nothing yet.

**Owed**
- The post-deploy check for B2: an unauthenticated `POST /graphql` with `{ reflectHome { hasPast } }` returns `Unauthorized` on production (bot user agent). Not recorded as run.
- Tracker cleanup: `git worktree remove` for `.claude/worktrees/reflect-b0-e2e-lanes` and the B2 worktree if still present, and `git branch -d reflect-b0-e2e-lanes reflect-b1-schema-content reflect-b2-entry-api` (if they exist).
- root-sot `main` is 2 commits ahead of `origin/main` (not pushed).

## 2026-10-22 · 8c verify B2 · main @ 014de4e · rishe-eco/tracker main @ 8644681

*Replaces the 8b land B2 block's lane row and its next step 1 (`/verify B2` is done). Its next step 2, carry-overs, questions and owed cleanup stand, and are copied below. Adds to the 8c verify B1 block's carry-overs, which stand.*

**What was done**
- `/verify B2` passed. The record is `docs/development/B2.md` in the code repo (`8644681`). It ran the lane's six files (107 passing), `tsc` clean, the full API suite once for `clearDb` (67 files, 1,203 passed), and probes over HTTP on a scratch database. All nine of the card's calls and the lane's own calls are accepted there.
- The review extended two fences (`1eba5e0`): the SDL fence now reads `extend type`, and the model-call fence reads raw queries and bracketed accessors. Both gaps were planted in the repo first and passed. The capture note is `lifecycle/learnings/inbox/2026-10-22-verify-B2.md` (`014de4e`).
- root-sot: open-work rows (`f5ccbec`), column 8 at 3/8 and state of the build 0.36 (`0969e92`). Tracker `main` and `origin/main` are level as of this block, and the B2 branch's worktree is gone.

**Next steps, in order**
1. Opus, medium effort, from the tracker checkout on `main`: `/revise tracker/modules/02-reflect`
   (for D-4: an entry stopped with writing but no story is kept yet never listed or deletable; and to write G1–G17 and the accepted W-calls into the spec. Before B6's card.)
2. Opus, medium effort, from the tracker checkout on `main`, slot A: `/build-phase tracker/modules/02-reflect B3`

**Carry-overs**
- Persian is the open research gap (spec R2). Every push to the code repo's `main` deploys.
- Open-work in `team/open-work.md`: B3 owes the fold copy. New rows: `reflectPastEntry` returns `step`, which shows a past entry was stopped (D-9 says never), so the founder decides before B6's card. Past the ceiling: the founder's sign-in after B2's deploy, after B1's, a Persian reader's pass on the `fa` surface, and B0's Linux Chrome run.
- Stale canon for `close-out`: `docs/development/B0.md`, `B1.md` and `B2.md` (B2: `02-graphql-api.md`, convention 11's second guard message, D-1 no account deletion, the plan's "every field and argument name" wording).
- `config.md`'s *Lane worktrees* row says the Agent tool's isolation makes them. `build-phase` uses `git worktree add`, so the row is to correct. Proposals for `brief-common.md`, not applied: fresh-worktree setup order, no backticks in SDL doc strings, write long files with the Write tool.

**Questions for the founder**
- Should a past entry show whether it was stopped (`step` kept), or should the past-entry type drop `step` (D-9)? Owed by: B6's card.
- Approve the calm-close copy, `en` and `fa`, and whether it names a trusted person or a professional? Owed by: B7 (P0-1).
- Veto any of PD-2, PD-3, PD-5, PD-6, PD-7, PD-8, PD-10, PD-11 or G6's split (`07-build-plan.md` §10)? Owed by: the card for the stage each touches. B2 built PD-7, PD-8 and PD-11.
- Lock the outcome above RFL-1 in `ecosystem/ost.md`, and who reads M1–M6? Where do database backups go, the box only or off it? Owed by: nothing yet.

**Owed**
- The post-deploy check: an unauthenticated `POST /graphql` with `{ reflectHome { hasPast } }` returns `Unauthorized` on production (bot user agent). This session didn't record that it ran.
- Tracker cleanup: `git worktree remove` for `.claude/worktrees/reflect-b0-e2e-lanes` and the B2 worktree if still present, and `git branch -d reflect-b0-e2e-lanes reflect-b1-schema-content reflect-b2-entry-api` (if they exist).

## 2026-10-21 · 8b land B2 · main @ d95dfd9 · rishe-eco/tracker main @ 871a2c1

*Replaces the 8a launch B2 block's lane row and its next step 1. Its next step 2, carry-overs, questions and owed cleanup stand, and are copied below.*

**What was done**
- The lane returned two commits on `reflect-b2-entry-api`: `a9fecc4` (the services, SDL, resolvers, `clearDb` and 28 integration tests) and `1641acf` (the fences). The author is the same as on `main`, with the Sonnet co-author line on both.
- Measured from `871a2c1`: +810 app, +763 tests, nothing moved, against size L. The run took 14.7 min and 188k tokens after one resume; the first run, cut off by a network error, wasn't recorded. `main` hasn't moved since the base, so nothing overlaps.
- The report is `tracker/modules/02-reflect/briefs/B2.report.md` (`d95dfd9`). The lane ran six targeted files, 107 passing, and `tsc` was clean.

**Lanes in flight**
| Stage | Branch (base) | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| B2 (L) | `reflect-b2-entry-api` (`main @ 871a2c1`) | A: test database `<worktree>/api/prisma/test.db`; no ports | `<checkout>/.claude/worktrees/reflect-b2-entry-api` | `briefs/B2.md` | landed |

**For verify to decide**
- **The card's nine calls** (`briefs/B2.md`, *Decided here*), above all:
  - a move to the current step is a no-op;
  - bounds are counted in UTF-16 units;
  - the state is pinned on the first start only;
  - word source, met and the pre-check are GraphQL enums.
- **The lane's own calls** (report part 4):
  - every Reflect write for one user runs under the `rfl-entry` lock, not only start;
  - `ensureOwned` is called inside the services;
  - `prompts` is fully typed, and `limits` carries more than §6.4;
  - the SDL fence refuses `lexicon` and `lastCatchAt` too;
  - `storyStart` drops a trailing half surrogate pair;
  - `reviewStatus` is Reflect's pack's only;
  - the schema-level test uses `ApolloServer.executeOperation`.
- **Card checks the lane didn't do:**
  - the post-deploy check, an unauthenticated `reflectHome` returning `Unauthorized` on production;
  - the server's read-only plugin against a read-scope mutation;
  - the `console` and "type outside the block" rules, which are planted only in the scanner's own strings, not in the repo.
- **What the deploy runs:** unchanged. The merge adds 14 live, unlinked operations, and no migration.
- **Departures** (report part 5): the plan's "every field and argument name" is read as operation and type names, per the card. Canon made stale: `02-graphql-api.md`.
- **Proposals for `brief-common.md`** (report part 7):
  - a fresh worktree needs `npm install`, `prisma generate` and a copied `api/.env`, in that order;
  - SDL doc strings can't hold backticks;
  - long heredocs in Git Bash fail, so write files with the Write tool.

**Next steps, in order**
1. From the tracker checkout on `main`, Opus, high effort (it runs forked): `/verify tracker/modules/02-reflect B2`
2. Before B6's card is drafted, run `/revise` (Opus, medium) on the spec for D-4 (an entry stopped with writing but no story is kept yet never listed or deletable) and to write G1–G17 and the accepted W-calls into the spec.

**Carry-overs**
- Open-work in `team/open-work.md`: B3 owes the fold copy. Past the ceiling: the founder's sign-in after the first migration deploy, a Persian reader's pass on the `fa` surface, and B0's Linux Chrome run.
- Stale canon for `close-out`: listed in `docs/development/B0.md` and `docs/development/B1.md`, and now `02-graphql-api.md` for B2.
- `config.md`'s *Lane worktrees* row says the Agent tool's isolation makes them. `build-phase` makes them with `git worktree add`, so the row is for the next verify to correct.
- Every push to the code repo's `main` deploys.

**Questions for the founder**
- Push tracker `main` (`871a2c1`; docs only, but the push deploys)? Owed by: nothing.
- Approve the calm-close copy, `en` and `fa`, and whether it names a trusted person or a professional? Owed by: B7 (P0-1).
- Veto any of PD-2, PD-3, PD-5, PD-6, PD-7, PD-8, PD-10, PD-11 or G6's split (`07-build-plan.md` §10)? Owed by: the card for the stage each touches. B2 built PD-7, PD-8 and PD-11.
- Lock the outcome above RFL-1 in `ecosystem/ost.md`, and who reads M1–M6? Where do database backups go, the box only or off it? Owed by: nothing yet.

**Owed**
- Tracker cleanup: `git worktree remove .claude/worktrees/reflect-b0-e2e-lanes` (prunable), and `git branch -d reflect-b0-e2e-lanes reflect-b1-schema-content` (both merged).

## 2026-10-21 · 8a launch B2 · main @ 8131c8a · rishe-eco/tracker main @ 871a2c1

*Partly completes the 8c verify B1 block: its next step 1 (`/build-phase B2`) is launched here. Its next step 2, carry-overs, questions and owed cleanup stand, and are copied below.*

**What was done**
- The B2 card is `tracker/modules/02-reflect/briefs/B2.md` (`0b936ee`), with 915 words of body. That's over the 700 target and under 1,000: the extra is the code check's findings.
- The code check found the following, and the card settles each:
  - Tracker already has a private `requireSession(ctx)` in `mutations.ts`, so Reflect's wrapper is named `requireReflectSession`, in `graphql/auth.ts`.
  - `makeCtx` sets no `auth`, so the Reflect tests build their own session and token contexts.
  - Noticing owns `NtcReflectCopy`, so a Reflect type is one whose name starts with `Reflect`.
  - No test in the repo fakes the clock yet, and Prisma's `@default(now())` can't be faked, so services write `createdAt` and `closedAt` themselves.
  - `clearDb` gains Reflect's tables.
- Worktree made, and the lane launched on Sonnet in the background.

**Lanes in flight**
| Stage | Branch (base) | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| B2 (L) | `reflect-b2-entry-api` (`main @ 871a2c1`) | A: test database `<worktree>/api/prisma/test.db`; no ports (no e2e) | `<checkout>/.claude/worktrees/reflect-b2-entry-api` | `briefs/B2.md` | running |

**Next steps, in order**
1. From the tracker checkout on `main`, Opus, medium effort, once the lane's report is at `<checkout>/.claude/worktrees/reflect-b2-entry-api/.tmp/B2.report.md`: `/build-phase tracker/modules/02-reflect B2 --land`
2. Before B6's card is drafted, run `/revise` (Opus, medium) on the spec for D-4 (an entry stopped with writing but no story is kept yet never listed or deletable) and to write G1–G17 and the accepted W-calls into the spec.

**Carry-overs**
- The card's *Decided here* (nine calls, among them a same-step move as a no-op, bounds in UTF-16 units, state pinned on first start only, enums for word source, met and the pre-check) is for verify B2 to rule on.
- Open-work in `team/open-work.md`: B3 owes the fold copy. Past the ceiling: the founder's sign-in after the first migration deploy, a Persian reader's pass on the `fa` surface, and B0's Linux Chrome run.
- Stale canon for `close-out`: listed in `docs/development/B0.md` and `docs/development/B1.md`.
- `config.md`'s *Lane worktrees* row says the Agent tool's isolation makes them. `build-phase` makes them with `git worktree add`, so the row is for the next verify to correct.
- Every push to the code repo's `main` deploys.

**Questions for the founder**
- Push tracker `main` (`871a2c1`; docs only, but the push deploys)? Owed by: nothing.
- Approve the calm-close copy, `en` and `fa`, and whether it names a trusted person or a professional? Owed by: B7 (P0-1).
- Veto any of PD-2, PD-3, PD-5, PD-6, PD-7, PD-8, PD-10, PD-11 or G6's split (`07-build-plan.md` §10)? Owed by: the card for the stage each touches. B2's card builds PD-7, PD-8 and PD-11.
- Lock the outcome above RFL-1 in `ecosystem/ost.md`, and who reads M1–M6? Where do database backups go, the box only or off it? Owed by: nothing yet.

**Owed**
- Tracker cleanup: `git worktree remove .claude/worktrees/reflect-b0-e2e-lanes` (prunable), and `git branch -d reflect-b0-e2e-lanes reflect-b1-schema-content` (both merged).

## 2026-10-21 · 8c verify B1 · main @ 0364c16 · rishe-eco/tracker main @ 871a2c1

*Replaces the 8b land B1 block's lane rows and its next steps 1 and 2 (`/verify B1` is done, and B0 and B1 are merged and deployed). Its next step 3 is copied below. Answers the 8a launch B1 and 8b land B1 blocks' questions on merging B0 and pushing root-sot. The 7 build-plan block's carry-overs and remaining questions stand.*

**What was done**
- `/verify B1` passed. The record is `docs/development/B1.md` in the code repo. Verify fixed the schema fence (named-argument indexes, bare id links: `15466f9`), AC-45's fence (follows Reflect's imports: `f6984c3`) and the pack's scope and labels (`b7ad796`), then merged B0 into B1 (`2fdfa87`).
- `main` fast-forwarded `5fd71c9..b882894` (B0 and B1 together) and was pushed with the founder's word. Deploy run https://github.com/rishe-eco/tracker/actions/runs/39630883685 is green; `add_reflect` is live. Both stage records cite it (`871a2c1`, not pushed: pushing deploys).
- root-sot: config edits approved after verify B0 applied (`9239f4f`); column 8 at 2/8, open-work rows, state of the build 0.35, capture note `lifecycle/learnings/inbox/2026-10-21-verify-B1.md` (`1a31940`); `brief-common.md` 0.3, the Windows `migrate dev` and CRLF notes (`0364c16`). root-sot `main` is pushed.

**Next steps, in order**
1. From the tracker checkout (`main`), Opus, medium effort, slot A or B: `/build-phase B2`
2. Before B6's card is drafted, run `/revise` (Opus, medium) on the spec for D-4 (an entry stopped with writing but no story is kept yet never listed or deletable) and to write G1–G17 and the accepted W-calls into the spec.

**Carry-overs**
- Open-work in `team/open-work.md`: B3 owes the fold copy; past the ceiling are the founder's sign-in after the first migration deploy, a Persian reader's pass on the `fa` surface, and B0's Linux Chrome run.
- B1 left `clearDb` for B2 (`briefs/B1.md`, *Decided here*).
- Stale canon for `close-out`: listed in `docs/development/B0.md` and `docs/development/B1.md` (`01-data-model.md`, the decision-log migration note, convention 13's spending on `lastCatchAt`, `CLAUDE.md`'s e2e and Edge paragraphs, `03-engineering/01-testing.md`).
- Persian is the open research gap (spec R2). Every push to the code repo's `main` deploys.

**Questions for the founder**
- Push tracker `main` (`871a2c1`, the deploy URL in the two stage records; docs only, but the push deploys)? Owed by: nothing.
- Approve the calm-close copy, `en` and `fa`, and whether it names a trusted person or a professional? Owed by: B7 (P0-1).
- Veto any of PD-2, PD-3, PD-5, PD-6, PD-7, PD-8, PD-10, PD-11 or G6's split (`07-build-plan.md` §10)? Owed by: the card for the stage each touches.
- Lock the outcome above RFL-1 in `ecosystem/ost.md`, and who reads M1–M6? Where do database backups go, the box only or off it? Owed by: nothing yet.

**Owed**
- Tracker cleanup: `git worktree remove .claude/worktrees/reflect-b0-e2e-lanes` (prunable), and `git branch -d reflect-b0-e2e-lanes reflect-b1-schema-content` (both merged).

