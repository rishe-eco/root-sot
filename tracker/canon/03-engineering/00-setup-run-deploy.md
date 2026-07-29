# Tracker — Setup, Run & Deploy

*Source of truth. How to get it running — locally and on a VPS. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

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

Full walkthrough: `03-engineering/` inherits the deploy runbook (also kept at `../../DEPLOY-VPS.md`). Summary:

1. **VPS:** Node 20; optionally nginx + certbot.
2. **Backend:** `npm ci`; `.env` with `DATABASE_URL="file:./prisma/dev.db"`, `PORT=4000`, and a **strong random `JWT_SECRET` (≥32 chars)**; `npx prisma generate`; `npx prisma db push`; build and run (`npm run build && npm start` — the `build`/`start` scripts now exist).
3. **Frontend:** set `VITE_API_URL` (e.g. `https://yourdomain.com/graphql`) **before** building — Vite bakes it in; `npm ci && npm run build` → static files in `dist/`.
4. **Nginx:** serve `client/dist` and reverse-proxy `/graphql` → `http://127.0.0.1:4000`; HTTPS via `certbot --nginx`.
5. **Process manager:** run the API under PM2 (`pm2 start dist/index.js --name tracker-api`; `pm2 save`; `pm2 startup`).

> **Doc-drift note (corrected here):** the standalone `DEPLOY-VPS.md` was written when the API had no `build`/`start` scripts and suggested a ts-node invocation. Both scripts now exist (`build: tsc`, `start: node dist/index.js`) — prefer `npm run build && npm start`. A frontend Dockerfile exists but expects alignment with Vite's `dist` output; the nginx path above is the supported route.

## 4. Common pitfalls

- **Frontend can't reach the API:** `VITE_API_URL` must be set *before* `npm run build`, and nginx must proxy the same path it names.
- **502 Bad Gateway:** the API process isn't running / wrong port — check `pm2 status` and `curl http://127.0.0.1:4000/graphql`.
- **CORS:** same-domain (nginx proxy) avoids it; cross-domain needs Express CORS config in `api`.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Local commands verified against both `package.json` files; deploy summarized from `DEPLOY-VPS.md` with the stale build/start caveat corrected.
