# 08a B3 launch — 2026-10-11

## Session
Opus 5.5 (`claude-opus-5-5`), medium effort (stated by the founder). Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, B3. Model: Opus, effort: medium." Claude desktop app (Code tab), working directory `E:\_root`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `build-phase`.
- `STATE.md`, the step-8c block (top).
- Plan 0.2: §5 B3 in full; §0.4 (to find B3's defects: none); the PD lines by grep, to pick the ones B3 needs; §6.1–§6.7.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole. `imnstr/open-work.md`, for S-2.
- Spec: heading list, and B3's AC lines by grep.
- Design: the README by grep for plates; plate titles from `04-wireframes.html` (the design export's plates aren't greppable; it is bundled), since the design keeps the wireframes' numbering.
- *Outside the read order:*
  - two memory notes on this machine (`imnstr-build`, `root-repos-layout`), to find the checkouts;
  - `log/08a-B1-launch.md` whole, and the *Lessons* and *Next* of the 08b and 08c logs, for the urgent carry-overs (report survival, 180 px, `app.ts`);
  - `docs/development/B1.md` *Decided* to *Flagged* in the code repo, to see what B1 built and owes;
  - the code: `app.ts`, `routes/public.tsx`, `routes/test.ts`, the exports of `lib/*`, `tests/e2e/support.ts`, `tests/helpers.ts`, the feed and log links in `views/`, the Playwright web server, `package.json` scripts. Needed so the card says what to reuse and doesn't ask for what exists (the feed `rel="alternate"` is already in `Layout`).

## Gate
By hand. Plan 0.2 exists and holds §5 B3. Status row: 0–7 `done`, column 8 `1/10`, nothing `STALE`. B3 depends only on B1, which is on `main @ 7ebc220` (`git log origin/main`). Lanes in flight: none (`STATE.md`, `git worktree list`). Result: pass.

## Did
1. Gate (step 1), as above.
2. Drafted the card from §5 B3 and the code at `7ebc220` (step 2): about 720 words with the lane table, over the 700 ceiling by the table's markup. It applies the 8c carry-overs: e2e at 360 and 180 px, routes in `app.ts`, S-2, `npm install`, plan 0.2. Committed and pushed as `briefs/B3.md`, `403fdf0`, after a rebase over the founder's 8c cost commit.
3. Slot A, port `4110`, `.tmp/e2e.db`, branch `b3-public-log` (step 3).
4. Made the worktree by hand (`git worktree add -b b3-public-log`), and launched a background Sonnet lane with the paths of the common brief and the card (step 4).
5. Recorded the lane in `STATE.md` (step 5). Column 8 stays `1/10`; a launch changes no count.

## Output
- `imnstr/modules/01-website/briefs/B3.md`, `403fdf0`.
- The `STATE.md` block and this log: the commit after `403fdf0`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b3-public-log`, branch `b3-public-log`, local.

## Spec gaps
- **The card settles test plumbing the plan doesn't name.** Plan B3 says the CLI seeds entries "for MS2 and manual checks", but e2e needs a way to seed the running server's database too. I chose test-only routes calling the same insert as the CLI. `build-phase`'s checklist of "what a card must settle" should include *how e2e gets its data*.
- **`brief-common.md` points at `E:\_root\root-sot`**, which this machine doesn't keep current; 8a pulls `root-sot-imnstr`. Second time (8a B1 too). I put the right path in the card. `config.md` should name it.
- **The report-survival lesson (08a/08b, urgent)** isn't in `brief-common.md` yet: only the founder edits it. I put it in the card instead: the lane also writes its report to `.tmp/B3.report.md`, gitignored. It survives the session but not a worktree removal; a committed file would need a place that isn't the stage record.
- **The 500–700-word limit** is tight once a card carries the carry-overs of earlier reviews. Counted with the lane table, the card is ~720. The limit should exclude the table, or the carry-overs should live in `brief-common.md`.
- **Plan §6.7 lists AC-1 for B3**, but §5 B3's *Acceptance* doesn't. I left AC-1 out of the card's list; the nav and landing link already reach the log.

## Template sample
Same headings as B1's card: *Your lane* · *Read, in this order* · *What to build* · *Done for <stage>* · *Not here*. *Your lane* gained a `root-sot` row. All five required.

## Missing foundation
- No `bin/gate`: checked by hand.
- No card template: copied B1's shape.
- No root-sot path in `config.md` that 8a keeps current (above).

## Founder Q&A
None.

## Skill shape
As at 8a B1: Opus, medium; not forked; it holds the lane. Inject the top `STATE.md` block, `git log -1 origin/main` and `git worktree list` of the code repo, plan §5 for the stage, and the *Owed* table of `docs/development/README.md`. The reference file should hold the card template and the "a card must settle" checklist, now with *e2e data* and *where the report is written*.

## Lessons
- **Rule:** carry-overs a review marks "for every card" belong in `brief-common.md`, not repeated in each card. **Event:** the B3 card spends ~120 words on 180 px, `app.ts`, `npm install`, the root-sot path and report-to-file, all of which apply to B4a–B9 too; it pushed the card over its limit. **Scope:** IMNSTR project config. **Destination:** `lifecycle/projects/imnstr/brief-common.md`, through the founder. **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b; the figures are the whole session:*
- Opus 5.5: 76 in / 1.8k out / 3.8M cache read / 97.2k cache write.
- Cost $5.69; API 30 min; wall 10 min. The general-purpose subagent, the B3 lane, was 62% of it.
- The lane alone, from its completion notice: 275,496 tokens, 92 tool uses, about 28 min.
- Against 8a B1 ($6.35, lane 76%): the lane's share fell, and the orchestrator's rose by about $0.60 because 8b's land ran in the same session.

## Next
8b, land B3, in this session when the lane reports. If the session ends first, see the `STATE.md` block for where the report is.
