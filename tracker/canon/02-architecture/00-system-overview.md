# Tracker — System Overview

*Source of truth. The shape of the system: repos, stack, auth, data flow. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

## 1. Two workspaces, one app

Tracker is the `rishe-eco/tracker` repo — a monorepo with two independent workspaces. (Until 2026-07-29 these were two separate repos, `trackerApi` and `trackerProject`; the workspace directories were named `tracker-api/` and `tracker-project/` then, and still carry those `package.json` names.)

- **`api/`** — the backend. Node.js + TypeScript, Express hosting an Apollo GraphQL server, Prisma ORM over SQLite. Owns all persistence and business logic. Runs on port **4000**; single endpoint **`POST /graphql`**.
- **`client/`** — the frontend. React 18 + Vite + React Router v7, TailwindCSS 4 + Radix UI, Apollo Client, i18next. PWA-ready (manifest + service worker in the build). Talks to the API **exclusively** over GraphQL.

The two communicate only through the GraphQL contract. There is no shared code package between them; the contract *is* the interface.

## 2. The stack

| Concern | Backend | Frontend |
|---|---|---|
| Language | TypeScript | TypeScript |
| Runtime / build | Node.js | Vite |
| HTTP / transport | Express + Apollo Server | Apollo Client |
| API style | GraphQL | GraphQL (via `useApi()`) |
| Data | Prisma ORM · SQLite (dev) / PostgreSQL (optional) | — |
| UI | — | React 18 · React Router v7 · Tailwind 4 · Radix UI |
| i18n | — | react-i18next (`en`, `fa`) |
| Auth | JWT (bcrypt) | Bearer token, stored client-side |
| Dates | — | date-fns v3 (named exports only) |
| Tests | Vitest (integration + unit) | Vitest + RTL · Playwright (e2e) |

## 3. Backend layout

```
api/
├── prisma/
│   ├── schema.prisma          data model + enums (see 01-data-model.md)
│   └── migrations/            SQL migration history (see the decision log)
├── src/
│   ├── index.ts               Express + Apollo entry; builds JWT context
│   ├── graphql/
│   │   ├── index.ts           re-exports typeDefs + resolvers
│   │   ├── auth.ts            JWT sign/verify, requireAuth, ensureOwned
│   │   ├── schema/typeDefs.ts the GraphQL schema
│   │   └── resolvers/
│   │       ├── index.ts
│   │       ├── query.ts
│   │       ├── mutations.ts
│   │       └── typeResolvers.ts   field resolvers; parses JSON-string arrays back to lists
│   ├── services/
│   │   ├── todayPreDayAfterDay.ts today actions, Pre-day status, After-day grouping
│   │   └── actionGathering.ts     interval/routine → gathered Action generation
│   ├── test/                  globalSetup, helpers (test DB)
│   └── __tests__/             integration + unit tests
└── .env                       DATABASE_URL, PORT, JWT_SECRET
```

The two **services** hold the app's real complexity — the recurrence/gathering engine and the daily-cycle logic. They are the highest-risk, highest-value code and the priority test targets.

## 4. Frontend layout

```
client/app/
├── api/queries.ts             ALL GraphQL documents live here
├── components/<module>/       one folder per module (see 01-product/03-modules.md)
│   └── ui/                    shared Radix-based primitives
├── layout/                    route layouts (InternalPageLayout, ProtectedAppLayout)
├── protectedRoutes.tsx        route table + auth gating
├── lib/ · utils/              helpers (dateUtils, etc.)
├── i18n/ · locales/{en,fa}/   translations (common.json per locale)
├── test/                      Vitest setup
└── e2e/                       Playwright specs + globalSetup
```

## 5. Auth & ownership

- **JWT-based.** `register` / `login` return `{ token, user }`. The token (containing `userId`, valid ~7 days) is stored client-side and sent as `Authorization: Bearer <token>`.
- **`requireAuth`** — every query/mutation except `register` / `login` requires a valid token, else `Unauthorized`.
- **`ensureOwned`** — every resource-touching operation checks the resource's `userId` against the caller; a mismatch returns `Not found` (no existence leak — you can't tell someone else's data apart from missing data).

This pair is the security spine. **Every new resolver must use both** — see `04-conventions.md`.

## 6. Data flow (a request end to end)

```
React component
  → useApi() hook  (app/api/queries.ts document)
    → Apollo Client  (Bearer token attached)
      → POST /graphql
        → Apollo Server → resolver (requireAuth → ensureOwned)
          → service logic (for day/gathering flows)
            → Prisma → SQLite
          ← typeResolvers parse JSON-string fields back to arrays
      ← JSON response
  ← component re-renders
```

## 7. Persistence notes

- **SQLite in dev** (a file, `DATABASE_URL="file:./dev.db"`). PostgreSQL is supported by swapping the `datasource` block in `schema.prisma` (currently the `postgresql` block is commented out).
- **SQLite has no array type**, so list-valued fields are stored as **JSON strings** and parsed back in `typeResolvers.ts`. This is a load-bearing convention — see `04-conventions.md`.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Layout and stack verified against both repos on this date.
