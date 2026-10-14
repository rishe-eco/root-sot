# 04 — Deploy on push to `main`

*Module `imnstr/modules/01-website/` · Change note written by `spec` in `change` mode (trial step 8e) · 2026-10-14, amended 2026-10-15. A Change to B2's deploy (build plan 0.5 §5 B2, config 0.3 §7). The **Stages** section below stands in for the build plan: `build-phase` (8a) and `verify` (8c) read it in place of plan §5. Grading: claims about the repo and the box are **as-built** (imnstr `main @ 4c2b9b2` since 0.2, `deploy/README.md`, the B2 and B4b records); everything else is **proposal** until CD1 is verified.*

## What changes and why

**Today.** Each stage's verify ends with the founder at the server, pasting the routine deploy one line at a time (`git pull`, `docker compose build`, `up -d`), then the checks in `deploy/README.md`, *Checks after every deploy*. That was B2's design: the lanes have no server access, and the orchestrator deploys with the founder.

**After this change.** A push to `main` on `rishe-eco/i-monster` deploys on its own:
1. **GitHub Actions** runs on the push. It installs with `npm ci --ignore-scripts` and runs `npm run check` and Vitest. The Edge e2e stays local, at the milestones.
2. If that passes, it opens an SSH connection to the box as a dedicated **deploy user**. That user's key is locked by a forced command to **one deploy script**. The user is not in the `docker` group, and its one sudoers line allows that script only, with no arguments.
3. The script, running as root, fast-forwards `/srv/imnstr`, **builds the image on the VPS** (no registry), runs `up -d`, waits for the container to be healthy, and then runs the deploy checks. It fails loudly if the container isn't healthy or any check fails.
4. **The script never changes Nginx, the compose file or itself.** If any of them changed, it stops before changing anything, and the founder does that part by hand, as today.

**Why.** It saves the founder a server session at every verify. It also makes the deploy the same every time: today it is retyped from the README, line by line.

**Why it is safe enough on a shared box.**
- **Only `verify` moves `main`,** so a deploy only ever runs reviewed code. The reviewed code then runs with root's reach on the box, since a compose file can mount anything. That was already true of the manual deploy. What is new is the key held by GitHub. With the forced command, that key can trigger a deploy of `main`, and nothing else.
- **A change to the workflow file** can't widen what the key does, for the same reason.
- **The box is shared with root-app and four other tenants.** The deploy user can't reach Docker or any other tenant. The script touches nothing outside the `imnstr` compose project and `/srv/imnstr`, and it never reloads Nginx.

**Decided by the founder at this step** (one batch, four questions; *Founder Q&A* in log `08e-ci-deploy-change.md`):
- **No automatic rollback.** A failed health check or deploy check leaves the new image running and turns the run red. Migrations run at boot, so restarting old code against a migrated database is the riskier move. The README gets the manual rollback.
- **The compose file is a stop file.** A change to `docker-compose.prod.yml` stops the deploy, like `imnstr.conf`.
- **The checks are split.** The installed root script keeps the privileged steps. The `curl` checks live in the repo as `deploy/checks.sh` and run from the new checkout as an unprivileged user. A later stage then adds its own deploy check without anyone reinstalling the root script.
- **SSH reachability** came back "not sure" and went to founder pre-flight CD-0. **Answered 2026-10-15:** SSH is open to all on 22, key-only, with no `AllowUsers` (CD-0 below).

## Acceptance criteria

Numbered **CI-n**, so they don't collide with the spec's AC-n. Each is checked at CD1's verify. The test or check that proves each one is named in CD1 *Tests*.

