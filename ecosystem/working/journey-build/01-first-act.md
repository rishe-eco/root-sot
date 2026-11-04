# Journey — **The first act** · minimum spec

*Spec, not as-built. The first thing anyone does in Journey: one pass through the whole loop, starting outward, ending in a goal. It wires together four other specs in this folder and adds the overview the person lands on afterwards. Decision: `../../decisions/decision-log.md`, 2026-10-18. Canon: `../../canon/02-pillars/00-the-loop.md` §5. Update the changelog; don't fork.*

**Version 0.2 · Status: spec · 2026-10-18 · Owner: _root**

---

## 1. What it has to prove

The child version is an MVP, so the first act has to **deliver real value the first time**, not explain the product. The value is this: *a person leaves with a goal that is theirs, for a need they actually saw, sized to what they actually have, and with the one thing that would make it easier already named.* Every step must be justified by what it contributes to that goal.

That is also the test of the decision behind it. If the first act feels like an onboarding form, or produces goals the person does not recognise as their own, the loop-first bet has failed at its first seam.

## 2. The sequence

| # | Step | Pillar | Spec | What it hands on |
|---|---|---|---|---|
| 0 | **Opening** — one screen, no pillar names | — | §3.0 | — |
| 1 | **Name a need** — one place, one person, what you saw, what it might point to | Impact | Noticing's loop (`../impact-build/01-noticing-spec.md` §4.2) | a `NoticingEntry` with an observation and a need |
| 2 | **Reflect on it** — why it matters to you, care or *should*, what you'd like to do, what's in the way | Reflect | `02-reflect-minimum.md`, need entry | intent, obstacle, motive |
| 3 | **Check your batteries** | Maintain | `03-batteries-check.md`, goal context | a read that sits beside the goal |
| 4 | **Set the goal** | Organize | Tracker's goal form + Clarity Check | a `Goal` that knows where it came from |
| 5 | **Check capacity for this goal** | (Organize) | `04-capacity-check.md` | what it takes; a capacity goal if something essential is missing |
| 6 | **Name the one thing** | Learn | §3.6 | `Goal.oneThing`, or an explicit *nothing* |
| 7 | **Close** → the overview | — | §3.7, §5 | — |

Batteries come before the goal and capacity after it, deliberately. Energy is about *now* and shapes how big a goal to write. Capacity only means something against a specific goal, and the founder's direction is to tie it to one (decision log 2026-10-18, item 6).

