# Journey — **Failure and ignoring** · minimum spec

*Spec, not as-built. What happens when pursuit stalls: an action that keeps moving, a goal gone quiet, a goal that ends without being achieved. One short structural read for all three, effort kept apart from outcome, letting go treated as a decision, and a route back into the loop. Canon: `../../canon/02-pillars/organize.md` §3 (mindset first), §4 (understanding, not fixing), §5 (failure handling — "a gap the concept must close"). Tracker side: `../../../tracker/canon/04-roadmap/02-refactor-toward-root.md` §3 lists this as missing. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-10-18 · Owner: _root**

---

## 1. Why ignoring is in the same spec

Failure is rarely announced. Mostly a goal just **goes quiet**, or an action keeps getting **moved to another day**, until it has quietly failed without anyone deciding anything. A failure mode that only runs when someone clicks *"this failed"* misses most failures. So this spec covers three moments, and gives each the same short read:

| Moment | What triggers it | Today in Tracker |
|---|---|---|
| **A · carried** | an action postponed again, a long time after it was first due | postponing works (B-10 is fixed in code: `postponeAction` clears the fate), but nothing remembers the original date, so nothing can notice the drift |
| **B · gone quiet** | an open goal with nothing done recently and nothing planned ahead | not detected; goals have no "quiet" concept |
| **C · closed** | the person ends a goal as *achieved*, *let go* or *didn't work* | **goals cannot be closed at all** — they are "done" only when the status cascade says every child is done |

Actions whose date has passed already show a badge, **"Ignored"** (`ActionPreview.tsx`). That word is a verdict on the person, so it is renamed (§7).

## 2. The stance, narrowly held

Growth mindset is graded **moderate** in the canon and used narrowly (`04-research/00-evidence-summary.md` §8). Average effects of mindset interventions on achievement are weak (Sisk et al., 2018). So this spec does **not** claim to install a mindset. It takes four narrower, better-supported moves:

1. **Separate effort from outcome** (`organize.md` §5) — you own what you tried, how and what you learned; you do not own the outcome.
2. **Meet failure with self-compassion, not self-criticism** — taking an accepting view of a failure *increases* the motivation to improve (Breines & Chen, 2012). That is Reflect's friend's view, reached from here.
3. **Make letting go a legitimate decision, and offer a way back in** — the ability to disengage from goals that cannot be reached *and* to re-engage with new ones both track wellbeing, and work together (Wrosch et al., 2003).
4. **End with an if-then** where there is a next time — implementation intentions have a medium effect on goal attainment (Gollwitzer & Sheeran, 2006).

## 3. The frame — once, felt, at the first look

`organize.md` §3: the frame comes first, briefly and felt. It runs **once**, the first time any look opens (A, B or C), and not at sign-up, when there is nothing for it to land on.

Two steps, on the Module 1 and Noticing pattern of the person supplying the material:

1. *"Think of something you dropped once and later came back to, or did differently the second time. What changed?"* — one line.
2. Their answer, shown back: *"That's the whole move. Look at what happened, change something, go again. Stalling is information about how you pursue things — not a verdict on you."*

Stored via Tracker's existing `ModuleIntroViewed` (moduleKey `journey-look-frame`). Skippable. Never shown again.

## 4. The look — one short read, three doors

**The core question, the same in every moment:** *"What's been in the way?"*

| Answer (single choice + text) | Where it goes |
|---|---|
| **no time** | *"Smaller, or a different day?"* → edit or split the action / new date |
| **not sure how** | → the goal's capacity check with **know-how** pre-picked (`04-capacity-check.md` §5), or name it as the goal's one thing |
| **didn't have what it took** | → the capacity check with the item to choose |
| **didn't want to** | → Reflect, failure entry (`02-reflect-minimum.md`), or let it go |
| **forgot** | *"Fine. New date?"* — nothing else. Forgetting is not a lesson. |
| **outside my control** | *"That part wasn't yours. Was there a part that was?"* → new date / let go |
| **it stopped mattering** | → let it go (§6), with no follow-up question |

