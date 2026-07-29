> **⚠ SUPERSEDED — 2026-07-22.** Dates from 2026-02; predates journals, notes, onboarding, and the Clarity Check. Current source of truth: `../../canon/02-architecture/`. Kept for history.

# Tracker API – Backend Documentation

Backend for the Tracker app: **GraphQL API** over **Node.js + Express + Apollo Server**, with **Prisma** and **SQLite** (or optional PostgreSQL).

## Stack

| Layer | Technology |
|-------|------------|
| Runtime | Node.js |
| HTTP / API | Express + Apollo Server (GraphQL) |
| Database | SQLite (default) or PostgreSQL |
| ORM | Prisma |
| Auth | JWT (Bearer token), bcrypt for passwords |
| Language | TypeScript |

## Repository layout

Backend code lives in **`api/`** (project root for the API).

```
api/
├── prisma/
│   ├── schema.prisma      # Data model and enums
│   └── migrations/        # SQL migrations
├── src/
│   ├── index.ts           # Express + Apollo entry, JWT context
│   ├── graphql/
│   │   ├── index.ts       # Re-exports typeDefs, resolvers
│   │   ├── auth.ts        # JWT sign/verify, requireAuth, ensureOwned
│   │   ├── schema/
│   │   │   └── typeDefs.ts
│   │   └── resolvers/
│   │       ├── index.ts
│   │       ├── query.ts
│   │       ├── mutations.ts
│   │       └── typeResolvers.ts
│   └── services/
│       ├── todayPreDayAfterDay.ts   # Today actions, Pre-day, After-day
│       └── actionGathering.ts       # Interval/Routine → Action generation
├── package.json
└── .env                  # DATABASE_URL, PORT, JWT_SECRET
```

## Setup and run

### Prerequisites

- **Node.js** and npm
- For **SQLite**: nothing else (DB is a file)
- For **PostgreSQL**: running Postgres instance and a database/user

### 1. Install dependencies

```bash
cd api
npm install
```

### 2. Environment

Create a `.env` in `api/`:

**SQLite (default):**

```env
DATABASE_URL="file:./dev.db"
PORT=4000
```

**Optional:** `JWT_SECRET=your-secret` (defaults to `dev-secret` if omitted).

**PostgreSQL:** set `DATABASE_URL` to your connection string and, in `prisma/schema.prisma`, use the `postgresql` datasource (comment out SQLite). Then run migrations (see below).

### 3. Database

Generate the Prisma client and apply migrations:

```bash
npx prisma generate
npx prisma migrate dev
```

- `prisma generate` – updates Prisma client from the schema.
- `prisma migrate dev` – applies migrations (and creates the SQLite file if needed).

### 4. Start the API

```bash
npm run dev
```

GraphQL endpoint: **http://localhost:4000/graphql** (or the `PORT` you set).

### After schema changes

```bash
npx prisma generate
npx prisma migrate dev --name describe_your_change
npm run dev
```

## Authentication

- **Register:** `register(email, password)` → returns `{ token, user }`.
- **Login:** `login(email, password)` → returns `{ token, user }`.
- **Authenticated requests:** send header `Authorization: Bearer <token>`.
- All data operations (except `register`/`login`) require a valid JWT; otherwise the API returns `Unauthorized`. Resource access is scoped by `userId`; wrong user returns `Not found`.

## Documentation index

| Document | Contents |
|----------|----------|
| [schemas.md](./schemas.md) | Prisma schema: models, enums, relations |
| [api.md](./api.md) | GraphQL API: queries, mutations, types, inputs |
| [concepts.md](./concepts.md) | Domain concepts: Pre-day, After-day, action gathering, DayState |
