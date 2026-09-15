# Tracker — Time Themes (draft spec)

*Draft. Not yet canon. When this lands, fold it into `01-product/00-concepts-and-hierarchy.md`, `02-architecture/01-data-model.md`, and a `decisions/decision-log.md` entry (Convention #11), and give it a `06-specs/` (or a new core-feature spec) home.*

**Version 0.1-draft · Status: spec (nothing built yet) · 2026-09-13 · Owner: _root**

---

## 1. What a Time Theme is

A **Time Theme** is a first-class entity that is **neither a project nor a goal**: it is a *span of time with a nature*. It answers "what **kind** of work should this stretch of the day be?" rather than "what is the work?" or "why am I doing it?".

- A goal carries a `dod`; a project is a body of work; an action is the thing you do.
- A Time Theme carries **no outcome and no target** — only a **tag** (its nature) and a **when** (a time-of-day span, on a recurring schedule).

It inverts the planning direction. The daily cycle today is bottom-up: here are my actions, when do I do each? A Time Theme lets you author the *shape* of the day top-down — "Mon/Wed mornings are deep work" — and then have matching actions surface into that shape.

> Naming note: "theme" is already used informally in the glossary for clustering goals under a goal group. This entity is unrelated; the model is named `TimeTheme` to keep code unambiguous. Product/UI term is provisional ("Time Theme"), rename freely.

## 2. Soft, never binding

A Time Theme **only suggests**. It never blocks, never gates, never touches `DayState` or the daily cycle. Any action can be scheduled in any time, regardless of themes. Its entire effect is:

1. **Surfacing** — during gathering / Pre-day, when placing actions into a slot covered by a theme, actions whose tags overlap the theme's tags **rank to the top**. Non-matching actions remain fully available below.
2. **Context** — on the day timeline, the theme renders as a **colored band** behind the actions, drawn from its tag colour, so the intended shape of the day is visible.

That's it. No enforcement anywhere.

## 3. Tags — a shared, first-class vocabulary

Tags are **not free text**. A `Tag` is a user-scoped entity with a name and a colour, so it can be renamed once, matched reliably by id (not spelling), and give the timeline band a colour.

One tag vocabulary attaches (many-to-many) to **five** entities: **Project, Interval, Routine, Action, and TimeTheme**. The match that drives surfacing is **tag overlap**: a theme surfaces an action when `action.tags ∩ theme.tags ≠ ∅`. A theme may carry more than one tag (e.g. a morning that is both `deep-work` and `creative`); usually one.

### 3.1 Inheritance & the locked-vs-editable rule

Tagging the four "source" entities lets tags flow onto actions automatically. The rule follows the existing origin distinction (`00-concepts-and-hierarchy.md` §1):

| Action origin | Tags come from | Editable on the action? |
|---|---|---|
| **Gathered** (from Interval / Routine) | the source template, **snapshot-copied at gather time** | **No — locked.** The nature belongs to the recurring template, not the occurrence. Change it on the template and future occurrences pick it up. |
| **Project-linked** (manually added under a project) | **initialised** from the project's tags at create | **Yes.** A project action is not *generated*; it is user-created, so the inherited tags are a starting point you can add to or drop. |
| **Standalone** | none by default | **Yes.** |

- **Snapshot, not live.** Gathered actions already snapshot their source (they copy the title). Tags copy the same way at gather time, so already-gathered occurrences freeze while future generations pick up any retag of the template — consistent with the rest of tracker. Enforcement of "locked" is a resolver guard: any tag mutation on an action with `sourceType != null` is rejected.
- **Project init is a copy, then independent.** Later changes to the project's tags do **not** retro-propagate to already-created project actions.

## 4. Recurrence — reuse the Interval implementation

A Time Theme repeats using the **Interval recurrence fields, verbatim**, so "every N units / weekdays / month-days / months / ad-hoc dates" reuse machinery already trusted (`01-data-model.md` §Interval, `services/…` occurrence logic):

`repeatValue` + `repeatUnit` (+ optional `customRepeatRule` JSON + `customRepeatDates` JSON), with `endTime` to stop. The occurrence resolver that answers "does this interval fire on date D?" is factored so a TimeTheme can call the same code.

Unlike an interval, a theme has **no `estimatedTimeMinutes` and no steps and no scope link**. It has instead a **time-of-day span**: `startTimeOfDay` → `endTimeOfDay` ("HH:mm"), which defines the band within each day it lands on.

## 5. Proposed schema

### New enum
None. Colour is a string (palette key or hex); status reuses `IntervalStatus`.

### `Tag`
`id` (uuid) · `name: String` · `color: String` (palette key/hex) · `userId` → User (Cascade) · `createdAt` · **`@@unique([userId, name])`** · m2m: `projects` `intervals` `routines` `actions` `timeThemes`

### `TimeTheme`
`id` (uuid) · `title: String` · `status: IntervalStatus=active` · `startTimeOfDay: String` ("HH:mm") · `endTimeOfDay: String` ("HH:mm") · **recurrence (Interval-shaped):** `repeatValue: Int=1` · `repeatUnit: RepeatUnit?` · `customRepeatDates: String?` (JSON) · `customRepeatRule: String?` (JSON) · `endTime: DateTime?` · `tags: Tag[]` (m2m) · `userId` → User (Cascade) · `createdAt/updatedAt`

### Additions to existing models
`Project`, `Interval`, `Routine`, `Action` each gain `tags: Tag[]` (implicit m2m — Tag pairs with five distinct models, so no relation-name clash).

> SQLite note: `customRepeatDates` / `customRepeatRule` stay JSON strings parsed in `typeResolvers.ts`, same pattern as Interval (`01-data-model.md` §JSON-string fields).

## 6. API surface (sketch)

- **Tags:** `tags` query · `createTag(name,color)` · `renameTag` · `recolorTag` · `deleteTag` (drops join rows; tagged entities simply lose that tag) · `setTagsOnProject/Interval/Routine/Action(ids)` — the Action mutation **rejects when the action is gathered**.
- **Themes:** `timeThemes` query · `createTimeTheme` · `updateTimeTheme` · `deleteTimeTheme` (no effect on actions — soft) · `setTimeThemeStatus` · `timeThemesForDate(date)` → resolved occurrences with their slots, for the timeline and surfacing.
- **Inheritance hooks:** `actionGathering.ts` copies source tags onto each gathered action; `createAction` (with `projectId`) initialises tags from the project.

## 7. UI surfaces

1. **Tag manager** — list, create, rename, recolour, delete tags. Small, lives in settings/modules.
2. **Tag picker (chips)** on Project / Interval / Routine editors, and on the Action editor.
3. **Action editor** shows inherited tags **read-only with a lock flag** for gathered actions; editable chips for standalone/project actions (project ones pre-filled).
4. **Time Theme editor** — title, tag(s), `startTimeOfDay`→`endTimeOfDay`, and the **same recurrence control the Interval editor uses**.
5. **Day timeline** — themes drawn as colored bands behind actions; in Pre-day / gathering, matching actions surface to the top of a themed slot with a subtle affinity marker (non-matching still selectable).

All new strings in **en + fa** with parity (`i18n:check-missing` / `check-hardcoded`).

## 8. Open questions / deliberately deferred

- **Multi-tag theme band colour** — a theme with several tags renders using its **primary (first)** tag's colour for now; a blended/striped band is deferred.
- **Overlapping themes** — allowed; the timeline stacks bands. No conflict resolution needed since behaviour is soft.
- **Gaps** — a time with no theme is normal and expected ("anything could be there").
- **Tag on goals/milestones** — out of scope: the user chose the four source entities + themes; goals/milestones are not tagged (yet).
- **Retro lens** ("did I honour the theme?" after-day scoring) — out of scope for v1; themes are surfacing + context only.

## 9. Build phases (proposed)

1. **Schema + migration** — `Tag`, `TimeTheme`, m2m on the four entities; regenerate; (canon deferred to after build per owner).
2. **Tag CRUD + tagging API** on Project/Interval/Routine/Action, with the gathered-action lock guard + tests.
3. **Inheritance wiring** — copy-at-gather (`actionGathering.ts`); init-from-project in `createAction` + tests.
4. **TimeTheme CRUD + recurrence resolution** — factor the interval occurrence resolver; `timeThemesForDate` + tests.
5. **Soft surfacing** — ranking of matching actions in gather/Pre-day; timeline bands.
6. **Client UI + i18n** — tag manager, pickers (incl. locked state), theme editor, timeline bands.
7. *(defer per owner's usual pattern: persona review / polish.)*

---

## Changelog
- **0.1-draft · 2026-09-13** — Initial draft. Decisions locked with owner: B (typed periods) only, not A (day subdivision); soft/suggestion binding; first-class `Tag` with colour, shared across Project/Interval/Routine/Action/TimeTheme; X holds actions; gathered-action tags locked (snapshot-copy), project-action tags editable (init-from-project); recurrence reuses the Interval implementation.
