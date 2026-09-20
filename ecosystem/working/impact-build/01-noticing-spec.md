# Impact Act 1 — **Noticing** · prototype spec

*Spec, not as-built. The tool that trains need recognition as a perceptual habit: one place, one person, what you saw, what it might point to, and — optionally — one small thing. Concept and its grounding: `00-act1-concept.md`. Wireframes: `02-noticing-wireframes.html`. Feel-test for the spine: `03-spine-evaluation.md`. Build plan for Tracker: `04-build-plan.md`. Pillar canon: `../../canon/02-pillars/impact.md`. Update the changelog; don't fork.*

**Version 0.8 · Status: spec (built; §4.2/§4.6 reconciled with the built loop) · 2026-09-21 · Owner: _root**

---

## 1. The three decisions this spec is built on

1. **Built as a tool inside Tracker now**, migrating to Impact's standalone app later — the same staging-ground arrangement as Feelings & Needs (decision log, 2026-08-01). Namespace: `/tools/impact/noticing`.
2. **LLM-free.** Every catch in Tier 3 runs on an **authored lexicon**, not a model — same constraint and same mechanism as Module 1's faux-feelings catch (D-21).
3. **Tiers 1–3 live.** The Environment Scan and the Offer Rehearsal are later acts and are not built, not stubbed, and not shown (`00-act1-concept.md` §8).

English-only prototype. The spec/surface content split is kept so Persian is cheap later; the Persian **pillar and tool names** are still open.

## 2. Scope

### In (fully working)
- Tier 1 day-one frame, once, ~8 min, two beats (beat 1 is five steps).
- Tier 2 noticing loop: place → person → observation → need → optional small thing. ~3 min, daily-ish, repeatable within a sitting.
- Sitting close: what you noticed today, laid side by side, never related.
- Tier 3 catches, surfaced in-context on the person's own text: read-as-observation, strategy-as-need, protective-motive.
- The capacity portrait, accreted from post-offer answers, in head / hands / heart.
- **Noticing's own needs palette** — authored for reading a need from outside, wider than Module 1's, and including needs that invite no offer.
- **The log** — what you've written, grouped by day, never by person.
- Self-initiation detection and the one-time graduation door.
- The handoff surface to Reflect's motive check (as a link-out stub while Reflect is unbuilt).

### Out (this pass)
- Any sharing, export, or second reader. Private-only (`00-act1-concept.md` §6).
- Tracking whether an offered act happened — that is Organize.
- Cross-entry pattern surfacing of any kind.
- Persian surface content.

### The honesty line
The tool trains **noticing**. Whether trained noticing converts into more or better contribution is **not established** — the prosociality literature is modest and heavily moderated (r = .13), and the cleaner finding is that benefit is motive-dependent, which is a reason to route motive to Reflect rather than a claim that the loop produces impact. What the tool can be expected to move is the **perceptual** component: how much unmet need in one's own immediate environment gets registered at all. That is the claim, and it is the thing the evaluation should measure.

## 3. The processes (anatomy, abbreviated)

Same eight-dimension template as `../learn-mechanisms/00-module1-process-anatomy.md` §2; abbreviated here to the three columns that drive the build. The full anatomy graduates into that doc once the concept stabilizes.

| # | Process | Mechanism (one line) | Grade |
|---|---|---|---|
| **N1** | Ambient-need frame install | belief that need is present-and-invisible → willingness to look → looking | mod (parallel to P1) |
| **N2** | Welcome-calibration install | correcting "they wouldn't want me to" against what helpers actually feel | strong (Zhao & Epley, N = 2,118) |
| **N3** | Place-and-person anchoring | one singular, proximate target defeats compassion fade; aggregates don't mobilize | strong (Slovic) |
| **N4** | Observation-before-inference | recording what was seen before what it meant keeps the read auditable and the need revisable | moderate (NVC observation; Reflect §2.3) |
| **N5** | Need-inference-in-context | repeated in-context inference about another's need trains the perceptual screening the construct describes | moderate (Reynolds; Kanov) |
| **N6** | Distinction-by-contrast | minimal pairs on the person's own material teach the boundaries (read/observation, strategy/need, motive) | moderate (as P5) |
| **N7** | Self-initiation | scaffold fades; the loop runs unprompted (= graduation) | — (habit/fade, as P7) |

