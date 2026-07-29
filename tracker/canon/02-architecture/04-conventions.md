# Tracker — Conventions

*Source of truth. The patterns you must follow to change this app without breaking it. If you read one architecture file before writing code, read this one. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

These are not style preferences — each one, skipped, produces a specific class of bug. They are stated as rules with the reason attached.

## Backend

### 1. Every resolver uses `requireAuth` **and** `ensureOwned`
No query or mutation (except `register` / `login`) may touch data without both. `requireAuth` rejects anonymous callers (`Unauthorized`); `ensureOwned` verifies the resource's `userId` matches the caller and returns `Not found` on mismatch — deliberately indistinguishable from a missing resource, so ownership can't be probed. **Why:** this pair is the entire authorization model; a resolver that forgets one is a data-leak.

### 2. List fields are JSON strings — stringify on write, parse in `typeResolvers.ts`
SQLite has no array type. Any list-valued field (`Goal.dodFlaggedDimensions`, `Interval.customRepeatDates`, `Interval.customRepeatRule`, `Routine.timeOfDayBlocks`) is stored as a JSON string and parsed back to a GraphQL list in `typeResolvers.ts`. **When you add a new list field:** (a) `String?` in the schema, (b) `JSON.stringify` in the mutation resolver, (c) `JSON.parse` in the corresponding type resolver. Skip (c) and the field returns a raw string to the client; skip (b) and Prisma throws.

### 3. Enforce scope exclusivity where the model demands it
Project: `goalId` **xor** `milestoneId`. Interval: at most one of `goalId` / `milestoneId` / `projectId`. These are enforced in the resolver/DB, not by Prisma's type system — preserve the checks when editing those mutations.

### 4. Validate at the resolver
`estimatedTimeMinutes` 0–1440 and required with `tbd`; times as "HH:mm"; dates as "YYYY-MM-DD". Domain errors are thrown with human-readable messages.

### 5. Daily-flow logic lives in the services
`todayPreDayAfterDay.ts` and `actionGathering.ts` hold the real complexity. Business rules about the day cycle, gathering window, or fates belong there, not scattered across resolvers — and that's where the tests target them.

## Frontend

### 6. All network access goes through `useApi()` + `queries.ts`
No component calls Apollo directly or fetches on its own. Add the document to `app/api/queries.ts`, call it via `useApi()`. **Why:** it's the mock seam for tests and the single source of the client-side contract.

### 7. Every user-facing string is a key in **both** `en` and `fa`
Add to `app/locales/en/common.json` and `app/locales/fa/common.json`. **Why:** Persian is a brand non-negotiable (Root); an English-only literal is a regression, not a TODO.

### 8. Wizard steps commit immediately; edit-context wizards save on completion
Don't buffer a multi-step flow to one final submit — each step fires its mutation (partial state must be valid). In edit contexts, completion saves with no extra step; only create-flows accumulate locally. (See `03-frontend.md` §5.)

### 9. Destructive actions use `ConfirmDialog`
Every delete/irreversible control routes through the shared confirm dialog — consistency the app already assumes. (Bug **B-1** was a delete that skipped it.)

### 10. date-fns v3 named imports only
`import { format } from "date-fns"`, `import { enUS } from "date-fns/locale/en-US"`. No default imports — they don't exist in v3 and will fail the build.

## Keeping the canon true

### 11. Schema change → data-model doc change, same commit
If you touch `schema.prisma`, update `02-architecture/01-data-model.md` and add a migration note to `../../decisions/decision-log.md`. The canon is only useful while it matches the code.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Distilled from the patterns memory, the base docs, and the resolver/service structure.
