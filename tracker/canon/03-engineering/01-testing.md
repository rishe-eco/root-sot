# Tracker — Testing

*Source of truth. What's tested, how, and the philosophy behind it. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built · 2026-08-02 · Owner: _root**

---

## 1. The philosophy (why tests are shaped this way)

A standing preference governs test investment here:

- **Backend integration tests are the preferred place to verify logic.** They exercise the real resolvers, services, and Prisma against a test database — closest to production truth.
- **Frontend component mocks are temporary scaffolding.** They currently mock `useApi`; the intent is to eventually point frontend tests at the real API. So: **keep mocks minimal and easy to replace**, and **don't write tests for thin I/O glue** (components that just call an API and conditionally render) — the value is low and they'll be rewritten.
- The **recurrence/gathering engine** is the highest-risk code (DST, month boundaries, leap years) and earns tests fastest.

## 2. Backend tests — `api`

Vitest (`test` = `vitest run`), with `@vitest/coverage-v8`. A dedicated test DB is set up via `src/test/globalSetup.ts` and `src/test/helpers.ts`.

**Present suites** (`src/__tests__/`, verified 2026-07-22):

| Suite | Kind |
|---|---|
| `auth.unit.test.ts` | unit — JWT / auth helpers |
| `overlap.unit.test.ts` | unit — Pre-day overlap math |
| `recurrence.unit.test.ts` | unit — interval/routine occurrence logic |
| `auth.integration.test.ts` | integration |
| `actions.integration.test.ts` | integration |
| `gathering.integration.test.ts` | integration — the gathering pipeline |
| `goals.integration.test.ts` | integration |
| `milestones.integration.test.ts` | integration |
| `projects.integration.test.ts` | integration |
| `today.integration.test.ts` | integration — day-flow queries |
| `journals.integration.test.ts` | integration |
| `feelingsNeedsContent.unit.test.ts` | unit — Feelings & Needs content invariants |
| `feelingsNeeds.integration.test.ts` | integration — the Day-1 frame gate and the daily loop |

This closes the roadmap's **T-1** (backend unit tests) and **T-4** (test env) items, and covers the three highest-risk pure functions (recurrence, overlap, auth) plus the main resolver happy-paths.

**A note on the content unit test, because it is a shape worth reusing.** Authored content packs (`content/skills/`, `content/feelings-needs/`) are hand-written files read by code that assumes they are well-formed — ids resolved by lookup, templates with placeholders substituted in, pool sizes assumed to exceed the display dials. None of that is expressible in the type system, because every one is a relationship *between* two hand-written files. Those invariants are exactly what gets checked once by hand on authoring day and never again, so they belong in a test: it is what keeps the fortieth lexicon entry from quietly breaking one of the first thirty-nine.

## 3. Frontend tests — `client`

- **Component:** Vitest + React Testing Library (`test` = `vitest run`; setup in `app/test/`). Mock `useApi`.
- **End-to-end:** Playwright (`test:e2e`, plus `:ui` and `:headed`), config at `playwright.config.ts`, specs in `e2e/`.

**Present e2e specs** (verified 2026-07-22): `auth`, `actions`, `action-form`, `goals`, `journals`, `navigation`, `projects`, `today` — plus `globalSetup.ts` and a `helpers/` folder. The setup registers a primary test user and a second "friend" user with `discoverableByEmail: true` (needed for journal-access tests), with per-test cleanup.

This substantially delivers the roadmap's **T-3** (E2E) item across the core journey.

## 4. Running

```bash
# backend
cd api && npm test

# frontend unit/component
cd client && npm test

# frontend e2e (needs the app reachable per playwright.config)
cd client && npm run test:e2e
```

## 5. Gaps / next

- Coverage targets (the roadmap named ~80% on the two service files) are not asserted here — measure with `@vitest/coverage-v8` before claiming a number.
- The eventual real-API frontend refactor (replacing `useApi` mocks) remains deferred, by preference.

---

## Changelog

- **0.2 · 2026-08-02** — Added the two Feelings & Needs suites (content invariants; the frame gate and daily loop). Recorded why authored content packs earn a unit test of their own.
- **0.1 · 2026-07-22** — Initial. Suites enumerated from the repos; philosophy carried from standing testing preferences.
