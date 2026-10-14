# 8c B2 verify — 2026-10-11 to 2026-10-14

## Session
Opus 5.5 (`claude-opus-5-5`), effort high, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c, verify B2." The founder added: "Can you hold up on backup remote data for later?", which deferred `BACKUP_REMOTE` and the ssh key (owed since 8a). The session spanned three days: the local review on 2026-10-11, and the server deploy, with the founder at the box, on 2026-10-14. Between the two, the founder moved the repo to `rishe-eco/i-monster` and rewrote its history to fix the commit identity, so this session's first push (`0c9ddb0`) now exists as `ed83c99`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `verify`, `handoff`.
- `STATE.md`, top block (8b B2).
- Inputs: `briefs/B2.report.md`; `git diff --stat main...b2-deploy`; `briefs/B2.md`; plan §5 B2; `lifecycle/projects/imnstr/review-checklist.md`.
- *Outside the read order, needed for the review:*
  - plan §7, §9 and the MS1 line of §3, which the card and checklist §6 cite; `config.md` §7 (where the deploy differs from the lane's);
  - `imnstr/open-work.md`, to add to it; `log/08c-B3-verify.md`, by section, as the shape of this log; `docs/development/B3.md`, as the shape of the record;
  - root-app's `deploy/nginx/*.conf` (`listen`, zones) and `deploy/README.md` "Somewhere else on the box": to judge `http2` on a shared socket, and for the §7 line;
  - the memory note on the rishe-eco git identity (new on 2026-10-14), which led to the repo move.
- Code: every file in the diff; `lib/db.ts` (what `openDb` does to the live file); `routes/system.ts` (the healthcheck path); `package-lock.json`'s diff.

## Gate
Checked by hand: card, report and branch present (`b2-deploy` @ `7010775`, local only); plan §5 B2 present; status row column 8 at `2/10`, nothing `STALE`; P0-2 and P0-3 answered in the 8a block. P0-4's `BACKUP_REMOTE` was owed "before B2's verify", and the founder deferred it at the start, so it became an owed item rather than a gate failure. **Gate passed**, with that one deferral.

## Did
Mapped to `verify`'s eleven steps.
1. **Stat, then core files.** 13 files, +470/−34. Read all the non-test files, then the two tests.
2. **Against the checklist** §1–§3, §6, §7. Three findings by reading:
   - `listen 443 ssl http2` turns HTTP/2 on for every tenant on `:443` in nginx 1.18. root-app's confs listen without it.
   - The lane symlinked the live conf into the repo, against plan §7 and config §7. certbot's nginx plugin then edits the git checkout at each renewal, and a `git pull` changes what the next reload loads.
   - `certonly` with no installer has no reload after renewal, so the new certificate isn't loaded.

   Then **built and ran the image** on this machine (Docker Desktop was up, which the lane had lacked). That found the fourth defect: every backup left `-wal`/`-shm` sidecars that the prune would never remove. Also ran: the healthcheck, the headers, an entry seeded and backed up, a restore into a scratch container, the `E2E_CLOCK` refusal, and `backup.sh` against stub `docker` and `rsync`.
3. **Fixed on the branch** (`0c9ddb0`, now `ed83c99`): a rollback journal on the backup copy, with a test; no `http2`, with a test; the README to copies in `sites-available`, the certbot deploy hook, a rollback for conf changes, cron without the remote, `/log`.
4. **Merged `main`:** a no-op.
5. **Reran** `deploy`, `backup`, `boot`, `pages` and `house-rules`: 58 passed; `npm run check` clean.
6. *Reordered:* the founder said yes to fast-forwarding `main` and pushing **before** the record. The server clones from GitHub, so the first deploy can't come from a local branch. Then the server deploy, in four parts the founder ran (A: clone, `.env`, start; B: bootstrap conf, `certonly`, final conf; C: `curl -I`, root-app, `certbot renew --dry-run`; D: backup, restore, cron). After that, the stage record `docs/development/B2.md`, on `main` (`10db886`).
7. **Owed** to `imnstr/open-work.md` 0.5: F-7 (off-box backups, deferred), F-8 (plan, checklist and config changelog), S-8 to S-10; S-6 and V-1 closed.
8. **Canon flagged** in the record: plan §5 B2 and §7, checklist §6, config §7, `CLAUDE.md`.
9. **Stage list** in the development README: B2 verified, owed rows updated. IMNSTR has no state-of-the-build file.
10. **Inbox:** no `lifecycle/learnings/inbox/` yet. The lane's item 7 and this review's lessons are under *Lessons* below, as at 8c B1 and B3.
11. **Verified; already on `main`.**

Also, per plan §7, at the founder's go-ahead ("pull first, then commit, then push"): the one paragraph in root-app's `deploy/README.md`. It went on root-app `main @ 46eeabf`, made in a temporary worktree, because the founder's checkout is on `wp-dashboards` with a locked lane worktree beside it.

During the deploy, the founder asked whether copying the final conf over the live file would destroy certbot's edits. It doesn't: `certonly` leaves the config as it was. That question is now answered in the README.

## Output
- imnstr (now `rishe-eco/i-monster`): `ed83c99` review fixes (was `0c9ddb0`); `10db886` stage record `docs/development/B2.md`, stage list, and the deploy README for a sudo user. `main @ 10db886`, pushed.
- root-app: `46eeabf`, the co-tenant paragraph in `deploy/README.md`, pushed to `main`.
- root-sot: `imnstr/open-work.md` 0.5; `lifecycle/status.md` column 8 `3/10`; `STATE.md` block; this log. Commit hash in the `STATE.md` block's commit.
- On the server: `/srv/imnstr` at the `i-monster` clone, compose project `imnstr` healthy on `127.0.0.1:4100`, `/etc/nginx/sites-available/imnstr` (copy) linked from `sites-enabled`, certificate for `imnstr.com` and `www` with the deploy hook, `/etc/cron.d/imnstr-backup` (local only).

## Spec gaps
- **`verify` assumes the stage merges after the record.** A deploy stage can't: the server pulls from the remote, so the fast-forward has to come before the deploy, and the deploy before the record's server checks. The skill needs a deploy-stage order: review → fixes → fast-forward (with the founder) → deploy → record on `main`.
- **`verify` has no step for a reviewer to run what the lane couldn't.** The card's "build the image if Docker answers" fell to the reviewer, and the review's most concrete defect came from running it. Report item 6 should become a checklist the reviewer works through first.
- **The server half is a conversation, and the skill is forked.** `verify` runs with `context: fork`. A deploy verify needs the founder to run commands and paste output across hours, or days here. A forked, `background: false` skill can't wait on that. The deploy part may need to be its own skill (`deploy <stage>`), or verify must end at "ready to deploy" and resume.
- **Commands for the founder must assume a sudo user, one command per line.** The founder pasted every line separately, added `sudo` to each, and rewrote redirects. The skill's reference file should say how to write commands for a human at a server: `sudo` explicit, `| sudo tee` for writes, no chains whose failure is ambiguous, and no Run-button shell tags (they would run on the local machine).
- **The trial's write rules don't cover a second repo.** Plan §7 makes one edit to root-app at this step. The trial README's rule 4 lists only root-sot files; done here at the founder's go-ahead.
- **A history rewrite in mid-session** invalidated hashes the session had pushed. Nothing in the method says to re-fetch before the record. Caught only because a memory note about the rewrite loaded at the session's restart.

## Template sample
The record used B3's headings: **Built** (with *The review changed*), **Decided** (with *Where the plan, card or brief was wrong*), **Owed**, **Flagged for close-out**, **Verification** (*Run at review*, *By reading*, *By hand on this machine*, *On the server*, *The ceiling*), and a last line. Required: Built, Decided, Owed, Verification. A deploy stage also needs a required *On the server* subsection, with each check graded *pasted output* or *founder's report*.

## Missing foundation
- `lifecycle/learnings/inbox/`: still missing; lessons are below.
- No per-project server runbook: the box's facts (sudo user, nginx 1.18, other tenants, no `http2`) live in the card and the README. `config.md` §7 should hold them.
- No state-of-the-build file for IMNSTR (as before).

## Founder Q&A
- *"Hold up on backup remote data for later?"* Yes: `BACKUP_REMOTE` and the ssh key moved to F-7.
- *Fast-forward `main` to `b2-deploy` and push now?* **Yes.**
- *Copy into `sites-available`, or the lane's symlink?* **Copy.**
- *Install the cron line without `BACKUP_REMOTE`?* **Yes.**
- *Founder:* "Is that last `cp` correct? … wasn't it re-written by certbot? wouldn't this destroy that?" *Answer:* `certonly` changes no config. The live file is still the bootstrap until the `cp` replaces it, and the final conf already holds the TLS lines. The README now says so.
- *Founder's notes after the deploy:* every command needed `sudo`; they pasted one at a time; redirects broke under `sudo`. The README is now fixed for a sudo user.
- *The root-app line, on `main`?* **"Pull first, then commit, then push."** Done.
- *F-8, the B2 changes to the plan, checklist, config and `CLAUDE.md`?* **"Accept all of them."** Applied in this session, as at 8c B1 and B3: build plan 0.4, review checklist 0.3, config 0.3, `CLAUDE.md` in the code repo.

## Skill shape
`verify`, Opus high, is right for the review. For a deploy stage, split it:
- `verify B2` (forked) runs to "ready to fast-forward", including building and running the image locally when Docker answers;
- a non-forked `deploy <stage>`, in the main conversation, holds the founder's server parts, writes the server half of the record, and makes the §7 edit.

Injectable at invocation: the diff stat, the report's items 4–6, `docker info`'s server line, `git config user.email` for every repo it will commit to, and `git fetch` plus `git log -1 origin/main` (stale hashes). The reference file should hold:
- the server-command style (above);
- the shared-box rules: zone names, `http2` and other per-socket listen flags, copies not links, `certonly`;
- the image smoke test, as a script: build, run as uid 1000 on a volume, `/healthz`, headers, seed, backup, restore, `E2E_CLOCK` refusal.

## Lessons
- **Rule:** a review of a deploy stage builds and runs the artifact before reading the deploy docs, whenever the machine can. **Event:** B2's lane couldn't start Docker. The reviewer could, and running the image found the backup sidecars in under a minute. Reading had passed them. **Scope:** `verify`, every project with an image. **Destination:** `skills-plan.md` `verify` step 2 and its reference file, through `revise`. **urgent:** no.
- **Rule:** on a shared web server, any listen-level option (`http2`, `proxy_protocol`, `default_server`, `reuseport`) in a guest's conf changes every tenant on that address. Guests use none of them. **Event:** the card itself prescribed `listen 443 ssl http2` for nginx 1.18, which would have switched HTTP/2 on for root-app and four other sites unannounced. **Scope:** IMNSTR, and any future co-tenant on root-app's box. **Destination:** review checklist §6 and the `build-phase` card notes (F-8). **urgent:** no.
- **Rule:** commands written for the founder at a server assume a sudo user: `sudo` on each line, `| sudo tee` for writes, one command per line, and no shell-tagged fences. **Event:** the founder rewrote every command of the first deploy by hand. **Scope:** all projects. **Destination:** `brief-common.md`'s README conventions and `verify`'s reference file. **urgent:** yes, for any card or session that writes server commands (B4a onwards deploy at each verify).
- *Lane's item 7:* "Docker Desktop running on the build machine, so the card's one-off image check could be done." Agreed. `config.md` should say to start Docker Desktop before launching a deploy lane.

## Cost
*From the founder, after the session. The total covers the review, the deploy with the founder, the root-app line, and F-8 (build plan 0.4, checklist 0.3, config 0.3, `CLAUDE.md`).*
- Opus 5.5: 132 in / 30.4k out / 9.5M cache read / 434.9k cache write.
- Cost $5.28; API 8 min; wall 12 min. No subagent.
- **Wall time is the session's, not the deploy's.** The founder ran the server parts between turns, over two calendar days, and that time isn't counted. The session also restarted between 10-11 and 10-14, so these figures may cover only the second half. If so, the review's local Docker work is missing from them.
- Against B1's verify ($5.40) and B3's ($6.52), it is the cheapest of the three, with the least cache read (9.5M against 12.3M and 16.9M). Output was 15× B3's: the record, the log, the rewritten README and the F-8 edits were all written here, not copied.
- **What added calls:**
  - Git Bash rewriting container paths (`MSYS_NO_PATHCONV`);
  - CRLF in root-sot and root-app, which broke two exact-match edits;
  - a heredoc the shell misparsed;
  - re-checking the repo after the history rewrite.

## Next
**8a B4a** (slot A), Opus medium, from build plan 0.4, review checklist 0.3 and config 0.3 (F-8 applied). For its card:
- every card from now on deploys at its verify, so the card should say what the verify will deploy.

The repo is `rishe-eco/i-monster`; the local clone `E:\_root\imnstr` already points there. **8d MS1** (full suites) can run at any point; MS1's acceptance otherwise holds.
