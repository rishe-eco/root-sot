# Journey — **Minimum Reflect** · spec

*Spec, not as-built. The smallest Reflect that can do the three jobs the loop gives it: carry a noticed need to an intention (with its motive checked), take a failure apart, and hold a free reflection. Built first, because it is step 2 of the first act and receives every failure. Pillar canon: `../../canon/02-pillars/reflect.md` (§2 the four moves, §4 mirror vs patterns, §5 couplings, §6 the reconstrual bet). Update the changelog; don't fork.*

**Version 0.2 · Status: spec · 2026-10-18 · Owner: _root**

---

## 1. The decisions this spec rests on

1. **One engine, three entries** — *need*, *failure*, *free*. They share screens and differ in what they open on and where they close.
2. **LLM-free.** Authored prompts and authored lexicons, like Feelings & Needs and Noticing. The canon leans towards an agent-driven mirror (`reflect.md` §8). That is deferred, not rejected: the loop can be tested without a model, and a model brings the authoring-drift risk (anti-patterns §3) before there is anything to compare it against.
3. **The mirror is structural.** "Pure reflection, no analysis, not mere repetition" (`reflect.md` §4) is met by **laying the person's own words side by side** — the move Noticing's frame proved out (`../impact-build/01-noticing-spec.md` §4.1, step 4). Nothing is inferred, summarised or interpreted.
4. **Exactly one reconstrual move per sitting.** H6b — writing alone is not enough, re-seeing from a step back is the lever (Kross & Ayduk) — is now load-bearing for the whole child version, so the minimum carries it rather than deferring it. The move is **the friend's view**: *"If a friend told you this, what would you say to them?"* (self-distancing; and self-compassion after failure increases the motivation to improve rather than lowering it — Breines & Chen, 2012).
5. **Feelings and needs reuse Feelings & Needs' palettes** (Module 1 ids). This is the person naming their *own* state, which is Module 1's job; Noticing's palette is for reading someone else and stays Noticing's. This is the canon's "Module 1 is Reflect's instrument" made concrete (`learn.md` §2).
6. **Pattern recognition stays gated** (`reflect.md` §4) — nothing in this spec reads across entries.

## 2. Scope

**In:** the three entries; story; feelings and own need (optional); the side-by-side mirror; one reconstrual move; the motive check (need entry); intent, obstacle and an optional if-then (need entry); meaning (failure entry); two catches; an immediate-action-or-handoff close; a log by day.

**Out:** an agent; cross-entry patterns of any kind; search; scales or intensity ratings; sharing; turning a reflection into a Journal entry (Journals stay as they are); Persian surface content.

## 3. The screens

| # | Screen | Prompt | Input | Entries |
|---|---|---|---|---|
| R1 | **what happened** | need: *"You saw: …"* (carried) + *"Anything else about that moment?"* · failure: *"What actually happened?"* · free: *"What happened? A day, an hour, a moment."* | free text | all |
| R2 | **what it stirs** | *"What did it stir in you?"* | F&N feelings palette + `other → type it` · skippable | all |
| R3 | **what you care about** | need: *"Why does this matter to you?"* · others: *"What were you needing?"* | F&N needs palette + text · skippable | all |
| R4 | **the mirror** | *(no question)* their R1, R2 and R3 side by side | — | all |
| R5 | **care or should** | *"Where is this coming from?"* | *I care about it · I feel I should · both · not sure* · waveable | need |
| R5b | **the friend's view** | *"Imagine a friend told you this exact story. What would you tell them?"* | free text | need (after *should*/*both*) · failure (always) · free (offered) |
| R6 | **what you'd like to do** | *"What would you like to do about it?"* | one line | need |
| R7 | **what's in the way** | *"What's most likely to get in the way?"* then, optional: *"If that happens, then I'll…"* | free text · optional if-then | need |
| R8 | **what it says** | *"What does this tell you about what you care about?"* | free text · skippable | failure |
| R9 | **close** | §5 | | all |

