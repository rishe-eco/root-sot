# Tracker — Frontend Architecture

*Source of truth. How the React client is put together and the patterns it repeats. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

> Verified against `client/package.json` and the `app/` tree on 2026-07-22.

## 1. Stack

React **18.3** · React Router **7.4** (framework mode; `react-router typegen` in the typecheck script) · Vite **5.4** · Apollo Client **3.8** · Tailwind CSS **4** (`@tailwindcss/vite`) + Radix UI primitives · i18next **24** / react-i18next **15** · date-fns **3** · PWA via `@vite-pwa`.

## 2. The API layer — one door

All server communication goes through a single, disciplined layer:

- **`app/api/queries.ts`** — *every* GraphQL document (queries and mutations) lives here. It is the frontend's mirror of the API contract. ~24 KB and growing; when you add an operation, it goes here.
- **`app/api/useApi.ts`** — a custom **`useApi()`** hook wrapping Apollo Client. Components call `useApi()` for all reads and writes rather than using Apollo hooks directly. This is the seam that makes the whole app mockable (tests swap `useApi`) and keeps the transport in one place.
- **Apollo Client** is initialized in `app/index.tsx`; it attaches the Bearer token from client-side storage to every request.

**Rule:** components never talk to the network except through `useApi()`. A new feature adds a document to `queries.ts` and calls it via the hook — nothing else.

## 3. Routing & layout

- **`app/protectedRoutes.tsx`** — the route table and auth gating.
- **`app/root.tsx`** — the app shell, including `ProtectedAppLayout`, where the first-login `OnboardingSlideshow` mounts on top of whatever route is active.
- **`app/layout/`** — reusable layouts (`InternalPageLayout`, etc.).

## 4. Component organization

One folder per module under `app/components/<module>/` (goals, projects, actions, intervals, today, calendar, journals, notes, onboarding, concepts, tools, settings, activities, auth, milestones). Shared primitives live in `app/components/ui/` (Radix-based, Tailwind-styled). Empty reserved folders: `insights/`, `habits/`.

## 5. The wizard pattern

Multi-step flows are a recurring shape: **`PreDayWizard`**, **`AfterDayWizard`**, **`DodClarityWizard`**. They share a structure — a step indicator, one focused step at a time, freely navigable steps — and a key behavior rule:

- **Each step commits its own mutation** rather than buffering everything to a final submit — safer and simpler, and it means a partially completed wizard leaves valid state.
- **In edit contexts, save immediately on completion** (no separate save step). In create-flows (before the entity exists) accumulate in local state and submit with the main form. *(This is a standing UX preference; keep to it.)*

## 6. Internationalization

react-i18next, **Persian-first** per Root. Keys live in `app/locales/en/common.json` and `app/locales/fa/common.json`. **Every user-facing string needs a key in both locales** — an English-only string is a bug (see `04-conventions.md`). Persian is not an afterthought here; affect-labeling and the brand's ground both require it (Root canon `01-philosophy/01-brand-definition.md`).

## 7. Dates

date-fns v3 uses **named exports only** — e.g. `import { enUS } from "date-fns/locale/en-US"`, never a default import. Shared date helpers live in `app/utils/` (`dateUtils`). The calendar uses `react-big-calendar`.

## 8. PWA

The build produces a manifest and service worker; the app is installable and web-first. Native iOS/Android apps are out of scope — a distribution decision deferred post-MVP.

## 9. Testing (frontend)

Vitest + React Testing Library for components (setup in `app/test/`), Playwright for end-to-end (`e2e/`). Component tests mock `useApi`. See `03-engineering/01-testing.md` for the strategy and its stated limits.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Verified against package.json and the app tree; `useApi` / `queries.ts` seam and wizard pattern confirmed in code.
