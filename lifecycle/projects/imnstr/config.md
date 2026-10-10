# IMNSTR — project config

*Where things are for the IMNSTR build, how its suites run, and which resources each lane gets. Read by `build-phase` (lane resources, the card's paths) and `verify` (suites, stage records, the milestone script, the deploy checks). The rules a lane follows are in `brief-common.md`; what a review checks is in `review-checklist.md`.*

**Version 0.1 · Status: proposal; the code repo doesn't exist yet (P0-1) · 2026-10-10 · Owner: founder**

**Grading.** Founder decisions are marked **[F]**. Everything about the code repo is **planned**: B1 creates the scripts and names, so where B1's stage record differs, it wins and this file is updated. Machine facts are **as-built** from the build machine's notes (`root-app-dev-machine`, `imnstr-build`), 2026-10-10.

---

## 1. Paths

| | |
|---|---|
| Code repo | `rishe-eco/imnstr`, **public [F]** (org spelling confirmed at step 7b) |
| Remote (this machine) | `git@github-TheMonster1995:rishe-eco/imnstr.git` (SSH alias; `gh` isn't installed) |
| Main checkout | `E:\_root\imnstr` |
| Lane worktrees | `E:\_root\imnstr\.claude\worktrees\<branch>` (made by the Agent tool's worktree isolation). **B1 adds `.claude/worktrees/` to `.gitignore`.** |
| Module folder | `root-sot/imnstr/modules/01-website/` |
| Build plan | `07-build-plan.md` in the module folder (§5 per stage) |
| Phase cards, lane reports | `briefs/<stage>.md`, `briefs/<stage>.report.md` in the module folder |
| Stage records | `docs/development/<stage>.md` in the code repo (shape: built · decided · owed · verification) |
| Development README | `docs/development/README.md` in the code repo: the stage list (B1–B9) and the milestone counts |
| State of the build | **none separate.** The development README's stage list is it. |
| Owed items (open work) | `root-sot/imnstr/open-work.md`, created by the first `verify` that owes something. *Not* `team/open-work.md`, which is Root's queue; IMNSTR is outside Root. |
| Design system | `root-sot/imnstr/modules/01-website/04b-design/README.md` 0.2 |
| Pointer from the code repo | `README.md` names the module folder (B1). |

## 2. Environment

- **Machine:** Windows 10, Git Bash through the Bash tool, npm scripts through cmd.exe, so no `VAR=value` prefixes in `package.json` scripts. **Node 24.**
- **Browser:** Edge only. Playwright uses `channel: 'msedge'`.
- **Database:** SQLite through better-sqlite3. No Docker or Postgres in development. Docker exists on the machine (29) but isn't needed until the server.
- **Founder pushes from another machine** (account markRice): `git fetch` before reading or branching.

## 3. Suites *(planned in B1)*

| Command | Runs | Who runs it |
|---|---|---|
| `npm run check` | `tsc --noEmit` and lint | lanes, before their last commit; reviews |
| `npm test -- <files>` | Vitest unit and integration, a temporary SQLite file per test file | lanes and reviews, **targeted** |
| `npm test` | all of Vitest | the orchestrator, at milestones only |
| `npx playwright test <spec> -g <name> --workers=1` | one e2e test | lanes and reviews, targeted |
| `npm run e2e` | all of Playwright, both languages and both colour schemes | the orchestrator, at milestones only |

**Heavy runners:** `npm test` and `npm run e2e`. Never two at once on this machine, across all checkouts.

## 4. Lane resources

At most **two lanes at once**, and never two that change the schema (PD-5 puts it all in B1). Each lane gets a slot:

| Slot | e2e server port | e2e database file | Variables to export in every suite command |
|---|---|---|---|
| A | `4110` | `<worktree>/.tmp/e2e.db` | `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1` |
| B | `4120` | `<worktree>/.tmp/e2e.db` | `PORT=4120 DB_PATH=.tmp/e2e.db E2E_CLOCK=1` |
| main checkout (dev, milestones) | `4100` | `E:\_root\imnstr\.tmp\dev.db` | `PORT=4100 DB_PATH=.tmp/dev.db` |

- Ports `4110` and `4120` are the plan's **[F]**. The variable names `PORT` and `DB_PATH` are **planned**; B1 fixes them, and its card says to read them from the environment with these names.
- `.tmp/` is gitignored (B1). The database file is per worktree, so slots never share one.
- **Branches:** `b1-foundation`, `b2-deploy`, `b3-public-log`, `b4a-auth-server`, `b4b-auth-screens`, `b5-entries-admin`, `b6-editor`, `b7-podcast`, `b8-reader-record`, `b9-motion-access`. A continuation lane after a stop keeps the branch.
- **Lane model:** Sonnet 5.5. Co-author line `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>`.

## 5. Stages *(plan §3)*

| Stage | Size | Depends on | May run beside | Milestone |
|---|---|---|---|---|
| B1 Foundation | L | P0-1 | none | MS1 |
| B2 Deploy | S | B1, P0-2, P0-3 | B3 | MS1 |
| B3 Public log and feed | L | B1 | B2, then B4a | MS2 |
| B4a Passkeys and sessions (server) | L | B1 | B3 | MS2 |
| B4b Auth screens | M | B4a | B3 | MS2 |
| B5 Entries API, admin shell, list | M | B3, B4b | B8 | MS3 |
| B6 The editor | L | B5 | B8 | MS3 (E1 at its verify) |
| B7 Podcast | L | B6 | none | MS3 |
| B8 Reader record | M | B3, B4a | B5 or B6 | MS3 |
| B9 Motion, wordmark, access sweep | M | B7 | none | MS4 |

**Sizes:** S about 1–2 h and under ~600 changed lines; M 2–4 h and ~1,500; L 4–6 h and ~3,000 (plan §3, estimate). The lane budget is twice the size.

## 6. Milestones

**Milestone script** (run by `verify --milestone`, in the main checkout, after the milestone's last stage is on `main`):

```bash
cd /e/_root/imnstr && git fetch && git status -sb
npm ci
npm run check
npm test
PORT=4100 DB_PATH=.tmp/milestone.db E2E_CLOCK=1 npm run e2e
```

One after another, never in parallel. Record the counts in `docs/development/README.md` under the milestone, with the date and `main @ <hash>`. Then the milestone's checks outside the suites:

| Milestone | Stages | Also, by hand |
|---|---|---|
| **MS1** | B1, B2 | The shell live at `https://imnstr.com` with noindex; `curl -I` headers; `certbot renew --dry-run`; one backup restored |
| **MS2** | B3, B4a, B4b | Entries seeded by the CLI; the founder signs in on the real phone and laptop; AC-24 by hand (review checklist §8) |
| **MS3** | B5–B8 | Every feature present; E1 passed at B6 |
| **MS4** | B9 | The access sweep passes; the step-9 live review can start |

## 7. Deploy *(from B2; plan B2 and §7)*

| | |
|---|---|
| Host | root-app's VPS, as a co-tenant **[F]** |
| App | compose project `imnstr`, `127.0.0.1:4100`, `/srv/imnstr/` (data in `/srv/imnstr/data`, backups in `/srv/imnstr/backups`) |
| Nginx | `/etc/nginx/sites-available/imnstr`, linked from `sites-enabled`; zone `imnstr_auth`; the repo copy is `deploy/nginx/imnstr.conf` |
| Routine deploy | on the server: `cd /srv/imnstr && git pull && docker compose -f docker-compose.prod.yml build && docker compose -f docker-compose.prod.yml up -d` |
| Who deploys | the orchestrator with the founder, at each stage's verify from B2 on. Lanes have no server access. |
| Checks after each deploy | `nginx -t` (before any reload); `curl -I` on `/`, `/fa/` and a 404; root-app's own URL answering. Into the stage record. |
| Open | the VPS facts (P0-3), the backup target (P0-4), DNS (P0-2) |

## 8. Models

| Work | Model · effort |
|---|---|
| Phase cards and landing (`build-phase`) | Opus · medium |
| Lanes | Sonnet 5.5 |
| Stage reviews and milestones (`verify`) | Opus · high, in a fresh session per review |

---

## Changelog

- **0.1 · 2026-10-10** — First version, at trial step 7b, from build plan 0.1 (§3, §4, B1, B2, §7, §8) and the build machine's notes. The org is `rishe-eco`, confirmed by the founder.