| # | Criterion |
|---|---|
| **CI-1** | A push to `main` starts the workflow. The `check` job runs `npm ci --ignore-scripts`, `npm run check`, `npm run build` (the admin bundle, since B4b) and `npm test`, on Node 24. It runs no Playwright. |
| **CI-2** | The `deploy` job runs only after `check` passes, only for `refs/heads/main`, and only when the repo variable `DEPLOY_ENABLED` is `true`. A red `check` means no SSH connection is made. Setting the variable to anything else switches automatic deploys off. |
| **CI-3** | The workflow has `permissions: contents: read`, uses no action except `actions/checkout` and `actions/setup-node`, each pinned by full commit SHA, and runs one deploy at a time (`concurrency`, with `cancel-in-progress: false`). The box's host key comes from a secret (`StrictHostKeyChecking=yes`), never from `ssh-keyscan` at run time. |
| **CI-4** | The deploy user has no password and a shell that can run the forced command, and is in no group but its own: `id` shows no `docker`. Its `authorized_keys` line is `restrict,command="sudo -n /usr/local/sbin/imnstr-deploy"`. `sudo -l -U imnstr-deploy` lists that one command, with `""` (no arguments). Any command sent over SSH runs the deploy script and nothing else. |
| **CI-5** | **The script stops before it changes anything,** exiting **2** with the file or reason and the manual step to take, when: another deploy holds the lock; the checkout has uncommitted changes; the new `main` isn't a fast-forward of the checkout (history rewritten); the new commit's `deploy/nginx/imnstr.conf` differs byte for byte from the live `/etc/nginx/sites-available/imnstr`; `docker-compose.prod.yml` changed between the checkout and the new commit; or the new commit's `deploy/imnstr-deploy.sh` differs from the installed `/usr/local/sbin/imnstr-deploy`. |
| **CI-6** | **A failed image build changes nothing that runs.** The old container keeps serving, and the run is red (exit 1). |
| **CI-7** | **After `up -d`, the script fails loudly (exit 1)** when the container isn't `healthy` within 120 s, when `nginx -t` fails, or when any check in `deploy/checks.sh` fails. Each failure names its step or its check. The site is left on the new image (no rollback). |
| **CI-8** | `deploy/checks.sh` covers every check in `deploy/README.md`, *Checks after every deploy*, as of the commit it lands in. That includes B4a's four admin API checks, B4b's two shell checks and the bundle's two (script and stylesheet URLs read from `/admin`, 200, `immutable`), `www` → apex, `http` → `https`, and root-app's own URL answering. It runs as an unprivileged user, never reads `.env`, and is told by the root script whether `PRELAUNCH` is set, so it can expect `noindex` or not. |
| **CI-9** | **Nothing secret reaches the Actions log,** which is public, because the repo is. No `.env` contents, no key, no token, no `set -x`. A green run ends with `DEPLOYED <sha>`, and the workflow says whether that equals the pushed commit or a newer one. |
| **CI-10** | **The manual path still works and is the fallback.** `sudo /usr/local/sbin/imnstr-deploy` from the founder's own shell does the same deploy under the same lock. `deploy/README.md` keeps the steps for an `imnstr.conf` or compose change, and gains the manual rollback, the server setup, and what each exit code means. |
| **CI-11** | **End to end:** with `DEPLOY_ENABLED=true`, one push to `main` that carries a real code change deploys it. The run is green, and `DEPLOYED` equals the pushed SHA. The run's URL and the checks' output go in `docs/development/CD1.md`. |

## What must not break

