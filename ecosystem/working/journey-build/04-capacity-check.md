# Journey — **Goal capacity check** · minimum spec

*Spec, not as-built. For one goal the person has already chosen: what will it take, do you have it, and if something essential is missing, a goal to get it that serves the real one. Decision: `../../decisions/decision-log.md` 2026-10-18, item 6. Canon: `../../canon/02-pillars/impact.md` §3 (why this is not the refused self-inventory), `organize.md` §6–§7. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-10-18 · Owner: _root**

---

## 1. What it is — and what it is not

A short check **scoped to one goal**, sitting beside the Clarity Check on that goal. The Clarity Check asks whether the goal is *defined* well enough to act on; the capacity check asks whether the person has *what it takes* to act on it. Both are **non-gating**.

**It is not a skills form.** Impact refused a general self-inventory for evidence reasons — self-report inventories overclaim, and the intersect-your-strengths-with-the-world framing paralyses (`impact.md` §3). That refusal stands. This check avoids both failures by construction:

- **It only ever exists against a goal already chosen** — there is no screen where a person inventories themselves, and no way to open the check without a goal.
- **It asks about concrete needs, not about ability.** Never *"how good are you at…"*; only *"does this need X, and do you have X?"*, answered *have it · some · not yet*. Overclaiming a rating is easy; overclaiming *"I have two hours a week for this"* is harder, and the failure flow checks it later (§6).

## 2. Scope

**In:** the experience question; what the goal takes; have / some / not yet per item, with an optional note; *can this go ahead without it?*; a capacity goal that serves the real one; the panel on the goal page; re-running the check; the walk back when a capacity goal is achieved.

**Out:** any general or cross-goal view of "your capacities"; ability ratings; scores, traffic lights or a readiness percentage; automatic suggestions of what a goal needs.

## 3. The check

| # | Prompt | Input |
|---|---|---|
| C1 | *"Have you done something like this before?"* | *yes · partly · not yet* |
| C2 | *"What will this take?"* | multi-select: **time · money · know-how · other people · tools or a place · energy over weeks** · `other → type it` |
| C3 | for each item picked: *"Do you have it?"* | *have it · some · not yet* + optional one-line note (*"about two hours a week"*, *"need to ask my brother"*) |
| C4 | for each *not yet*: *"Can this go ahead without it?"* | *yes, I'll manage · no, it can't* |
| C5 | for each *can't*: *"Set a goal to get it?"* | *yes →* the goal form (§4) · *not now* |

**Close:** a two-line summary in the person's words — *have:* … · *not yet:* … — and the check is saved to the goal.

**Energy over weeks is here on purpose.** The batteries read is about *now* (`03-batteries-check.md`); a goal runs for weeks. Whether this split holds is open in both specs.

**Know-how links to the one thing.** In the first act, a *know-how: not yet* note is offered at the one-thing step as *"Is it this?"* (`01-first-act.md` §3.6). They are different questions — the capacity check asks what the goal **cannot go ahead without**, the one thing asks what would make it **much easier** — and they often have the same answer.

## 4. Capacity goals — the super-goal link

A capacity goal is an ordinary `Goal` with one extra field, **`servesGoalId`**, pointing at the goal it exists for.

- **Created through the normal goal form**, title pre-filled from the person's own C3 note (*"Get: know-how — how to file the council request"*), editable. The Clarity Check is offered as usual.
- **Not part of the structural tree.** Tracker's tree is single-parent by decision (D-4), and its status cascade runs up that tree. `servesGoalId` is a **separate relation**, so the cascade, goal groups and D-4 are untouched. A goal can both sit in a goal group *and* serve another goal.
- **On the real goal**, the panel says *waiting on: [capacity goal]* — information, never a lock. The real goal can be worked on, edited or closed whatever state its capacity goals are in.
- **On the capacity goal**, a line says *serves: [real goal]*, with the real goal's *why* if it has one.
- **When a capacity goal is closed as achieved**, the person is walked back: *"Back to [real goal]?"* → the C3 item flips to *have it* (one tap to confirm) and the real goal opens.
- **When the real goal is closed**, open capacity goals serving it are listed: *close these too?* — never closed silently.
- **Depth.** A capacity goal can have its own capacity check and its own serving goal, up to `maxServeDepth` (2). Beyond that the form says, without judgement, *"That's three goals deep — worth checking the first one is still what you want?"* and allows it. Long chains of preparation are a known way to avoid starting; the line points at that and stops there.