### A · carried *(an action)*
**Trigger:** the person postpones an action (in After-day, Pre-day or the action's own postpone) **and** it is now `carryDays` or more past its `firstDueOn` **and** it has not been looked at in the last `lookCooldownDays`.
**Surface:** one line under the postpone control, never a modal: *"This has been moving since 3 Oct. Want to look at it?"* Dismissing it costs nothing and is recorded only as `lookedAt` (the cooldown), never as a refusal.
**Dates, not counts.** The line says *since when*, never *how many times* — the same rule Noticing's state follows (*when* something happened, never *how often*).
**Gathered actions** (from intervals and routines) use the same rule on their own `forDate`; *pass* stays what it is — a normal outcome, never counted.

### B · gone quiet *(a goal)*
**Detected** (in a service, `goalQuiet.ts`), a goal is quiet when **all** hold: it is open (not closed); it is older than `quietDays`; **no action under it is dated within the last `quietDays`**; **nothing under it is dated ahead** (no future-dated action, no active interval); and its `quietLookAfter` is unset or past. "Under it" is walked through its projects (direct and via milestones) and intervals. Goal groups are skipped in the minimum (their cascade is known-incomplete — B-15).
**Surface:** the overview's *Gone quiet* section and the goal page — the goal's name, *"nothing planned since 12 Sep"*, and *look*. No count of quiet goals anywhere.
**The look opens with one question first:** *"Do you still want this?"*
- **yes** → *What's been in the way?* (table above) → usually: plan a next step (the goal page) or the capacity check.
- **not now** → `quietLookAfter` = today + `quietSnoozeDays`. Snoozing is a decision; it is not asked about again until then.
- **no** → the close, as *let go* (§6).

### C · closed *(a goal)*
A new **Close goal** control on the goal page, three ways:

**achieved** →
- optional: *"What did you have that made this possible?"* — head / hands / heart, Noticing's chips reused (`04-capacity-check.md` §6);
- if it **serves** another goal → *"Back to [goal]?"* (`04-capacity-check.md` §4);
- if other goals **serve it** and are still open → *"Close these too?"*

**didn't work** → the structural read (`organize.md` §5's four questions, made short):

| # | Prompt | Input |
|---|---|---|
| F1 | *"What part was yours — what you tried, how?"* | free text |
| F2 | *"What part wasn't — the outcome, other people, circumstances?"* | free text |
| F3 | *"Did you know what it would take?"* | *yes · partly · no* → on *partly/no*: *"What was missing?"* → offered to the capacity check of the next attempt |
| F4 | *"What did you learn?"* | free text · skippable |
| F5 | *"Next time, if ___, then I'll ___."* | optional if-then |
| F6 | *"What now?"* | **try again** (a new goal, pre-filled from this one, editable) · **build what was missing** (a capacity goal) · **reflect on it** (Reflect, failure entry — the meaning side, `organize.md` §5) · **close here** |

F1 and F2 are the effort/outcome split, and they come first, on purpose: the person names their own part before anything asks what went wrong.

**let go** → lighter:
- *"What made you let it go?"* — *it stopped mattering · it wasn't mine to do · not now · it cost too much · other* · skippable;
- then the re-engagement offer: *"Is there something you'd rather put this into?"* → Notice · New goal · *not now*. Re-engaging is half of what Wrosch found; the offer is made once and not repeated.

**Closed goals can be reopened.** `closedAt` back to null, no penalty and no note on the goal.

**Closing and the cascade.** Tracker's status cascade still derives *done* from children. `closedAs` is the person's word and **wins for display**: a goal closed as *let go* is not shown as "in progress" because some child action is open. Open actions under a closed goal are listed at close time with *let them go too?* (→ the existing BucketList/Backlog fates).

## 5. Where the look connects

- **Reflect** (failure entry) receives the look with its goal or action; its friend's view (R5b) is the self-compassion move; it returns here with `outcome = returned` (`02-reflect-minimum.md` §4.5).
- **Capacity** receives *not sure how* / *didn't have what it took* / F3's *what was missing*.
- **Batteries.** If the goal was set on a low read, the look shows it as one line of context (*"set on a day when: body low"* — `03-batteries-check.md` §5). Not a reason, just there.
- **The motive.** If the goal's origin reflection recorded *should* (`01-first-act.md` §4.3), the gone-quiet look adds one optional question: *"When you set this, part of it felt like a should. Is that still part of it?"* This is the gentle follow-up that keeping a *should* goal comes with (founder decision, 2026-10-18). It is asked **once per goal**, is skippable, and its answer is not stored beyond the look.

## 6. Letting go

Letting go is offered **on equal footing** with trying again, everywhere: same size, same position, never last, never grey. Copy: *"Letting go is a decision, not a failure."* It never asks for a justification beyond the one skippable question. An action let go takes Tracker's existing fate (BucketList for standalone, Backlog for linked); a goal let go is closed as `letGo`.

## 7. Language — the rules that apply to every screen here

- **Process words, never trait words.** *"what you tried"*, *"what got in the way"*; never *"you failed"*, *"you're behind"*, *"you missed"*. A goal *"didn't work"* — the attempt, not the person.
- **Rename the "Ignored" badge** to **"Date passed"** (en; Persian authored), with a neutral colour. The postpone button beside it stays.
- **No counts:** no *"postponed 5 times"*, no *"3 goals have gone quiet"*. Dates only.
- **No red, no warning icons** for carried, quiet or closed-as-didn't-work.
- **Nothing is ever marked overdue in the overview.**