**Composition.** N1+N2 are the substrate installed once and reinforced by every pass. The spine is **N3 → N4 → N5**, one ~3-minute motion, not three steps the person experiences separately. N6 is a refinement layer on N4/N5 and never the opening move. N7 is the exit condition, not a step.

**The one precondition worth naming:** N5 presupposes a needs vocabulary. Someone who has run Learn Module 1 arrives with it trained. Someone who hasn't gets the palette anyway — it is not a gate (`00-act1-concept.md` §7).

## 4. Screen / flow spec

### 4.1 Day-one frame — once *(N1, N2)*

Two beats, ~8 min, no account of what the pillar is.

**Beat 1 — you, on the receiving end.** Five steps. The design rule that generates all of them: **the person supplies both halves and the tool only lays them side by side.** Nothing here is asserted; the turn is earned out of their own two answers, which is what "felt, not told" has to mean if it means anything.

| # | Step | Prompt | Input | Why it's here |
|---|---|---|---|---|
| 1 | **the moment** | "Think of a time someone helped you without being asked for it. What happened?" | free text, one line | a single concrete episode — the same scale floor as the loop, applied to memory |
| 2 | **what you didn't say** | "What were you needing, that you weren't saying out loud?" | needs palette + `other → type it` | **the missing beat.** Invisibility is established *first-person* before it is claimed about anyone else. The person meets their own unspoken need as a fact about themselves |
| 3 | **what they had to go on** | "They couldn't hear that. So what could they actually *see*?" | multi-select chips + escape — *my face · that I'd gone quiet · that I was still there late · how I was standing · something I said in passing* | the load-bearing step. It teaches observation→need **from the side of the person who was read**, and it makes the cue small and outward, which is exactly what step 3 of the loop will ask for |
| 4 | **the turn** | *(no question)* — their step-3 answer and their step-2 answer, side by side, with an arrow | — | "They got from one to the other without you saying anything. That's the whole move." The sentence is now a description of what they just wrote, not a claim |
| 5 | **the reverse** | "Yesterday — how was the person you sat nearest to?" | *I know · no idea* | most people cannot answer. "That's ordinary. It's not that you don't care — you weren't looking. Looking is a thing you can get better at." |

**The escape at step 1, which turns out to matter.** Some people cannot recall being helped unasked — and that is not a reason to fail them out of the frame. `can't think of one →` reroutes to *"a time you wished someone had."* Steps 2 and 3 run unchanged, and the beat lands harder rather than softer: the need was real, the cue was there, and nobody read it.

**Step 4 is the exception, and it has to be.** *(Corrected 2026-09-20, found in build.)* This doc previously said steps 2–4 all run unchanged. They cannot. Step 4's line is *"They got from one to the other without you saying anything"* — and on the reroute path there is no **they**. The single sentence the whole beat builds toward is the one sentence the reroute breaks, so step 4 needs its own variant: the two halves still laid side by side, and the observation that **nobody put them together**. Same structure, opposite outcome, and the point survives intact — which is what "lands harder" actually means here. Step 1's prompt needs a variant for the same reason.

**Why beat 1 is five steps and not two.** The old two-step — recall the moment, then be told they saw something you never said — conflated the **cue** and the **need** into one question ("what do you think they noticed?") and then asserted the conclusion. Splitting them is what makes the frame a rehearsal of N4→N5 rather than a motivational preamble. The person arrives at the loop having already run the inference once, from the inside.

**Beat 2 — the welcome prediction.** "If you offered someone a small hand today, how glad would they be?" — a coarse three-way pick (*not very · somewhat · very*). Then what the research found: people underestimate how willing others are, underestimate how good helping feels to the helper, and overestimate the inconvenience. Shown once, as a correction to a prediction the person just made — never as a standing statistic.

Ends with the loop, not with a summary.

### 4.2 The noticing loop — the daily spine *(N3 → N4 → N5)*

Four steps and a close. No timer anywhere.

