# Tracker — Setup, Run & Deploy

*Source of truth. How to get it running — locally and on a VPS. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built · 2026-10-21 · Owner: _root**

---

## 1. Prerequisites

- **Node.js** (v20 LTS recommended) + npm.
- SQLite needs nothing (the DB is a file). PostgreSQL is optional — swap the `datasource` block in `schema.prisma` and set `DATABASE_URL`.

## 2. Local development

### Backend (`api/`)

```bash
cd api
npm install
# .env:
#   DATABASE_URL="file:./dev.db"
#   PORT=4000
#   JWT_SECRET=dev-secret        # defaults to "dev-secret" if omitted
npx prisma generate
npx prisma migrate dev
npm run dev                       # nodemon src/index.ts → http://localhost:4000/graphql
```

Scripts: `dev` (nodemon), `build` (`tsc`), `start` (`node dist/index.js`), `test` / `test:watch` (Vitest).

**After a schema change:** `npx prisma generate && npx prisma migrate dev --name describe_change`, then update `02-architecture/01-data-model.md` and note the migration in the decision log (convention #11).

### Frontend (`client/`)

```bash
cd client
npm install
# VITE_API_URL points at the API's /graphql (dev default assumes localhost:4000)
npm run dev                       # Vite dev server
```

Scripts: `dev`, `build` (`vite build`), `preview`, `typecheck` (`react-router typegen && tsc`), `test` / `test:watch` (Vitest), `test:e2e` / `:ui` / `:headed` (Playwright).

### Repo-root convenience
`run-dev.cmd` / `run-dev.sh` at the `tracker` repo root start the dev setup; inspect them for the exact commands on your platform.

## 3. Deployment (Linux VPS)

The runbook is the code repo's `deploy/README.md`; the summary and the one-time setup are in `../../DEPLOY-VPS.md`. In short:

1. **The box** has no Node. The checkout is `/opt/stacks/tracker` (root-owned, on `main`). The API runs in Docker from `api/docker-compose.yml` (container `api-api-1`, `127.0.0.1:4000`), and the container runs `prisma migrate deploy` at every start. The SQLite database is `api/data/prod.db`. Secrets are in `api/.env` on the box only.
2. **The web** is built off the box (`client/.env.production` sets `VITE_API_URL="/graphql"`, same origin). Host Nginx serves `/opt/stacks/tracker/current`, a link to the live release, and proxies `/graphql` to the container.
3. **A push to `main` deploys** once the setup is done. CI (`.github/workflows/ci.yml`) runs on every pull request. `deploy.yml` runs it again on `main`, then sends the runner's client build to the box over one locked SSH key. The box's script backs up the database before a migration, rebuilds the container and swaps the web release.

## 4. Common pitfalls

- **Frontend can't reach the API:** `VITE_API_URL` must be set *before* `npm run build`, and nginx must proxy the same path it names.
- **502 Bad Gateway:** the API container isn't running or is still migrating — `sudo docker compose logs api` in `/opt/stacks/tracker/api`, and `curl -X POST -H 'Content-Type: application/json' --data '{"query":"{ __typename }"}' http://127.0.0.1:4000/graphql` on the box.
- **CORS:** same-domain (nginx proxy) avoids it; cross-domain needs Express CORS config in `api`.

---

## Changelog

- **0.2 · 2026-10-21** — §3 rewritten for what runs (Docker at `/opt/stacks/tracker`, no Node on the box) and for CD1 (CI on pull requests, a push to `main` deploys); the PM2 pitfall replaced.
- **0.1 · 2026-07-22** — Initial. Local commands verified against both `package.json` files; deploy summarized from `DEPLOY-VPS.md` with the stale build/start caveat corrected.