**R6 + R7 are deliberate.** A wish alone predicts *lower* effort (positive fantasies predict less energy and worse outcomes — Kappes & Oettingen, 2011; Kappes, Oettingen & Mayer, 2012). A wish held next to its obstacle, plus an if-then plan, is mental contrasting with implementation intentions — small-to-medium effects on goal attainment (g ≈ 0.34, probably smaller after publication bias — Wang et al., 2021). The if-then is optional because the goal and capacity steps that follow do some of the same work.

## 4. Rules

### 4.1 The mirror never adds a word
R4 shows only what the person wrote or picked. If R2 and R3 were skipped, R4 shows R1 alone and says nothing about the gaps. Reordering is allowed; paraphrase is not.

### 4.2 Skips are written nowhere
As in Noticing (§4.6 there): a waved motive question or a skipped palette lives in component state and dies with it. A stored "declined" is a record of a refusal.

### 4.3 Two catches, authored, on a cooldown
Surfaced after writing, gently, never blocking, original text kept and editable — the Noticing and Module 1 convention.

- **R-a · verdict-as-event** (failure and free entries, on R1). Lexicon: entity-theory and global-self language — *always, never, I'm just, lazy, useless, hopeless, typical me, can't do anything right, failure* (as a noun for oneself). Response: *"'I'm lazy' is a verdict, not something that happened. What happened?"* This is Reflect §2.3's reality check, aimed at the specific story that turns a missed step into a trait.
- **R-b · should** (all entries, on any free text). **Noticing's protective-motive lexicon reused** (the VFI protective register — *should, have to, ought, guilty, the least I can do*). In the need entry it routes to R5 if R5 was waved; elsewhere it offers R5b.

The faux-feeling catch from Module 1 also fires on R2's `other` text, reused as is.

Cooldown `reflectCatchCooldownDays`, **per type** from the start (the lesson Noticing recorded in its §6). Max one catch per sitting.

### 4.4 The motive branch (need entry)
- **care** → R6.
- **should / both** → R5b, then *"Is there a part of this you'd want to do even if no one ever knew?"* → **yes**: R6, reshaped around that part · **no**: the close offers *let it go* (in the first act → the noticing path) · **"I'll do it anyway"**: allowed — R6 as written, `motive` kept on the reflection (`01-first-act.md` §4.3).
- **not sure** → R6, unflagged. Not knowing is ordinary.
- **waved** → R6. Nothing stored.

### 4.5 Immediate action, or a handoff (Reflect §3)
Reflect never queues anything for later. Every sitting ends in one of:

| Close | Means | Writes |
|---|---|---|
| **doing it now** | the small act is done or happening | `outcome = actNow` |
| **make it a goal** | → the goal form, title from R6 | `outcome = goal`, `goalId` |
| **back to the look** | failure entry → returns to `05-failure-and-ignoring.md` with R5b/R8 attached | `outcome = returned` |
| **notice more** | → Noticing (in the first act: the noticing path) | `outcome = notice` |
| **let it rest** | nothing to do now | `outcome = rest` |

In the first act the close is fixed to *make it a goal* — it carries on to the batteries step.

## 5. Where Reflect is opened from

| From | Entry | Carries in |
|---|---|---|
| first act step 2 | need | the `NoticingEntry` |
| Noticing's close, **"work on this →"** (new) | need | the `NoticingEntry` |
| Noticing's motive chip (as built, a stub today) | need | the `NoticingEntry` — **the stub is replaced by this** |
| a look, in the failure flow | failure | the `PursuitLook` and its goal or action |
| the overview, "Reflect" | free | — |

## 6. The log

Reflections by day, newest first: R1's text and the close. **No counts, no patterns, no search, no filter** — the same refusals as Noticing's log (§4.3 there), for the same reasons. A reflection that made a goal links to it.

## 7. Failure modes = acceptance criteria

