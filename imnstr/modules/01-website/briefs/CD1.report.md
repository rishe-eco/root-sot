# CD1 report: Deploy on push to `main`

## 1. Branch and commits
Branch `cd1-ci-deploy` (from `main @ 4c2b9b2`, not pushed). `git config user.email` checked before the first commit and after the last: salmanian.foad2@gmail.com.
- `2ec5451` CD1: deploy on push to main (workflow, deploy script, checks, tests)
- `8fd95a9` CD1: README server setup, exit codes, rollback; CLAUDE.md line

## 2. Files changed
- `.github/workflows/deploy.yml` (new): `check` job (ci, check, build, test; Node 24, TZ=UTC) and `deploy` job (needs check, main only, DEPLOY_ENABLED, environment production, concurrency, SSH with a secret known_hosts, DEPLOYED verdict). Actions: checkout v7.0.1 `3d3c42e5aac5ba805825da76410c181273ba90b1`, setup-node v7.1.0 `949feb2413d6458794dcd2491c4babbbce0c15c1`, from `git ls-remote` (lightweight tags, so no peeled line).
- `deploy/imnstr-deploy.sh` (new, mode 100755): the reference copy of the root script.
- `deploy/checks.sh` (new, 100755): one function per check, 14 checks, prints `ok <name>`, stops at the first `FAILED <name>: <why>`.
- `deploy/README.md`: Routine deploys rewritten (push deploys, by hand, exit codes, manual rollback); Checks section points at `checks.sh`; new Server setup for CI (9 steps).
- `CLAUDE.md`: the one line.
- `tests/unit/ci-deploy.test.ts` (new, 31 tests, text).
- `tests/integration/deploy-script.test.ts` (new, 19 tests, the bash harness).
Not touched: Dockerfile, docker-compose.prod.yml, package.json, deploy/nginx/*, deploy/backup.sh.

## 3. What I ran
- `npx vitest run tests/unit/ci-deploy.test.ts tests/integration/deploy-script.test.ts`: **Test Files 2 passed (2), Tests 50 passed (50)**, 96 s (the harness is slow under Git Bash).
- `npx vitest run tests/unit/deploy.test.ts`: **Test Files 1 passed (1), Tests 20 passed (20)**.
- `npm run check`: clean (tsc, tsc admin, eslint; no output).
- `bash -n` on both scripts: OK. Workflow parsed with PyYAML: OK (jobs check, deploy).
- **`bash deploy/checks.sh 1` against the live site**, exit 0:
```
ok   check_public /
ok   check_public /fa/
ok   check_public /no-such-page
ok   check_www_redirects_to_apex
ok   check_http_redirects_to_https
ok   check_admin_session_unauthenticated
ok   check_admin_origin_refused
ok   check_admin_signin_options
ok   check_test_routes_absent
ok   check_admin_shell /admin
ok   check_admin_shell /admin/setup/x
ok   check_admin_bundle js
ok   check_admin_bundle css
ok   check_root_app_answers
checks passed (PRELAUNCH=1)
```
  Negative runs, to see that it can fail: `0` gives `FAILED check_public /: x-robots-tag is present, and PRELAUNCH is not set` (exit 1); a root-app URL that answers 404 gives `FAILED check_root_app_answers: https://imnstr.com/no-such-page answered 404, expected 200`; no argument gives usage, exit 64. Everything passed against the live site on the first run, so neither a check nor the site was wrong.
- **Not run:** `shellcheck` and the Linux `node:24` run. `timeout 20 docker info` timed out (rc 124), so Docker is down; per the card I did not touch it. No vitest or playwright process was running. CI does the Linux run at the verify. `shellcheck` is not installed natively.

## 4. Decisions the card did not make
- **Override names** (one block at the top of `imnstr-deploy.sh`, with the comment on sudo's env_reset): `IMNSTR_DIR`, `IMNSTR_LOCK`, `IMNSTR_LIVE_CONF`, `IMNSTR_INSTALLED`, `IMNSTR_CONTAINER`, `IMNSTR_CHECK_USER`, `IMNSTR_FLOCK`, `IMNSTR_DOCKER`, `IMNSTR_NGINX`, `IMNSTR_RUNUSER`, `IMNSTR_BASH`. The harness points the stubs at these names rather than changing PATH (which also avoids Windows' `Path`/`PATH` key clash). The test's own bash is found from `git --exec-path`, or `IMNSTR_TEST_BASH`.
- **`checks.sh` arguments:** `<prelaunch 1|0> [origin] [root-app url]`; prelaunch is required (usage, exit 64, otherwise). The script passes only the flag.
- **An already-current run still builds and runs `up -d`** (cached, no-op) and skips only the merge. See item 5.
- **Stop files are compared even when current**, and all that differ are reported together before exit 2.
- **Untracked files are ignored** by the clean-tree check (`--untracked-files=no`): `.env`, `data/`, `backups/`.
- **The checkout stays moved after a failed build** (exit 1): merge is step 6, before the build, as the note orders it. The README says the old container keeps serving.
- **Workflow:** `ssh -T`, `</dev/null`, and `set -euo pipefail` so the pipe to `tee` keeps ssh's exit code for the verdict. The deploy job has its own `actions/checkout` (`fetch-depth: 0`, `persist-credentials: false`) plus `git fetch origin main`, so it can say "newer" with `merge-base --is-ancestor`. Still only the two permitted actions.
- **README server setup:** `.ssh` and `authorized_keys` belong to root (0755/0644), so the deploy user cannot rewrite its own forced command. The sudoers temp file is made with `mktemp`, not a fixed `/tmp` name (shared box). `DEPLOY_KNOWN_HOSTS` is made on the box from `ssh_host_ed25519_key.pub`.
- **README rollback** sets `DEPLOY_ENABLED=false` first, and rolls back only when the bad commit added no migration.
- The unit test imports `CSP` from `lib/headers.ts`, so `checks.sh` and the app cannot drift apart silently.

## 5. Where the note, card or brief was wrong or vague
- **"Already current: skip steps 6-8, checks only" gives a false green.** The note orders merge, then build. If the build fails, the checkout is already at the new commit, so a re-run (the workflow_dispatch the README recommends) would find "current", skip build and up, check the old container and print `DEPLOYED <new sha>`. I skip only the merge; the build is cached and `up -d` is a no-op, so the re-run is honest. A test covers it ("does not take a failed build for a deploy"). The note's harness case "already current, checks only" therefore reads "moves nothing, still builds, ups and checks". Reviewer: confirm, or revert to the note's wording.
- `runuser -u nobody -- bash <abs path>/deploy/checks.sh` needs `nobody` to read `/srv/imnstr/deploy/checks.sh`. A root `git clone` is 0755 so it should; Server setup step 6 proves it.
- The card's "stub flock, runuser first on PATH" is done through the `IMNSTR_*` overrides instead; the harness needs no PATH change.
- The note's text test "no `reset --hard`, no unfiltered prune" is asserted on the raw file, so no comment may contain those words. I worded the comments to match. A trap for the next editor.
- `npm test` in CI also runs the harness, which needs `git` and `bash` on the runner (both on ubuntu-24.04), and is slow (about 100 s here).

## 6. What I could not verify
- **The Linux/UTC run of the full suite, and the harness on Linux.** Docker is down. Verified by CI's first `check` run at the verify, or by the card's `node:24` run.
- **`shellcheck`** on both scripts (Docker down, no native binary). `docker run --rm -v "$PWD:/mnt" koalaman/shellcheck /mnt/deploy/imnstr-deploy.sh /mnt/deploy/checks.sh`, or CI.
- **On the box:** the real `flock`, `runuser`, `sudo -n`, the forced command, `adduser --disabled-password` plus key login (a locked `!` password field can block key login unless UsePAM is on; README step 2 has the `usermod -p '*'` fallback), and `runuser -u nobody -- bash` with nobody's nologin shell (README step 6 proves it).
- **The workflow itself:** the YAML parses, but it has not run on GitHub and there is no `actionlint` here. The anonymous `git fetch origin main` in the verdict step (`persist-credentials: false`, public repo) should work but is unproven.
- The `docker compose up -d --wait --wait-timeout` flags against Compose v5 on the box, and the `docker inspect` health string: stubs only.
- CI-11 is the verify's. No stop under the budget (about 1.5 h in).

## 7. One thing that would have made this faster
A shared test helper for "find Git Bash and build a temporary git fixture" in `tests/` (the harness needs both, and the next deploy test will too). Also, a note in the brief that long heredocs with apostrophes or `${...}` break in the Bash tool, so multi-line files go through Write.
