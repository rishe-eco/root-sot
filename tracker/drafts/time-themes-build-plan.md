# Time Themes — build plan

*The order it gets built in, the exact files, the algorithms that would otherwise be invented, and the gate at the end of each phase. Implements `time-themes.md`; wireframes `time-themes-wireframes.html`. Written to be handed to a coding agent together with those two files. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-09-15 · Owner: _root**

---

## 0. Read this first

**Read, in order:** `../canon/02-architecture/04-conventions.md` (all of it — the auth pair §1, the JSON-string list rule §2, resolver validation §4, daily-flow-lives-in-services §5, the i18n rules §7, ConfirmDialog §9, date-fns imports §10) · `../canon/03-engineering/01-testing.md` (backend integration tests are the gate; recurrence/gathering is the highest-risk code) · then `time-themes.md` (**§2 "soft, never binding" and §3.1 the inheritance table are the build's constraints, not background**) · then open the wireframes.

**Two facts about this feature that a competent agent will otherwise smooth away:**

1. **A Time Theme never blocks anything.** No gate, no filter that removes options, no touch to `DayState` or the daily cycle. Its entire effect is *re-ranking* (surfacing) and *drawing a band*. If any phase produces a hard filter or a required field on an action, the phase is wrong.
2. **A gathered action's tags are locked; a project/standalone action's tags are editable.** This distinction is the whole point of §3.1 and it is enforced *server-side* (`sourceType != null` ⇒ reject tag mutation), not merely hidden in the UI.

**Canon is deferred by owner decision.** Normally Convention #11 requires the data-model doc + a `decision-log` entry in the same commit as a schema change. For this build the owner has chosen to build first and fold into canon afterward. The coding agent works only in `E:\_root\tracker` (the code repo); the canon lives in the separate `E:\_root\root-sot` repo and is **out of scope for the agent**. The owner will, at finalization, add **D-54** to `decisions/decision-log.md`, bump `04-roadmap/00-state-of-the-build.md` to **0.32**, and transcribe the two new models into `02-architecture/01-data-model.md`.

---

## 1. The one architectural decision — tags as a relation, not a JSON list

Convention #2 says list fields are JSON strings on this SQLite schema, and today **there is not a single many-to-many relation anywhere** (recon confirmed: every `@relation` is 1:N; `customRepeatDates`, `timeOfDayBlocks`, `dodFlaggedDimensions` are all JSON-string value-lists). So a naive reading says "store `tagIds` as a JSON string on each entity."

**This plan does not do that. Tags are modelled as a real many-to-many.** Reasoning:

- Convention #2 exists for **lists of primitive values** (dates, weekday numbers, "HH:mm" strings) — a SQLite workaround for "no array type." A tag is **a reference to another table**, not a value. Forcing entity relationships into JSON blobs is outside what #2 was written for.
- The feature is inherently bidirectional. The tag manager shows a **usage count per tag** ("12 uses" in the wireframe §1) and delete must be clean — both are natural relation queries and awkward JSON-scans.
- The whole reason the owner chose first-class tags over free text was *reliable match by id and rename-once*; a real relation is the honest expression of that.

**Chosen shape: implicit Prisma m2m** (`tags Tag[]` on each entity, `projects/intervals/routines/actions/timeThemes` back-relations on `Tag`). Prisma manages the five join tables; resolvers use `include: { tags: true }`. Because `Tag` pairs with five *distinct* models, no `@relation` name disambiguation is needed.

> **DECISION TO RATIFY AT REVIEW (owner):** implicit m2m as above, vs. explicit join models (`ProjectTag`, `ActionTag`, …) if you want per-join metadata/indexes later, vs. the JSON-`tagIds` fallback if you'd rather not introduce m2m to this schema at all. The plan below assumes **implicit m2m**; flipping to explicit join models changes only Phase 1 and the `include` shapes. **Do not start Phase 1 until this is confirmed** — it is the one irreversible-ish call here.

---

## 2. What this plan implements (settled with owner, 2026-09-13)

1. **Idea B only** — typed time periods. Idea A (subdividing the day into sections) is explicitly **not** in scope.
2. **Soft/suggestion binding.** Surfacing + band only; never a gate.
3. **First-class `Tag`** (name + colour), one shared vocabulary across **Project · Interval · Routine · Action · TimeTheme**.
4. **X holds actions.** A theme surfaces actions; it does not hold projects/goals.
5. **Inheritance:** gathered actions inherit source tags **locked (snapshot at gather)**; project actions inherit **editable (init-from-project)**; standalone actions start empty, editable.
6. **Recurrence reuses the Interval implementation** — the exported `intervalOccursOnDate` / `dateMatchesRepeatFromAnchor` in `actionGathering.ts`.

Out of scope (deferred, per spec §8): goals/milestones tagging; an after-day "did I honour the theme?" retro lens; blended multi-tag band colour.

---

## 3. Phases

Each phase is one logical commit (two where noted). Backend phases end on a green `cd api && npm test`; client phases on `cd client && npm test` **plus** `npm run i18n:check-missing && npm run i18n:check-hardcoded` **plus** `npx tsc --noEmit` (not `npm run typecheck` — it is broken in this repo, per the repo reference). End the client-visible phases with a live in-browser check (dev server), `en` and `fa`, no console errors.

### Phase 0 — Confirm the ground · *no code*

- Both suites green; record counts.
- Ratify §1 (m2m shape).
- Re-verify the recon's key line refs still hold: `mutations.ts` `addAction` (~102-120), `actionGathering.ts` `collect` push (~347-357) and `intervalOccursOnDate` (~26-124), `typeResolvers.ts` JSON-parse pattern (~192-200). If any drifted, note the new lines before touching them.

### Phase 1 — Schema + migration · *one commit*

Add to `api/prisma/schema.prisma`:

```prisma
model Tag {
  id         String      @id @default(uuid())
  name       String
  color      String                        // palette key or hex; see §UI palette
  userId     String
  user       User        @relation(fields: [userId], references: [id], onDelete: Cascade)
  createdAt  DateTime    @default(now())
  // shared vocabulary — the five m2m back-relations
  projects   Project[]
  intervals  Interval[]
  routines   Routine[]
  actions    Action[]
  timeThemes TimeTheme[]
  @@unique([userId, name])
}

model TimeTheme {
  id                String         @id @default(uuid())
  title             String
  status            IntervalStatus @default(active)   // reuse existing enum
  startTimeOfDay    String                             // "HH:mm"
  endTimeOfDay      String                             // "HH:mm"
  // recurrence — same field shape as Interval, so the occurrence resolver is reused verbatim
  repeatValue       Int            @default(1)
  repeatUnit        RepeatUnit?
  customRepeatDates String?                            // JSON array of ISO datetimes
  customRepeatRule  String?                            // JSON, same grammar as Interval
  endTime           DateTime?
  tags              Tag[]
  userId            String
  user              User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  createdAt         DateTime       @default(now())
  updatedAt         DateTime       @updatedAt
}
```

Add `tags Tag[]` to `Project`, `Interval`, `Routine`, `Action`. Add `tags Tag[]`, `timeThemes TimeTheme[]` back-relations to `User` (and `tags`/`timeThemes` list relations already implied). Add `User.tags Tag[]` and `User.timeThemes TimeTheme[]` owner relations.

```bash
cd api && npx prisma migrate dev --name add_time_themes && npx prisma generate
```

This produces a real migration (new tables + five join tables) — unlike the enum-only skill migrations. **Gate:** migration applies clean on a fresh DB; `npm test` green (no behavioural change yet); update `api/src/__tests__/schema.unit.test.ts` if it enumerates models.

### Phase 2 — Tag model: CRUD + tagging API · *one commit*

**SDL** (`api/src/graphql/schema/typeDefs.ts`):

```graphql
type Tag { id: ID!  name: String!  color: String!  usageCount: Int!  createdAt: String! }

extend type Query { tags: [Tag!]! }

extend type Mutation {
  createTag(name: String!, color: String!): Tag!
  renameTag(id: ID!, name: String!): Tag!
  recolorTag(id: ID!, color: String!): Tag!
  deleteTag(id: ID!): Boolean!
  setProjectTags(projectId: ID!, tagIds: [ID!]!): Project!
  setIntervalTags(intervalId: ID!, tagIds: [ID!]!): Interval!
  setRoutineTags(routineId: ID!, tagIds: [ID!]!): Routine!
  setActionTags(actionId: ID!, tagIds: [ID!]!): Action!
}
```

Add `tags: [Tag!]!` to the `Project`, `Interval`, `Routine`, `Action`, and (Phase 4) `TimeTheme` SDL types.

**Resolvers.** Every one wrapped `requireAuth` + `ensureOwned` (Convention #1). Mutations in `mutations.ts`, query in `query.ts`, `Tag.usageCount` and the per-type `tags` field in `typeResolvers.ts`.

- `createTag` — reject duplicate name for the user (the `@@unique` also guards; catch and throw a human message per Convention #4). Validate `color` against the allowed palette set (§UI palette) — reject unknown.
- `renameTag` / `recolorTag` — `ensureOwned` the tag; same validations.
- `deleteTag` — `ensureOwned`; with implicit m2m, disconnecting is automatic when the row is deleted (join rows cascade). Route the client through `ConfirmDialog` (Convention #9).
- `setXTags(xId, tagIds)` — `ensureOwned` the entity **and** every tag id (all must belong to the caller; unknown/foreign id ⇒ `Not found`). Use Prisma `set:` to replace the connection: `tags: { set: tagIds.map(id => ({ id })) }`.
- **`setActionTags` is the guarded one:** if the action has `sourceType != null` (gathered), **reject** with a message like "This action's tags come from its {interval|routine} and can't be edited here." This is constraint #2 from §0.

**Type resolvers.** `Tag.usageCount` = sum of the five relation counts (`prisma.tag.findUnique({ include: { _count: { select: { projects:true, intervals:true, routines:true, actions:true, timeThemes:true } } } })`, or a targeted count query). `Project.tags` / `Interval.tags` / `Routine.tags` / `Action.tags` resolve via the relation (lazy load, mirroring the existing lazy relation loads in `typeResolvers.ts`).

**Client contract.** Add the documents to `client/app/api/queries.ts` (plain template strings — no codegen in this repo). Nothing else client-side this phase.

**Tests** (`api/src/__tests__/tags.integration.test.ts`, new): create/rename/recolor/delete; `@@unique` collision rejected; `setXTags` happy path for all four entities; **foreign tag id rejected**; **`setActionTags` on a gathered action rejected**; `usageCount` correct after connecting to two entity kinds; delete scrubs the connection (formerly-tagged entity now returns `tags: []`).

**Gate:** `npm test` green.

### Phase 3 — Inheritance wiring · *one commit*

Two hooks, both backend, both in the daily-flow/services layer (Convention #5).

**3a. Project init-from-project** — `mutations.ts` `addAction` (~102-120). After the existing project load + `ensureOwned` (~103-106), when `projectId` is present, read the project's tag ids and connect them on create:

```ts
// after ensureOwned(project, ctx)
const projectTagIds = (await prisma.project.findUnique({
  where: { id: projectId }, select: { tags: { select: { id: true } } },
}))?.tags.map(t => t.id) ?? [];
// in the create data:
tags: { connect: projectTagIds.map(id => ({ id })) },
```

This is an **initialisation, not a live link** — later changes to the project's tags do not propagate (§3.1). Because the action is standalone/project-origin (`sourceType == null`), `setActionTags` remains allowed on it afterward.

**3b. Gathered snapshot-copy** — `actionGathering.ts`. (i) In the template load (`include` at ~279-286) add the source tags: `include: { steps: {…}, tags: { select: { id: true } } }`. (ii) In `collect` (extend the `template` param type at ~333) and the `toCreate.push` (~347-357), add `tags: { connect: template.tags.map(t => ({ id })) }`. Tags are **not** part of the dedup identity (`gatheredActionKey`, ~244-256) — leave that untouched, so re-runs stay safe.

Snapshot semantics: a gathered action freezes the source's tags at gather time; retagging the interval/routine affects only *future* gathers (consistent with how title is already snapshotted). No back-fill.

**Tests** (extend `actions.integration.test.ts` and `gathering.integration.test.ts`): a project action created under a tagged project carries those tags and `setActionTags` still succeeds on it; a gathered action from a tagged interval carries the interval's tags and `setActionTags` is **rejected**; retagging the interval does not change an already-gathered action; a routine's tags propagate identically.

**Gate:** `npm test` green.

### Phase 4 — TimeTheme: CRUD + recurrence resolution · *one commit*

**SDL:**

```graphql
type TimeTheme {
  id: ID!  title: String!  status: IntervalStatus!
  startTimeOfDay: String!  endTimeOfDay: String!
  repeatValue: Int!  repeatUnit: RepeatUnit
  customRepeatDates: [String!]!  customRepeatRule: String
  endTime: String  tags: [Tag!]!  createdAt: String!  updatedAt: String!
}
extend type Query {
  timeThemes: [TimeTheme!]!
  timeThemesForDate(dateKey: String!): [TimeTheme!]!   # resolved occurrences for one day
}
extend type Mutation {
  createTimeTheme(input: TimeThemeInput!): TimeTheme!
  updateTimeTheme(id: ID!, input: TimeThemeInput!): TimeTheme!
  setTimeThemeStatus(id: ID!, status: IntervalStatus!): TimeTheme!
  deleteTimeTheme(id: ID!): Boolean!
}
input TimeThemeInput {
  title: String!  startTimeOfDay: String!  endTimeOfDay: String!
  repeatValue: Int  repeatUnit: RepeatUnit
  customRepeatDates: [String!]  customRepeatRule: String  endTime: String
  tagIds: [ID!]!
}
```

**Resolver validation** (Convention #4): `startTimeOfDay`/`endTimeOfDay` well-formed "HH:mm" and `end > start`; recurrence fields validated exactly as the Interval editor's mutation does (mirror that resolver). `customRepeatDates` is stored `JSON.stringify`'d and parsed back in `typeResolvers.ts` with the standard guard (recon §2, the ~192-200 pattern); `customRepeatRule` is stored as a raw JSON string and returned as-is (as Interval does — it is consumed by the service, not exposed parsed). Tag connect uses the same ownership-checked pattern as Phase 2.

**Recurrence reuse — the point of the whole field-shape choice.** `timeThemesForDate(dateKey)`:

```ts
const themes = await prisma.timeTheme.findMany({
  where: { userId: ctx.user.id, status: "active" },
  include: { tags: true },
});
return themes.filter(t => intervalOccursOnDate(t, dateKey));  // reused verbatim
```

`intervalOccursOnDate` (exported from `actionGathering.ts`, ~26-124) duck-types on `{ createdAt, repeatValue, repeatUnit, customRepeatRule, customRepeatDates, endTime }` — all present on `TimeTheme` — so it is called with the theme object directly. **Do not fork or reimplement it.** A theme has no `timeOfDayBlocks`; its slot is `startTimeOfDay`→`endTimeOfDay`, not the interval's per-occurrence blocks, so `getIntervalOccurrencesForDate` is *not* used for themes.

**Tests** (`api/src/__tests__/timeThemes.integration.test.ts`, new; plus a `recurrence.unit.test.ts` case if a new occurrence branch is exercised): CRUD with ownership; `end <= start` rejected; a weekly `customRepeatRule` theme fires on the right weekdays via `timeThemesForDate` and not on others; `endTime` stops it; `status: inactive` excluded; deletion returns true and removes it. Reuse-proof: assert a theme and an interval with identical recurrence fields agree on which dates they fire.

**Gate:** `npm test` green.

### Phase 5 — Soft surfacing: the match helper + backend support · *one commit*

One pure, shared function so the same rule drives the picker and the timeline:

```ts
// api/src/services/timeThemes.ts (new) — and mirrored client-side, see Phase 6
export function actionTagIdsMatchTheme(actionTagIds: string[], themeTagIds: string[]): boolean {
  return actionTagIds.some(id => themeTagIds.includes(id));   // overlap; never blocks
}
```

Surfacing is **presentation only** — it changes order, never membership. Two consumers:

- **Pre-day picker ranking:** for a slot covered by theme(s) T, actions whose tag ids overlap ∪T.tags sort to the top; everything else remains, below a divider (wireframe §6). Order is the only change.
- **Timeline affinity marker:** an action gets the "↑ match" tick when it overlaps a band *in time* **and** `actionTagIdsMatchTheme` is true for that band. Non-matching actions inside a band render normally (dimmed in the mock is optional polish, not a filter).

No new gate logic, no writes. If a helper is enough and no resolver needs it, this phase may fold into Phase 6 — but keep the helper and its unit test regardless.

**Tests:** `api/src/__tests__/timeThemes.unit.test.ts` — overlap true/false/empty-either-side. If any resolver surfaces ranked data, an integration assertion that membership is unchanged and only order differs.

**Gate:** `npm test` green.

### Phase 6 — Client UI + i18n · *one commit (or split editor/timeline if large)*

All strings via `t()` into **both** `client/app/locales/en/common.json` and `client/app/locales/fa/common.json` (Convention #7; the fa values follow 7a–7d and ship `draft` pending native review — see §Persian below). All network through `useApi()` + `queries.ts` (Convention #6). Destructive controls (delete tag/theme) through `ConfirmDialog` (Convention #9). Dates through `useAppDate`/`dateUtils` per the wire-vs-display split (Convention #7e).

Build, in dependency order:

1. **Tag manager** — new page/section (settings/modules area, alongside existing module pages). List with usage counts, create, rename, recolour, delete. Palette picker from the fixed set (§UI palette).
2. **Tag picker (chips)** — a reusable `TagPicker` component. Wire into `client/app/components/projects/ProjectForm.tsx`, `client/app/components/intervals/IntervalForm.tsx` (the **shared** interval+routine form — branch on `ScheduleFormMode`), and `client/app/components/actions/ActionForm.tsx`.
3. **Action editor locked state** — in `ActionForm.tsx`, when the action is gathered (`sourceType != null`), render tags read-only with the lock flag and no add/remove (wireframe §3); otherwise editable, pre-filled for project actions. The server guard (Phase 2) is the real enforcement; this is the affordance.
4. **Time Theme editor** — new `TimeThemeForm.tsx` under a new `client/app/components/timeThemes/`. Reuse the Interval editor's **recurrence control** (extract/share it from `IntervalForm.tsx` rather than duplicate) plus title, tag picker, and start/end time-of-day. A themes list/management surface alongside.
5. **Timeline bands + picker ranking** — draw active themes as coloured bands behind actions in the day view (`client/app/components/today/PreDayWizard.tsx` for the assignment flow; `TodayPage.tsx`/`TodayActionWidget.tsx` for the day view). **Client recurrence is duplicated** in `client/app/components/calendar/useCalendarItems.ts` (its own `intervalOccursOnDate` etc., per recon §5) — extend that copy (or the `timeThemesForDate` query result) to resolve which themes fire on the shown day, and add a client mirror of `actionTagIdsMatchTheme`. Prefer driving the day view from the `timeThemesForDate` query to avoid a third copy of recurrence logic; use the client recurrence util only where the calendar already does.

**Tests:** component tests for `TagPicker` (add/remove, locked mode renders read-only) and the locked-vs-editable `ActionForm` branch; a `TimeThemeForm` happy-path. Keep mocks minimal per the testing doc (don't test thin I/O glue). E2E is optional this pass.

**Gate:** `cd client && npm test` green; `npm run i18n:check-missing` and `npm run i18n:check-hardcoded` clean; `npx tsc --noEmit` clean; **live in-browser pass**, `en` and `fa`, no console errors — verify: create a tag; tag an interval; gather and see the locked tag on the occurrence; create a weekly theme; see its band on the right weekday and matching actions surfaced; confirm a non-matching action can still be placed in the band.

### Phase 7 — Deferred (owner's usual pattern)

Persona review (`../canon/05-reviews/00-persona-review-method.md`) and polish (blended multi-tag band colour; usage-count performance if the scan grows). Not in this pass.

---

## Persian glossary additions (draft — native pass owed)

Per Convention #7c (one Persian word per concept) and #7d (Western digits). New concepts, added to the glossary at finalization; ship `draft`:

| Concept | Proposed Persian | Note |
|---|---|---|
| Tag | برچسب | standard, low-risk |
| Time Theme | حال‌وهوا (of time) | **must not** be بازه — that is Interval. `حال‌وهوا` ("mood/atmosphere") reads as a stretch-of-time-with-a-character; alternatives for the native reviewer: درون‌مایه, سرشتِ زمان. Flag in `team/open-work.md`. |
| "locked / inherited" (tag flag) | از {بازه/روال} می‌آید | convey the concept (7a), informal (7b) |

The native reviewer decides the Time Theme term; do not finalize it in-build.

## UI palette (tag colours)

A **fixed** set (keeps bands legible in light + dark, and lets the validator/enum reject stray hex). Suggested keys mirroring the wireframe: `indigo` (deep-work), `slate` (admin), `amber` (creative), `green` (errands), `plum` (rest), plus a couple of spares. Define once in a shared client module and echo the allowed set in the `createTag`/`recolorTag` resolver validation. Store the **key**, not the hex, so a future palette re-tune is one place.

---

## Test-gate summary

| Phase | New/changed test files | The assertion that matters most |
|---|---|---|
| 2 | `tags.integration.test.ts` | `setActionTags` on a gathered action is rejected; foreign tag id rejected |
| 3 | `actions.integration.test.ts`, `gathering.integration.test.ts` | gathered action carries source tags **and is locked**; project init is a copy, not a live link |
| 4 | `timeThemes.integration.test.ts` | a theme and an interval with identical recurrence agree on firing dates (reuse proof) |
| 5 | `timeThemes.unit.test.ts` | overlap match; surfacing changes order, never membership |
| 6 | `TagPicker`/`ActionForm` component tests | locked mode renders read-only; en+fa parity clean |

---

## Changelog
- **0.1 · 2026-09-15** — Initial plan. Six build phases + deferred review. Records the one architectural decision (tags as real m2m, not JSON — with the "relation, not value-list" reasoning) as owner-ratify-at-review; the canon-deferred deviation from Convention #11; and the reuse of `intervalOccursOnDate` for theme occurrences as the reason the TimeTheme recurrence fields mirror Interval's exactly.
