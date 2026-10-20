# Tracker — project config

*Where things are for Tracker work, how its suites run, and which resources each lane gets. Read by `build-phase` (lane resources, the card's paths), `verify` (suites, stage records, the milestone script, the deploy), `design-review` (the design system) and `close-out` (the canon). The rules a lane follows are in `brief-common.md`; what a review checks is in `review-checklist.md`.*

**Version 0.3 · Status: planned; CI and CD written (CD1), live once the founder's setup is done · 2026-10-21 · Owner: founder**

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

- **Machines:** the founder's Linux machine (Node 22, Chrome, no Edge) and the Windows build machine (Edge). **`client/playwright.config.ts` hard-codes `channel: "msedge"`**, so the suite doesn't run on the Linux machine until the channel is read from the environment (§4, owed). **One spec can:** put a config in the git-ignored `client/.tmp/` that spreads `playwright.config.ts` and sets only `use.channel: "chrome"`, and give the API a fresh SQLite file (`DATABASE_URL=file:<scratch>/x.db npx prisma db push --skip-generate`), so nothing writes to `dev.db`. `goals.spec.ts` passed 4/4 this way at `verify --fix B-15`.
- **Setup per checkout:** `cd api && npm install && npx prisma generate`, then `cd ../client && npm install`. `api/.env` isn't in git: `DATABASE_URL="file:./dev.db"`, `JWT_SECRET`, `CORS_ORIGINS`, and an Anthropic key for the features that call it.
- **Database:** SQLite files, no Docker. Dev: `api/prisma/dev.db`. Tests: `api/prisma/test.db`, pushed fresh by Vitest's global setup.
- **Founder's devices and accounts:** not recorded yet; the open-work file's *From the founder* table holds them when a check needs them.
- **Heavy-runner lock:** none; one heavy suite at a time, by agreement.
- **CI:** `.github/workflows/ci.yml` on every pull request, and called by `deploy.yml` on every push to `main` (CD1). Jobs: `api` (`npm ci`, `prisma generate`, the migrations-build-the-schema check, `tsc`, `npm test`), `client` (`npm ci --legacy-peer-deps`, `npx tsc --noEmit`, both i18n checks, `npm test`, `npm run build`), `deploy-script` (shellcheck and `deploy/test/tracker-deploy.test.sh`). Node 24, as the API image. No e2e (the msedge channel). A pull request's checks must be green before `verify` merges it.

## 3. Suites

| Command | Runs | Who runs it |
|---|---|---|
| `cd client && npx tsc --noEmit` | `tsc` (`npm run typecheck`'s `react-router typegen` step fails on this app; CI runs `tsc` alone) | lanes before their last commit; reviews; CI |
| `cd api && npx vitest run <files>` | unit and integration files, one at a time (`fileParallelism: false`) | lanes and reviews, targeted |
| `cd client && npx vitest run <files>` | component tests, with `useApi` mocked | lanes and reviews, targeted |
| `cd client && npm run i18n:check-missing && npm run i18n:check-hardcoded` | a key missing in `en` or `fa`; literal strings in components | lanes and reviews |
| `cd client && npx playwright test <spec> -g <name>` | one e2e test (one worker is the config's default); on the Linux machine add `--config .tmp/<scratch>.config.ts` (§2) | lanes and reviews, targeted; one at a time per machine (§4) |
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
| Host | the founder's VPS, shared with root-app and IMNSTR; `https://tracker.m-root.com`. No Node on the box |
| App root | `/opt/stacks/tracker`, a root-owned clone of `main`. The API is `api/docker-compose.yml` (container `api-api-1`, `127.0.0.1:4000`, `node:24-alpine`), which runs `prisma migrate deploy` at boot; the database is `api/data/prod.db`. The web is `releases/<stamp>-<sha>/`, live through the `current` link |
| How | **A push to `main` deploys** (`.github/workflows/deploy.yml`, CD1), once the founder's one-time setup is done: `check` (ci.yml), then, while the repository variable `DEPLOY_ENABLED` is `true`, `deploy` builds the client on the runner and sends it over one locked SSH key (`tracker-deploy`) to `/usr/local/sbin/tracker-deploy`. The script fast-forwards to exactly that commit, backs up the database before a migration, builds and ups the container, waits for the API, runs `nginx -t`, swaps `current` and runs `deploy/checks.sh`. It exits 2, changing nothing, when `api/docker-compose.yml` or `api/.env.example` changed or the installed script differs. `workflow_dispatch` re-runs it after a manual step |
| Secrets | GitHub environment `production`: `DEPLOY_HOST`, `DEPLOY_PORT`, `DEPLOY_KEY`, `DEPLOY_KNOWN_HOSTS`; repository variable `DEPLOY_ENABLED`. The app's own secrets stay in `api/.env` on the box |
| Who deploys | whoever pushes `main`. `verify` asks the founder before any push, and says that the push deploys; a new `api/.env` line goes onto the box by hand **before** that push |
| Checks after each deploy | the run ends `DEPLOYED <sha>` equal to the pushed commit, and `deploy/checks.sh` ran on the box; then sign in on the live site |
| Runbook | `deploy/README.md` in the code repo, summarised in `root-sot/tracker/DEPLOY-VPS.md` and `tracker/canon/03-engineering/00-setup-run-deploy.md` |

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

- **0.3 · 2026-10-21** — §2 and §3: one e2e spec runs on the Linux machine from a scratch Chrome config and a scratch database. From `learned --consolidate`, the first (L-44).
- **0.2 · 2026-10-21** — §2 CI and §7 Deploy, for CD1: CI on pull requests, a push to `main` deploys, the box's real layout (Docker at `/opt/stacks/tracker`, no Node), the secrets. §3: `npx tsc --noEmit` is the type check.
- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the code repo, the conventions 0.6, testing 0.3 and setup 0.1. Not written by `project-config`, which doesn't exist yet; its first run on a Tracker module reviews this file.