| Step | Prompt | Input | Notes |
|---|---|---|---|
| **place** | "Where were you today?" | small palette + `other → type it` | home · a commute · work · a shop or street · someone's house. **Scale floor lives here** — there is no option larger than a place you physically were. |
| **person** | "Who was there?" | free text, one line | a name or a description ("the man at the counter"). **The third-party warning sits under this field** (§7). Never a category; the copy asks for one person. |
| **observation** | "What did you actually see or hear?" | free text | the anchor. Catches fire here (N6-a). |
| **need** | "If that points at something they care about — what?" | Noticing's own needs palette (§8.2) + `other → type it` + **"not sure — that's fine"** | offered, never forced. Ending here is a complete pass. |
| **small thing** | "Anything small you want to offer or ask?" | free text, **skippable and skipped by default** | catches fire here (N6-b, N6-c). If filled → the Reflect handoff. |

**The close.** "✓ noticed." One line restating what was seen and what it might point to. Then a quiet secondary: *"see someone else today?"* → another pass. Passes within a sitting are **parallel and never related** — the same guardrail as Module 1, for the same reason.

**The palette is not narrowed by the place.** Showing only the needs "plausible at a commute" would be the tool deciding what kind of need a place is allowed to contain — the same quiet convenience §11 flags about pre-seeding `place`, and worse, because it prunes the *answer* rather than the question. The on-screen selection is deterministic and place-blind; `other → type it` carries whatever the list does not.

**If a small thing was written**, the close adds one question and nothing else: *"what did you have that made that possible?"* — head / hands / heart, three chips and a text escape. That single answer is the whole of move 2 (`impact.md` §3). **Built shape, settled 2026-09-21:** this question and the motive line of §4.6 render **inline in the close**, not as screens after it. They were first built as separate steps with their own headers and controls, which made an offer feel like it had two more hoops behind it — the opposite of what a close is for. Each disappears once answered, Finish is on screen throughout, so neither is ever owed.

### 4.3 The log — a record, and deliberately nothing more

The same surface Feelings & Needs ended up with, and the same refusals, plus one that is specific to this pillar.

**What it shows.** Days, in reverse order. Under each day: the place, what you wrote you saw, the need if you named one, and the small thing if there was one. Nothing else. A day with nothing in it simply isn't there — not greyed out, not marked missed.

**What it refuses, and why each would be easy to add.**

- **No counts and no streaks.** "You've done this 14 times" is the counting the pillar structurally refuses; a marker you can lose becomes the reason to act.
- **No patterns.** "You often notice this at work" is cross-entry pattern recognition — same gate as Reflect §4.
- **No missing-marks.** Nothing says you skipped a day, because nothing was owed.
- **No grouping or filtering by person, and no search.** This is the one that is specific to Impact and it is the **dossier fence**: a log you can filter by a name, or search for a name in, *is* a file on that person, however innocent each entry was. Ordering is by day and only by day, and there is no search box. Stated here because a search box is the single most natural thing for a developer to add to a list of text entries, and adding it would quietly convert this tool into something the canon forbids.

**Why it exists at all**, given all that. Two reasons, both load-bearing: it is the person's own record and they are entitled to it, and it is where they can *see their own observations getting more observational* — which is the module's real learning signal, and the one thing worth seeing back. It is also what the feel-test reads (`03-spine-evaluation.md` §2A).

### 4.4 In-context catches *(N6)* — three, authored

Surfaced **after** the person has written, gently, never blocking, never scored. Each is a contrast on their own words.

- **N6-a · read-as-observation.** Trigger lexicon: evaluative adjectives and attributed states — *rude, difficult, lazy, fine, ignoring me, being dramatic*. Response: "'difficult' is your read on it. What did you actually see?" with the original text kept and editable.
- **N6-b · strategy-as-need.** Trigger: the need field or the small-thing field containing a concrete act where a need belongs — *a ride, money, a job, someone to call them*. Response: "a ride is one way to meet it. What's underneath?" offering two or three needs from the palette.
- **N6-c · protective-motive.** Trigger lexicon, VFI's protective register: *should, have to, ought, guilty, bad if I don't, the least I can do*. Response does **not** argue and does **not** block: "'should' is worth a look before this becomes a plan." → routes to the Reflect motive check. This is the canonical handoff, not a new opinion.

Each catch fires on a **cooldown** (§6) so it stays a distributed touch and never becomes a grammar checker.

### 4.5 Graduation *(N7)*

Prompts fade; when the loop runs unprompted for long enough with entries that still contain an observation and a need, a one-time door: *"You've been looking on your own lately. That's the whole thing."* No count, no streak, no score — inferred, per the 2026-08-01 detect-don't-count decision.