## 5. Where the check is opened

| From | Notes |
|---|---|
| first act, step 5 | on the goal just set |
| a goal page, *"What this takes"* panel | any goal, any time; re-running edits the same check |
| the failure flow, when *"didn't know how"* or *"didn't have what it took"* is chosen | opens the check with that item pre-picked (`05-failure-and-ignoring.md` §4) |

## 6. Keeping it honest over time

Self-report at the start of a goal is the least reliable moment. Two later moments correct it, both already in other specs:

- **The failure flow asks** *"did you know what it would take?"* and, on *no / partly*, routes back here (`05-failure-and-ignoring.md` §4, F3).
- **Closing a goal as achieved asks** *"what did you have that made this possible?"* — head / hands / heart, Noticing's chips reused. That is Impact's emergent capacity (`impact.md` §3) — capacity read back from what the person *turned out* to have — arriving through Organize. Whether it joins Noticing's portrait is open (§10).

## 7. Fences = acceptance criteria

| Failure | What it looks like | Guard |
|---|---|---|
| **The skills form** | a self-portrait to fill in | no screen without a goal; no ability questions; no cross-goal capacity view |
| **Paralysis** | the check becomes a reason not to start | non-gating; *yes, I'll manage* is the first option at C4; the summary is two lines |
| **Readiness score** | a traffic light or a percentage | none, structurally — the model has no status field |
| **Preparation as avoidance** | goals to prepare for goals to prepare for… | `maxServeDepth` and its one honest line; the real goal stays workable throughout |
| **Authored capacity goals** | Root decides what you need | titles only from the person's own note; Root never proposes what a goal takes |

## 8. Data (illustrative; convention #12 applies on landing)

```prisma
model CapacityCheck {
  id         String   @id @default(uuid())
  goalId     String   @unique   // exactly one per goal; re-running edits it
  userId     String
  experience String?  // "yes" | "partly" | "notYet"
  items      String?  // JSON: [{ kind, other?, status: "have"|"some"|"notYet", note?, essential?: boolean, servingGoalId? }]
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt
  goal       Goal     @relation(fields: [goalId], references: [id], onDelete: Cascade)
  // No status, score or readiness field — deliberately. See §7.
}

// Goal gains:
//   servesGoalId String?   — self-relation "Serves", onDelete: SetNull
//   serves       Goal?     @relation("Serves", fields: [servesGoalId], references: [id], onDelete: SetNull)
//   servedBy     Goal[]    @relation("Serves")
// Not part of the structural tree: D-4 and the status cascade ignore it.
```

## 9. Evaluation (the seam this owns: goal → capacity)

- **Inventory feel or useful check?** Think-aloud: *"did this feel like describing yourself or like planning the goal?"* The first is a fence failing.
- **Realism.** At two weeks: was anything marked *have it* actually missing? (Read from the failure flow's *did you know what it would take?* — collected, never shown.)
- **Capacity goals.** How often the first act ends in one, and whether people come back to the real goal afterwards. A capacity goal that never returns to its super-goal is the avoidance pattern §4 warns about.

## 10. Open decisions

- Whether an achieved goal's *what did you have* answers join **Noticing's capacity portrait** or stay with the goal. Joining them makes one emergent portrait across the loop; it also means Organize writes into an Impact surface.
- Whether **C2's list** is right — *energy over weeks* in particular (`03-batteries-check.md` §9).
- Whether more than one capacity goal per check should be encouraged, or the form should suggest starting with the most blocking one. Proposed: allow several, suggest one.
- Persian: the six item labels.

---

## Changelog

- **0.1 · 2026-10-18** — Initial minimum spec: a check that only exists against a chosen goal and asks about concrete needs rather than ability (why it is not Impact's refused inventory); have / some / not yet; *can it go ahead without it*; capacity goals linked by a **non-structural** `servesGoalId` so D-4 and the cascade are untouched, with a walk-back on achievement and a soft depth line; honesty corrected later by the failure flow and the achieved-close question; no score field anywhere.
