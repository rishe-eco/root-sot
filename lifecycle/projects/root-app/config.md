# root-app — project config

*Where things are for root-app work, how its suites run, and which resources each lane gets. Read by `build-phase` (lane resources, the card's paths), `verify` (suites, stage records, the milestone script, the deploy), `design-review` (the design system) and `close-out` (the canon). The rules a lane follows are in `brief-common.md`; what a review checks is in `review-checklist.md`.*

**Version 0.4 · Status: planned · 2026-10-20 · Owner: founder**

**Grading.** Facts about the code are **as-built**, read from `rishe-eco/root-app` on 2026-10-20: `docs/development/README.md` on `wp-dashboards` @ `873c70b`, and `deploy/README.md` and `.github/workflows/deploy.yml` on `main` @ `66c5698`. Facts about the Windows build machine are **as recovered**: the journeys brief (`templates/brief-common.example.md`) and the retrospective's finding 6. The build machine's memory files are not on this machine and weren't read again. **Planned:** the lane slots in §4 and the milestone script in §6, which the first stage's `verify` confirms or corrects. No module has run on the lifecycle here yet: the first is the journeys build's owed items, on the Change track (`README.md` §8, stage 2).

---

## 1. Paths

| | |
|---|---|
| Code repo | `rishe-eco/root-app`, **public** (checked 2026-10-20) |
| Checkouts, per machine | build machine (Windows 10): `E:\_root\root-app`. Founder's Linux machine: `~/Desktop/Root/root-app` |
| Remote | `git@github-markRiceOld:rishe-eco/root-app.git` on the Linux machine (an SSH alias). Check `git config user.email` before the first commit |
| Branches | `main` is the base branch. Since 2026-10-20 it holds the whole journeys build: `wp-dashboards` (`c6b2fc4`), `journeys-build` (`2c5b1c6`) and the CI deploy (`5bb1160`) are merged into it; `main` @ `66c5698`. A lane branches from `main` |
| The root-sot checkout lanes read | build machine: `E:\_root\root-sot`. Linux: `~/Desktop/Root/Root`. `git pull` it before the card is drafted; the card names the commit it was drafted at |
| Where each kind of session writes, and how it commits | lanes: their own worktree and branch, and never push. `verify`: the main checkout, merging the lane's branch into the base branch. **A push to `main` deploys** (§7), so the push is the founder's yes to a deploy |
| Lane worktrees | `<checkout>/.claude/worktrees/<branch>`, made by `build-phase` with `git worktree add` (L-33). **Never `git add -A` in the main checkout:** the worktrees would be committed as embedded repos |
| Module folder | `root-sot/ecosystem/modules/NN-slug/` (`README.md` §3). Modules from before the method keep their files in `ecosystem/working/` (`status.md`) |
| Build plan | `07-build-plan.md` in the module folder; a Change builds from its change note's Stages |
| Phase cards, lane reports | `briefs/<stage>.md`, `briefs/<stage>.report.md` in the module folder |
| Stage records | `docs/development/<stage>.md` in the code repo (built · decided · owed · flagged for close-out · verification) |
| Development README | `docs/development/README.md` in the code repo: the sequence, the house rules, the working agreement and the files table |
| State of the build | none separate. The development README's sequence is it |
| Open-work file | `root-sot/team/open-work.md`, with *From the founder*, *Owed to later stages* and *Past the verification ceiling* tables. The working list toward prototype v1 is `ecosystem/working/root-studio-v1-readiness.md` §3 |
| Design system | `apps/web/src/styles/tokens.css` and `kit.css`, from the design handoff; Root's brand paths are in `skills/design-review/reference.md` |
| Canon kept in sync by `close-out` | the module's spec and plan; `docs/development/README.md`; `deploy/README.md`; the code repo's `CLAUDE.md` |

## 2. Environment

- **Build machine:** Windows 10, Git Bash through the Bash tool; npm runs scripts through **cmd.exe**, so no `VAR=value` prefixes inside `package.json` scripts.
- **Browser:** on the build machine, Edge, not Chrome: export `E2E_BROWSER_CHANNEL=msedge`. On the Linux machine, Chrome is installed and is Playwright's default channel, so leave the variable unset. Playwright's browser download is geo-blocked; nothing needs downloading.
- **Setup per worktree:** `npm install`, then `npx prisma generate --schema apps/api/prisma/schema.prisma` after **every** install. If `npm install` strips `"dev": true` from `fsevents` in `package-lock.json`, revert it: `git checkout package-lock.json`.
- **Postgres:** on the build machine, Postgres 16 runs in Docker at `localhost:5432` (`root`/`root`), shared by every checkout. **Start Docker Desktop before a lane launches,** and never stop the container. On the Linux machine there is no Docker: a native Postgres 14 serves the same address, and its `root` role can create databases (granted 2026-10-20). `psql` by hand needs `PGPASSWORD=root`, or it waits for a password. Nothing in root-app needs 15 or later. Either way, never `prisma migrate reset` or `migrate dev` against any database but your own test database. Check free disk before an image build.
- **Background Bash ignores a leading `cd`:** wrap as `bash -c 'cd <worktree> && …'`.
- **Founder's devices and accounts:** the commit identity is the founder's (`markRice`); the founder pushes from more than one machine, so `git fetch` before reading or branching. Phones and test accounts for live checks: not recorded yet; the open-work file's *From the founder* table holds them when a check needs them.
- **Heavy-runner lock:** none yet; one heavy suite at a time, by agreement, because the shared Postgres starves otherwise.
- **CI:** `.github/workflows/deploy.yml`, on every push to `main`: `typecheck`, `npm test`, `npm run test:integration` and the build, then the deploy (§7). It doesn't run e2e, so e2e still runs only on a machine.

## 3. Suites

| Command | Runs | Who runs it |
|---|---|---|
| `npm run typecheck` | both workspaces | lanes before their last commit; reviews |
| `npm test --workspace=apps/api -- <files>` and `--workspace=apps/web -- <files>` | unit, pure functions, no database | lanes and reviews, targeted |
| `npm run test:integration -- <files>` | resolvers against the lane's own `*_test` database, created and migrated if missing (`apps/api/prisma/test-db.ts`) | lanes and reviews, targeted |
| `npm run e2e -- -- <spec> -g <name> --workers=1` | one e2e test, against the built app. **Two `--`:** with one, npm reads `-g` as "global" and drops `--workers=1` | lanes and reviews, targeted |
| `npm test`, `npm run test:integration`, `npm run e2e` | the full suites (≈8 min for integration) | the orchestrator, at milestones and before a deploy |

**Before any e2e run, check the slot's ports are free** (`ss -ltnp | grep -E ':<api>|:<web>'`). A preview server left behind by an interrupted run is reused, and the run then tests an old build.

**Heavy runners:** `npm run test:integration` and `npm run e2e`. Never two at once on one machine, across all checkouts. The integration runner refuses any `DATABASE_URL` that doesn't name a `*_test` database: it truncates every table.

## 4. Lane resources

At most two lanes at once, and never two that change `schema.prisma`.

| Slot | Branch | Test database | Ports | Variables |
|---|---|---|---|---|
| A | from the stage | `root_wt_a_test` | API `4201`, web `4273` | `ROOT_TEST_DB=root_wt_a_test E2E_API_PORT=4201 E2E_WEB_PORT=4273 E2E_BROWSER_CHANNEL=msedge` |
| B | from the stage | `root_wt_b_test` | API `4211`, web `4283` | `ROOT_TEST_DB=root_wt_b_test E2E_API_PORT=4211 E2E_WEB_PORT=4283 E2E_BROWSER_CHANNEL=msedge` |
| main checkout (milestones, review) | — | `root_website_test` | the defaults | `E2E_BROWSER_CHANNEL=msedge` |

- The variable names are as-built (P0's test-lanes prep); the slot values are **planned**. On the Linux machine, drop `E2E_BROWSER_CHANNEL=msedge` (§2). The journeys build gave each lane its own (`root_wt_p07_test` 4201/4273, `root_wt_dr_test` 5231/5235). Export them in **every** Bash command that runs a suite: shell state doesn't persist.
- **Branches:** the plan's own stages are `stage-<id>-<slug>` (development README). **Change stages:** `<two letters><n>-<slug>`, taking the free slot.
- **Review port and seed route:** the slot's ports; `npm run dev` and `npm run dev:api` in the main checkout for a browser walk. A seed route for a review is not built.

## 5. Stages

None planned on the lifecycle yet. The journeys build's stages and sizes are in `ecosystem/working/root-studio-journeys-build-plan.md` §3; the first module's plan or change note fills this table.

| Stage | Size | Depends on | May run beside | Milestone |
|---|---|---|---|---|
| — | | | | |

## 6. Milestones

**Milestone script** (run by `verify --milestone`, in the main checkout, after the milestone's last stage is merged). **Planned**, from the working agreement; it hasn't run as a script.

```bash
cd /e/_root/root-app && git fetch && git status -sb
out=.tmp/milestone-$(date +%Y%m%d-%H%M).log; mkdir -p .tmp
{ npm run typecheck && npm test && npm run test:integration && E2E_BROWSER_CHANNEL=msedge npm run e2e; echo "EXIT $?"; } >"$out" 2>&1
grep -E 'Tests? +[0-9]+|passed|failed|EXIT' "$out" | tail -n 20
```

One after another, never in parallel; `.tmp/` is git-ignored, from the commit that added the repo's `CLAUDE.md`. Record the counts in `docs/development/README.md`'s sequence under the milestone, with the date and the base branch `@ <hash>` (the journeys build's M1–M4 lines are the shape).

| Milestone | Stages | By hand |
|---|---|---|
| — | set by the first module's plan | open-work rows whose *needed by* names the milestone |

## 7. Deploy

| | |
|---|---|
| Host | the founder's VPS, `/srv/root/`; co-tenant with IMNSTR (`/srv/imnstr`, `127.0.0.1:4100`) and others |
| How | **A push to `main` deploys** (`.github/workflows/deploy.yml`): the `check` job, then, while the repository variable `DEPLOY_ENABLED` is `true`, the `deploy` job runs `deploy/root-deploy.sh` on the box through one locked SSH key, for exactly the pushed commit. `workflow_dispatch` reruns it after a manual step. By hand, `./deploy/release-web.sh` is the fallback (`deploy/README.md`) |
| App root | `/opt/stacks/root` on the box (`ROOT=` in `deploy/root-deploy.sh`); the API listens on `4009`. Migrations apply on start; a failed one stops the container from booting |
| Nginx | `deploy/nginx/root.conf` and `security-headers.conf`, copied by hand; `sudo nginx -t` before a reload |
| Who deploys | whoever pushes `main`. `verify` asks the founder before any push, and says that the push deploys |
| Checks after each deploy | the run ends `DEPLOYED <sha>`, and `deploy/checks.sh` runs on the box after it; then `curl -I` for the CSP and `frame-src` (plan §8). Whether the journeys build has reached production isn't recorded here: read the last run of the `deploy` workflow |
| Runbook | `deploy/README.md` in the code repo |

## 8. Review and check scripts

Not built yet. The first stage that needs one adds it under `tests/review/`, and this table names it.

| Script | Does |
|---|---|
| — | capture every state at 360 and 1100 px, at 180 px, in both colour schemes and with forced colours |

## 9. Models

| Work | Model · effort |
|---|---|
| Phase cards and landing (`build-phase`) | Opus · medium |
| Lanes | Sonnet 5.5 |
| Stage reviews and milestones (`verify`) | Opus · high, forked |

## Changelog

- **0.4 · 2026-10-20** — At the founder's word, from `verify TK1`: §3 a single e2e test takes two `--`, and the slot's ports are checked free before any e2e run; §2 `psql` on the Linux machine needs `PGPASSWORD=root`.
- **0.3 · 2026-10-20** — At the founder's word, before session D's first card: §1 Branches (everything is merged into `main` @ `66c5698`) and Lane worktrees (`git worktree add`, L-33); §2 the Linux machine's browser is Chrome, and CI exists; §4 the Linux lanes drop `msedge`; §7 a push to `main` deploys.
- **0.2 · 2026-10-20** — §2: the Linux machine runs root-app's tests on a native Postgres 14, without Docker.
- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the development README, the deploy runbook, the journeys plan §0.2–§0.3 and §8, the recovered brief and the retrospective. Not written by `project-config`, which doesn't exist yet; its first run on a root-app module reviews this file.
