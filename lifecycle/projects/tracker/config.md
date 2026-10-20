# Tracker — project config

*Where things are for Tracker work, how its suites run, and which resources each lane gets. Read by `build-phase` (lane resources, the card's paths), `verify` (suites, stage records, the milestone script, the deploy), `design-review` (the design system) and `close-out` (the canon). The rules a lane follows are in `brief-common.md`; what a review checks is in `review-checklist.md`.*

**Version 0.1 · Status: planned · 2026-10-20 · Owner: founder**

**Grading.** Facts about the code are **as-built**, read from `rishe-eco/tracker` `main` @ `003db5a` on 2026-10-20: both `package.json` files, `api/vitest.config.ts`, `api/src/test/globalSetup.ts`, `client/playwright.config.ts`, `client/e2e/globalSetup.ts`. Conventions and testing are from the canon (`tracker/canon/02-architecture/04-conventions.md` 0.6, `03-engineering/01-testing.md` 0.3). **Planned:** the stage records, the development README and the lane slots, because Tracker has no lane setup yet (§4). No module has run on the lifecycle here; the first planned is a Fix, B-15 (`README.md` §8, stage 2).

---

## 1. Paths

| | |
|---|---|
| Code repo | `rishe-eco/tracker`, **public** (checked 2026-10-20). Two npm projects with no root `package.json`: `api/` and `client/` |
| Checkouts, per machine | Linux: `~/Desktop/Root/tracker`. Windows build machine: not recorded; the founder supplies it |
| Remote | `git@github-markRiceOld:rishe-eco/tracker.git` on the Linux machine (an SSH alias). Check `git config user.email` before the first commit |
| The root-sot checkout lanes read | Linux: `~/Desktop/Root/Root`. `git pull` it before the card is drafted; the card names the commit it was drafted at |
| Where each kind of session writes, and how it commits | lanes: their own worktree and branch, and never push. `verify`: the main checkout, merging the lane's branch into `main`, then pushing with the founder's yes |
| Lane worktrees | `<checkout>/.claude/worktrees/<branch>`, made by the Agent tool's worktree isolation |
| Module folder | `root-sot/tracker/modules/NN-slug/` (`README.md` §3). Work from before the method keeps its specs and plans in `tracker/canon/06-specs/` and `tracker/drafts/` |
| Build plan | `07-build-plan.md` in the module folder; a Fix or Change builds from its change note's Stages |
| Phase cards, lane reports | `briefs/<stage>.md`, `briefs/<stage>.report.md` in the module folder |
| Stage records | `docs/development/<stage>.md` in the code repo, **planned**: the first `verify` creates the folder. Builds before the method kept a running log in `notes/` (`notes/noticing-build-log.md`) |
| Development README | `docs/development/README.md` in the code repo, **planned**, created by the first `verify` with the stage list. Until then the root `README.md` holds the commands |
| State of the build | `root-sot/tracker/canon/04-roadmap/00-state-of-the-build.md`, written by `verify` |
| Open-work file | `root-sot/team/open-work.md`, with *From the founder*, *Owed to later stages* and *Past the verification ceiling* tables |
| Design system | `root-sot/tracker/canon/02-architecture/03-frontend.md` (Tailwind and Radix); Root's brand paths are in `skills/design-review/reference.md` |
| Canon kept in sync by `close-out` | `tracker/canon/02-architecture/01-data-model.md`, `02-graphql-api.md`, `03-frontend.md`, `04-conventions.md`; `03-engineering/01-testing.md`; `04-roadmap/01-known-issues-and-debt.md`; `tracker/decisions/decision-log.md`; the code repo's `CLAUDE.md` |

## 2. Environment

- **Machines:** the founder's Linux machine (Node 22, Chrome, no Edge) and the Windows build machine (Edge). **`client/playwright.config.ts` hard-codes `channel: "msedge"`**, so e2e doesn't run on the Linux machine until the channel is read from the environment (§4, owed).
- **Setup per checkout:** `cd api && npm install && npx prisma generate`, then `cd ../client && npm install`. `api/.env` isn't in git: `DATABASE_URL="file:./dev.db"`, `JWT_SECRET`, `CORS_ORIGINS`, and an Anthropic key for the features that call it.
- **Database:** SQLite files, no Docker. Dev: `api/prisma/dev.db`. Tests: `api/prisma/test.db`, pushed fresh by Vitest's global setup.
- **Founder's devices and accounts:** not recorded yet; the open-work file's *From the founder* table holds them when a check needs them.
- **Heavy-runner lock:** none; one heavy suite at a time, by agreement.
- **CI:** none.

## 3. Suites

| Command | Runs | Who runs it |
|---|---|---|
| `cd client && npm run typecheck` | route types and `tsc` | lanes before their last commit; reviews |
| `cd api && npx vitest run <files>` | unit and integration files, one at a time (`fileParallelism: false`) | lanes and reviews, targeted |
| `cd client && npx vitest run <files>` | component tests, with `useApi` mocked | lanes and reviews, targeted |
| `cd client && npm run i18n:check-missing && npm run i18n:check-hardcoded` | a key missing in `en` or `fa`; literal strings in components | lanes and reviews |
| `cd client && npx playwright test <spec> -g <name>` | one e2e test (one worker is the config's default) | lanes and reviews, targeted; one at a time per machine (§4) |
| `cd api && npm test`; `cd client && npm test`; `cd client && npm run test:e2e` | the full suites: 62 files and 1,079 tests on the API, 23 and 223 on the client (2026-09-21) | the orchestrator, at milestones only |

**Heavy runners:** the API's full run (integration tests take 5–10 s each on SQLite) and the e2e suite. Never two at once on one machine.

## 4. Lane resources

At most two lanes at once, and never two that change `schema.prisma`.

| Slot | Branch | Test database | Ports | Variables |
|---|---|---|---|---|
| A | from the stage | `<worktree>/api/prisma/test.db` | e2e: API `4000`, web `5173` | none yet |
| B | from the stage | `<worktree>/api/prisma/test.db` | **no e2e** until the ports are movable | none yet |
| main checkout (milestones, review) | — | `api/prisma/test.db` | API `4000`, web `5173` | — |

- **API tests** are safe in two worktrees at once: the test database is a file inside each worktree.
- **e2e is not lane-safe yet** (as-built): the API URL is fixed at `localhost:4000` in `client/e2e/globalSetup.ts` (and is `useApi.ts`'s default), the web port at `5173` with `reuseExistingServer: true`, and the e2e signs up its users through **whatever API is running, against its dev database**. Until a prep stage makes the ports, the API URL, the browser channel and the e2e database movable (as root-app's P0 test-lanes prep did), only one lane per machine runs e2e, and it starts its own API on a copy of the dev database. The first module's plan schedules that prep, or the founder waives it.
- **Branches:** before the method, a feature branch per build (`impact-noticing`) and `fix/<slug>` for fixes. **Change and Fix stages:** `<two letters><n>-<slug>`, taking the free slot.
- **Review port and seed route:** `npm run dev` in `api/` and `client/` (`run-dev.sh`), or the `api` and `client` entries in `.claude/launch.json`. No seed route.

## 5. Stages

None planned on the lifecycle yet; the first module's plan or change note fills this table.

| Stage | Size | Depends on | May run beside | Milestone |
|---|---|---|---|---|
| — | | | | |

## 6. Milestones

**Milestone script** (run by `verify --milestone`, in the main checkout, after the milestone's last stage is on `main`). **Planned**; it hasn't run as a script.

```bash
cd ~/Desktop/Root/tracker && git fetch && git status -sb
out=.tmp/milestone-$(date +%Y%m%d-%H%M).log; mkdir -p .tmp
{ (cd api && npm test) && (cd client && npm run typecheck && npm test && npm run test:e2e); echo "EXIT $?"; } >"$out" 2>&1
grep -E 'Test Files|Tests +[0-9]|passed|failed|EXIT' "$out" | tail -n 20
```

One after another, never in parallel; `.tmp/` is git-ignored, from the commit that added the repo's `CLAUDE.md`. Record the counts in the development README under the milestone, and in the state of the build, with the date and `main @ <hash>`.

| Milestone | Stages | By hand |
|---|---|---|
| — | set by the first module's plan | open-work rows whose *needed by* names the milestone |

## 7. Deploy

| | |
|---|---|
| Host | the founder's VPS; host Nginx serves `client/dist` and proxies `/graphql` to the API on `127.0.0.1:4000` |
| How | API: `npm ci`, `npx prisma generate`, `npx prisma db push`, `npm run build && npm start` under PM2 (`tracker-api`). Client: `npm ci && npm run build`, with `VITE_API_URL` set **before** the build |
| Who deploys | the founder, by hand. `verify` asks before any push |
| Checks after each deploy | `pm2 status`; `curl http://127.0.0.1:4000/graphql` on the box; sign in on the live site |
| Runbook | `root-sot/tracker/DEPLOY-VPS.md`, summarised in `tracker/canon/03-engineering/00-setup-run-deploy.md` |

## 8. Review and check scripts

Not built yet. The first stage that needs one adds it under `client/tests/review/`, and this table names it.

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

- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the code repo, the conventions 0.6, testing 0.3 and setup 0.1. Not written by `project-config`, which doesn't exist yet; its first run on a Tracker module reviews this file.