**Time.** Target ≤ 15 minutes (`firstActTargetMinutes`, a dial for the evaluation, not a timer anywhere). **Resumable across days:** every step commits as it goes (Tracker convention #8), and reopening the app returns to the first unfinished step.

## 3. Step detail

### 3.0 Opening
One screen. What the person is about to do, in one or two sentences, and nothing about pillars, loops or Root: *start with something you noticed near you; leave with a goal you want to pursue.* One button. No slideshow.

### 3.1 Name a need *(Impact)*
**Reuse Noticing's loop as built**: place → person → observation → need, with its palette, its catches and their cooldowns. The entry is a real `NoticingEntry` in a real `NoticingSitting`, so it shows in Noticing's log like any other pass. Two differences, both first-act-only:

- **The small-thing step is skipped.** Reflect does that job next, with more room.
- **"Not sure" does not move the act forward.** In Noticing it is a complete pass; here the act needs a need. It gets an honest line — *"That's a fine answer. Try another moment, or start a noticing practice and come back when one stands out"* — with both options.

**No need comes to mind** (`can't think of one →`, available from the place step on) → the **noticing path** (§4.2).

Noticing's day-one frame is **not** run here (it is ~8 minutes and would double the act). It is offered inside the noticing path, where it belongs.

### 3.2 Reflect *(Reflect)*
`02-reflect-minimum.md`, need entry: what you saw (carried from step 1), what it stirs, what you care about, the side-by-side mirror, **care or *should***, what you'd like to do, what's most likely to get in the way, and an optional if-then. Its close is fixed to *carry on to the goal*. The *should* branch is §4.3.

### 3.3 Batteries *(Maintain)*
`03-batteries-check.md` in goal context: body, mind, spirit, four words each. A low or too-full battery gets its respond-now offer **in this moment**, and then the act carries on. **Inform, never gate.**

### 3.4 Set the goal *(Organize)*
Tracker's goal form, with three things added for this context:

- **The title is pre-filled from the person's own intent** (step 2), editable. Root never proposes a goal — the pre-fill is their sentence, moved, not ours.
- **The batteries read sits above the form** as one quiet line, with one optional prompt if anything is low: *"Want to size this to what you have right now?"* Nothing is required.
- **The Clarity Check is offered inline** (existing, non-gating, amber/green).

The goal stores `originReflectionId`. The goal page then shows **why it exists** — *"You noticed: …"* — for as long as it is open. Keeping the outward purpose in view while the work gets dull is the point (a self-transcendent purpose sustains effort on tedious tasks — Yeager et al., 2014).

### 3.5 Capacity for this goal
`04-capacity-check.md`. If something the goal **cannot go ahead without** is missing, the person may set a **capacity goal that serves this one** (§4.1).

### 3.6 The one thing *(Learn)*
> *"If you already knew how to do one thing, what would make this much easier?"*

- **Root offers questions, not answers** — three authored prompts beside the field: *Which part feels slowest or least clear? · What would someone who has done this before know? · Who could you ask?*
- **"Nothing — I know how to do this"** is a full answer, one tap, and is not followed up.
- If the capacity check recorded **know-how: not yet**, its note is offered as *"Is it this?"*
- Once named, three short **guides** for *how* to learn one thing are offered (authored, a card each): *ask someone who knows · find one good source, not ten · try a small version and look at what happens.* The person may pick one; nothing is assigned.

Stored on the goal (`oneThing`, `oneThingAnsweredAt` — the second distinguishes *nothing* from *not asked yet*). The goal page shows it next to the why. **No first project or action is created for the person**; the goal page offers "plan it", which opens Tracker's normal project/action creation under the goal.

### 3.7 Close
One screen: the need, the goal, the capacity goal if there is one, the one thing. *"This is yours now."* Then the overview. `firstActCompletedAt` is set.

## 4. The paths that end differently — all of them in a goal

### 4.1 Capacity is short
From step 5. A **capacity goal** goes through the same goal form, titled from the person's own note, with `servesGoalId` pointing at the real goal. The real goal stays open and shows *waiting on: …* as information, never as a lock. Steps 6–7 run on the real goal. When the capacity goal is closed as achieved, the person is walked back to the goal it serves. Detail: `04-capacity-check.md` §4.

### 4.2 No need comes to mind — the noticing path
The first act ends in a goal anyway: **finding a need is the goal.**

1. Noticing's **day-one frame is offered** (skippable).
2. A goal is proposed with an **editable** title (*"Notice one need I want to do something about"*) and definition of done (*"I've named a need and decided what I'd like to do about it"*). Proposing a goal is a step towards authoring, so it is limited to this one scaffold, which is about the practice and not about the person's life, and the person confirms or rewrites it.
3. The person picks **when they will practise** — days of the week, default three. This creates an `Interval` linked to the goal, whose gathered actions open Noticing.
4. The first act is **complete** — it ended in a goal.

**Finding one later.** Noticing's close gets one new option when a pass has a need: **"work on this →"**. It opens the **need → goal path** — steps 2–6 of this spec on that entry — and offers to close the noticing goal as achieved. The need → goal path is not first-act-only: it is how any need becomes a goal from now on.

**A consequence for Noticing that has to be said.** Noticing's spec rests on *the app never cues anyone*; its `wasPrompted` field is hardcoded false and its graduation detector is built on that (`../impact-build/01-noticing-spec.md` §4.5). An interval the person sets is their own commitment, not the app nudging them — but it is a cue all the same, and gathered actions will put Noticing on their Today. **`wasPrompted` becomes real for sittings opened from a gathered action**, and the graduation detector has to be revisited before it is trusted for these users. Recorded here so the Noticing build is changed on purpose, not by accident.

### 4.3 The motive check finds *should* — **decided: the person may keep it**
Reflect surfaces it, reconstrues once (`02-reflect-minimum.md` §4.4), and asks whether part of this is something the person would want to do even if no one knew.

- **Yes** → back to intent, reshaped around that part → carry on.
- **No** → let it go → the noticing path (§4.2), so the act still ends in a goal.
- **"I'll do it anyway"** → **allowed** (founder, 2026-10-18). The goal is set like any other; the motive answer stays on the reflection; nothing on the goal page marks it. If the goal later goes quiet, the gone-quiet look asks about it **once** (`05-failure-and-ignoring.md` §5). The Loop §4's *stopped here* is read as *not passed unexamined*: the person has seen the motive and been offered two other ways, and the choice is theirs. Refusing would mean the app overruling the person on their own motive.

## 5. The overview — where the person lands afterwards

Route `/journey`. **Free of metrics:** no counts, no totals, no streaks, no percentages beyond the goal-progress information Tracker already shows (decision log 2026-07-29).

| Section | Shows | Never |
|---|---|---|
| **Working on** | open goals; serving goals nested under the goal they serve; each with its *why* when it has one | ordering by "progress", any score |
| **Gone quiet** | goals gone quiet and actions carried a long time (`05-failure-and-ignoring.md`), as items with a *look* | a number, red, warning icons |
| **Recently** | the last few things noticed and reflected on, grouped by day | patterns, "you often…" |
| **Start something** | Notice · Reflect · Check batteries · New goal | — |

**Free movement.** Once the first act is complete the whole app is open, Today and the tools included, in any order.

## 6. Data (illustrative; convention #12 applies on landing)

```prisma
model JourneyState {            // one per user; the first act's place, resumable
  id                  String    @id @default(uuid())
  userId              String    @unique
  needEntryId         String?   // the NoticingEntry step 1 wrote
  reflectionId        String?   // step 2
  goalId              String?   // step 4 (or the noticing-path goal)
  path                String?   // "need" | "noticing" — which ending
  firstActCompletedAt DateTime?
  createdAt           DateTime  @default(now())
  updatedAt           DateTime  @updatedAt
}
// The current step is DERIVED from which links are set and whether the goal has
// a capacity check and a oneThingAnsweredAt — never stored as a step number.

// Goal gains (this spec): originReflectionId String?, oneThing String?, oneThingAnsweredAt DateTime?
// Goal gains (04): servesGoalId.  Goal gains (05): closedAt, closedAs, quietLookAfter.
```

## 7. Failure modes = acceptance criteria

| Failure | What it looks like | Guard |
|---|---|---|
| **The form** | the act feels like onboarding paperwork | one opening screen, no slideshow; every step feeds the goal; resumable; target ≤ 15 min |
| **An authored goal** | the goal reads as Root's idea | title only ever pre-filled from the person's own words; the noticing-path scaffold is the one proposed goal, and it is editable |
| **Obligation in, goal out** | a *should* walks straight into Organize | Reflect's motive check and its reconstrual step; the *should* catch on every free-text field |
| **A gate in disguise** | low batteries or a capacity gap stop the goal | both inform; the goal form is always reachable; no "you may not" copy anywhere |
| **Guilt on the noticing path** | the practice reads as a test failed | the noticing goal is a real goal with its own dignity; no copy suggests the person was supposed to have a need |
| **Dossier** | the first need becomes a file on someone | Noticing's fences carry over unchanged (`../impact-build/01-noticing-spec.md` §7) |

## 8. Dials

| Dial | Provisional | Why it's a dial |
|---|---|---|
| `firstActTargetMinutes` | 15 | an evaluation threshold, never a visible timer |
| `noticingPathDefaultDays` | 3 per week | the person changes it; too many reads as a regimen |
| `oneThingPromptCount` | 3 | more becomes a worksheet |

## 9. Per-seam evaluation (engine §7)

Founder plus 2–4 testers, retrospective think-aloud on the first act and once a week after (the method from `../impact-build/03-spine-evaluation.md` §2A).

| Seam | The pre-written question | Signal (collected, never shown) |
|---|---|---|
| need → reflect | Does the reflection stay with the need, or drift to the self? | think-aloud coding; whether the intent mentions the person or place noticed |
| reflect → goal | Is the goal the person's own sentence? | how far the title was edited from the intent; "is this yours?" in the interview |
| batteries → goal | Did the read feel like permission or like an obstacle? | think-aloud; whether the goal was resized after a low read |
| goal → one thing | Is the one thing a real lever or a filler answer? | at a week: was it acted on, was it the right thing |
| first act → after | Does the person come back to the goal without being cued? | first return within 7 days; which overview section they enter from |

**Stop rule, written before the data:** if two of the first three testers describe the first act as something they *completed* rather than something they *started*, the sequence is redesigned before anything else is built on it.

## 10. Open decisions

- Whether **new users are held in the first act** until it completes, or only offered it. Proposed: new users land in it; existing users (the team) are offered it once from the overview.
- Whether `/journey` replaces Today as the **landing page** after sign-in. Proposed: yes for the child version; Today stays one tap away and keeps its Pre-day gate.
- Whether the old **first-login slideshow** retires. Proposed: yes, for new users; the first act replaces it.
- Persian names: the first act, the overview.

---

## Changelog

- **0.1 · 2026-10-18** — Initial minimum spec from the 2026-10-18 decision: the seven-step sequence, Noticing reused for step 1, batteries before the goal and capacity after it, the one thing with questions and guides and an explicit *nothing*, three endings that all land in a goal (capacity goal; noticing practice; the open *should* case with a proposed default), the metric-free overview, `JourneyState` with a derived step, per-seam evaluation and a stop rule. Records the consequence for Noticing's `wasPrompted` and graduation detector.
- **0.2 · 2026-10-18** — §4.3 decided by the founder: a *should* goal **may be kept**; the motive stays on the reflection, nothing marks the goal, and the gone-quiet look asks about it once. Removed from §10.
