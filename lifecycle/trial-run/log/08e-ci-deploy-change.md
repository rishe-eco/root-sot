# 08e CI deploy, spec change — 2026-10-14

## Session
Opus 5.5 (`claude-opus-5-5`), high effort, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8e, spec change: CI deploy. Model: Opus, effort: high." It went on to:
- name the role (`spec` in `change` mode) and how to handle the missing trial row;
- set the gate (B4a verified and deployed; a B4b lane may be in flight);
- describe the change (push to `main` deploys), with six constraints already decided: Actions with `--ignore-scripts`, check and Vitest, no Edge e2e; build on the VPS, no registry; a dedicated deploy user, forced command, one sudoers line; stop on an `imnstr.conf` change and fail loudly on health or checks; only `verify` moves `main`; server commands for a sudo user.

Claude desktop app (Code tab), working directory `E:\_root`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `spec`, and (outside §1's order) `build-plan`, `build-phase` and `verify`. I needed those three to know what a Stages section must give 8a and 8c, and the shape of §5.
- `STATE.md`: the top blocks, down to 8c B2, for the gate and the deploy as it stands. After the mid-session pull, the new 8a B4b block.
- Plan 0.5: the heading list, the header and §0, §3, §4, §5 B2, B4a and B4b, and §7. I needed §5's shape, B2's deploy, and B4b's Dockerfile and build step, because B4b may be the first CI deploy.
- `lifecycle/projects/imnstr/config.md` §3–§7 and `review-checklist.md` §6, for the suites, the slots and the deploy as configured.
- `changes/03-…md`, the head and headings, for the house shape of a change note.
- `briefs/B4b.md`, by grep (Dockerfile, deploy, Vite, slot), for the traps.
- `log/08a-B4a-launch.md`, for the log's shape.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkouts and check the commit identity;
  - in the code repo at `d29166b`: `deploy/README.md`, whole (the checks the script must run, and the manual path it keeps); `docker-compose.prod.yml`, `Dockerfile`, `.env.example`, `package.json` (the scripts CI runs), `.gitattributes`, the `tests/` tree, `vitest.config.ts` (`include`), and greps of `CLAUDE.md` and `docs/development/B2.md` (root-app check, Compose v5.3.1);
  - `log/08c-B2-verify.md`, by grep, for root-app's check URL. It isn't recorded.
  - `git ls-remote` on `rishe-eco/i-monster` over anonymous HTTPS, to learn whether the repo is public. It is, so its Actions logs are public too.

## Gate
By hand:
- **The founder's gate:** the top `STATE.md` block was 8c B4a, *verified and deployed*. Pass.
- **A B4b lane:** none at the first pull. A second fetch, before writing, brought `01b8233` and `a74b839`, 8a B4b launched in slot A. I pulled with rebase and wrote this step's block **on top of B4b's, adding to it**.
- **`spec change` has no gate** (skills-plan). `lifecycle/status.md` has nothing `STALE`; column 8 is `4/10`.

## Did
Mapped to `spec` (`change`):
1. **Asked first,** one batch, four questions (the tool's limit per call). The rest went to founder pre-flight instead (*Spec gaps*).
2. **Wrote `changes/04-ci-deploy.md`:**
   - what changes and why, with the security argument for a shared box;
   - acceptance criteria CI-1 to CI-11;
   - what must not break;
   - founder pre-flight CD-0;
   - **Stages:** one stage, CD1 (M), in plan §5's shape (goal, files, tests, acceptance, size, traps, not here), plus an *At the verify* runbook for the server part;
   - what the change makes stale, for the founder to accept at CD1's verify.
3. **The two traps the founder asked for:** how a stage verified after CI lands is deployed, and that B4b may be the first. Both are CD1's first two traps.
4. **No code, no phase card, no status cell** (none exists for this step).

Design calls in the note that the founder's constraints left open, each a *proposal*:
- **The workflow passes nothing to the script.** The sudoers line is `""`, and the script deploys `origin/main` as it finds it. sudo would strip `SSH_ORIGINAL_COMMAND` anyway, and with no arguments there is no input to validate.
- **Stop files are compared with what is live:** the live conf copy and the installed script. A manual fix followed by a re-run then passes.
- **The script itself is a stop file,** for the same reason as the conf: it is a privileged copy.
- **`DEPLOY_ENABLED` switches automatic deploys on and off.** It solves CD1's chicken-and-egg (the scripts must be on the box before the first CI deploy) and gives the founder an off switch.
- **Exit 2** means "stopped, nothing changed" and **exit 1** "failed after a change", so the run tells the founder which manual path to take.
- **A shell-script harness,** with stub `docker`, `nginx` and `runuser`, tests every stop and failure without root or a server.
- **The CI job's commands also run in `node:24` with `TZ=UTC`** before the workflow exists. The suite has only ever run on Windows.
- **The lane runs `checks.sh` against the live site.** It is read-only except one challenge.

## Output
- `imnstr/modules/01-website/changes/04-ci-deploy.md` 0.1.
- A new top block in `imnstr/modules/01-website/STATE.md`, added on top of 8a B4b's.
- This log.
- Commit hash: see `git log` (one commit, *IMNSTR trial step 08e: spec change CI deploy*).

- **0.2 amendment (2026-10-15):** re-pulled first. root-sot had gained 8b and 8c B4b (`444f350`, `b6b8979`, `39d543b`), and imnstr `main` had moved `d29166b` → `4c2b9b2`. I read the diff of `deploy/`, `Dockerfile`, `package.json`, `vitest.config.ts` and `CLAUDE.md`, the new top `STATE.md` block, open-work S-14 and S-15, and a grep of `docs/development/B4b.md`. Then I updated the note to **0.2**:
  - B4b was deployed by hand, so it isn't the first CI deploy, and its checks join CI-8;
  - `npm run build` replaces `--if-present`;
  - the lockfile trap is retired, since the VPS built Vite on Linux;
  - S-14's conf change is a stop;
  - slot B is still CD1's, now next to a possible B5 in slot A.
  New STATE block on top of 8c B4b's.

## Spec gaps
- **The trial table has no row for a mid-build Change.** The README's Change-track line only covers intake finding a Change. This one arrived during the build, from the founder. I followed that line anyway (`spec change` writes a note with stages, then 8a–8c), as the founder said. The table wants a row: *8e Change · `spec` (`change`) · Opus · high · inputs: the founder's description, `STATE.md`, the plan sections and code it touches · output `changes/NN-slug.md` · done: questions asked, CI-style criteria, Stages in §5 shape · don't: write code or a card.*
- **Step numbering for a Change mid-build.** "8e" was the founder's. `8d` is the milestone, so the letters run out quickly if Changes recur. The trial needs a rule, perhaps `8x-<slug>`.
- **`spec change` says "gate: none"**, but a Change mid-build depends on the build's state: what is deployed and which lanes are in flight. The founder supplied the gate. The skill should inject the top `STATE.md` block and refuse while a lane touches the same files. Here B4b and CD1 overlap only in `deploy/README.md`, which the note names.
- **Up to eight questions in one batch,** but the question tool takes four per call. I asked the four that change the design. Factual server questions (SSH reachability, `AllowUsers`, root-app's URL) went to a founder pre-flight in the note, as P0-3 did for B2. The skill should say that facts the founder must look up go to pre-flight, not into the batch. One question ("Can runners reach SSH?") came back "not sure", which is that kind of fact.
- **Stage names and lane resources for Change stages are undefined.** The config's branch list and slots cover B1–B9 only. I named the stage `CD1` with branch `cd1-ci-deploy`, and gave it slot B, because B4b holds A. `config.md` §4 should say how a change stage gets its branch and slot.
- **Criterion IDs.** The spec's AC-n is the only scheme. I used **CI-n** in the note so they don't collide. A change note should own a prefix.
- **A change that moves the deploy changes `verify` for every later stage.** The skill's Stages shape (§5) has no place for that. I put it under CD1's *Traps*, as the founder asked, and in the STATE carry-overs. `spec change` should ask, for any infra change: "what does this change about how later stages are built, verified or deployed?"
- **Infrastructure stages have a server part no lane can do.** §5's shape assumes lane-built code. I added an *At the verify* runbook to CD1, as B2's plan section did in prose. The shape could carry it as an optional field.
- **Who updates the documents a Change makes stale?** These are the config, the review checklist, the plan's B2 and `brief-common`. The method gives `revise` the spec and the founder the configs, but says nothing about a Change that overrides the plan. I listed them in the note for the founder to accept at CD1's verify, the way F-8 and F-9 went.
- **The status table has no place for a Change.** Does CD1 count in column 8's `n/10`? I left the cell alone and passed the question to the verify.
- **`changes/` mixes two kinds of file:** `revise`'s change requests (01–03) and `spec change`'s notes (04). The numbering is shared, and nothing in a file's name says which kind it is. The header line says so, here.

- **A change note written beside a running build goes stale before its stage launches.** 0.1 was written against `d29166b`. By the time the founder answered, B4b had been verified and deployed by hand, so the note's "B4b may be the first" trap and its file guard against B4b were wrong. `build-phase` should re-read a change note against `main`'s log since the note's `main @` before drafting the card. A change note should carry its `main @` in the header, as this one does.

## Template sample
Headings used:
- *What changes and why*
- *Acceptance criteria*
- *What must not break*
- *Founder pre-flight*
- *Stages*, with one `###` per stage: Goal, Branch and slot, Files, Not changed, Tests, At the verify, Acceptance, Size, Traps, Not here
- *What this makes stale*
- *Changelog*

Required (future `required-headings.txt`, change note): *What changes and why*, *Acceptance criteria*, *What must not break*, *Stages*, and per stage *Size* and *Traps* (skills-plan's own list). *Founder pre-flight* and *At the verify* only where the change touches a server.

## Missing foundation
- No change-note template. I used change note 03's frame and plan §5's stage shape.
- No `bin/gate`: checked by hand.
- No record of root-app's check URL; it is in CD-0.

## Founder Q&A
Asked in one batch:
1. *Can GitHub's hosted runners reach the VPS over SSH?* **"Not sure; I'll check."** It became founder pre-flight CD-0, with the commands and what happens if SSH is limited by address.
2. *On a failed health check or deploy check?* **Fail loudly, no rollback** (recommended). Migrations run at boot.
3. *Should a `docker-compose.prod.yml` change stop the CI deploy, like `imnstr.conf`?* **Stop on change** (recommended).
4. *Where do the post-deploy checks live?* **Split** (recommended): the root script is fixed, and the `curl` checks are `deploy/checks.sh` in the repo, run as an unprivileged user.

**Continued 2026-10-15, same session.** The founder pasted the CD-0 output and asked "does this change anything?", adding that the repo had moved on.
- `ufw` is active and allows 22, 80 and 443 from anywhere. `sshd -T` shows `port 22`, key-only login and no `AllowUsers` or `AllowGroups`. **The design stands.** Hosted runners can connect, no `sshd` change is needed, and `DEPLOY_PORT` is 22.
- **The prompt shows the founder's sudo user is named `deploy`.** The note now says that CI's `imnstr-deploy` is a separate account.
- Then: root-app is **`https://m-root.com/`**, and `curl -sI` from this machine gives 200. The founder asked what the GitHub environment needs; the note's CD-0 (0.3) now spells out the clicks.

## Skill shape
`spec` in `change` mode: Opus, high, as specified. Not forked: it asks the founder. Inject at invocation:
- the top two `STATE.md` blocks;
- `git log -1 origin/main` of the code repo;
- `git worktree list` (lanes in flight and the files they touch);
- the plan's heading list;
- for an infra change, the deploy README's headings and the config's deploy section.

The reference file should hold:
- the change-note template, with the headings above;
- a criterion-prefix rule;
- the infra questions: what it changes for later verifies, what is privileged, and what must stay manual;
- the rule that factual server questions go to pre-flight, not the question batch.

## Lessons
- **Rule:** a Change to how code is deployed must say how every later stage's verify deploys after it lands, in the note's traps and in the STATE carry-overs. **Event:** CI deploy (8e). After CD1, a verify's push to `main` is the deploy, so a red run means the stage isn't done. Missed, the next verify would push and walk away. **Scope:** `spec change`, `verify`. **Destination:** `spec`'s reference file (infra questions); `verify` step 11, "deployed" means a green run. **urgent:** yes. The next 8c after CD1 must know it, and it is in the STATE block.
- **Rule:** facts only the founder can look up on a server go to a pre-flight list, not into the clarifying batch. **Event:** one of four questions came back "not sure; I'll check", which spent a slot in a four-question tool call. **Scope:** `spec` (both modes), `build-plan`. **Destination:** `spec`'s reference file. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
*(As of 0.2, 2026-10-15.)*
- **8a CD1** (Opus · medium): `build-phase changes/04-ci-deploy.md#CD1`, slot B. It can run beside a B5 lane in slot A.
  - Draft the card from note 0.2's CD1 section, not plan §5.
  - Check `git config --local user.email` in the new worktree.
  - The card must say: no edits to `Dockerfile`, `package.json` or the compose file; new test files only; action SHAs by `git ls-remote`.
  - `checks.sh` carries every README check on `main`, B4b's included.
- **CD-0:** SSH and root-app's URL are settled. The GitHub `production` environment is needed by CD1's verify, not its lane.
