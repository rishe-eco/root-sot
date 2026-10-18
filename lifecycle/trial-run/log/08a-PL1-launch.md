# 08a PL1 launch — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **medium** effort, which matches the README's table for 8a. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a pl1. Model: Opus, effort: medium." Claude desktop app (Code tab), working directory `E:\_root`. The prompt matched the state: `STATE.md`'s top block (9b) named 8a PL1 as next, and `briefs/` held no PL1 card. root-sot pulled at `5e3fa45` (already current).

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `build-phase` and `handoff`.
- `STATE.md`: the top two blocks (9b; 9).
- **Change note 05, whole** (0.2): it is the stage's spec.
- `lifecycle/projects/imnstr/config.md` §1–§8 and `brief-common.md`, whole.
- `briefs/B9.md` and `log/08a-B9-launch.md`, as the model card and log.
- *Outside the read order:*
  - two memory notes on this machine (`imnstr-build`, `rishe-eco-git-identity`), to find the checkouts and check the identity;
  - in the code repo at `b894598`, to check the note's line numbers and find tests PL1 ends: `admin/composer.tsx:300–308`, `admin/admin.css:136–153`, `passkeys.tsx:178`, `episode-form.tsx:176`, `lib/entries.ts:208`, `routes/admin-api.ts:52–60`, `views/layout.tsx:89`; by grep: `press('Tab')`, `btn--solid`, `toBeDisabled` on the language control, "newer" and `rel="prev"`, the owner line and the footer joke, and every test date after the fixture clock; the contexts of `editor.spec.ts:383–400` and `:660–690`, `admin-podcast.spec.ts:505–537`, `log.test.ts:180–199`.

  They settled three things for the card:
  - **Every line number the note cites held.** `main` hadn't moved since `b894598` (`git log b894598..origin/main` empty).
  - **One test pins the lock PL-8 ends:** `editor.spec.ts:399` asserts the language control is disabled after Save draft. Two others assert it disabled while a send is unanswered, which PL-8 keeps. The card names both kinds, so the lane neither keeps the first nor "fixes" the second two.
  - **The tests banning "newer"** (`log.test.ts:199`, `entry.spec.ts:60`) are on the entry page, which gets no Newer row. No conflict.

## Gate
By hand:
- Note 05 0.2 has a **Stages** section with PL1. No `STALE` in the status row. 9b's block names 8a PL1 next.
- Lanes in flight: none (`git worktree list` showed only the main checkout). Port 4110 free.
- PL1 depends on nothing unbuilt: B1–B9 are on `main` and deployed.
- `git config --local user.email` is the founder's in root-sot and in the new worktree. `C:` 9.4 GB free, `E:` 13 GB; PL1 needs no Docker.

Result: pass.

## Did
1. Gate (step 1). **No founder question:** the note settled every product call, and the founder accepted its one exception (0.2).
2. Re-read the note against the code at `b894598` (the 9b block asked for `git log b894598..origin/main` first: empty). Checked a sample of its line numbers and grepped for tests pinning what PL1 ends (the B9 lesson).
3. Drafted the card (step 2). It is 914 words with the header and table. It doesn't restate the note: it points the lane at it, whole, and settles only what the note leaves open:
   - the full run belongs to the verify (*Spec gaps*);
   - the tests that change on purpose, and those that must not;
   - the targeted files to rerun after each commit;
   - stop only at a commit boundary;
   - the fixture dates stay;
   - the Persian placeholders go in report item 4.

   Committed as `briefs/PL1.md`, `5d283d1`, and pushed. Moved the read-only checkout `E:\_root\root-sot-imnstr` to `5d283d1`.
4. Assigned resources (step 3): slot A, port `4110`, `.tmp/e2e.db`, branch `pl1-live-polish`.
5. Made the worktree by hand: `git worktree add -b pl1-live-polish` from local `main` (= `origin/main @ b894598`), no upstream. Checked the identity there.
6. Launched a background Sonnet lane (step 4). The prompt gives the paths of the common brief and the card, an identity check before the first and last commit, the backtick rule (B9's verify slipped on it), and a report to `.tmp/PL1.report.md` as well.
7. Recorded the lane in `STATE.md` (step 5).

## Output
- `imnstr/modules/01-website/briefs/PL1.md`, `5d283d1`.
- The `STATE.md` block and this log, in the next commit.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\pl1-live-polish`, branch `pl1-live-polish`, local.

## Spec gaps
- **A change note's *Tests* can contradict `brief-common`.** Note 05 ends PL1's tests with "the full run before the report"; `brief-common` says lanes never run the full suites, and the verify owns PL-12. `spec change` wrote the note as if for a plan's §5 without the lane rules beside it. The card sided with `brief-common`. `spec` (`change` mode) should name the full run as the verify's, as `build-plan` does.
- **A detailed change note leaves a card little to do.** Note 05 already names every file, line, test and trap. The card's work was checking it against the code, grepping for tests the stage ends, and the lane rules. This is a lighter 8a than a plan-driven stage: `build-phase` could, on the Change track, emit a short card that defers to the note, as this one did.
- **"Stop at a commit boundary"** is in the note's *Size* but not in `brief-common`'s stop rules, which say only "commit your work in progress". For a stage planned in commit groups, the boundary rule is better: the card states it. `brief-common` could say "at the last commit boundary, if the card defines them".

## Template sample
*Your lane* · *Read, in this order* · *Order, and where you may stop* · *What this card settles* · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: *Your lane*, *Read*, *What the verify deploys*, *Done*, *Not here*. *What to build* is replaced by *What this card settles* when a change note holds the build spec.

## Missing foundation
- No `bin/gate`: checked by hand.
- `config.md` §4 still lists only B-stage branch names; change stages take a two-letter prefix by precedent (CD1, PL1), as log 08e noted.

## Founder Q&A
None asked.

## Skill shape
Opus, medium. Not forked; it holds the lane. On the Change track with a note this full, the work is a fidelity check, not drafting: inject `git log <note's base>..origin/main`, and greps for tests pinning absences or locks the stage ends (`toBeDisabled`, `not.toMatch`, `not.toContain`, class names the note deletes). Its reference file should hold the card headings above, and the rule that a card defers to the note rather than restating it.

## Lessons
- **Rule:** when a change note supplies the stage's tests, check them against `brief-common`'s test rules before drafting the card; where they disagree, the card follows `brief-common` and names the verify as owner. **Event:** note 05 told the lane to run the full suites, which `brief-common` forbids (one heavy runner at a time on this machine); caught at drafting, no cost. **Scope:** `spec` (`change` mode), `build-phase` launch. **Destination:** `skills-plan.md` `spec` change mode. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land PL1, when the lane reports: in this session if it comes back here. Then 8c, verify PL1 (Opus · high, fresh session): full run; the founder's word before the deploy push.
