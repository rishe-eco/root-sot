# 08a B1 launch — 2026-10-10

## Session
Opus 5.5, medium effort (stated by the founder). Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, B1. Model: Opus, effort: medium. The repo rishe-eco/imnstr exists."

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§6 (§5 and §6 are beyond the §1 read order; I needed §6 for the lane limits).
- `skills-plan.md` §0, `learned` (part of §1, read because it ran on from §0) and `build-phase`. I also read `debug` and `verify` (beyond the read order), which came in the same read, to see what the review would check in the card.
- `STATE.md`, the step-7b block.
- Build plan 0.1: §5 B1 in full; §4 (P0); §0.1–§0.4; the PD headers in §2, plus PD-5, PD-9 and PD-18 in full; §6.1–§6.6.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole.
- Spec: the heading list and the AC lines B1 owns (grep), to name sections in the card.
- Design README: "What's here", the start of "The design system it settles", and a grep for fonts and Persian, to name plates in the card.
- `lifecycle/status.md`.
- Outside the read order: two memory notes on this machine (`imnstr-build`, `root-repos-layout`), to find the checkout; `npm view @fontsource/<family> version` for all four families, to check the card's font instruction could be followed.

## Gate
By hand. The build plan exists, holds §5 B1, and the status row shows 0–7 `done` with nothing `STALE`. No lanes in flight (`STATE.md`). P0-1: `git ls-remote` on `rishe-eco/imnstr` showed `main @ 6e5a915`. Result: pass.

## Did
1. Gate (step 1), as above.
2. Drafted the card from §5 B1 and the code as it is, which is one README (step 2). 649 words. It names exact sections and settles what the plan leaves open (see Spec gaps). Committed and pushed as `briefs/B1.md` before the launch.
3. Assigned slot A, port `4110`, `.tmp/e2e.db`, and branch `b1-foundation` from `config.md` (step 3).
4. Cloned the code repo to `E:\_root\imnstr` and created the lane's worktree there by hand (see Spec gaps). Launched a background Sonnet subagent with the common brief and the card, which it reads from disk by path (step 4).
5. Recorded the lane in `STATE.md`, and set column 8 to `0/10` (step 5).

## Output
- `imnstr/modules/01-website/briefs/B1.md`, `1e00bce`.
- A `STATE.md` block, `lifecycle/status.md` column 8, and this log: the commit after `1e00bce`.
- Outside root-sot: the clone at `E:\_root\imnstr` and the worktree `.claude/worktrees/b1-foundation` on branch `b1-foundation`. Neither has been pushed.

## Spec gaps
- **The lane's worktree can't come from the Agent tool's `isolation: "worktree"`.** That isolation makes a worktree of the session's own repo, which is root-sot, not the code repo. I made it by hand with `git worktree add`. The Agent tool has no working-directory parameter, so the card tells the lane to `cd` in every command. `build-phase` should either run from the code repo (with root-sot added as a directory) or own the `git worktree add` step and the `cd` instruction.
- **Nobody is named to clone the code repo.** Plan P0-1 says "B1's lane clones it", but `config.md` puts lane worktrees inside the main checkout, so the clone must exist before the launch. I cloned it. The skill should check for the checkout in its gate and make it if it's missing.
- **The lane report goes back to the launching session.** If 8a's session ends before the lane finishes, the report, the only input of 8b, is lost. The skill spec assumes 8b is a separate session. Either the lane writes its report to a file on its branch, or 8a and 8b are one session. I recorded the risk in `STATE.md`.
- **The plan leaves things open that a card must settle**, and `build-phase` doesn't say the card may decide them: lint needs `eslint`, which isn't in §6.6; the fonts have no named source; "hashed names" has no mechanism; `PRELAUNCH` and `robots.txt` (PD-22, routes table) are B1's but not in §5 B1. I settled the first three in the card and left the hashing to the lane. The skill should say the card may add development dependencies and must list them.
- **"Launch with `brief-common.md` + the card"** doesn't say whether the text goes into the prompt or the lane reads it. I gave paths; it costs the lane one read and keeps the launch prompt short.
- **The common brief's paths point at `E:\_root\root-sot`,** which is the founder's checkout and isn't fetched by 8a. I pushed the card to origin, and the lane reads it from the worktree `root-sot-imnstr`. `config.md` should name one root-sot path that 8a keeps current.
- **Column 8's total:** "stages done out of the total" didn't say whether B4a and B4b count as one stage or two. I counted ten.

## Template sample
Card headings: *Your lane* (a table: worktree, branch, slot, size) · *Read, in this order* · *What to build* (only what the plan leaves open) · *Done for <stage>* · *Not here*. Require all five. *Your lane* and *Read, in this order* matter most.

## Missing foundation
- No code repo checkout: cloned it.
- No `bin/gate`: the gate was checked by hand.
- No card template: used the shape above.

## Founder Q&A
None.

## Skill shape
Opus, medium; not forked, because it must hold the lane handle until the report comes back. Inject: the gate, the top `STATE.md` block, `git ls-remote` and `git log -1` of the code repo, `config.md` §4, and plan §5 for the stage, sliced by heading. The reference file should hold the card template and a checklist of what a card must settle that plans leave open: dev dependencies, asset sources, environment variables, docs the stage writes. The skill should also own the clone and the `git worktree add`.

## Lessons
- **Rule:** before launching a lane, check that the code repo's main checkout exists and create the worktree by hand. Agent worktree isolation is for the session's own repo. **Event:** 8a B1: the plan said the lane clones, and the config put worktrees inside the clone; I noticed it before the launch, so it cost nothing. **Scope:** `build-phase`. **Destination:** `build-phase` reference file. **urgent:** no.
- **Rule:** a lane's report must survive the session that launched it. **Event:** 8a B1: the method splits launch and land into two sessions, but the report comes back only to the first. **Scope:** method, `build-phase`. **Destination:** `skills-plan.md` `build-phase`, through `revise`; meanwhile, `brief-common.md` could ask the lane to also commit its report as a file. **urgent:** yes, for 8b.

## Cost
*Founder fills in.*

## Next
8b, B1 land, once the lane reports. This session holds the lane, so the report arrives here. If the founder ends the session first, check `b1-foundation` for commits and relaunch from `briefs/B1.md` with a "continue from the branch" note.
