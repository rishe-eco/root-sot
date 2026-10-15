# 8c CD1 verify — 2026-10-15

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c verify CD1. Model: Opus, effort: high. Be wary another agent is running 8d at the same time. the git environment is created with `main` rule." The step and effort matched the top `STATE.md` block. Run beside an 8d (MS2) session working in `E:\_root\imnstr` itself; this session worked only in CD1's worktree. The founder was at the server for the second half.

## Read
- `lifecycle/trial-run/README.md`, whole. `skills-plan.md` §0 and `verify`. Not `lifecycle/README.md` §0–§4: the memory notes for this build held what I needed.
- `STATE.md`, top block (8b CD1).
- Inputs: `briefs/CD1.report.md`; `git diff --stat main...cd1-ci-deploy`; `briefs/CD1.md`; change note `changes/04-ci-deploy.md` 0.3, whole (it stands in for plan §5); `lifecycle/projects/imnstr/review-checklist.md`, whole; `config.md` §7.
- Code: all seven files in the diff. The two scripts and the workflow whole; the README diff whole; both test files whole; `docker-compose.prod.yml` and `.gitattributes` (container name, LF in checkouts).
- *Outside the read order:* `docs/development/B4b.md` and the development README, as the record's shape and to update the stage list; `imnstr/open-work.md`, to add to it; `log/08c-B4b-verify.md` (*Session* to *Did*), as this log's shape.

## Gate
Checked by hand:
- card, report and branch present (`cd1-ci-deploy` @ `8fd95a9`, local, 2 commits, founder identity);
- the change note's CD1 section present, 0.3;
- status column 8 at `5/10`, nothing `STALE`;
- base `main @ 4c2b9b2` still `origin/main`;
- `user.email` the founder's in both repos.

