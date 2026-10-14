# CD1 · Deploy on push to `main` — phase card

*For the Sonnet lane building CD1. Read `lifecycle/projects/imnstr/brief-common.md` first; this card adds to it. Drafted by `build-phase CD1` (trial step 8a), 2026-10-15, from change note **`changes/04-ci-deploy.md` 0.3**, section *CD1*, which stands in for the build plan's §5, and the code as it is: `rishe-eco/i-monster` `main @ 4c2b9b2` (B1–B4b verified and deployed; no `.github/` yet).*

## Your lane

| | |
|---|---|
| Worktree | `E:\_root\imnstr\.claude\worktrees\cd1-ci-deploy`. **Your Bash calls don't start there:** begin every command with `cd /e/_root/imnstr/.claude/worktrees/cd1-ci-deploy &&`, and use absolute paths with Read, Edit and Write. Run `npm install --ignore-scripts` first. |
| Branch | `cd1-ci-deploy`, from `main`, already checked out, no upstream. `git config --local user.email` is set for the repo; don't change it. |
| Slot | **B**: port `4120`, `.tmp/e2e.db`. You need no e2e server; the slot keeps you off slot A's port. |
| Size | **M** (2–4 h). Stop at 8 h, per the common brief. |
| root-sot | Read it at `E:\_root\root-sot-imnstr`, **not** `E:\_root\root-sot`. Paths below are relative to `imnstr/modules/01-website/` there. |
| Beside you | **Another session is running milestone suites (8d) in `E:\_root\imnstr` itself.** Never touch that checkout, its `node_modules` or `.tmp/`. |

## Read, in this order

1. `CLAUDE.md` and `docs/development/README.md` in your worktree; `deploy/README.md` whole; `docs/development/B2.md` (*Decided*, *Owed*) and `docs/development/B4b.md` (*Verification*: what the pasted checks lacked). Skim `Dockerfile` (its `HEALTHCHECK`), `docker-compose.prod.yml`, `.env.example`, `tests/unit/deploy.test.ts`, `vitest.config.ts`.
2. **Change note `changes/04-ci-deploy.md`, whole.** It is your plan: *Acceptance criteria* (CI-1 to CI-11), *What must not break*, and *CD1*'s Files, Tests, Traps and Not here. Skip nothing in *Traps*.
3. Review checklist `lifecycle/projects/imnstr/review-checklist.md` **§1, §2 and §6**. The reviewer ticks them; build to them.

## What to build

The note's *Files* list is the spec. These points settle what it leaves open:

- **Actions pinned by SHA.** Take the newest release tag of `actions/checkout` and `actions/setup-node` and its commit with `git ls-remote --tags https://github.com/actions/<name>` (use the peeled `^{}` line for an annotated tag). Write `@<40-hex> # vX.Y.Z`. Never a SHA from memory.
- **The harness on Windows.**
  - Git Bash has **no `flock`** and no `runuser`. Stub both, with `docker` and `nginx`, in a temporary `bin/` first on `PATH`. The lock-held case is a `flock` stub that fails, plus one text assertion that the script calls `flock -n`.
  - From Node on Windows, `bash` can resolve to `C:\Windows\System32\bash.exe`, which is WSL. Resolve Git Bash explicitly on `win32` (for example from `git --exec-path`, or `C:\Program Files\Git\bin\bash.exe`), and plain `bash` elsewhere. If no bash is found, the test fails with that message. It does not skip quietly.
  - Everything under `.tmp/`, removed after each case. No root, no Docker, no network: the "origin" is a local bare repo.
- **Overrides for the harness.** Name every path and command the script takes from the environment in one block at its top, with a comment that `sudo`'s `env_reset` strips them on the box. List the names in report item 4.
- **`PRELAUNCH`** is read from `.env` with `grep` and passed to `checks.sh` as an argument (`1` or `0`). No other `.env` line is read or printed.
- **`checks.sh`** gets one function per check, each named in its failure line. It covers every check in `deploy/README.md` *Checks after every deploy* as of `4c2b9b2` (the public headers, `/fa/`, the 404, `www` → apex, `http` → `https`, the four admin API checks, the two shell checks, the bundle's two), plus root-app at `https://m-root.com/` → 200. The README's section then points at `checks.sh` as the one list.
- **The workflow's verdict.** After SSH, it prints whether `DEPLOYED <sha>` equals `github.sha` or is newer, and fails if no `DEPLOYED` line came back.

## Proving it here

- `npx vitest run tests/unit/ci-deploy.test.ts tests/integration/deploy-script.test.ts`, then `tests/unit/deploy.test.ts` (it must still pass), then `npm run check`.
- `bash -n` on both scripts.
- **`deploy/checks.sh` against the live site** from this machine, with `PRELAUNCH` as the box has it (`1`: the site is still noindex). Paste its output in item 3. If a check fails against the live site, find out whether the check or the site is wrong before changing either.
- **Docker, only if it is already up.** `timeout 20 docker info`. If it doesn't answer, skip the two items below and say so in item 3. Don't start, restart or repair Docker Desktop.
  - `shellcheck` on both scripts, through `koalaman/shellcheck`.
  - **The Linux run:** CI's `check` job's commands in `node:24` with `TZ=UTC`, against a `git archive` of your branch, never your `node_modules`. It runs the full `npm test`, so it is a **heavy runner**. Do it last, and only when no other is running on the machine. Check that first:

    `powershell -NoProfile -Command "Get-CimInstance Win32_Process -Filter \"name='node.exe'\" | Select -Expand CommandLine" | grep -iE 'vitest|playwright'`

    If anything shows, the milestone session is running. Skip the Linux run and say so in item 3. CI does it at the verify.

## What the verify does

The note's *At the verify* list, steps 1–8, with the founder at the server. Write the README's *Server setup for CI* so that list can be followed line by line: one command per line, `sudo` on each, `| sudo tee` for root files, the sudoers file through `/tmp` and `visudo -cf`.

## Done for CD1

- CI-1 to CI-10 provable from your files and tests. CI-11 is the verify's.
- Every harness case in the note's *Tests*, passing here under Git Bash.
- No change to the files under the note's *Not changed*.
- **Also write your report to `.tmp/CD1.report.md`** in your worktree, then give it as your final message. All seven parts.

**Not here:** the note's *Not here* list; any server or GitHub settings change; pushing. If the note and the code disagree, follow the code and say so in item 5.