**What "unprompted" means, settled in build (2026-09-20).** It means **the scaffolding copy has been withdrawn and the practice held its quality anyway** — not that the app stopped cueing the person, because *the app never cues anyone.* The `wasPrompted` column exists on the sitting in both this module and Feelings & Needs, and **both clients hardcode it to `false` on every open**: nothing in Tracker has ever sent a reminder, so the field has never carried information in either tool. A detector built on it would fire for every user on their first qualifying sitting while appearing to work, which is worse than no detector.

This is the correct reading of D-21 rather than a workaround: that decision says to infer from **prompt-withdrawal plus content**, and the prompt being withdrawn is the *fade* — the app saying less — which is a thing that demonstrably happens here. So the signal is the fade level having reached its cap **plus** the content check, and `wasPrompted` is vestigial in both modules. Noted so that nobody later reads that column as evidence. If the standalone Impact app ever does send a reminder, the field becomes real and this detector should be revisited before it is trusted.

**The honest part:** the fade level is derived from completed sittings, so the door does sit behind a count internally. It is never shown, never aimed at, and cannot be lost — which is what the decision requires — but "no count anywhere" is true of the surface, not of the inference.

### 4.6 The Reflect handoff

A small surface, deliberately thin while Reflect is unbuilt — and, as built, **not a surface at all but two chips at the foot of the close** (§4.2): the noticed need, the small thing, and the motive question — *is this from capacity and care, or from obligation?* — with the answer stored and nothing computed from it. When Reflect exists, this becomes a real handoff object. Nothing in Noticing is gated on the answer; Noticing recognizes, Reflect audits, Organize executes. It must also stay **waveable**, and a wave must be **written nowhere**: asking *was this obligation?* after every kind act is the self-auditing `../../canon/02-pillars/impact.md` warns about, and a stored "declined" would be a record of a refusal. A skip lives in component state for that pass and dies with it; the N6-c protective catch already routes the people whose own words raised the question.

## 5. Failure modes = acceptance criteria

Per the Module 1 convention, these are pass/fail, not preferences.

| Failure | What it looks like | Guard in the build |
|---|---|---|
| **Surveillance** | the tool becomes a dossier on colleagues | private-only; one line per person per pass; no person-centric view, ever — entries are indexed by sitting, not by name; **the log has no search and no person filter** (§4.3) |
| **Savior framing** | "who can I fix today" | the need step is skippable; "not sure" is a complete ending; copy never says *help* where it can say *notice* |
| **Guilt accumulation** | noticed-but-unacted needs pile up as debt | the small thing is skipped by default; nothing is marked outstanding; no list of what you didn't do |
| **To-do-list collapse** | entries become errands | N6-b catches strategies in the need field; nothing is ever marked done |
| **Empathic distress** | noticing outruns capacity | scale floor; one person per pass; the act stays small (the effort/stress finding) |
| **Score drift** | someone adds a total | no counter exists in the schema — the absence is structural, not hidden by the UI |
| **Instrumentalized relationships** | people become material for your growth | the capacity portrait is built only from *what you had*, never from *who you helped*; it stores no names |

## 6. Dials

For the evaluation-and-settings layer; hardcoded in the prototype, per the Module 1 precedent.

| Dial | Provisional | Why it's a dial |
|---|---|---|
| `placePalette` | 5 + escape | too many and it becomes a form |
| `needPoolSize` / `needDisplayCount` | ~20 authored / 6 on screen | two numbers on purpose, per the Module 1 precedent. The pool has to be wide enough to read another person's life; the screen has to stay small or the step becomes a menu to browse |
| `repeatSoftCap` | 3 passes/sitting | the fourth pass is usually inventory, not noticing |
| `catchCooldownDays` | ~~3~~ **5**, shared across types | distributed touches. Raised in build: `read`'s triggers are the casual evaluative shorthand people reach for constantly (*rude, difficult, fine, cold*), while `strategy` and `protective` triggers are rarer **and** sit behind optional fields skipped by default — so at 3 days `read` alone would refire about twice a week indefinitely, which is a running commentary on word choice rather than a distributed touch. **The real fix is a per-type cooldown**, which `lastCatchAt` already supports structurally and this dial's shape does not; deliberately not guessing a second number before the feel-test |
| `catchesPerSitting` | max 1 | two in one sitting reads as correction |
| `frameRecallWindow` | "today / yesterday" | the reverse-prompt only lands if the memory is close |
| `selfInitiationWindow` | unprompted passes over ~2 weeks | graduation is a door, not a threshold to hit |
| `smallThingLengthHint` | one line | the soft signal that keeps the act small |