Local `main` was one commit ahead (`09c7302`, the 8d session's unpushed MS2 change), so I left local `main` alone. **Gate passed.**

## Did
Mapped to `verify`'s eleven steps, with the note's *At the verify* list folded in:
1. **Stat, then core files.** The deploy script and the workflow first, then `checks.sh`, the README's server setup, then the tests.
2. **Checklist §2, §3, §6, and the note's CI-1 to CI-10.** Re-pinned both actions with `git ls-remote`: they match, and both are the newest tags. Findings:
   - (a) **The lock was in `/run/lock`, which is world-writable.** On a shared box another account could plant the file and hold every deploy off.
   - (b) **The harness's stubs had no execute bit.** Git Bash ran them anyway; Linux would refuse them, so CI's first `npm test` would have gone red.
   - (c) **`shellcheck` had never run** (Docker down for the lane and still down for me), and nothing would run it.
   - Lane item 5, "already current still builds": accepted; the note's version is a false green.
3. **Fixed** (`faceda1`): lock in `/run`; stubs written `0o755`; a `shellcheck` step in `check` (the runner image ships it), and a text assertion for it.
4. **Merge `main`:** no-op (`origin/main` = base). The 8d commit was left out: it was unpushed work of another session.
5. **Reran:** the three deploy test files (70 passed), `npm run check`, `bash -n`, and `checks.sh 1` against the live site (14 ok).
   - **Note step 2:** pushed `HEAD:main` from the worktree (`4c2b9b2..faceda1`), without touching the local `main` that 8d holds. Run 1: `check` green on Linux in UTC, 32 files and 599 tests, shellcheck clean; `deploy` skipped.
   - **Messaged the 8d session** to rebase before pushing. It did (`2020960`, unpushed).
   - **Note steps 3–7 with the founder:**
     - the manual deploy;
     - the key pair on the founder's PC. The first paste used the key's fingerprint, not the public key, so I corrected it.
     - user, `authorized_keys`, sudoers (`visudo -cf` → `parsed OK`), install;
     - the CI-4 proofs;
     - `nobody` running the checks;
     - the installed script by hand: `DEPLOYED faceda1`.
   - **The GitHub part.** Run 2's `deploy` was **skipped**: `DEPLOY_ENABLED` had been set as a variable of the `production` environment, and a job's `if` can't see those. Moved to a repository variable. Run 3: `check` and `deploy` green, `DEPLOYED` = `faceda1`.
   - **The Actions log needs sign-in** even on a public repo, so I read runs and jobs through the public API, and the founder's log download for run 2.
6. **Stage record** `docs/development/CD1.md`; stage-list row and two owed rows in the development README; the README's step 7 now warns about the environment variable. Pushed as `0cbfdc1`: **the first automatic deploy of a real commit (CI-11).** Its run and verdict went into the record in a follow-up commit.
7. **Owed → `imnstr/open-work.md` 0.9:** F-10 (stale canon, for the founder) and S-16 (image pruning).
8. **Stale canon** flagged in the record (config §7, checklist §6, build plan B2 and §7, brief-common, and the note itself), as F-10.
9. **Stage list** updated. Status column 8 left at `5/10`: CD1 is a Change, not one of the plan's ten stages.
10. **Learnings:** below, under *Lessons*. The lane's item 7 (a shared "find Git Bash, build a git fixture" test helper) is carried there.
11. **Ready-to-fast-forward:** done; CD1 is on `main` and deployed by CI.

## Output
- imnstr: `faceda1` (review), `0cbfdc1` (record; run 4 deployed it on its own: CI-11), `60d30db` (the run in the record). `main @ 60d30db`.
- root-sot: `imnstr/open-work.md` 0.9; this log; a `STATE.md` block.

## Spec gaps
- **`verify` has no step for "push, then watch a deploy"** now that a push deploys. The note's *At the verify* list served. The skill should gain a stage-kind branch: for a project whose `main` deploys, *before the push* (stop files, `.env` lines), *push*, *read the run*, then *record the run URL*.
- **"Watch the run in the in-app browser" fails:** GitHub's job logs need sign-in, even for a public repo. Status comes from the public API; the logs come from the founder. The config should say which.
- **"Merge `main` in" assumes `main` is the reviewer's to read.** With 8d holding local `main` with an unpushed commit, the right base was `origin/main`. The skill should say `origin/<base>`, and push with `HEAD:main` from the stage worktree.
- **Parallel sessions sharing one code repo and one `main`** have no rule. Messaging the other session worked. The trial README's parallel rule covers only `STATE.md`.
- **A change note's stage has no status-column home.** I left column 8 alone.

## Template sample
The stage record kept B4b's headings: *Built* (with *The review changed*), *Decided* (with *Where the note was wrong*), *Owed*, *Flagged for close-out*, *Verification*. *Verification* gained **In CI** between *Run at review* and *On the server*. It should be a required sub-heading for any project whose `main` deploys.

## Missing foundation
- No GitHub CLI and no signed-in API, so runs are read anonymously through `api.github.com` (60 requests an hour).
- Docker Desktop still down; CI stood in for the `node:24` run and for shellcheck.

## Founder Q&A
- *Founder:* "like this?", with the key's `SHA256:` fingerprint in angle brackets in the `authorized_keys` line. *Answer:* no; the line takes the public key's text (`Get-Content …\imnstr-ci-key.pub`), without the brackets.
- *Founder:* "would you run F10 or should I run it in another session?" *Answer:* here, as F-8 and F-9 were; listed the edits. *Founder:* "yes, F-10". Applied: config 0.4 §7, review checklist 0.4 §6, build plan 0.6 (B2 goal and *Not here*, §7 item 5), brief-common 0.3 (Git), change note 0.4 (lock path, already-current build, repository variable, reading a run), open-work 0.11 (F-10 closed; 0.10 was the 8d session's).
- *Founder:* "Deploy keeps saying job was skipped", with run 2's logs. *Answer:* `DEPLOY_ENABLED` must be a **repository** variable, not one of the `production` environment; move it and re-run. Run 3 went green.

## Skill shape
Opus · high fits: the review found three real defects in 1,285 lines of shell and YAML that tests alone wouldn't have caught on Windows. Not forked: the session needs the founder's pastes across several turns, and a peer session's messages. Could be injected: the diff stat, the report, the note's stage section, `git ls-remote` for any pinned action, and the latest run's status from the API. Reference file: the server-setup paste rules (sudo per line, `| sudo tee`, no tagged fences), plus "variables vs environment variables" for GitHub.

## Lessons
1. **Rule:** a test harness that runs stub executables by path must write them executable. **Event:** CD1's stubs passed under Git Bash and would have failed in CI, the stage's first Linux run; caught by reading. **Scope:** any harness built on Windows that also runs in CI. **Destination:** `brief-common.md` (environment). `urgent: no`.
2. **Rule:** a job-level `if` on `vars.X` needs a repository (or organisation) variable; environment variables load only after the job starts. **Event:** run 2's deploy was skipped and cost the founder a round trip. **Scope:** any GitHub workflow gated by a variable. **Destination:** `config.md` §7 and the deploy README (done). `urgent: no`.
3. **Rule:** when a parallel session holds the code repo's local `main`, verify pushes `HEAD:main` from the stage worktree and tells that session to rebase. **Event:** 8d had `09c7302` unpushed on local `main` during this verify. **Scope:** parallel 8c/8d. **Destination:** `verify` skill, trial README's parallel rule. `urgent: yes`: any later stage's verify pushes a deploy.

## Cost
*Founder fills in.*

## Next
**8a B5** (slot A). B5's verify is likely the first stage deployed by CI: before its push, check the diff for stop files and `.env` lines, then read the run through the API. The 8d session will push `2020960` plus the MS2 record, which deploys too. F-10 is for the founder before 8a B5.
