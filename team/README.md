# Root · ریشه — Team

*The third area of root-sot. Who is doing what, and the work that is waiting on a person rather than on code. Update the changelog; don't fork.*

**Version 0.1 · Status: living · 2026-08-01 · Owner: _root**

---

## Why this area exists

`ecosystem/` owns the *why*, `tracker/` owns the *what and how*. Neither has a good home for **work that is blocked on a human being available**, and that turned out to be the binding constraint the moment the Skills Engine started shipping.

The pattern that forced it: Clarity Lab and Evidence Lab are both **built and both gated** — not on engineering, but on content verification, native-speaker review, and a scoring-calibration pass. Those are hours of careful human attention, they are the difference between a tool that trains and a tool that measures, and they were invisible in a canon organised around code and concept.

So this area holds two things:

- **`open-work.md`** — the queue: what is waiting, on whom, why it blocks what, and how long it should take. Each item is written to be handed over without a briefing conversation.
- Later, as the team grows: who holds what, and the working agreements that are neither philosophy nor architecture.

## House rules

- **An item here names its blocker, not just its task.** "Verify the Evidence answer keys" is a task. "The scored baseline cannot run until these are verified" is why anyone should care.
- **Estimate in hours, honestly.** These are volunteer-adjacent hours from a small team. An item with no estimate does not get picked up.
- **Link the brief, don't restate it.** Where a task has a written work order (`tracker/canon/06-specs/02a-...`), this queue points at it and stays short.
- **Delete finished items.** The decision logs are the permanent record; this is a worklist, and a worklist that keeps its history stops being read.

## Map

```
team/
  README.md      this file
  open-work.md   the queue — work blocked on a person
```

---

## Changelog

- **0.1 · 2026-08-01** — Created. Prompted by the Skills Engine shipping into a state where every remaining gate is human rather than technical.
