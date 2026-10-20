# Deploying Tracker to the VPS

*How Tracker reaches `https://tracker.m-root.com`. The runbook, with every command, is in the code repo: [`deploy/README.md`](https://github.com/rishe-eco/tracker/blob/main/deploy/README.md) in `rishe-eco/tracker`. This file is the summary, and lists what the founder sets up once.*

**Version 0.2 · Status: as-built (the box) and planned (CI, until its setup is done) · 2026-10-21 · Owner: founder**

**Grading.** The box's layout is **as-built**, from the founder's shell on 2026-10-21 (`git status`, `stat` and `docker ps` in `/opt/stacks/tracker`), the repo's `api/docker-compose.yml` and `api/Dockerfile`, and the live site. CI and the deploy script are **as written** in change CD1 (`rishe-eco/tracker`, branch `cd1-ci-deploy`), and are not live until the founder does *Setup, once* below.

Version 0.1 of this file described a host install (Node 20, `npm run build && npm start` under PM2, `prisma db push`). That isn't what runs now: the box has no Node, and the API runs in Docker.

---

## 1. What runs where

```
browser ──TLS──▶ host Nginx ──┬──▶ /opt/stacks/tracker/current        (static files: a release)
                              └──▶ 127.0.0.1:4000  (container api-api-1) ──▶ api/data/prod.db
```

| | |
|---|---|
| Box | the founder's VPS, shared with root-app (`127.0.0.1:4009`), IMNSTR and others. Ubuntu, Nginx 1.18, Docker. **No Node** |
| Checkout | `/opt/stacks/tracker`, a clone of `main`, owned by root |
| API | `api/docker-compose.yml`, run from `/opt/stacks/tracker/api`: container `api-api-1`, `127.0.0.1:4000`, image `node:24-alpine`. It runs `prisma migrate deploy` at every start, then `node dist/index.js` |
| Database | SQLite, `/opt/stacks/tracker/api/data/prod.db` (the container's `/app/data`). `DATABASE_URL` is set by the compose file, not `.env` |
| Secrets | `/opt/stacks/tracker/api/.env` on the box only: `JWT_SECRET`, `CORS_ORIGINS`, the Anthropic key |
| Web | built off the box; `client/.env.production` sets `VITE_API_URL="/graphql"`, the same origin. After setup, Nginx serves `/opt/stacks/tracker/current`, a link to `releases/<stamp>-<sha>/` |

## 2. How a deploy happens

**After setup, a push to `main` deploys** (`.github/workflows/deploy.yml`), in root-app's style:

1. `check`: the same jobs as every pull request (`.github/workflows/ci.yml`). API: `npm ci`, `prisma generate`, a check that the migrations build `schema.prisma`, `tsc`, and vitest. Client: `npm ci --legacy-peer-deps`, `npx tsc --noEmit`, both `i18n:check-*` scripts, vitest and the build. Deploy script: shellcheck and its harness. No e2e.
2. `deploy` runs only on `main`, and only while the repository variable `DEPLOY_ENABLED` is `true`. The runner builds the client and sends it, with the commit's id, over one SSH connection as `tracker-deploy`. That key runs only `/usr/local/sbin/tracker-deploy`.
3. The script on the box deploys exactly that commit:
   - It fast-forwards the checkout.
   - If the commit adds a migration, it backs up the database (`VACUUM INTO`, run inside the container) into `api/data/backups/`.
   - It runs `docker compose build api` and `up -d`, and waits for `{ __typename }` on `127.0.0.1:4000`. The container applies migrations as it starts.
   - It runs `nginx -t`, swaps `current` to the new web release, and runs `deploy/checks.sh` as `nobody`.
   - It ends `DEPLOYED <sha>`.

   It stops with exit 2, changing nothing, if `api/docker-compose.yml` or `api/.env.example` changed, or if the installed script differs from the commit's. Those steps stay by hand.

By hand (CI off or red, or after an exit 2): the API is `sudo git pull --ff-only` in the checkout and `sudo docker compose up -d --build` in `api/`. The web is built on your machine and placed as a release. Both are in the runbook's *Deploying by hand*.

## 3. Setup, once

All of it is in the runbook, *Server setup for CI*, step by step. In short:

**On the box** (as the sudo user `deploy`):
1. `sudo git -C /opt/stacks/tracker fetch origin main`. **Don't pull.** Leaving the checkout at `003db5a` makes the first CI run back up the database before it applies `add_focus_periods`.
2. Copy the web root Nginx serves today into `releases/20261021000000-003db5a`, link `current` to it, and point the Tracker site's `root` at `/opt/stacks/tracker/current`. Then `nginx -t`, reload, and run `deploy/checks.sh` once.
3. Create the user `tracker-deploy` (no password, `/bin/sh`). Give it the key line `restrict,command="sudo -n /usr/local/sbin/tracker-deploy" <public key>` in a root-owned `authorized_keys`.
4. Install the script at `/usr/local/sbin/tracker-deploy` (root, 0755). Add the sudoers line `tracker-deploy ALL=(root) NOPASSWD: /usr/local/sbin/tracker-deploy ""`, checked with `visudo -cf`.

**On GitHub**, in `rishe-eco/tracker`:

| Where | Name | Value |
|---|---|---|
| Settings → Environments → `production` (deployment branches: `main` only) → Environment secrets | `DEPLOY_HOST` | the box's hostname or address |
| same | `DEPLOY_PORT` | the box's SSH port (`22` unless changed) |
| same | `DEPLOY_KEY` | the private half of a new ed25519 key made for CI (`ssh-keygen -t ed25519 -N '' -C tracker-ci -f ./tracker-ci-key`), whole file; delete it locally after pasting |
| same | `DEPLOY_KNOWN_HOSTS` | one line, made on the box: `echo "<host> $(cut -d' ' -f1,2 /etc/ssh/ssh_host_ed25519_key.pub)"` |
| Settings → Secrets and variables → Actions → **Variables** → Repository variables | `DEPLOY_ENABLED` | `true`, **set last**. Not an environment variable: the job's `if` can't see those |

Nothing else goes into GitHub: CI's tests need no `JWT_SECRET` and no Anthropic key.

Then **Run workflow** (Actions → `deploy` → `main`). A green run ends `DEPLOYED <sha>`, and Focus Periods is live.

## 4. Checks after each deploy

`deploy/checks.sh` in the code repo is the one list. It checks that `/` and a deep link serve the release's `index.html`, and that its script, `manifest.webmanifest` and `sw.js` are the release's own. It checks that `/graphql` answers `{ __typename }` through Nginx, and that `http://` redirects to `https://`. The script also checks the API on `127.0.0.1:4000`, with its container running, and `nginx -t`. Signing in on the live site stays a by-hand check.

## 5. Known gaps

- **No off-box backup.** Pre-migration backups stay on the same disk as the database.
- **A by-hand deploy takes no backup**; take one first when the commit adds a migration (runbook, *Backups*).

---

## Changelog

- **0.2 · 2026-10-21** — Rewritten for what actually runs (Docker at `/opt/stacks/tracker`, no Node on the box) and for CD1: a push to `main` deploys once the setup is done. The runbook moved to the code repo's `deploy/README.md`; this file keeps the summary and the secrets.
- **0.1** — Host install with Node 20 and PM2.