## 8. Failure modes = acceptance criteria

| Failure | What it looks like | Guard |
|---|---|---|
| **Nagging** | the look appears every time | `lookCooldownDays`; one line, never a modal; snooze respected |
| **Blame** | the read feels like a trial | F1 (your part) before anything else; process language (§7); the friend's view one tap away |
| **Rumination** | the look becomes "why am I like this" | the look always ends in a door (§4); the meaning side goes to Reflect, which keeps moving |
| **Guilt ledger** | carried/quiet items pile up as debt | dates not counts; letting go equal; nothing marked overdue |
| **Toxic persistence** | "never give up" by default | *let go* on equal footing; re-engagement offered after it |
| **Learned helplessness** | "it didn't work, so effort is pointless" | F1/F2 split effort from outcome; F5 if-then gives the next attempt a shape |

## 9. Data (illustrative; convention #12 applies on landing)

```prisma
enum GoalCloseKind { achieved letGo didntWork }

// Action gains:
//   firstDueOn DateTime?  — the first date it was given (tbd, or forDate when gathered);
//                           set once, NEVER moved by postpone. The source of "moving since".
//   lookedAt   DateTime?  — when a carried look was last offered or opened (cooldown only).

// Goal gains:
//   closedAt       DateTime?
//   closedAs       GoalCloseKind?
//   quietLookAfter DateTime?   — "not now" snooze for the gone-quiet look

model PursuitLook {             // one look, at any of the three moments
  id            String    @id @default(uuid())
  userId        String
  moment        String    // "carried" | "quiet" | "closed"
  actionId      String?
  goalId        String?
  stillWant     String?   // quiet: "yes" | "notNow" | "no"
  inTheWay      String?   // §4 table key, or free text
  yourPart      String?   // F1
  notYourPart   String?   // F2
  knewWhatItTook String?  // F3: "yes" | "partly" | "no"
  missing       String?   // F3 follow-up
  learned       String?   // F4
  ifThen        String?   // F5
  letGoReason   String?
  capacityTags  String?   // achieved: JSON head/hands/heart (Noticing's chips)
  decision      String?   // F6 / the door taken
  reflectionId  String?   // if Reflect was opened from here
  createdAt     DateTime  @default(now())
  @@index([userId, createdAt])
}
// No counter of postponements, looks or failures exists anywhere — the
// absence is the fence (same rule as Noticing's schema).
```

**Migration note.** `firstDueOn` is backfilled from the current `tbd`/`forDate` for existing rows, which means existing actions read as "moving since" their *current* date — the true history is gone and is not reconstructed.

## 10. Dials

| Dial | Provisional | Why it's a dial |
|---|---|---|
| `carryDays` | 7 | too short and every postpone triggers a look |
| `lookCooldownDays` | 7 per action | one look a week per thing at most |
| `quietDays` | 14 | a goal with a natural fortnight gap is not quiet |
| `quietSnoozeDays` | 14 | "not now" should mean it |

## 11. Evaluation (the seams this owns)

- **failure → reflect → re-goal.** After a *didn't work* close, does a next goal or a *let go* with re-engagement follow within two weeks? (Collected, never shown.) Re-engagement, not persistence, is the target.
- **Feel.** Interview after the first look: *"did that feel like being judged, or like looking?"* IMI pressure/tension, short form.
- **The quiet detector.** At two weeks, founder review: did it flag goals the person agreed were quiet, and miss none they considered abandoned? A detector people disagree with is worse than none.

## 12. Open decisions

- Whether **goal groups** get the quiet look (needs B-15's cascade first).
- Whether **standalone actions** whose date passed and that were never disposed (After-day step 2 is optional for them) should surface in the overview's *Gone quiet* with a look, or stay as they are with the new *Date passed* badge. Proposed: stay as they are in the minimum.
- Whether a **didn't-work close of a service goal** (outcome not in the person's control — `organize.md` §5's Impact gap) needs its own copy beyond F2.
- Persian: *Date passed*, the three close words, the frame.

---

## Changelog

- **0.1 · 2026-10-18** — Initial minimum spec: three moments (carried, gone quiet, closed) sharing one look; the frame once, at the first look; effort/outcome first in the didn't-work read; letting go on equal footing with a single re-engagement offer; an if-then for next time; dates never counts (`firstDueOn`, `lookedAt`); goal closing (`closedAt`/`closedAs`) for the first time, winning over the cascade for display; the "Ignored" badge renamed. Notes B-10 is already fixed in code (known-issues doc stale).
