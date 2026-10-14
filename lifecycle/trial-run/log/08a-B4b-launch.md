# 08a B4b launch — 2026-10-14

## Session
Opus 5.5 (`claude-opus-5-5`), medium effort, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, review B4b. Model: Opus, effort: medium." Claude desktop app (Code tab), working directory `E:\_root`.

**"Review" didn't fit step 8a.** The top `STATE.md` block named "8a B4b" as next, and `briefs/` held no B4b card. So this session ran the launch, not a review. At B4a the same wording ("8a, review B4a") meant 8c, because the card already existed then. Here the state decided it, and no question was needed.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `build-phase` and `handoff`.
- `STATE.md`, the step-8c B4a block and the 8b/8a B4a blocks under it.
- Plan 0.5:
  - the heading list;
  - §0.3, §3;
  - §5 B4a and B4b whole;
  - PD-4, PD-13 to PD-21;
  - §6.1, §6.2, §6.5, §6.6, §8, §9.
- `lifecycle/projects/imnstr/config.md`, whole. `brief-common.md` *Environment*, *Git*, *Budget*. `review-checklist.md`, the heading list and §5. `imnstr/open-work.md` by grep (S-10 to S-14, V-7). `lifecycle/status.md`, the row.
- Spec 0.4, the lines for AC-9, AC-20 to AC-24 and AC-45, and decisions 9, 10, 22, 39, 40 (by grep). Journeys, the heading list. Wireframes W1, W7, W8 (by grep). The design README, by grep for plates and F2/F3. The design export, by grep for plate markers (it is 1.5 MB).
- `briefs/B4a.md`, as the model card.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkouts and check the commit identity;
  - `log/08a-B4a-launch.md`, for the log's shape;
  - in the code repo at `d29166b`: `package.json`, `app.ts`, `tsconfig.json`, `playwright.config.ts`, `.gitignore`, `Dockerfile`, `.dockerignore`, the heads of `lib/assets.ts`, `lib/headers.ts` and `routes/test-auth.ts`, the `routes/`, `lib/`, `tests/` trees, and `docs/development/B4a.md` from *Owed* on.

    These showed what the card had to settle. Assets are hashed at startup with no build step (PD-4). The Dockerfile is one stage, `--omit=dev`, run through `tsx`. The root tsconfig's JSX is `hono/jsx`. `dist/` is already gitignored. Docker Desktop was running (29.6.1).

## Gate
By hand:
- Plan 0.5 holds §5 B4b.
- Status row: 0–7 `done`, column 8 `4/10`, nothing `STALE`.
- B4b depends on B4a, which is on `main` (`d29166b`) and deployed.
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Slot A is free.
- No P0 item gates B4b.
- `git config --local user.email` is the founder's in both repos.

Result: pass. No questions for the founder.

## Did
1. Gate (step 1).
2. Drafted the card (step 2) from §5 B4b, PD-16, PD-17, PD-21, review checklist §4–§6 and the code at `d29166b`. It is 1,122 words with the header and lane table. Committed as `briefs/B4b.md`, `01b8233`, pushed. This root-sot checkout is detached (the branch is checked out in `E:\_root\root-sot`), so I committed here and pushed `HEAD:lifecycle-trial/imnstr`.
3. Slot A, port `4110`, `.tmp/e2e.db`, branch `b4b-auth-screens` (step 3).
4. Made the worktree by hand: `git worktree add -b b4b-auth-screens` from `origin/main @ d29166b`. I removed the upstream it picked up, so the lane branch can't track `main`, and checked that its identity is the founder's. Launched a background Sonnet lane with the paths of the common brief and the card, an identity check before the first and the last commit, and the image check (step 4).
5. Recorded the lane in `STATE.md` (step 5). Column 8 stays `4/10`.

## Output
- `imnstr/modules/01-website/briefs/B4b.md`, `01b8233`.
- The `STATE.md` block and this log, in the commit after `01b8233`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b4b-auth-screens`, branch `b4b-auth-screens`, local.

## Spec gaps
- **PD-21 and PD-4 disagree, and the plan doesn't reconcile them.** PD-21 asks for a Vite bundle with hashed assets. PD-4, the code and the Dockerfile (one stage, `--omit=dev`) all assume no build. The card settled it: build the admin only, with fixed names, and let the existing manifest hash them; the Dockerfile gets a build stage. `build-plan` should check that every stage adding a toolchain says what it does to the image and to the deploy, as a §7 line.
- **The stage changes the image, but plan §5 B4b doesn't say so.** Config §7 says a deploy lane builds the image once, and the common brief says "no Docker in development". The card overrode the common brief. `brief-common.md` *Environment* should say "Docker only when your card says so" (founder's call, through 10a).
- **The card is 1,122 words.** As at B2–B4a, the header and lane table should sit outside the 700. The body is still near 950, because the build-step decision is the plan's to make. Either the plan settles such things, or `build-phase` allows a longer card when it records decisions the plan left open.
- **The opening prompt's verb.** "8a, review B4b" names a phase and a different action. `build-phase` should read `STATE.md` and the existence of `briefs/<stage>.md` to choose launch or land. A prompt that disagrees should be logged, not followed.
- **The root-sot checkout is detached.** The branch is checked out in `E:\_root\root-sot`, so this worktree can't check it out too. Pushing `HEAD:<branch>` works, but the project config should name the trial checkout and how to commit from it (B4a's log asked the same).
- **`git worktree add -b` from `origin/main` sets an upstream.** A lane that ran `git push` would then aim at `main`. `config.md` should say to branch from local `main` after `git pull`, or to unset the upstream.

## Template sample
Same headings as B4a's card: *Your lane* · *Read, in this order* · *What to build* · *What the verify deploys* · *Done for <stage>* · *Not here*. Required from B2 on: all six.

## Missing foundation
- No `bin/gate`: checked by hand.
- No place for the card's own decisions except the card and the `STATE.md` block (as at B4a).
- The design export has no anchor per plate. The card tells the lane to grep `Wireframe plate N.`. A plate index (plate → journeys, ACs, copy) in `04b-design/README.md` would let cards cite copy exactly.

## Founder Q&A
None.

## Skill shape
As at B4a: Opus, medium; not forked; it holds the lane. Inject, besides B4a's list:
- `ls briefs/` (does a card or report exist? This picks launch or land);
- the `Dockerfile` and `package.json` scripts when the stage section names a new tool or dependency;
- `docker info` when the card asks for an image check.

The reference file should hold the card template, and a line for "this stage changes the image".

## Lessons
- **Rule:** when a stage brings in a toolchain (a bundler, a compiler), the card states what changes in the image and the deploy, and the lane builds the image once. **Event:** PD-21's Vite bundle against a one-stage `--omit=dev` image; left open, the first B4b deploy would ship no bundle. **Scope:** `build-plan`, `build-phase`. **Destination:** `build-plan`'s per-stage template (an "image and deploy" line) and the card checklist. **urgent:** no.
- **Rule:** `build-phase` picks launch or land from the files (`briefs/<stage>.md`, `.report.md`) and `STATE.md`, not from the verb in the opening prompt. **Event:** twice now (B4a, B4b) the prompt said "review" for a different step; the state was right both times. **Scope:** `build-phase`, `verify`. **Destination:** both skills' first step. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land B4b, when the lane reports: in this session if it comes back here. Then 8c verify B4b (Opus · high), with the founder at the server and on the phone: the first real setup token and passkey.
