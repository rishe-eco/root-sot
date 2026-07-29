# Tracker — The Daily Cycle

*Source of truth. The rhythm the app is built around, and the state machine that enforces it. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built (model + flow) / inferred (step-level detail, marked) · 2026-07-22 · Owner: _root**

---

## 1. The gate

The daily cycle is not a suggestion — it is enforced by `DayState`. The order is:

```
After-day (yesterday)  →  Pre-day (today)  →  Today  →  After-day (today)  →  gathering → …
```

You cannot access **Today** until **Pre-day** is complete. You cannot complete a new day's Pre-day cleanly until the **previous** day's After-day is closed. The rhythm is the product: it guarantees that scheduled work is either done or *consciously disposed of*, never silently dropped.

## 2. DayState — the day's state machine

One `DayState` row exists per user per `dateKey` (`"YYYY-MM-DD"`), with three timestamps:

| Field | Meaning | Set by |
|---|---|---|
| `afterDayCompletedAt` | After-day wizard closed for this day | `completeAfterDay` |
| `actionGatheringCompletedAt` | Gathering has run for this date (internal) | `runActionGathering` |
| `preDayCompletedAt` | Pre-day done; Today accessible | `completePreDay` |

`preDayStatus(date)` reads these to answer: is After-day required first? can Today be accessed? which actions still need a time? which actions overlap?

## 3. Pre-day — the morning ritual

A guided flow that must be completed before Today unlocks. Steps (component: `PreDayWizard.tsx`):

1. **(Conditional) After-day for yesterday** — if yesterday's After-day wasn't done, it runs first, embedded here.
2. **Day overview** — all timed actions in chronological order, plus a list of untimed tasks. Overlaps shown in amber.
3. **Set times for untimed tasks** — for each timeless action, the user must resolve it: set a time, postpone, outsource, ignore (standalone only), or pass (interval-gathered only). Overlap warnings update live.
4. **Final overview & begin** — read-only chronological review; "Begin" sets `preDayCompletedAt` and unlocks Today.

**Overlap detection:** two actions overlap when their `[start, start + estimatedTimeMinutes)` windows intersect. If the user submits times that still overlap, a confirmation dialog appears before proceeding — overlaps are a warning, never a block.

## 4. Today — the primary view

Gated behind Pre-day. Shows the day's actions in two sections: **Linked** (project-linked or gathered) and **Standalone**. The user can quick-add a standalone action inline (title, date, estimated time, time of day), toggle actions done, and open the After-day wizard at any time. Gathered actions appear here only on their `forDate`.

> Grounding note: Focus Mode is present only as an `UnderConstruction` placeholder in Today — not built.

## 5. After-day — the evening ritual

An end-of-day flow to process unfinished actions and close the day. It must be completed for a given day before the next day's Pre-day runs cleanly. Steps (component: `AfterDayWizard.tsx`):

1. **Mandatory linked actions** — gathered interval-linked actions not done must be explicitly handled: **Postpone** (pick a new date), **Outsource** (creates two follow-up actions), **Not important** (→ Backlog), or **Pass** (→ PassedArchived).
2. **Standalone actions** — optional. Postpone, outsource, ignore (→ BucketList), or delete each unfinished standalone action.
3. **Day that passed** — read-only summary of what was completed.
4. **Tomorrow review** — a read-only preview of tomorrow's actions. *Hidden when After-day is embedded inside Pre-day* (an intentional asymmetry; see bug **B-9**).

**Auto-archiving:** non-linked gathered actions (routines, unscoped intervals) are archived to `PassedArchived` without user input when After-day opens — the user is only asked about work they committed to via a scope link.

**On completion:** `completeAfterDay` sets `afterDayCompletedAt`, then `runActionGathering` fires for today / tomorrow / day-after.

## 6. Action fates — the disposition vocabulary

Every unfinished action leaves the daily flow through exactly one **fate**, written to `Action.actionFate`:

| Fate | Meaning | Applies to |
|---|---|---|
| `Postponed` | rescheduled to a new date | any |
| `OutsourceWoo` | delegated; two follow-up actions created | any |
| `Backlog` | not important | linked actions |
| `BucketList` | ignore | standalone actions |
| `PassedArchived` | passed / auto-archived | non-linked gathered |

> **Known data-integrity caveat (as of the June-10 audit; verify against current code):** `Postponed` is written as a terminal fate, but the Today/Pre-day/After-day queries exclude any action with a non-null `actionFate`. A postponed action can therefore vanish from the flow entirely on its new date. This is bug **B-10** in `04-roadmap/01-known-issues-and-debt.md`; treat `Postponed` as the one fate that should behave transitionally.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Flow and DayState are as-built; step-level wizard detail carried from the platform doc and marked where it drops to inference.
