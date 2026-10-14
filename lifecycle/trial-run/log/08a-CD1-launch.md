# 08a CD1 launch — 2026-10-15

## Session
Opus 5.5 (`claude-opus-5-5`), **high** effort, as the founder stated. The brief's table gives 8a as Opus · medium; the founder chose high, and I followed the opening prompt. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a CD1. Model: Opus, effort: high. Be wary another agent is running 8d at the same time. the git environment is created with `main` rule." Claude desktop app (Code tab), working directory `E:\_root`.

The last sentence I read as: the session's git environment was set up on `main`. The run's branch is checked out in `E:\_root\root-sot`, so I worked there, and the code repo's lane branches from `main`. No question was needed.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `build-phase`.
- `STATE.md`, the two 10-15 blocks (8e amended, 8c B4b).
- **Change note `changes/04-ci-deploy.md` 0.3, whole.** On the Change track it stands in for plan §5.
- `lifecycle/projects/imnstr/config.md` whole; `brief-common.md` whole; `review-checklist.md`, the heading list. `lifecycle/status.md`, the row.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), for the checkouts and the commit identity;
  - `briefs/B4b.md` and `log/08a-B4b-launch.md`, as the model card and log;
  - in the code repo at `4c2b9b2`: the tree, `package.json` scripts, `docker-compose.prod.yml`, `Dockerfile`, `CLAUDE.md` (head), `vitest.config.ts`, `deploy/README.md` (*Routine deploys* and *Checks after every deploy*), the test names in `tests/unit/deploy.test.ts`, `docs/development/` listing.

    These showed what the card had to settle: the Dockerfile already has a `HEALTHCHECK` (so `up -d --wait` has something to wait on, which the note assumed but didn't cite); there is no `.github/`; the integration suite is in Vitest's `include`, so the harness runs in every `npm test` here, under Windows.
  - Git Bash on this machine, by `which`: **no `flock`**; `where bash` lists `C:\Windows\System32\bash.exe` (WSL) beside Git's.

## Gate
By hand:
- The change note has a *Stages* section with CD1 (Files, Tests, Traps, Not here, At the verify). Status row: 0–7 `done`, column 8 `5/10`, nothing `STALE`.
- CD1's lane needs nothing from CD-0 (the note: "before CD1's verify, not before its lane").
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Slot B is free.
- An 8d session runs at the same time (founder). It uses the main checkout and the heavy runners. That doesn't block a lane, but it rules out the lane's full Linux run while 8d runs one (config §3: never two heavy runners).
- `git config --local user.email` is the founder's in both repos; both pulled, up to date (root-sot `c1d8d99`, imnstr `4c2b9b2`).
- `docker version` didn't answer within 8 s: Docker Desktop is down or hung. `C:` had 9.1 GB free.

Result: pass. No questions for the founder.

## Did
1. Gate (step 1).
2. Drafted the card (step 2) from note 0.3 *CD1* and the code at `4c2b9b2`: 964 words with the header and lane table. Committed as `briefs/CD1.md`, `e3470f8`, pushed. The note is already very detailed, so the card points at it and settles only what it leaves open:
   - SHAs by `git ls-remote`, peeled tags;
   - the harness on Windows: stub `flock` and `runuser`, resolve Git Bash explicitly, fail (not skip) without bash;
   - one override block at the script's top;
   - `PRELAUNCH` passed as `1`/`0`;
   - `checks.sh`'s list, plus root-app at `m-root.com`;
   - the workflow fails if no `DEPLOYED` line comes back;
   - Docker only if already up; the Linux full run only when no other heavy runner shows (a `Get-CimInstance` check for `vitest`/`playwright`), else left to CI at the verify;
   - the 8d session beside it: never touch the main checkout.
3. Slot B, branch `cd1-ci-deploy` (step 3).
4. Refreshed the read-only checkout `E:\_root\root-sot-imnstr` to `e3470f8`, so the lane reads the card. Made the worktree by hand: `git worktree add -b cd1-ci-deploy … main`, from local `main` (= `origin/main`), so no upstream was set (B4b's log, *Spec gaps*). Identity checked. Launched a background Sonnet lane with the paths of the common brief and the card, the identity check, and the 8d warning (step 4).
5. Recorded the lane in `STATE.md` (step 5). Column 8 stays `5/10`.

## Output
- `imnstr/modules/01-website/briefs/CD1.md`, `e3470f8`.
- The `STATE.md` block and this log, in the next commit.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\cd1-ci-deploy`, branch `cd1-ci-deploy`, local.

## Spec gaps
- **Parallel sessions and the heavy-runner rule.** Config §3 says never two heavy runners "across all checkouts", but nothing tells a lane how to know another session is running one. The card used a process check. `config.md` should name one way (a lock file under `E:\_root\imnstr\.tmp\heavy.lock` that the milestone script and any heavy lane take would be simplest), and `build-phase` should read `STATE.md` for a running 8d.
- **A change-note stage has no size line in config §5 or a column-8 total.** Column 8 counts `n/10` against the build plan's ten stages. CD1 is an eleventh stage from a change note. Left as `5/10`; the 8c that verifies CD1 decides whether the total becomes 11. The README's status rule should say whether change-note stages count.
- **The card is 964 words.** Header and lane table outside the 700, the body is near 800, because the note left Windows-specific harness details open. As at B4a/B4b: the 500–700 limit should exclude the lane table.
- **The note assumes the image has a healthcheck** (`--wait`, `docker inspect … Health`) without citing it. It does (`Dockerfile`, B2). `spec change` should cite the as-built facts its steps depend on.
- **The opening prompt's last sentence** ("the git environment is created with `main` rule") was unclear. It didn't change anything here, but `build-phase` should state which checkout it writes in at its first message.
- **The effort differed from the brief's table** (high vs medium). Followed the founder.

## Template sample
As at B4b, plus one: *Your lane* · *Read, in this order* · *What to build* · **Proving it here** (new: the checks that need the live site, Docker or Linux, each with its condition) · *What the verify does* · *Done for <stage>* · *Not here*. Required: all; *Proving it here* only for stages whose proof isn't the test suite alone.

## Missing foundation
- No `bin/gate`: checked by hand.
- No machine-wide record of heavy runners in progress (above).
- `config.md` §4's branch list has no entry for change-note stages; used the note's `cd1-ci-deploy`.

## Founder Q&A
None.

## Skill shape
Opus, medium is enough when a change note is this detailed: most of the card is pointers. Not forked; it holds the lane. Inject, besides B4b's list:
- the running sessions or a heavy-runner lock, when another phase runs in parallel;
- `which flock runuser` and `where bash` on Windows, when the stage adds shell scripts with tests;
- `timeout 10 docker info`.

## Lessons
- **Rule:** when two phases run at once on one machine, the card says which checkout the other uses and how the lane tells whether a heavy runner is going. **Event:** CD1 launched beside 8d; the note's plan included a full Linux `npm test`, which would have collided with the milestone run. **Scope:** `build-phase`, `config.md`. **Destination:** config §3 (a heavy-runner lock), the card template. **urgent:** no.
- **Rule:** shell scripts tested from Node on Windows resolve Git Bash explicitly; `bash` may be WSL. Git Bash lacks `flock` and `runuser`, so harnesses stub them. **Event:** found by `which`/`where` before the lane, at no cost. **Scope:** IMNSTR and any repo on this machine. **Destination:** `brief-common.md` *Environment*. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land CD1, when the lane reports: in this session if it comes back here. Then 8c verify CD1 (Opus · high), with the founder at the server and on GitHub; the `production` environment must exist first. 8a B5 (slot A) can launch beside the lane.