| Failure | What it looks like | Guard |
|---|---|---|
| **Rumination** | the person circles "why am I like this" | story first, the loop always moves on (R1 → R9); R-a catches the global-self story; no "why" prompt anywhere |
| **Journaling-only** | writing with no re-seeing (H6b's low-value case) | R5b is in every failure sitting and every *should*; the mirror lays the halves side by side |
| **Analysis by the tool** | the mirror interprets | R4 adds no word (§4.1); no model |
| **Motive audit as surveillance** | being asked "was this obligation?" after every kind act | R5 is only on the need entry, waveable, a wave stored nowhere; R-b routes the people whose own words raise it |
| **Flattening** | feelings reduced to a number | no scales, no intensity, palettes and words only (anti-patterns §3) |
| **Deferral** | Reflect becomes a to-do list | the close has no "later" except handing to Organize as a goal |

## 8. Data (illustrative; convention #12 applies on landing)

```prisma
model Reflection {
  id              String    @id @default(uuid())
  userId          String
  entry           String    // "need" | "failure" | "free"
  noticingEntryId String?   // need entry
  pursuitLookId   String?   // failure entry (05)
  story           String?   // R1
  feelings        String?   // JSON: F&N palette ids + free text
  needs           String?   // JSON: F&N palette ids + free text — the person's OWN needs
  motive          String?   // "care" | "should" | "both" | "unsure"; null = waved or not asked
  friendView      String?   // R5b
  intent          String?   // R6
  obstacle        String?   // R7
  ifThen          String?   // R7, optional
  meaning         String?   // R8
  outcome         String?   // "actNow" | "goal" | "returned" | "notice" | "rest"
  goalId          String?   // set when outcome = goal
  caughtTypes     String?   // JSON: catches fired this sitting (one-per-sitting gate)
  completedAt     DateTime? // null while open — resumable
  createdAt       DateTime  @default(now())
  @@index([userId, createdAt])
}

model ReflectState {            // per-type catch cooldowns; no counters
  id          String   @id @default(uuid())
  userId      String   @unique
  lastCatchAt String?  // JSON: catch type → ISO date (stored, not derived — same reason as NoticingState, convention #13)
  updatedAt   DateTime @updatedAt
}
```

Absent, and staying absent: any count, any score, any field that compares two reflections.

## 9. Content to author (English, prototype)

1. Prompts for R1–R9, per entry, plus the mirror layout copy.
2. R-a lexicon and response copy.
3. Close copy, five outcomes.
4. The *"even if no one ever knew"* follow-up and its three answers.

The F&N palettes, the faux-feeling catch and Noticing's protective lexicon are **reused, not re-authored**.

## 10. Evaluation (the seam this owns)

- **need → intent.** Does the intent still point at what was noticed? Think-aloud plus a read of R6 against the `NoticingEntry`.
- **The H6b probe.** In failure sittings, does what is written *after* R5b differ in kind from R1 (less verdict, more event; a next step appears)? Qualitative coding, founder plus testers. A null here is a real result for the whole child version, not a feature bug.
- **The motive check's feel.** In the interview: did the care/*should* question feel like a check on you or a help to you? (IMI pressure/tension, short form, as in `../impact-build/03-spine-evaluation.md` §2B.)

## 11. Open decisions

- Whether R5b is offered in **free** sittings by default or only on R-b.
- Whether the agent mirror is the next Reflect increment after the child version's first feel-test, or waits for pattern-recognition review.
- Persian: whether R5b's wording survives translation (distanced self-talk is language-sensitive; Persian-first means authored, not translated — `learn.md` §4).

---

## Changelog

- **0.1 · 2026-10-18** — Initial minimum spec: one engine, three entries; LLM-free; a structural mirror that adds no word; one reconstrual move (the friend's view) carried from the start because H6b is now load-bearing; motive check with the *even if no one knew* follow-up; intent beside obstacle plus an optional if-then (MCII); two catches (verdict-as-event, new; *should*, reused from Noticing) with per-type cooldowns; immediate-action-or-handoff close; a log without counts, patterns or search; replaces Noticing's motive stub.
- **0.2 · 2026-10-18** — §4.4: *"I'll do it anyway"* is allowed (founder decision), with `motive` kept; removed from §11.
