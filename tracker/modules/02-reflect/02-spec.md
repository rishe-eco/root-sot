# Reflect — spec

*Module `tracker/modules/02-reflect/` · Track: Module · Phase 2 · Spec, not as-built. One entry at a time that walks a person from an observer's account of one scene, through the feelings and needs in it, to noticing which parts are a reading, and a last look at what they see now. Structured prompts only, no AI. Inputs: `00-intake.md`, `01-research.md`. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-10-21 · Owner: _root**

**Grading.** Everything here is **proposal** until built. Items marked **[F]** were decided by the founder at this step (§2, 2026-10-21). Items under *Decided here, by Claude* are Claude's calls, not the founder's; refuse any of them on review. Research findings keep their grade from `01-research.md` and are cited by its section and source id ([S3] is `01-research.md`'s Sources). Every as-built fact cites its file in `rishe-eco/tracker`; code read at `main @ 5fd71c9`. This session ran below the skill's `high` effort.

**Scope ledger** *(acceptance criteria by area, at each version, against the intake)*:

| Area | Intake | 0.1 |
|---|---|---|
| Data, ownership and the unshareable fence | in scope (storage left open) | 7 |
| Home and resuming | in scope | 4 |
| Pre-check and stopping | **added at spec [F]** (§2 #3) | 6 |
| Story | in scope, wording changed [F] (§2 #1) | 4 |
| Feelings and needs | in scope | 5 |
| Reality check and the interpretation catch | in scope; catch added [F] (§2 #4) | 6 |
| Re-reading close and the after-entry question | **added at spec [F]** (§2 #2, #6) | 4 |
| Past entries | in scope (left open) [F] (§2 #8) | 4 |
| Language and content | in scope | 3 |
| Policy guards | in scope | 4 |
| **Total** | | **47** |

*Growth against the intake: the pre-check, the re-reading close and the after-entry question are new moves; the founder accepted each (§2). Nothing out of scope at intake came in.*

---

## Summary

**Reflect** is a new tool at `/tools/reflect`: one entry at a time, four steps, no AI, nothing scored.
**Story** is told as an observer would tell one scene, in order, with no "why" [F]. A light **pre-check** asks when it happened and whether it has been written about before, and suggests waiting when it is close; **Stop here** sits on every step [F].
**Feelings and needs** use Feelings & Needs' own palettes and faux-feeling catch [F], anchored to moments in the story, each need met or unmet.
The **reality check** sorts readings from what a camera would have caught, with one authored-lexicon offer on the story text [F]; a **re-reading close** asks what the person sees now [F], and one optional three-word question after finishing feeds the drop rule, never shown back [F].
Entries live in their own tables, unshareable by construction, listed plainly and deletable [F]. Practice content is English with a complete Persian draft [F].

## 1. What it is

**One entry is one scene.** Not a day's journal, and not an event's whole history: one moment, an hour at most, told once. A second entry on the same event is allowed, and the pre-check is where the app says what that risks (§4.3). The app never compares entries.

**Four steps, in this order** (research §4: end on a re-reading, not on feelings):

1. **Story** — where and who (one line), then what was said and done, in order, as someone watching from the side would tell it (§2 #1).
2. **Feelings and needs** — up to three moments in the story: when it was, the feeling, the need, and whether that need was met or unmet.
3. **Reality check** — the story shown back; up to three pairs of *a reading in it* and *what a camera would have caught there*. Framed as noticing a reading, not disputing it (research §4, [S14]).
4. **Re-reading close** — one optional line: what do you see now that you didn't when you started (§2 #2).

Before step 1 there is a **pre-check**; after step 4, **Finish** and the optional **after-entry question**. Every step can be skipped forward, and every step has **Stop here**.

**What it is not.** Not a journal (it writes nothing to Journals and can't be shared), not Feelings & Needs (no body step, no breath, no small action, no frame), not pattern-finding (no entry ever reads another), and not a hand-off (nothing leaves Reflect for Learn, Organize or Impact).

### 1.1 What it reuses (as-built)

- **The step-commit wizard.** Feelings & Needs and Noticing commit each step as it goes, with no final submit, and keep a sitting resumable by a null `completedAt` (`api/prisma/schema.prisma`, `LoopSitting`, `NoticingSitting`; convention 8, `tracker/canon/02-architecture/04-conventions.md`). Opening returns the still-open row rather than a second one, under `withUserLock` (`api/src/services/noticing/session.ts:255`; D-57).
- **Feelings & Needs' content.** `getFeelingsNeedsPack(contentVersion, locale)` (`api/src/content/feelings-needs/index.ts:25`) returns the feelings palette (pool 20, shown 6, tier-weighted) and the needs palette (pool 12, shown 5) with an "other → type it" escape (`api/src/content/feelings-needs/dials.ts`, `palette`). Its faux-feeling catch is two pure functions, `detectFauxFeeling` and `composeCatch` (`api/src/services/feelingsNeeds/distinctions.ts:166`, `:218`); the gate beside them, `catchAllowed` (`:198`), counts `LoopEntry` rows and is Feelings & Needs' own, not Reflect's.
- **The authored-lexicon catch pattern.** Noticing's `catches.ts` matches a normalized trigger list per field, with Unicode-letter lookarounds instead of `\b`, Arabic-keyboard folding, longest match wins, a catch that offers rather than corrects, a cooldown written when the catch is *surfaced*, and lexicons that never reach the browser (`api/src/services/noticing/catches.ts`; `NoticingState.lastCatchAt` in `schema.prisma`; convention 13's one spending).
- **The draft-locale notice.** A practice-content locale and `reviewStatus` on the state type, and a banner when the content is a draft (`FeelingsNeedsState` in `api/src/graphql/schema/typeDefs.ts:1600`; `client/app/components/learn/FeelingsNeedsPage.tsx:81`).
- **The fences suite.** A unit test that reads `schema.prisma` and `typeDefs.ts` as text and fails the build on a refused field or argument (`api/src/__tests__/noticingFences.unit.test.ts`).

## 2. Decisions taken at spec

Asked 2026-10-21, one batch of eight.

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | How is the story step worded? | **Observer, in "you".** One scene, as if watched from the side: who was there, what was said and done, in order. No "why" in any prompt. | Prompts are authored to [S1], [S11]: no "deepest thoughts and feelings", no "why". Persian uses the informal second person the glossary sets. Wording, not scope. |
| 2 | A re-reading close after the reality check? | **Yes.** | A fourth step, optional. Skipping it still finishes the entry (AC-33). |
| 3 | A guard before or during an entry? | **Light pre-check and an exit.** "When did this happen?" and "Have you written about it here before?"; if recent or written before, one line suggests waiting or keeping it short, with *Keep going* and *Not now*. **Stop here** on every step closes calmly. Never blocks. | Two stored answers per entry, never shown back (AC-3). The calm-close copy is authored content the founder approves at build (R6). |
| 4 | An interpretation catch on the story? | **Yes, on the story text only,** Noticing's pattern in Reflect's own copy, at most one offer per entry. | Reflect authors an interpretation lexicon (`en` reviewed, `fa` draft) in its own content pack. |
| 5 | Whose palettes and faux-feeling catch? | **Feelings & Needs'.** | Reflect reads F&N's content pack and pure catch functions, never its tables or state. A coupling between two rehearsals that migrate separately (R3). |
| 6 | What lives in the app for the drop rule? | **One optional tap after finishing,** three plain answers: *I see it a bit differently* · *About the same* · *More caught up in it*. Stored, never shown back, never counted on screen. | M1. Anything heavier (a rumination questionnaire, a Journals comparison arm) is the eval plan's, outside the app. "Felt judged" isn't covered by the tap (§3). |
| 7 | What language is the practice content in? | **English, with a complete Persian draft** marked as draft, as Feelings & Needs and Noticing did. | Persian users get Persian chrome around English practice content and are told so (AC-43). The bet is not tested for Persian users in this version (R2). |
| 8 | Can the person see past entries? | **A plain list, each entry deletable.** Reverse-chronological, read-only, no search, no filters, no counts. | Delete is a hard delete behind `ConfirmDialog` (convention 9). The first deletable record among the pillar rehearsals. |

**Decided here, by Claude.** Each is reversible at `revise`; refuse it on the diff if it's wrong.

| # | Decision | Why |
|---|---|---|
| 9 | **Entries live in new tables** (`ReflectEntry` with child rows for moments and readings, and a `ReflectState` per user), not in Journals. Table shape is `build-plan`'s. | Journals are linkable to goals and shareable by email (`client/app/components/journals/`; `JournalAccess` in `schema.prisma`). A separate model is unshareable by construction rather than by a flag someone can flip. |
| 10 | **Reflect refuses API-token callers.** Every Reflect query and mutation answers only the app's own session. | Tokens can read any query (`api/src/index.ts`, `enforceTokenScope` only blocks writes). A token is how data leaves for a third-party tool, an AI agent included, and the intake excludes both sharing and the AI mirror. The person still owns and can delete everything. |
| 11 | **The pre-check answers, the after-entry answer and which catches fired are not in the GraphQL entry type.** They are written by mutations and read only by the eval plan from the database. | "Never shown back" holds by construction: no client can display a field the API doesn't return. |
| 12 | **No frame, no prompt fade, no graduation.** | Feelings & Needs and Noticing have them; the intake asks for none, and each is a module of its own. |
| 13 | **Bounds.** Scene line ≤ 140 characters; story soft line at 1,500, server refusal over 5,000; moment, reading and camera lines ≤ 280; own feeling or need word ≤ 60; close ≤ 1,000. Moments and reading pairs soft-capped at 3. No character counter on screen: past the soft line, one sentence says to keep it to one scene. | Research §7 Q4: an entry with no bound is on the avoid list. A visible counter is a number on screen (AC-44). |
| 14 | **One open entry per person.** Opening Reflect with one open offers *Continue* (naming the day it was started) or *Start a new one*, which closes the open one as stopped at its current step. | Matches `startNoticingSitting`'s rule (`typeDefs.ts`, "returns the still-open sitting instead"), and stops a reload splitting one entry into two. |
| 15 | **The interpretation catch matches the practice locale's lexicon only** (`en` in this version), when the reality check opens, not while the story is being written. | The `fa` lexicon is a draft; firing draft content on real Persian text is untested content touching people. Not interrupting the story keeps the observer account whole. Cost: the catch is silent on Persian text for now (R5). |
| 16 | **Tree node** (proposal; `ecosystem/ost.md` has the structure but no tree written, and no Reflect outcome locked). Opportunity **RFL-1**: *I replay the same experience and spiral, with nowhere that helps me re-see it* (H6a). Solution **RFL-1a**: *the observer recount, a structured no-AI entry* (this module). Assumptions **RFL-1a.1** *an observer's account plus a reality check produces re-seeing more often than free journaling* (H6b; drop condition 1); **RFL-1a.2** *it does not leave people more caught up, or feeling scored or judged* (drop condition 2); **RFL-1a.3** *the observer wording carries into Persian* (research §8). | The intake left the node to `spec` (`00-intake.md` §3); the IDs follow the drafted scheme in `ecosystem/working/affine-canvas-notation.md`. The outcome above RFL-1 is the founder's to lock. |
| 17 | **Reflect lives on the Tools home** as a third card beside Feelings & Needs and Noticing (`client/app/components/tools/ToolsHomePage.tsx:80-94`), not in the main navigation. | Same place as the other pillar rehearsals. |
| 18 | **Noticing's Reflect hand-off stays a stub.** `setNoticingMotive` and its copy are untouched. | The motive audit (Reflect↔Impact) is a hand-off, out of scope at intake. |

## 3. Metrics

| # | Measure | What it counts | Why |
|---|---|---|---|
| M1 | After-entry answers | Of finished entries, the share answered *differently*, *about the same* and *more caught up*, and the share left unanswered | Drop conditions 1 and 2 as the person reports them (§2 #6). |
| M2 | Stops | Of entries past the pre-check, the share closed by **Stop here**, and at which step | A stop is the other way "more caught up" shows; the step says where. |
| M3 | Pre-check answers | Of entries started, the share answered *recent* or *written before*, and of those, the share that chose *Not now* | Whether the guard is met and heeded; a rough split for the tendency to ruminate that [S3] says the evaluation needs. |
| M4 | Re-reading close | Of finished entries, the share with a close line | The most direct reconstrual move (§2 #2); empty closes everywhere suggest the step isn't landing. |
| M5 | Readings named | Of finished entries, the share with at least one reading pair, and whether an interpretation catch was surfaced on that entry | Whether the reality check is used, and whether the catch is what gets it used. |
| M6 | Language shift | Between the story and the close: first-person singular, causal and insight words | A passive reconstrual proxy ([S4], [S9]), counted offline by the eval plan, never in the app. |

What the measures don't reach: *felt scored or judged* (drop condition 2's second half), *no differently than journaling* (needs a comparison arm) and the split by tendency to ruminate. Those are the eval plan's instruments, outside the app (§2 #6).

## 4. Interface requirements

Every user-facing string is a key in `en` and `fa` `common.json` (convention 7); practice content (prompts, palettes, lexicon, catch copy) is in Reflect's content pack (§2 #7). Dates go through `useAppDate`. Steps commit as they go (convention 8).

### 4.1 Entry point

- A **Reflect** card on the Tools home, with one line on what it is and an **Open Reflect** button to `/tools/reflect`.
- Routes: `/tools/reflect` (home), `/tools/reflect/entry` (the open entry), `/tools/reflect/past` (the list), `/tools/reflect/past/:id` (one entry).

### 4.2 Reflect home

- One or two lines on what an entry is: one scene, told as an observer would.
- **Start an entry**, or, with an entry open, **Continue the entry you started on <date>** and **Start a new one** (§2 #14).
- A link to **Past entries**, shown once one exists. No count beside it.
- The draft-locale banner when the person's interface language differs from the practice content's, or the practice content is a draft (§1.1).

### 4.3 Pre-check

- **When did this happen?** Three choices: *In the last few days* · *In the last few weeks* · *Longer ago*. Optional.
- **Have you written about it here before?** *Yes* · *No*. Optional.
- If the answer is *the last few days* or *Yes*, one line before the story: it may still be close, and writing now can stir it more than settle it; it could wait, or stay short. Two buttons: **Keep going** (to the story) and **Not now** (the calm close, §4.9).
- Otherwise the pre-check goes straight on to the story. Both questions can be skipped.

### 4.4 Story

- **Where were you, and who was there?** One line (the *scene*). It is what names the entry in the list.
- **What happened, in order.** A multi-line field. The prompt asks for what was said and done, as someone watching from the side would tell it. Proposal for the `en` wording: *"Tell it as if you were watching from across the room: what each person said and did, one thing after another."* No "why", no "how did you feel" here; feelings are the next step.
- Past the soft line, one sentence under the field: keep it to one scene; what came after can be its own entry. No counter.

### 4.5 Feelings and needs

- **Where in the story did a feeling come up?** Moments, one at a time, up to three:
  - **When** — one line ("when she closed the door").
  - **Feeling** — Feelings & Needs' palette, six shown, with *other → type it*.
  - **Need** — Feelings & Needs' needs palette, five shown, with *other → type it*.
  - **Met or unmet?** — *Met* · *Unmet* · *Not sure*.
- **Add another moment** until the soft cap; past it the control is gone, with no message.
- **Faux-feeling catch.** When a committed feeling matches Feelings & Needs' lexicon, an offer under that moment: what might be underneath, with its feeling and need hints, from `composeCatch`. **Use one** replaces the feeling; **Keep mine** dismisses it. At most one per entry, under Reflect's own cooldown dial.
- The step can be skipped.

### 4.6 Reality check

- The story shown back, read-only (collapsed to its first lines on a phone, expandable).
- The prompt: read it back; which parts would a camera have recorded, and which are your reading of it? Noticing a reading isn't saying it's wrong.
- **Reading pairs**, up to three: **A reading in it** (one line) and **What a camera would have caught there** (one line). Either half can stay empty.
- **Interpretation catch.** When the step opens and the story contains a trigger from Reflect's lexicon (absolutes such as "always", "never", "everyone"; mind-reading such as "on purpose", "wanted to"; labels such as "selfish", "rude"; verdicts dressed as events such as "ignored me"), one offer above the pairs: the word, and a line saying it might be a reading. **Use this** fills the next empty *reading* field with the sentence that holds the word; **Not this one** dismisses it. Neither is recorded as a judgment.
- **Gestures.** Each control has one effect: the offer's two buttons act only on the offer; tapping the shown-back story only expands it; nothing in the story is selectable as a control.

### 4.7 Re-reading close

- **Looking at it now, what do you see that you didn't when you started?** One optional multi-line field.
- **Finish** closes the entry, filled or not.

### 4.8 After the entry

- One optional question, once, right after **Finish**: *I see it a bit differently* · *About the same* · *More caught up in it*. Tapping one stores it and moves on; **Skip** moves on. No number, no colour scale, no follow-up line that reacts to the answer.
- Then a short done line and **Back to Reflect**. No count, no streak, nothing about how many entries there are.

### 4.9 Stop here, and the calm close

- **Stop here** on the pre-check and on every step, in the same place on each.
- It closes the entry where it is, keeping what was written, and shows the calm close: it's fine to stop; what you wrote is kept and can be deleted; and one line suggesting a trusted person or a professional if this is too much to hold alone. **The copy is the founder's to approve at build** (R6). No phone numbers in this version.
- **Back to Reflect** and **Delete what I wrote** (behind `ConfirmDialog`).
- The after-entry question is not asked after a stop.

### 4.10 Past entries

- **List:** closed entries that have story text, newest first; each row shows the date (`useAppDate`) and the scene line, or the story's first words when there is no scene. The whole row opens the entry; there is no other control on a row. No search, no filter, no count, no grouping.
- **One entry:** read-only, in step order: scene, story, moments, reading pairs, close. Not shown: the pre-check, the after-entry answer, any catch.
- **Delete** in the entry view only, behind `ConfirmDialog`, saying it can't be undone. A hard delete of the entry and its rows; back to the list.

## 5. Risks

| # | Risk | Why it matters | Mitigation |
|---|---|---|---|
| R1 | **The story step is re-lived anyway.** | For people prone to rumination, story writing did worst in the one trial with this audience ([S3], research §3). Observer wording lowers the risk; it doesn't remove it. | The wording (§2 #1), the pre-check (§4.3), **Stop here** (§4.9); M1 and M2 watch for it; the eval plan splits by tendency to ruminate. |
| R2 | **The bet isn't tested for Persian users.** | Practice content is English (§2 #7); labeling regulates only in the dominant language (research §1); how distancing reads in Persian is unknown (research §8). | A complete `fa` draft, marked draft and said so. The `fa` content is reviewed by a Persian-dominant reader before it is marked reviewed. RFL-1a.3 stays open. |
| R3 | **Coupling to Feelings & Needs.** | Two rehearsals that migrate out separately (convention 13); a change to F&N's words or pack shape changes Reflect. | Read only through `getFeelingsNeedsPack`, `detectFauxFeeling` and `composeCatch`, never F&N's tables, state or `catchAllowed`. Reflect pins the F&N content version it enrolled on. Say so at the site and in the decision log. |
| R4 | **The after-entry tap reads as a rating.** | The intake bans scores and scales for the person; Etkin's cost of quantification (research §1). | Three words, no numbers, optional, never shown back, not in the API (§2 #11). If M1's *more caught up* share rises, or interviews say it feels like grading, it goes. |
| R5 | **The interpretation catch corrects, or is silent.** | A catch on every entry is a spellchecker for thoughts; and with the `en` lexicon it never fires on Persian text (§2 #15). | One per entry, a cooldown dial, an offer not a verdict, dismissal unrecorded. The Persian silence is stated in the eval plan. |
| R6 | **Someone in acute distress.** | Crisis routing in self-help apps wasn't researched (research §8). A wrong support line can do harm. | Calm close with a general line, no numbers; the founder approves the copy at build (a stop point for `build-plan`). |
| R7 | **The most sensitive text in Tracker sits in SQLite and its backups.** | The deploy backs up the database before a migration (`config.md` *Deploy*); the repo is public. | No share path, API tokens refused (§2 #10), no index on text columns, bodies never logged, hard delete. Encryption at rest is a stack decision for `build-plan`'s foundation batch, named here, not decided. |
| R8 | **Noticing's fences suite slices `schema.prisma` from its banner to the end of the file** (`noticingFences.unit.test.ts`, "comment banner through to EOF"), and Noticing is the last block today. | Reflect's models appended at the end would fall under Noticing's fences: passing or failing for the wrong reason. | `build-plan` puts Reflect's block before Noticing's banner, or bounds Noticing's slice at the next banner, and gives Reflect its own fences suite. |
| R9 | **e2e isn't lane-safe** (`config.md` *Lane resources*). | Reflect needs e2e for the flow; only one lane per machine can run it, and it writes to the running API's dev database. | `build-plan` schedules e2e in one lane, or the prep stage. One lane changes `schema.prisma`. |
| R10 | **"Written before" is a self-report.** | No entry ever reads another (out of scope), so repeated entries on one event go unnoticed if the person answers *No* or skips. | Accepted for this version; the pre-check is advisory, not a detector. |

## 6. Acceptance criteria

### 6.1 Data, ownership and the unshareable fence

- **AC-1.** An entry is stored in Reflect's own tables, with its scene, story, moments (when, feeling and its source, need and its source, met/unmet/not sure), reading pairs, close, the pre-check answers, the after-entry answer, which catches were surfaced, `closedAt` and the step it was stopped at, if any. Nothing is written to `Journal`, `JournalEntry`, `LoopSitting` or `LoopEntry`.
- **AC-2.** Every Reflect resolver calls `requireAuth` and `ensureOwned` (convention 1); one person's entry id passed by another returns not-found, and an integration test proves it for a read, a write and a delete.
- **AC-3.** The GraphQL types Reflect exposes have no field for the pre-check answers, the after-entry answer or the catches surfaced; a fences test reads `typeDefs.ts` as text and fails if one is added.
- **AC-4.** Every Reflect query and mutation called with a personal API token, read or write scope, is refused with a clear error; an integration test covers one query and one mutation.
- **AC-5.** No Reflect operation has an argument named `search`, `query`, `filter` or `name`, no Reflect model has an index on a text column, and no Reflect model relates to `Journal`, `Goal`, `Project` or `JournalAccess`; a fences test asserts all three.
- **AC-6.** The server refuses a scene over 140 characters, a story over 5,000, a moment, reading or camera line over 280, an own feeling or need over 60, a close over 1,000, and a fourth moment or reading pair.
- **AC-7.** Deleting an entry removes it and its child rows; deleting the user removes all their Reflect rows.

### 6.2 Home and resuming

- **AC-8.** The Tools home shows a Reflect card whose button opens `/tools/reflect`.
- **AC-9.** Starting an entry while one is open returns the open one; two concurrent starts produce one entry (`withUserLock`).
- **AC-10.** With an entry open, the home offers *Continue* with the day it was started and *Start a new one*; *Start a new one* closes the open entry as stopped at its current step and opens a fresh one.
- **AC-11.** A reload at any step returns to that step with every committed field in place.

### 6.3 Pre-check and stopping

- **AC-12.** The pre-check shows both questions, each optional, and goes straight on to the story when neither answer is *the last few days* or *Yes*.
- **AC-13.** An answer of *the last few days*, or *Yes*, shows the advisory line with **Keep going** and **Not now** before the story.
- **AC-14.** **Not now** closes the entry as stopped at the pre-check and shows the calm close; such an entry has no story and never appears in Past entries.
- **AC-15.** **Stop here** is on the pre-check and on each of the four steps, closes the entry with that step recorded, keeps what was written, and shows the calm close.
- **AC-16.** The calm close shows the approved copy, **Back to Reflect** and **Delete what I wrote**; deleting asks through `ConfirmDialog` first.
- **AC-17.** The after-entry question is never shown after a stop.

### 6.4 Story

- **AC-18.** The story step has the scene line and the story field, and its authored `en` prompt asks for what was said and done, in order, from an observer's place.
- **AC-19.** No authored prompt in Reflect's content pack contains "why" or "deepest" (`en`), or their `fa` equivalents, which the content test names; a unit test over the pack asserts it.
- **AC-20.** Past 1,500 characters the one-sentence keep-it-to-one-scene line appears under the story field; no character count is shown at any length.
- **AC-21.** No catch is surfaced during the story step.

### 6.5 Feelings and needs

- **AC-22.** The feeling and need choices come from `getFeelingsNeedsPack` at the F&N content version pinned on `ReflectState`, six feelings and five needs shown, each with *other → type it*; the source (palette or own) is stored.
- **AC-23.** Each moment records *Met*, *Unmet* or *Not sure*, or nothing.
- **AC-24.** **Add another moment** is gone at three moments.
- **AC-25.** A committed feeling that matches F&N's faux-feeling lexicon surfaces the offer from `composeCatch` under that moment, at most once per entry and only off Reflect's cooldown; **Use one** replaces the feeling and **Keep mine** leaves it, and neither writes anything beyond the surface itself.
- **AC-26.** No Reflect code reads or writes F&N's tables or calls `catchAllowed`; a unit test or import check asserts it.

### 6.6 Reality check and the interpretation catch

- **AC-27.** The reality check shows the story read-only and up to three reading pairs, either half of each optional.
- **AC-28.** Reflect's content pack ships an interpretation lexicon in `en` (reviewed) and `fa` (draft), in the four authored families, and the lexicon never reaches the browser.
- **AC-29.** When the step opens and the story holds a trigger, one offer is surfaced, at most once per entry and only off the cooldown dial; the cooldown is written when it is surfaced.
- **AC-30.** **Use this** fills the next empty *reading* field with the sentence containing the trigger, split on `.`, `!`, `?`, `؟` and line breaks; **Not this one** dismisses it, with nothing sent to the server.
- **AC-31.** Matching uses Unicode-letter boundaries, not `\b`, and the longest trigger wins: unit tests show "never" doesn't fire inside "nevertheless", a nested trigger picks the longer match, and an `fa` trigger matches with and without a zero-width non-joiner and with Arabic-keyboard letters.
- **AC-32.** The trigger matches the story field only; text in the scene, moments, readings or close never surfaces the offer.

### 6.7 Re-reading close and the after-entry question

- **AC-33.** The close step shows its one optional field and **Finish**; **Finish** with it empty closes the entry as finished.
- **AC-34.** After **Finish**, the three answers and **Skip** are shown once; a tap stores the answer, **Skip** stores nothing, and both move to the done line.
- **AC-35.** The done line shows no count, streak or total.
- **AC-36.** An entry's after-entry answer can be set once; a second call is refused.

### 6.8 Past entries

- **AC-37.** Past entries lists closed entries with story text, newest first, each row showing its date through `useAppDate` (Jalali in Persian) and its scene line, or the story's first words.
- **AC-38.** The whole row opens the entry; a row has no other control.
- **AC-39.** The entry view shows scene, story, moments, reading pairs and close, read-only, and none of the pre-check, the after-entry answer or the catches.
- **AC-40.** **Delete** in the entry view asks through `ConfirmDialog`, then removes the entry and returns to the list.

### 6.9 Language and content

- **AC-41.** Every interface string Reflect adds is a key in both `en` and `fa` `common.json`; `npm run i18n:check-missing` and `npm run i18n:check-hardcoded` pass.
- **AC-42.** Reflect's content pack has a complete `fa` surface for every `en` key, marked `draft`, and a unit test fails on a missing key.
- **AC-43.** A Persian-interface user sees Persian chrome around English practice content and the draft-locale banner saying so; the layout is right to left with Western digits.

### 6.10 Policy guards

- **AC-44.** No Reflect screen shows a number other than a date: no counts, scores, percentages, character counters or streaks.
- **AC-45.** No Reflect code path calls a model or the Anthropic key.
- **AC-46.** No Reflect operation reads more than one entry's content except the Past entries list, which returns scene, start of story and date only.
- **AC-47.** Reflect creates no actions, intervals, reminders, goals, journal entries or links to Learn, Organize or Impact.

## 7. Out of scope

- The AI or agent mirror, and any model call (intake §5).
- Cross-entry pattern recognition, comparison, search or "you wrote about this before" detection; gated on psychological review (`ecosystem/canon/02-pillars/reflect.md` §4).
- Scores, scales, ratings, streaks or any number on screen. The after-entry tap is three words, never shown back (§2 #6).
- Hand-offs to Learn, Organize or Impact, the "act now" exit, and Noticing's motive audit (§2 #18).
- Deferred tasks, reminders or intervals.
- Sharing, export, API-token access (§2 #10), and linking entries to goals, projects or journals.
- A frame, prompt fade or graduation (§2 #12).
- Editing a closed entry.
- Crisis-line numbers or routing (R6).
- Reviewed Persian practice content (§2 #7), and a Persian interpretation catch that fires on real text (§2 #15).
- In-app research instruments beyond the after-entry tap: the rumination questionnaire, reconstrual items and the Journals comparison arm are the eval plan's (research §5).
- Encryption at rest (R7, `build-plan`'s to decide).

## Changelog

- **0.1 · 2026-10-21** — Spec, from `00-intake.md` and `01-research.md`, against `rishe-eco/tracker main @ 5fd71c9`. Eight founder decisions (§2 #1–8), ten of Claude's (#9–18), 47 criteria.

## References

- `00-intake.md`; `01-research.md`
- `ecosystem/canon/02-pillars/reflect.md` (0.2); `ecosystem/ost.md` (0.2); `ecosystem/working/affine-canvas-notation.md`
- `tracker/canon/02-architecture/04-conventions.md` (conventions 1, 7, 8, 9, 13); `lifecycle/projects/tracker/config.md`
- `rishe-eco/tracker` @ 5fd71c9: `api/prisma/schema.prisma`; `api/src/graphql/schema/typeDefs.ts`; `api/src/index.ts`; `api/src/content/feelings-needs/`; `api/src/services/feelingsNeeds/distinctions.ts`; `api/src/services/noticing/catches.ts`, `session.ts`; `api/src/__tests__/noticingFences.unit.test.ts`; `client/app/components/tools/ToolsHomePage.tsx`; `client/app/components/learn/FeelingsNeedsPage.tsx`; `client/app/protectedRoutes.tsx`
