# Journey — **Batteries check** · minimum spec

*Spec, not as-built. Maintain's first tool: read your three batteries now, respond now if one is low or too full, and let the read sit beside a goal as information. Pillar canon: `../../canon/02-pillars/maintain.md` (§2 the three recognitions, §3 immediate action only plus the 2026-10-18 goal-context use, §4 the drift-to-optimization risk). Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-10-18 · Owner: _root**

---

## 1. What it is, and the one risk

A read of **body, mind and spirit** in four words each, then — only if one is low or too full — an offer to do something small for it **now**, drawn from the person's own list. In goal context, the read sits beside the goal so the goal can be sized to it. That is all.

**The risk is the one the canon names:** drift from recognition to optimization (`maintain.md` §4). A battery read is the one place in Journey that is close to a measurement. Every design choice below is there to stop it becoming a gauge, a chart, a target or a schedule.

The founder's own read is that this step is not yet clear. This spec is deliberately minimal so it can be tried before it is designed further; §9 lists what is unsettled.

## 2. Scope

**In:** the read; respond-now from the person's own recharge list; personal signals (*what told you?*); three modes — standalone, goal context, first act; the read shown on the goal it informed.

**Out:** any history view, chart or trend; any reminder or scheduled check; numbers or percentages; gauges; cross-read patterns; recharge "plans"; a Maintain day-one frame (a later act — §9).

## 3. The read

| Battery | Gloss on screen | Words |
|---|---|---|
| **Body** | sleep, food, movement, how your body feels | low · okay · full · too full |
| **Mind** | focus, room to think, mental load | low · okay · full · too full |
| **Spirit** | meaning, connection, feeling part of something | low · okay · full · too full |

- **Words, not a scale.** Four discrete words, no numbers, no slider, no fill level. *Too full* is there because the canon counts overcharge as much as depletion (wired, restless, over-stimulated).
- **Each battery is skippable**, and a skip is written nowhere.
- **The spirit gloss stays plain.** The canon leaves the boundary with the deeper register open (`maintain.md` §7); the gloss does not reach for it.

## 4. Respond now

If any battery reads **low** or **too full**, one screen per battery:

> *"Anything small you can do for your [body] right now?"*

- The person's **own recharge strategies** for that battery are listed (their words, added over time), plus `add one →`.
- Choosing one → *"Go ahead — this can wait."* The act is the point; **whether they did it is not recorded** (a record of doing it would become a compliance log, and a log becomes a streak).
- *"Not now"* is a full answer. If immediate action is not possible, the canon's handoffs apply: a capability gap → Learn, a future commitment → Organize (`maintain.md` §3). The tool offers both as quiet links and pushes neither.

Then, optional: *"What told you?"* → free text, saved as a **personal signal** for that battery (recognition 2). Signals and strategies are two short, editable lists per battery — the person's own vocabulary, which is what the canon asks Maintain to build (`maintain.md` §2).

## 5. The three modes

| Mode | Opened from | After the read |
|---|---|---|
| **standalone** | overview "Check batteries", `/tools/maintain/batteries` | respond-now, then done |
| **goal context** | setting a goal; "check batteries" on a goal page | respond-now, then the read is shown **above the goal form** as one line, with one optional prompt if anything is low: *"Want to size this to what you have right now?"* |
| **first act** | `01-first-act.md` step 3 | as goal context |

**Inform, never gate.** In goal context the goal form is reachable whatever the read says, and no copy says *should*, *before you*, or *first*. A goal set on a low read is shown with that read on its page — *"set on a day when: body low"* — which is information for later (especially for the failure flow), not a judgement.

## 6. Fences = acceptance criteria

| Failure | What it looks like | Guard |
|---|---|---|
| **Gauge** | the read becomes a level to raise | four words, no number, no fill graphic, no "good/bad" colour |
| **Chart** | reads over time become a trend line | no history view at all in the prototype; a read is visible only on the goal it informed |
| **Schedule** | "check your batteries every morning" | no reminder, no interval, no gathered action can open this tool — enforced, not just unbuilt |
| **Target** | "get your body to full" | no goal can be created *from* the batteries tool; respond-now is in the moment only |
| **Compliance log** | did-you-recharge records | whether a strategy was done is never stored |
| **Gate** | a low read blocks planning | §5; no blocking copy |

The schedule fence is the one most likely to be added "helpfully". It is written into the data model comment so it cannot be added quietly (§7).

## 7. Data (illustrative; convention #12 applies on landing)

```prisma
enum BatteryLevel { low okay full over }

model BatteryRead {
  id        String        @id @default(uuid())
  userId    String
  body      BatteryLevel? // null = skipped (a skip is not otherwise recorded)
  mind      BatteryLevel?
  spirit    BatteryLevel?
  context   String        // "standalone" | "goal" | "firstAct"
  goalId    String?       // the goal this read informed, if any
  createdAt DateTime      @default(now())
  // NO history query returns a series of reads. NO scheduled or gathered path
  // creates or opens a read. Adding either turns recognition into a KPI —
  // maintain.md §4, anti-patterns §3. Do not add one without a decision-log entry.
}

model BatteryNote {           // the person's own words, per battery
  id         String    @id @default(uuid())
  userId     String
  battery    String    // "body" | "mind" | "spirit"
  kind       String    // "recharge" | "signal"
  text       String
  archivedAt DateTime? // the person removes it; nothing counts its use
  createdAt  DateTime  @default(now())
}
```

## 8. Evaluation (the seam this owns: batteries → goal)

- **Permission or obstacle?** Retrospective think-aloud on the first act and on goal-setting: does the read help the person size the goal, or feel like being told off? IMI pressure/tension, short form.
- **Does it change anything?** Was the goal resized, or the respond-now taken, after a low read? (Collected, never shown.)
- **Optimization drift.** In the interview at week two: *"Have you found yourself wanting your batteries to read better?"* A yes is a fence failing, whatever the cause.

## 9. Open decisions — this step is the least settled

- **Whether a low read should do more than inform** — e.g. suggest a smaller first step, or offer to delay the start date. The founder's direction today is *inform only*; this spec does exactly that and no more.
- **Whether the person ever sees their own past reads.** Seeing them could build signal-literacy (recognition 1); it also invites the trend line §6 refuses. Proposed: no, until the feel-test.
- **Recognition 1 — what each battery feels like for this person** — needs its own short frame (a Maintain day-one, like Noticing's). Not in the minimum.
- **Capacity and energy over weeks.** "Energy over weeks" appears as an item in the capacity check (`04-capacity-check.md`), because a battery read is about *now* and a goal runs for weeks. Whether that is the right split is unsettled.
- Persian: the three battery names and glosses — authored, not translated.

---

## Changelog

- **0.1 · 2026-10-18** — Initial minimum spec: three batteries in four words each (*too full* counted), respond-now from the person's own recharge list with whether-they-did-it never stored, personal signals, three modes, the read shown on the goal it informed and nowhere else, inform-never-gate. Fences as acceptance criteria, with the no-schedule fence written into the schema comment. Marked the least settled of the five specs, per the founder.