- **root-app and the other tenants.** Their compose projects, Nginx files, zones (`root_api`, `root_ask`), certificates and ports. Nothing the deploy user or the script does reaches them. **No global prune** (`docker image prune` or `system prune` without a filter removes other tenants' images). **No Nginx reload from CI,** ever. `nginx -t` only reads.
- **The founder's own `sudo`.** A broken file in `/etc/sudoers.d/` breaks `sudo` for every user on the box. The sudoers line is checked with `visudo -cf` before it is installed (CD1 *Traps*).
- **B2's guarantees:** the live conf stays a copy, changed only by `cp`, `nginx -t`, reload; certbot stays `certonly` with its deploy hook; the backup cron, `.env`, `data/` and `backups/` are untouched; `E2E_CLOCK` stays unset.
- **The live site when a deploy fails early.** Every stop (exit 2) and a build failure leave the running container as it was.
- **House rule 10 (secrets never enter the repo),** now extended to the Actions log.
- **The local suites and the milestone script,** unchanged: `npm test` and `npm run e2e` still run here, one heavy runner at a time.
- **"Only `verify` moves `main`."** Unchanged. It now matters more, because a push is a deploy.

## Founder pre-flight (CD-0)

**Status 2026-10-15:** questions 1 and 2 are answered (below). Question 3 and the GitHub environment are still open.

Before CD1's verify, not before its lane. Run at the server as the sudo user, one line at a time:

```
sudo ufw status verbose
sudo sshd -T | grep -iE '^(port|allowusers|allowgroups|passwordauthentication|pubkeyauthentication) '
```

Also check any firewall in the hosting provider's panel. Then answer three things:
1. **Can any address reach SSH, and on which port?** *Answered:* `ufw` is active, deny incoming by default, and allows 22/tcp (OpenSSH), 80 and 443 from anywhere, IPv4 and IPv6. `sshd -T`: `port 22`, `pubkeyauthentication yes`, `passwordauthentication no`. Hosted runners can connect, so `DEPLOY_PORT` is `22`. The provider's own firewall wasn't reported; the first CI run tests it. GitHub's hosted runners connect from a wide, changing range. If SSH is limited by source address, CD1's lane still runs, but its verify **stops before the server part**. The founder then chooses between opening SSH to all (key-only), a tunnel, or another route, and this note goes back to `spec change`.
2. **Do `AllowUsers` or `AllowGroups` exist?** *Answered: neither,* so no `sshd` change is needed. If either is added later, the verify adds `imnstr-deploy` to them, using `sshd -t` before `systemctl reload ssh`.
3. **root-app's own URL** for the "still answers" check. *Open.* The B2 record says it was checked, but not which URL, and B4b's record says it was missing from the pasted output.

**Not to reuse:** the founder's sudo user on the box is named `deploy`. CI's user is `imnstr-deploy`, a separate account. Never give CI's key to `deploy`, which has full `sudo`.

On GitHub (web; `gh` isn't installed on the build machine): Actions enabled on `rishe-eco/i-monster`, and an environment named `production` limited to the `main` branch. The secrets go in at the verify.

## Stages

One stage. The lane writes the files and proves them locally. The server part is CD1's verify, with the founder, as B2's was.

---

### CD1 · Deploy on push to `main`

**Goal.** CI-1 to CI-11: a push to `main` checks, then deploys through a forced-command key, a root-owned script and unprivileged checks. The manual path stays as the fallback.

**Branch and slot.** `cd1-ci-deploy`, from `main`. **Slot B** (`4120`), so a B5 lane can hold slot A beside it. The lane needs no e2e server, but it takes the slot so the two lanes never share a port. Neither touches the schema.

**Files** (in the code repo)
- **`.github/workflows/deploy.yml`**
  - on `push` to `main`, and `workflow_dispatch`, for re-running after a manual step;
  - `check` on `ubuntu-24.04`, Node 24 with the npm cache: `npm ci --ignore-scripts`, `npm run check`, `npm run build`, `npm test` (Vitest's global setup also builds the bundle when it is missing; the explicit step makes a broken bundle fail on its own line);
  - `deploy`: `needs: check`, `if: github.ref == 'refs/heads/main' && vars.DEPLOY_ENABLED == 'true'`, `environment: production`, `concurrency: { group: deploy-production, cancel-in-progress: false }`;
  - writes `DEPLOY_KEY` and `DEPLOY_KNOWN_HOSTS` to `0600` files under `$RUNNER_TEMP`, then runs `ssh -i … -p "$DEPLOY_PORT" -o BatchMode=yes -o StrictHostKeyChecking=yes -o UserKnownHostsFile=… imnstr-deploy@"$DEPLOY_HOST"` with no remote command;
  - passes the remote exit code through, and reads `DEPLOYED <sha>` from the output (CI-9).
- **`deploy/imnstr-deploy.sh`**, the reference copy of `/usr/local/sbin/imnstr-deploy`, in bash with `set -euo pipefail`. In order:
  1. take `flock -n` on `/run/lock/imnstr-deploy.lock`;
  2. check the tree is clean;
  3. `git fetch origin main` (anonymous HTTPS, as today);
  4. check it is a fast-forward;
  5. the three stop-file comparisons (CI-5);
  6. `git merge --ff-only`;
  7. `docker compose -f docker-compose.prod.yml build`;
  8. `up -d --wait --wait-timeout 120` (Compose v5.3.1 on the box);
  9. check health with `docker inspect`, then `nginx -t`;
  10. read `PRELAUNCH` from `.env` with `grep`, never `source`;
  11. run `runuser -u nobody -- bash deploy/checks.sh <prelaunch>` from the new checkout;
  12. print `DEPLOYED <sha>`.

  If `main` is already checked out, it skips steps 6–8 and still checks, so a re-run gives a verdict. Exit codes: **0** deployed; **2** stopped, nothing changed; **1** failed after something changed. Paths default to `/srv/imnstr` and the live locations, overridable by environment variables for the test harness only. `sudo`'s `env_reset` strips them from the deploy user.
- **`deploy/checks.sh`**: the README's checks, each one named and asserted (status, header present or absent, body code). It takes the origin (default `https://imnstr.com`), the `PRELAUNCH` flag and root-app's URL as arguments. It exits non-zero on the first failure and prints which check failed. It needs only `bash`, `curl`, `grep` and `sed` (it reads the bundle's hashed URLs from `/admin`).
- **`deploy/README.md`**:
  - **Server setup for CI,** for a sudo user, `sudo` on each line, one command per line, `| sudo tee` for root files:
    - the user, with `/bin/sh` as its shell and no password;
    - the key's `authorized_keys` line;
    - the sudoers line, through a temporary file, `visudo -cf`, then `install -m 0440`;
    - installing the script with `install -o root -g root -m 0755`;
    - the four secrets and the variable, on the GitHub web UI;
    - generating the key pair, then deleting the private half once it is pasted.
  - **What each exit code means,** and the manual steps for exit 2. For `imnstr.conf`: `cp`, `nginx -t`, reload, then re-run the job. For the compose file: the manual deploy. For the script itself: reinstall, then re-run.
  - **The manual rollback.**
  - **Routine deploys** become "push to `main`". By hand, `sudo /usr/local/sbin/imnstr-deploy`.
  - **The checks section** points at `deploy/checks.sh` as the one list.
- **`CLAUDE.md`**: one line. "A push to `main` deploys. Only `verify` pushes `main`. A new deploy check goes in `deploy/checks.sh`."
- **Tests** (new files only, so they don't collide with another lane's edits to `deploy.test.ts`):
  - `tests/unit/ci-deploy.test.ts`, which reads the workflow and both scripts as text;
  - `tests/integration/deploy-script.test.ts`, the harness below.

**Not changed:** `Dockerfile`, `docker-compose.prod.yml`, `package.json`, `deploy/nginx/*`, `deploy/backup.sh`. All as on `main @ 4c2b9b2` (B4b made the Dockerfile two stages and added `npm run build`).

**Tests**
- **Unit (text):**
  - CI-1: `--ignore-scripts` present, no `playwright` or `e2e`;
  - CI-2: the `if:`, `needs` and `environment`;
  - CI-3: `permissions`, `concurrency`, only the two actions, each `@` a 40-hex SHA, `StrictHostKeyChecking=yes`, no `ssh-keyscan`;
  - the script has `set -euo pipefail`, `--ff-only` and `flock`;
  - the script has **no** `reset --hard` and no unfiltered `prune`;
  - `checks.sh` never names `.env`;
  - neither script uses `set -x`.
- **Integration (the harness):** runs `deploy/imnstr-deploy.sh` with `bash` against:
  - a temporary bare "origin" repo and a clone standing in for `/srv/imnstr`;
  - a temporary live conf and an installed copy of the script;
  - stub `docker`, `nginx` and `runuser` first on `PATH`, which log their calls and return set codes.

  One case each:
  - deploys and prints `DEPLOYED`;
  - already current, checks only;
  - lock held → 2;
  - dirty tree → 2;
  - history rewritten → 2;
  - conf differs → 2, with the checkout unmoved;
  - compose changed → 2;
  - installed script differs → 2;
  - build fails → 1, with no `up`;
  - unhealthy → 1;
  - `nginx -t` fails → 1;
  - a check fails → 1, naming it.

  It runs in CI (Linux) and under Git Bash here. If it can't run here, the lane says so in report item 3.
- **Linux, before CI exists:** run the CI job's commands in `node:24` with `TZ=UTC` against a `git archive` of the branch, never the Windows `node_modules`. This is the first time the suite runs on Linux and in UTC.
- **`deploy/checks.sh` against the live site** from this machine, with the current flags. Everything it checks is live since B4a, so all checks pass. It is read-only except one sign-in options POST, which leaves a 5-min challenge in memory.
- `bash -n` on both scripts, and `shellcheck` through its Docker image if Docker Desktop is up.

**At the verify** (the server part; the founder at the box; commands for a sudo user, one per line):
1. Review, fix, merge `main` in. If a stage was verified in the meantime, move any deploy check it added to the README into `checks.sh`.
2. Fast-forward and push `main`. `DEPLOY_ENABLED` is unset, so `check` runs and `deploy` is skipped. **`check` must be green.**
3. Deploy that commit **by hand** (the README's manual path), which brings the scripts onto the box.
4. Set up the server part: user, key, sudoers, install the script, with CD-0 settled.
5. Add the secrets and set `DEPLOY_ENABLED=true`.
6. Re-run the workflow (`workflow_dispatch`). It is already current, so it only checks: green.
7. Prove CI-4 on the box: `id imnstr-deploy`; `sudo -l -U imnstr-deploy`; `sudo -u imnstr-deploy docker ps` refused.
8. Write the stage record `docs/development/CD1.md`. **Its push is the first real CI deploy** (CI-11). Paste the run's URL and output into the record in a follow-up commit; that push deploys again, harmlessly.

**Acceptance.** CI-1 to CI-11.

**Size: M** *(estimate)*. About 700 changed lines including the harness, over S's ~600. The lane budget is 2× M.

**Traps**
- **From the moment `DEPLOY_ENABLED` is `true`, every verify's push to `main` is that stage's deploy.** The verify then:
  1. **Before pushing,** checks the stage's diff for a stop file (`deploy/nginx/imnstr.conf`, `docker-compose.prod.yml`, `deploy/imnstr-deploy.sh`), a new `.env` line, or a one-off server step. A new `.env` line goes in by hand **before** the push: the app boots on defaults without it. For a stop file, plan the manual step, or expect the red exit 2 and do it then.
  2. **Pushes.**
  3. **Watches the run** in a browser. The repo is public, so the Actions page reads without signing in, and the in-app browser can read it.
  4. **Puts the run's URL and the `checks.sh` output** in the stage record.

  **A red run means the stage is not deployed, and the verify isn't done.** One-off server steps stay the founder's, by hand: a setup token, a conf, a cron line. A stage that adds a deploy check adds it to `deploy/checks.sh` in its own diff.
- **The first stage deployed this way is whichever is verified after `DEPLOY_ENABLED` goes on, likely B5.** *(0.1 named B4b. B4b was verified and deployed by hand on 2026-10-14, `main @ 4c2b9b2`, before CD1 was launched.)* B4b's checks are already in the README, so the lane carries them into `checks.sh` (CI-8). B4b's record lists what its pasted output lacked: the container's health after `starting`, and root-app's URL. The script makes both mandatory.
- **The next `imnstr.conf` change stops a CI deploy (exit 2).** S-14 (a stale comment) is owed "at the next conf change". Whichever stage makes it plans the manual `cp`, `nginx -t`, reload, then re-runs the job.
- **The VPS builds two stages since B4b,** and it did so with 1,209 MiB still available (B4b record). CI changes nothing about the build, but it does run it unattended. If a later stage makes the build heavier, its verify builds the image locally first.
- **The lockfile and Linux** are proven. The box's Linux `npm ci --ignore-scripts` plus `vite build` worked at B4b, so CI's `ubuntu-24.04` run should too. If CI's `npm run build` fails on a missing platform binary, fix the lockfile; don't drop `--ignore-scripts`.
- **The sudoers file can lock the founder out of `sudo` on a shared box.** Never `tee` straight into `/etc/sudoers.d/`. Write to `/tmp`, run `sudo visudo -cf` on it, and only then `sudo install -m 0440`. The file's name has no dot (sudo skips names with one).
- **The deploy user needs a real shell.** `sshd` runs the forced command through the user's shell, so `nologin` blocks it. `restrict` gives no pty, and `sudo -n` doesn't need one on Ubuntu (no `requiretty`).
- **sudo strips the environment and SSH arguments.** Nothing reaches the script from the client, by design. `SSH_ORIGINAL_COMMAND` is ignored, and the sudoers `""` forbids arguments. The script deploys `origin/main` as it finds it, and the workflow compares the SHA afterwards (CI-9).
- **Stop files compare against what is live, not against the last commit.** Compare `imnstr.conf` with the live copy and the script with its installed copy, so a manual fix followed by a re-run passes. The compose file has no live copy, so compare it between the checkout's `HEAD` and the new commit.
- **No `git reset --hard`, ever.** A rewritten `main` (as on 10-14) is exit 2, and the founder decides by hand.
- **Run the checks as `nobody`,** not as the deploy user. Repo code then holds no sudo right at all. Confirm on the box that `runuser -u nobody -- bash …` works with `nobody`'s `nologin` shell.
- **Public logs:** the workflow echoes no secret and no `.env` line, and the script prints none. GitHub masks secrets it knows, but not a value derived from one.
- **`concurrency` keeps one run pending,** and a newer push replaces it. That is harmless: the newer run deploys the tip of `main`. The server-side lock covers a manual deploy at the same moment.
- **Actions pinned by SHA:** get each SHA with `git ls-remote` on the action's tag, and never write one from memory.
- **The harness must not need root, Docker or the network.** Stubs only, and temporary directories under `.tmp/`.
- **The lane has no server access.** It writes the files, the README and the tests. The server part is the verify's.

**Not here:**
- a registry, or building in CI;
- Playwright in CI;
- deploys on branches other than `main`, or preview environments;
- automatic rollback;
- GitHub branch protection on `main` (the founder's call; it would also block a history rewrite like 10-14's);
- pruning old images: today's manual deploy leaves them too, so it is an owed item at CD1's verify, filtered by label if it is ever automated;
- off-box backups (F-7).

---

## What this makes stale, for the founder to accept at CD1's verify

These are not edited by this note. CD1's verify lists them in the stage record, as F-items, the way F-8 and F-9 were handled.
- **Config 0.3 §7:** the *Routine deploy* and *Who deploys* rows, and *Checks after each deploy* (now `deploy/checks.sh`).
- **Review checklist 0.3 §6:** add CI-4's deploy user, the no-global-prune rule, and "a stage that adds a deploy check edits `checks.sh`".
- **Build plan 0.5:** B2's goal ("redeployable with one command") and *Not here* ("each later stage deploys at its own verify"); §7's list of what is on the box (add the deploy user, the sudoers file and the installed script).
- **`brief-common.md`:** lanes still never push. Add "a push to `main` deploys" to the reason.

## Changelog

- **0.2 · 2026-10-15** — CD-0 questions 1 and 2 answered (SSH open on 22, key-only, no `AllowUsers`); root-app's URL still open. Brought up to `main @ 4c2b9b2`: B4b was verified and deployed by hand, so it is not CD1's first CI deploy; its checks join CI-8; `npm run build` in CI; the lockfile trap is retired; the next conf change (S-14) is a stop. The founder's sudo user `deploy` is not CI's.
- **0.1 · 2026-10-14** — First version (trial step 8e). Four founder decisions; one stage, CD1 (M).