## 7. Third-party data — the build rules

Decided in `00-act1-concept.md` §6; here is what it means in code.

- **Private by construction.** No share, no export, no second reader in v1. The resolver surface has no query that returns another user's entries, and the client has no view that aggregates by person.
- **Warned at the point of writing.** A persistent, quiet line under the person field: *"You're writing about someone else. Write as if they could read it."* Not a modal, not dismissible-forever — it is part of the field.
- **Names are stored as free text and never indexed.** No person entity, no autocomplete across entries, no "you've mentioned them 4 times." Building the index is what would make this a dossier.
- **Sanitization is a precondition on any future sharing**, not a toggle over raw text. Written into the schema comment so it can't be quietly skipped.

## 8. Content to author (English, prototype)

1. **Place palette** — 5 + escape.
2. **Needs palette** — **authored for this tool**, not imported. Wider than Module 1's twelve, because what is legible from outside is a different set: practical and physical needs, informational ones (*to know what's going on*), and — the category that only exists once the list is authored for this job — needs that **invite no offer**: *to be left alone*, *nothing from anyone right now*. Without those the palette itself argues for intervention, which is the savior framing §5 lists as a failure mode. **Same-meaning needs keep Module 1's ids** (`00-act1-concept.md` §7). Pool wide, screen small — §6.
3. **Day-one frame copy** — beat 1 (five steps, plus the `can't think of one` reroute), beat 2 (prediction + correction).
3b. **Observable-cue chips** — ~6 starters for beat-1 step 3 (*my face · that I'd gone quiet · that I was still there late · how I was standing · something I said in passing*) + escape. These are the frame's only new palette.
4. **Loop prompts** — five, plus the close and the repeat invitation.
5. **Catch lexicons** — three authored lists (evaluative/attributive terms; concrete-act terms; the VFI protective register) with the response copy for each, and two or three palette needs per common strategy.
6. **Capacity chips** — head / hands / heart, ~6 starters each, escape to text.
7. **Graduation copy** — one screen.
8. **The third-party warning** — one line, carefully worded.

## 9. Data model (Prisma/SQLite, illustrative)

*Illustrative means illustrative. Three things change on contact with the Tracker repo, all of them the host's own precedent rather than new opinions: ids become `uuid()` with explicit relations and cascade; `promptLevel` is **derived** from completed sittings rather than stored (Tracker dropped the equivalent mirror from `LoopState` for the same reason — the sittings are the authoritative record and a cached number beside them can disagree with them); and `lastCatchAt` **stays**, against the host's derive-don't-mirror idiom, for two reasons that are Noticing's own: the cooldown here is per-type and measured in days rather than per-pass, so deriving it means a date-bounded join with per-row JSON parsing on every catch evaluation; and a catch that was surfaced and **dismissed** is still a touch that should count, which `caughtTypes` cannot record because dismissal happens after the entry write. `caughtTypes` stays too, for the different job §12 gives it. The model as it actually lands is `04-build-plan.md` §6.*

```prisma
model NoticingFrame {       // tier 1, once
  id            String   @id @default(cuid())
  userId        String
  moment        String?  // beat 1 step 1, the recalled episode
  unsaidNeed    String?  // step 2 — palette key or free text
  visibleCues   String?  // step 3 — JSON string of chip keys + free text
  wishedInstead Boolean  @default(false) // took the "a time you wished someone had" reroute
  welcomeGuess  String?  // the beat-2 prediction, kept to show the correction once
  completedAt   DateTime?
}

model NoticingSitting {     // one sitting; passes are parallel, never related
  id        String   @id @default(cuid())
  userId    String
  startedAt DateTime @default(now())
  endedAt   DateTime?
  entries   NoticingEntry[]
}

model NoticingEntry {       // one pass
  id           String   @id @default(cuid())
  sittingId    String
  place        String
  // free text, deliberately un-indexed: no person entity, no cross-entry lookup.
  // Any future sharing surface MUST de-identify this field; do not add a share
  // path without one. See 00-act1-concept.md §6.
  person       String
  observation  String
  need         String?          // palette key or free text; null = "not sure", a complete pass
  smallThing   String?          // null by default
  capacityTags String?          // JSON string, head/hands/heart — only when smallThing is set
  motiveNote   String?          // the Reflect handoff answer; nothing is computed from it
  caughtTypes  String?          // JSON string of catches fired, for cooldown only
}

model NoticingState {       // graduation + cooldowns; no counters of achievement
  userId          String   @id
  lastCatchAt     String?  // JSON string: catch type → date. Cooldown only.
  // promptLevel is NOT stored — derived from completed sittings, and capped.
  graduatedAt     DateTime?
}
```

Note what is absent and must stay absent: no `count`, no `streak`, no `Person` table, no index on `person`.

## 10. Build order (milestones)

*File paths, phase exit criteria, the shared-palette refactor this order presupposes, and the test suites: `04-build-plan.md`.*

| # | Milestone | Contents |
|---|---|---|
| **1** | **Scaffold** | Prisma models + migration, `content/noticing/` (types, dials, v1 spec + surface.en, registry), state service, one GraphQL query, route + page shell, i18n keys (en + fa placeholders) |
| **2** | **Content** | The eight authored assets of §8, including the three catch lexicons |
| **3** | **The spine** | Tier 2 loop end to end, repeat, sitting close — the thing that has to feel right |
| **4** | **Day-one frame** | Tier 1, beat 1's five steps + the reroute, beat 2, gated to once |
| **5** | **Catches** | Tier 3, three catch types, cooldowns, in-context surfacing |
| **6** | **Capacity + handoff** | the post-offer question, the head/hands/heart portrait, the Reflect stub |
| **6b** | **The log** | days in reverse order, no counts, no patterns, no search, no person filter (§4.3) |
| **7** | **Self-initiation** | prompt fade + the graduation door |
| **8** | **Polish + feel-test** | the founder runs it for two weeks; the question is whether it changes what gets *seen*, not what gets done |

Milestone 3 is the risk. If the spine doesn't feel like noticing — if it feels like filling in a form about a coworker — no later milestone rescues it.

The feel-test cannot run *at* milestone 3 — it wants a fortnight of daily use, which presupposes the frame and something to come back to. So the risk splits into two gates: a **3-day disconfirming smoke** at the end of milestone 3 (founder, think-aloud only, coded for *recalling a person* vs *composing an entry*), and the full design at milestone 8. `04-build-plan.md` §10, which also defines in advance what "stop" means.

## 11. Open decisions before/within the build

- Whether the **place** step is ever pre-seeded (from time of day, from last entry) or always chosen fresh. Pre-seeding is convenient and may be exactly the wrong convenience.
- Whether the **capacity portrait** is shown to the person at all in the prototype, or accrues silently until it has enough to be worth showing.
- Whether an entry that ends at "not sure" needs its own closing line, so noticing-without-capacity doesn't read as failure.
- Persian names: pillar and tool.

## 12. Evaluation (what would count as it working)

**The milestone-3 risk has its own design:** `03-spine-evaluation.md` — four instruments (retrospective think-aloud, AttrakDiff + IMI, an objectification tripwire plus one interview question, and the Day Reconstruction Method for transfer) and a decision rule written before the data. It exists because the two ways the spine can fail — *it's a form* and *it instrumentalizes people* — produce **identical usage logs**, so usage data cannot settle it.


Observable signals, per the anatomy convention — collected for the settings layer, never shown to the user as a score:

- Entries increasingly contain an **observation that is actually observational** (the N6-a catch fires less over time on the same person's text).
- The **place** distribution widens — noticing starts happening somewhere other than the one place they first thought of.
- Passes continue **after prompts fade** (N7).
- The person reports, in the feel-test, seeing things they would previously have walked past. This is the real target and it is qualitative; no instrument in the prototype replaces it.

**Pre-registered null:** if noticing improves and nothing downstream changes, that is a result consistent with the modest prosociality literature and not a failed build. The pillar hands off to Reflect and Organize by design; Act 1 is not responsible for what they do with it.

---

## Changelog

- **0.8 · 2026-09-21** — §4.2 and §4.6 reconciled with the built loop: the capacity question and the motive line are **part of the close**, rendered inline, rather than two further steps behind it — found by walking the built tool, not by reading the spec. §4.6 also pins that a wave is stored nowhere. **Housekeeping:** this header had said 0.4 since the palette reversal while the changelog ran to 0.7; the changelog was right.
- **0.7 · 2026-09-20** — §4.5 pins what **"unprompted"** means, after the build found the obvious reading unbuildable: `wasPrompted` is hardcoded `false` by every client in **both** Noticing and Feelings & Needs, because nothing in Tracker ever cues a sitting — so the column has never carried information and a detector resting on it would fire for everyone while looking correct. Resolved as the *scaffolding-withdrawal* reading, which is what D-21 actually says and what the fade mechanism actually does. Also states plainly that the fade is derived from a count: never surfaced, never aimable, but the inference is not count-free and the doc should not pretend otherwise.
- **0.6 · 2026-09-20** — `catchCooldownDays` 3 → 5 (§6), from phase 5 of the build. The three lexicons have very different natural firing rates and the one shared dial was set for the rarest of them: `read` matches ordinary evaluative shorthand on a required field, the other two match narrow phrases on fields that are skipped by default. Records the structural finding too — **this wants a per-type cooldown**, which the stored `lastCatchAt` map already supports and only the dial shape does not. Left as one number on purpose rather than inventing a second before there is usage data to set it from.
- **0.5 · 2026-09-20** — **§4.1 corrected from the build.** The reroute does *not* run steps 2–4 unchanged: step 4's line asserts that someone made the connection, which is exactly what did not happen on that path, so the frame's pivotal sentence was the one thing the escape hatch broke. Step 4 (and step 1's prompt) now take a reroute variant — same side-by-side structure, opposite outcome. Caught while implementing phase 4, not by reading the doc.
- **0.4 · 2026-09-20** — **The needs palette is Noticing's own, not Module 1's** — reversing the 2026-09-20 seam decision on scope grounds (`00-act1-concept.md` §7): reading a need from outside is a wider job than naming one from inside, and the palette needs a category Module 1 could not have — needs that invite no offer — or the list itself argues for intervention. §2 moves it from Out to In, §8.2 becomes an authoring task, §6 splits the dial into pool and display size, and §11 drops the other-directed-subset question, which this answers. Adds the rejection of **place-narrowed palettes** (§4.2): pruning the answer is worse than pre-seeding the question. Also **restores `lastCatchAt`** to `NoticingState` (§9) — the one place Tracker's derive-don't-mirror idiom is the wrong fit, because this cooldown is per-type and day-based, and a dismissed catch is a touch the entry row cannot record.
- **0.3 · 2026-09-20** — Points at `04-build-plan.md` throughout, and records what building against Tracker changed: §9 gains the three data-model deltas (uuid and relations; the fade level derived rather than stored; `lastCatchAt` dropped because the cooldown is derivable from `caughtTypes`, which shrinks `NoticingState` to the single underivable fact), and §10 gains the split of the milestone-3 risk into a 3-day disconfirming smoke and the full feel-test at milestone 8. No change to the concept, the flow, or the fences.
- **0.2 · 2026-09-20** — **Beat 1 of the day-one frame rebuilt from two steps to five** (§4.1): the old version conflated the cue and the need in one question and then asserted the conclusion, which is why the first-to-second transition didn't sit right. Now the person supplies both halves — their own unsaid need, then what was actually *visible* — and the turn is the tool laying their two answers side by side. Adds the `can't think of one → a time you wished someone had` reroute, one new palette (observable cues), and four fields on `NoticingFrame`. **Added §4.3, the log** — days in reverse order, and the refusals that make it safe: no counts, no patterns, no missing-marks, and — specific to this pillar — **no person filter and no search**, the dossier fence. Sections 4.3–4.5 renumbered to 4.4–4.6; milestone 6b added; §12 now points at the feel-test design.
- **0.1 · 2026-09-20** — Initial spec from `00-act1-concept.md`: seven processes (N1–N7), the four-step loop with its scale floor, the three authored catches including the VFI protective-motive route to Reflect, capacity-by-accretion, third-party data rules written through to the schema, failure modes as acceptance criteria, dials, data model with the named absences, eight milestones, and the pre-registered null.
