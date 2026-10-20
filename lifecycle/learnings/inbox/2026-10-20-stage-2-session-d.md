*Session: 2026-10-20 · ecosystem/modules/01-root-studio-journeys · rollout stage 2, session D (TK1, Change track) · Opus 5.5*

## Check config.md's branch and deploy facts against the remote before drafting

**Rule:** At the start of a code session, `git fetch` and compare `config.md`'s Branches and Deploy rows with the remote (`origin/main`'s log, `.github/workflows/`) before writing a change note or card; correct `config.md` first, with the founder's yes.
**Event:** Session E's prompt and root-app `config.md` 0.2 said nothing was merged and there were no push deploys; `origin/main` was 183 commits ahead, with every build branch merged and `deploy.yml` deploying on push. The founder had done it the same day from another machine.
**Cost:** caught before the card; had it not been, `verify`'s push would have deployed without anyone saying so.
**Scope:** skill `build-phase` · project root-app
**Destination:** `skills/build-phase/SKILL.md` (Launch step 3, check the plan against the code)
**Urgent:** no

## One lookup, not two copies, for module to project

**Rule:** When `bin/gate` and `skills/shared/build.sh` both need the same mapping (module folder to project), have the gate use the shared function rather than keep its own copy.
**Event:** `bash lifecycle/bin/gate ecosystem/modules/01-root-studio-journeys 8 TK1` failed with `missing file: lifecycle/projects/ecosystem/config.md`: the gate used the module's top folder, while `project_of` in `build.sh` already mapped `ecosystem` to root-app. Fixed in `f16784f` by a second copy (`area_project`).
**Cost:** about 10 minutes and a gate-test case.
**Scope:** method · `bin/gate`
**Destination:** `lifecycle/engineering-checklist.md`, and a refactor of `bin/gate` to source `build.sh`'s `project_of`
**Urgent:** no

## Don't chain a command that can prompt after commands that change state

**Rule:** Run anything that may wait for input (`psql`, `ssh`, a `git push` without a key) in its own Bash call, never after a commit or a `git worktree add` in the same one.
**Event:** One call committed the TK1 card, fast-forwarded root-app's `main` and added the lane's worktree, then ran `psql` without `PGPASSWORD`; `psql` waited for a password, the call hit the 120 s timeout, and it moved to the background with its earlier results unseen until it was read and stopped.
**Cost:** about 3 minutes and a background task to stop.
**Scope:** model behaviour
**Destination:** `lifecycle/engineering-checklist.md`
**Urgent:** no
