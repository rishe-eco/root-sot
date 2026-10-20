# 08a B4a launch — 2026-10-14

## Session
Opus 5.5 (`claude-opus-5-5`), medium effort, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, B4a. Model: Opus, effort: medium." Claude desktop app (Code tab), working directory `E:\_root`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0 and `build-phase`.
- `STATE.md`, the step-8c B2 block (and the blocks under it as far as 8c B3, for carry-overs).
- Plan 0.4:
  - the heading list;
  - §0.3, §3, §4 whole;
  - §5 B4a whole;
  - PD-13 to PD-18;
  - §6.1, §6.2, §6.3, §6.4, §6.6, §7, §8, §9.
- `lifecycle/projects/imnstr/config.md`, whole. `brief-common.md`, whole. `review-checklist.md` §3, §4 and §6. `imnstr/open-work.md`, whole, for S-1 and S-8.
- Spec 0.4, the heading list and the lines for AC-8 to AC-11, AC-20 to AC-24 and AC-45 (by grep).
- `briefs/B3.md`, as the model card.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkouts and check the commit identity;
  - `log/08a-B2-launch.md`, for the log's shape;
  - in the code repo at `76727e4`: `app.ts`, `lib/env.ts`, `lib/limits.ts`, `routes/test.ts`, `package.json`, `.env.example`, `.gitignore`, the auth tables of `migrations/001_init.sql`, the `tests/` tree, and greps of `lib/headers.ts`, `docker-compose.prod.yml`, `deploy/nginx/imnstr.conf`, `deploy/README.md` and the *Owed* lines of `docs/development/{README,B1,B2}.md`.

    These showed several things the card needed. There is no `ORIGIN` or RP ID in the env yet. The server's `.env` lives on the VPS, so a new required variable would need the founder's hands. The compose service is named `imnstr`. Tests live in `tests/`, not `test/`. The admin's `no-store` already exists. The limits B4a needs, including `backoffSeconds`, are already in `lib/limits.ts`.

## Gate
By hand:
- Plan 0.4 holds §5 B4a.
- Status row: 0–7 `done`, column 8 `3/10`, nothing `STALE`.
- B4a depends on B1, which has been on `main` since 8c B1. Plan §3 forbids a B2 + B4a pair, and B2 is merged and deployed.
- Lanes in flight: none (`STATE.md`, `git worktree list` shows only the main checkout). B3 is merged, so no lane shares the slot.
- No P0 item gates B4a.

Result: pass. No questions for the founder.

## Did
1. Gate (step 1).
2. Drafted the card (step 2) from §5 B4a, PD-13 to PD-17, review checklist §4 and the code at `76727e4`. It is 952 words with the header, the lane table and the verify section. Committed as `briefs/B4a.md`, `3df044f`, pushed.
3. Slot A, port `4110`, `.tmp/e2e.db`, branch `b4a-auth-server` (step 3).
4. Made the worktree by hand, `git worktree add -b b4a-auth-server` from `main @ 76727e4`, and checked that its commit email is the founder's. Launched a background Sonnet lane with the paths of the common brief and the card, plus an identity check before its first commit (step 4).
5. Recorded the lane in `STATE.md` (step 5). Column 8 stays `3/10`.

## Output
- `imnstr/modules/01-website/briefs/B4a.md`, `3df044f`.
- The `STATE.md` block and this log, in the commit after `3df044f`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b4a-auth-server`, branch `b4a-auth-server`, local.

## Spec gaps
- **The plan contradicts itself on `GET session`.** §5 B4a says it reports "signed in or not", and also that `requireSession` wraps every route except the ceremonies, answering 401. The card chose 401 when signed out, so the AC-8 enumeration needs no exceptions, and flagged it for verify. `build-plan` should say how a signed-out client learns it is signed out.
- **The plan has no origin or RP ID setting.** PD-14 names `https://imnstr.com`, and the lane must also run on `http://localhost:4110`. The card added `ORIGIN`, with a production default, so that the server's `.env` on the VPS needs no change. When a stage needs a new environment variable, `build-phase` should ask whether production needs a server-side edit. If it does, the verify card should list it.
- **"What the verify deploys"** was asked for by the 8c B2 block, not by the skill spec. `build-phase`'s card template should carry the section for every stage from the first deploy on. The verify's checks belong to the card, because the lane has to build to them.
- **The card is 952 words.** As at B2 and B3, the 700-word limit should exclude the lane table and the header. The body is near 800 words. Auth stages carry more decisions than the plan settles.
- **Plan paths are stale against the code:** `test/softAuthenticator.ts` should be `tests/`. This is small, but the plan should be checked against the tree before drafting (the 8a B2 lesson again).
- **The common brief points root-sot at `E:\_root\root-sot`**, while every card overrides it with `E:\_root\root-sot-imnstr`. The project config should name the trial checkout once.

## Template sample
Same headings as B3's card: *Your lane* · *Read, in this order* · *What to build* · *Done for <stage>* · *Not here*. New: **What the verify deploys**. Required from B2 on: all six.

## Missing foundation
- No `bin/gate`: checked by hand.
- No place for the card's own decisions except the card and the `STATE.md` block. Verify needs them as a list to rule on, and the `STATE.md` block is where this session put them.

## Founder Q&A
None.

## Skill shape
As at the earlier 8a sessions: Opus, medium; not forked; it holds the lane. Inject:
- the top `STATE.md` block;
- `git log -1 origin/main` and `git worktree list` of the code repo;
- `git config --local user.email` of the code repo, checked against the project config before the worktree is made;
- plan §5 for the stage, and the PD entries it cites;
- the *Owed* rows of `docs/development/README.md` addressed to the stage;
- the env reader (`lib/env.ts`) when the stage section names a setting.

The reference file should hold the card template, with *What the verify deploys* in it.

## Lessons
- **Rule:** a card for a stage that adds an environment variable gives it a production default, or names the line the founder must add to the server's `.env` in its verify section. **Event:** B4a needs an origin and RP ID that the plan never named; a required variable would have broken the first deploy after B4a. **Scope:** `build-phase`, `build-plan`. **Destination:** the card checklist in `build-phase`'s reference file. **urgent:** no.
- **Rule:** the lane prompt repeats the commit-identity check, and the orchestrator checks the worktree's `user.email` before launching. **Event:** the 10-14 history rewrite (memory `rishe-eco-git-identity`). A worktree inherits the repo's local config, but a lane can't know whose identity is right. **Scope:** `build-phase` launches for any rishe-eco repo. **Destination:** `brief-common.md` *Git*, through the founder. **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b; the figures are the whole session, including the Sonnet lane:*
- Opus 5.5: 66 in / 1.2k out / 3.7M cache read / 109.6k cache write.
- Cost: $6.95 · API 21m · wall 5m, as reported.
- The subagent (the lane) was 67% of the cost. The lane itself reported about 277k tokens, 92 tool uses and 23 minutes.

## Next
8b, land B4a, when the lane reports: in this session if it comes back here. Then 8c verify B4a (Opus · high), with the founder at the server for the deploy.
