# Impact Act 1 — **Noticing** · build plan for Tracker

*How the spec becomes code in the Tracker repo: where every file lands, which host conventions it inherits and the one it deliberately breaks, why Noticing authors its own needs palette rather than sharing Learn's, the data model as it actually ships, the GraphQL surface, the test suites — including the one that makes the dossier fence a failing build rather than a paragraph — and the two gates. Spec: `01-noticing-spec.md`. Feel-test: `03-spine-evaluation.md`. Living layer. Update the changelog; don't fork.*

**Version 0.4 · Status: built and merged (phases 1–7) · 2026-09-21 · Owner: _root**

---

> **Built 2026-09-20, merged 2026-09-21.** Phases 1–7 are on `tracker` `main` (via `impact-noticing`; 62 test files / 1079 tests green). What remains is **phase 8 and Gate A — both human** (§10); until they run, “built” means the code, not the verdict. The as-built record, including every decision the plan did not specify, is `tracker/notes/noticing-build-log.md`; read that before this doc if you are picking the work up.

## 1. What this adds to the spec

`01-noticing-spec.md` §10 gives eight milestones and one sentence each. That is the right altitude for a spec and the wrong altitude for a build: it does not say which files exist, which of Tracker's existing conventions are binding, or what "done" means for a phase.

This plan answers those. It is written against the **Feelings & Needs module as built** (`api/src/content/feelings-needs/`, `api/src/services/feelingsNeeds/`, `client/app/components/learn/`), because that module is the precedent and copying its shape is most of the reason this build is cheap.

Three things changed the plan on contact — one from re-opening a settled decision, two from reading the host repo:

1. **Noticing authors its own needs palette.** The seam decision is reversed on scope, which deletes a phase rather than adding one. §4.
2. **Tracker derives rather than mirrors — and once is the wrong call here.** The fade level is derived; the catch cooldown is not. §6.
3. **The fences can be tests.** Tracker already reads its own GraphQL SDL in a unit test. The same move turns "no search box, no person index" from a promise into a red build. §9.4.

## 2. Where it lands

**Route namespace:** `/tools/impact/noticing`, beside `/tools/learn/feelings-needs` and `/tools/skills/*`. Impact is a new second-level namespace in `client/app/protectedRoutes.tsx`; nothing else about routing changes.

**GraphQL type prefix:** `Ntc*`, as Feelings & Needs uses `Fn*`.

**Nothing outside `content/noticing/`, `services/noticing/` and `components/impact/` is created.** The only edits to existing files are additive: four routes, one SDL block, eleven resolvers, one tools-home card, the locale files. Feelings & Needs is **not touched at all** — which is the practical payoff of §4.

### File map

| Path | New? | What |
|---|---|---|
| `api/src/content/noticing/{types,dials,index}.ts` | new | content types, dials, version registry |
| `api/src/content/noticing/v1/{index,spec,surface.en,surface.fa}.ts` | new | the pack, **including its own needs palette** |
| `api/prisma/schema.prisma` | edit | four models + three `User` back-relations |
| `api/prisma/migrations/<ts>_add_noticing/` | new | one migration |
| `api/src/services/noticing/state.ts` | new | state, frame, fade, graduation |
| `api/src/services/noticing/session.ts` | new | the loop: sittings, passes, close, history |
| `api/src/services/noticing/catches.ts` | new | the three authored catches |
| `api/src/graphql/schema/typeDefs.ts` | edit | one `# ── Impact · Noticing ──` block |
| `api/src/graphql/resolvers/{query,mutations}.ts` | edit | 4 queries, 7 mutations |
| `api/src/__tests__/noticing{,Content,Catches,Guardrails,Fences}.*.test.ts` | new | five suites — §9 |
| `client/app/components/impact/Noticing{Page,FramePage,LoopPage,LogPage}.tsx` | new | four pages |
| `client/app/protectedRoutes.tsx` | edit | four routes |
| `client/app/api/queries.ts` | edit | the documents |
| `client/app/components/tools/ToolsHomePage.tsx` | edit | one card |
| `client/app/locales/{en,fa}/common.json` | edit | `impact.noticing.*` |

## 3. Conventions inherited, and why each is binding here

These are not style preferences; each one is load-bearing for something in the spec.

**Content is authored, versioned, and pinned per user.** `getNoticingPack(contentVersion, locale)` with a `VERSIONS` registry and a cache, versions never deleted — copied from `content/feelings-needs/index.ts`. The pin matters more here than it did there: the person is building familiarity with a **place palette and a cue palette**, and a content bump that silently swapped words under them would be exactly the instability the practice is supposed to be free of.

**Spec / surface split, English-only, `fa` structurally present.** The prototype ships English content. The split is the one shortcut not taken — the same call as Module 1 — and the `fa` surface is authored as a declared draft with `reviewStatus: "draft"` so the UI can say so, rather than being absent and falling back to English. A locale with no surface **throws**; it does not fall back. Falling back would hand someone a vocabulary exercise in a language they are not noticing in.

**Every step commits as it goes.** There is no `submitNoticingLoop` mutation. Partial state is valid state — this is what makes a sitting resumable and what stops a closed tab losing a pass. It is also why `completedAt` is nullable and why an abandoned sitting is left alone rather than cleaned up: an abandoned pass is honest data about how the loop is used.

**Detection and fade are server-side.** The catch lexicons never reach the browser (`toPublicPack` strips them), and the prompt fade is served, not computed by the client. A client that decided when to stop explaining would be a second, silent copy of the dial.

**Derive, don't mirror — where it is right, not because it is the house style.** Tracker dropped `LoopState.frameDone` and `LoopState.promptFadeLevel` once it was clear the sittings were the authoritative record and a cached number beside them is a number that can disagree with them. Noticing follows that **for the fade level** and deliberately does **not** for the catch cooldown, where the same reasoning does not hold. §6.

This is worth stating as a general permission with a narrow scope, because these tools are rehearsals for standalone pillar apps and will migrate out of Tracker: **a divergence is free to take where the pillar's shape differs from Tracker's, and costs a second idiom to carry where Tracker simply happens to be right.** The test is whether the reason survives without the phrase "the host does it" — and, since the code migrates later, whether the divergence is one you would still want in the standalone app. Below, that permission is spent exactly once.

## 4. The needs palette is Noticing's own

**Reversed.** The concept doc's first version of this seam shared Learn Module 1's twelve needs, and this plan's first version turned that into a phase-0 extraction — pulling the palette into its own versioned content module that both packs import. Both are withdrawn. Noticing authors its own palette inside its own pack, and `content/feelings-needs/` is not touched.

**The reason is scope, and it is not a code argument.** Module 1's palette is tuned for naming a need **from the inside**, where the evidence available is a feeling:

```
rest · connection · to_matter · safety · space · ease
to_be_seen · autonomy · trust · understanding · respect · support
```

Twelve inward, relational words. Noticing asks a different question — *what might a thing I could **see** point at?* — and the set that is legible from outside is wider in three directions the inside set has no reason to cover:

- **Practical and physical.** A hand with something heavy. A seat. Food, warmth, a working door. These are the needs a stranger can actually show you, and they are most of what the loop's scale floor puts in front of someone.
- **Informational.** *To know what's going on*, *to know it isn't just them*, *direction*. Visible as confusion, as asking twice, as standing in the wrong queue.
- **Needs that invite no offer.** *To be left alone.* *Nothing from anyone right now.* This is the category that only appears once the list is authored for this job, and it is the one that matters most: a palette on which every word argues for intervention **is** the savior framing that spec §5 names as a failure mode. Module 1 had no reason to carry these — you do not offer yourself a hand — so an inherited palette would silently make the tool push.

The last point is the one that decides it. The shared palette was not merely too small; it was **biased toward acting**, in a tool whose whole thesis is that noticing is the skill and the offer is optional.

**What survives of the shared decision is the part that was load-bearing.** The worry behind it was two tools growing incompatible vocabularies for one concept. That worry is real and is answered by an authoring rule, not a code dependency: **where both palettes mean the same need, they carry the same id.** No recoining `to_matter` as `mattering`. Asserted in the content suite (§9.1), which is cheap, and which leaves both tools' content versions independent — the problem the extraction was invented to dodge in the first place.

**What it costs.** Phase 2 grows: ~20 needs authored in English with a declared-draft `fa` surface, rather than twelve imported free. Two lists exist where one was planned, and they can drift — the id rule bounds the drift to *coverage*, which is the harmless kind. And the pool is wider than the screen should ever be, so the `needPoolSize` / `needDisplayCount` split (spec §6) is not optional bookkeeping here; it is what stops a twenty-word step becoming a menu to browse.

**One convenience rejected while authoring it:** the palette is **not** narrowed by the chosen place. It would be easy, and it would be the tool deciding what kind of need a commute is allowed to contain. Worse than pre-seeding `place`, because it prunes the answer rather than the question.

## 5. The phases

Sizes are relative, not calendar. Each phase ends green and runnable; nothing is left half-wired between phases.

| # | Phase | What lands | Done when | Size |
|---|---|---|---|---|
| **1** | Scaffold | models + migration; `content/noticing/` skeleton with types, dials, registry, v1 with placeholder copy; `state.ts`; `noticingState` query; the four routes with a home page shell; `impact.noticing.*` keys in both locales | `/tools/impact/noticing` loads, reports `frameDone: false`, and the i18n checks pass | M |
| **2** | Content | the nine assets of spec §8 — place palette, **the needs palette (§4)**, frame copy (five beats + the reroute), the cue chips, loop prompts, three catch lexicons with their response copy, capacity chips, graduation copy, the third-party warning line. `surface.fa.ts` authored as a declared draft | `noticingContent` returns a full pack; content + guardrail suites green | L |
| **3** | **The spine** | `session.ts`: start sitting, four-step pass committing as it goes, the close, the bounded repeat, the side-by-side recap. `NoticingLoopPage`. The third-party warning under the person field | the loop runs end to end, and **the 3-day smoke passes** — §10 | L |
| **4** | Day-one frame | beat 1's five steps + the `can't think of one` reroute, beat 2's prediction and its one-time correction, gated to once | frame completes once, is idempotent, and the loop is reachable without it having been done (it is not a gate on Module 1, and Module 1 is not a gate on it) | M |
| **5** | Catches | `catches.ts`: the three types, per-type cooldown, at most one per sitting, in-context and declinable | catch suite green, including *never fires on the person field* | M |
| **6** | Capacity + handoff | the post-offer "what did you have that made that possible?", head/hands/heart accretion, the Reflect motive stub | a pass with a small thing asks once and stores; nothing is computed from the answer | S |
| **6b** | The log | `NoticingLogPage` — days in reverse, and the refusals | **fences suite green** (§9.4) | S |
| **7** | Self-initiation | prompt fade served from the server, the one-time graduation door | fade level advances off completed sittings; the door fires once and cannot re-fire | S |
| **8** | Polish + feel-test | the two-week run of `03-spine-evaluation.md` | the decision rule in that doc has been applied | — |

**Ordering notes.** There is no phase 0 any more — §4 deleted it rather than deferring it. 3 before 4 is deliberate and is a departure from how Module 1 was built: there, the frame gated the loop. Here the frame is a *rehearsal of the loop's own inference* (spec §4.1), so it cannot be authored well until the loop it rehearses exists and has been felt. 5 after 3 for the same reason the module itself says so — a refinement layer is never the opening move. 6b can move earlier if the feel-test wants more to replay, and that is the only phase whose position is negotiable.

## 6. The data model as it lands — three deltas from spec §9

Spec §9 is marked illustrative. Three things change on contact with the repo. Two are the host's own precedent; the third is a deliberate divergence from it.

**Delta 1 — `uuid()`, relations, cascade.** Tracker uses `String @id @default(uuid())` throughout, with an explicit `user User @relation(..., onDelete: Cascade)` and back-relations on `User`. The spec's `cuid()` was drawn from nothing in particular.

**Delta 2 — `promptLevel` is derived, not stored.** Module 1 stored `promptFadeLevel` on `LoopState`, then dropped it: the sittings are the authoritative record, a cached number beside them can disagree with them, and deriving it means there is no write path to forget. `computeFadeLevel(completedSittings)` does the work and is capped at the graduation dial, so it is never a number that keeps climbing — which would be a score in everything but name. Noticing copies this exactly.

**Delta 3 — `lastCatchAt` stays. This is the one place the host's idiom is the wrong fit, and it is where the §3 permission gets spent.**

The first draft of this plan derived the catch cooldown from `NoticingEntry.caughtTypes`, on the grounds that Module 1's `catchAllowed` derives its own the same way. Two things break the parallel, and both are properties of Noticing rather than preferences:

- **The cooldown is per-type and measured in days, not per-pass.** Module 1 has one catch and counts passes, so "have enough passes happened" is a cheap read of rows it is already holding. Noticing has three catch types on a `catchCooldownDays: 3` window, so the derived form is a date-bounded join from entries through sittings, parsing a JSON string per row, on **every** catch evaluation — to answer a question a three-key map answers exactly.
- **A dismissed catch is still a touch, and the entry row cannot know that.** The catch is surfaced after the person has written and is declinable by design — `dismiss` is load-bearing, not politeness. Dismissal happens *after* the entry write, so `caughtTypes` systematically under-records the thing the cooldown exists to space out. Deriving from it would let a person be touched three times in a week while the data said once.

So the state row keeps a small JSON map of catch type → last date. It is **not** a counter and the fences suite (§9.4) still forbids one; it records when something last happened, which is what a cooldown is.

`caughtTypes` stays on the entry regardless, for the different job spec §12 gives it: whether N6-a fires **less over time on the same person's text** is the module's real learning signal, and that is an entry-level fact, not a state one.

```prisma
model NoticingFrame {           // tier 1, once
  id            String   @id @default(uuid())
  userId        String   @unique   // the frame happens once
  /// Beat 1 step 1 — the recalled episode, one line.
  moment        String?
  /// Step 2 — the person's own unsaid need. Palette key or free text.
  unsaidNeed    String?
  /// Step 3 — JSON string: cue chip keys plus any free text.
  visibleCues   String?
  /// Took the "a time you wished someone had" reroute. Not a failure flag:
  /// the reroute is a first-class path through the frame.
  wishedInstead Boolean  @default(false)
  /// The beat-2 prediction, kept only so the correction can be shown once
  /// against what they actually guessed.
  welcomeGuess  String?
  completedAt   DateTime @default(now())
  user          User     @relation(fields: [userId], references: [id], onDelete: Cascade)
}

model NoticingSitting {         // passes within a sitting are parallel, never related
  id          String          @id @default(uuid())
  userId      String
  wasPrompted Boolean         @default(false)
  /// Null while open, which is what makes a sitting resumable — every step
  /// commits as it goes. Not a completion metric: nothing is shown a total.
  completedAt DateTime?
  createdAt   DateTime        @default(now())
  user        User            @relation(fields: [userId], references: [id], onDelete: Cascade)
  entries     NoticingEntry[]

  @@index([userId, createdAt])
}

model NoticingEntry {           // one pass
  id           String          @id @default(uuid())
  sittingId    String
  /// 0-based position within the sitting. A soft cap bounds how many passes a
  /// sitting can hold, so it can never become an inventory of people.
  passIndex    Int
  place        String?
  /// Free text, deliberately UN-INDEXED. There is no Person entity, no
  /// autocomplete across entries, no cross-entry lookup, and no index on this
  /// column — building the index is what would turn this tool into a dossier.
  /// Any future sharing surface MUST de-identify this field; do not add a share
  /// path without one. See 00-act1-concept.md §6, 01-noticing-spec.md §7.
  person       String?
  observation  String?
  /// Palette key (shared needs palette) or free text. Null is "not sure",
  /// which is a complete pass and not a missing answer.
  need         String?
  /// Null by default. Skipped is the ordinary outcome, not an omission.
  smallThing   String?
  /// JSON string, head/hands/heart. Only written when smallThing is set, and
  /// it records what the person HAD — never who they helped.
  capacityTags String?
  /// The Reflect handoff answer. Stored; nothing is computed from it.
  motiveNote   String?
  /// JSON string of catch types that fired on this pass. Read for cooldown
  /// only — never aggregated, never shown.
  caughtTypes  String?
  createdAt    DateTime        @default(now())
  sitting      NoticingSitting @relation(fields: [sittingId], references: [id], onDelete: Cascade)

  @@index([sittingId])
}

model NoticingState {
  id                 String   @id @default(uuid())
  userId             String   @unique
  /// Pinned at enrolment. The words should not change under someone mid-practice.
  contentVersion     String
  /// JSON string, catch type → ISO date of the last touch. A cooldown, not a
  /// counter: it records WHEN something last happened, never how often. Kept
  /// here rather than derived from `caughtTypes` because a dismissed catch is
  /// still a touch and the entry row cannot know that. See 04-build-plan.md §6.
  lastCatchAt        String?
  /// A door you have walked through cannot be lost, which is what stops it
  /// re-firing — and there is deliberately no counter behind it.
  graduationSurfaced Boolean  @default(false)
  createdAt          DateTime @default(now())
  updatedAt          DateTime @updatedAt
  user               User     @relation(fields: [userId], references: [id], onDelete: Cascade)
}
```

**The named absences, which the fences suite enforces:** no `count`, no `streak`, no `total`, no `Person` model, no index on `person`, and no index that would make a person-ordered read cheap.

`ensureNoticingState` uses create-then-recover rather than `upsert`, for the reason `ensureLoopState` does: the home page may fire two queries in parallel on a fresh account, both find nothing, both insert, and losing the unique-constraint race is the ordinary outcome, not an error.

## 7. The GraphQL surface

One block in `typeDefs.ts`. Sketch, not final SDL:

```graphql
type NoticingState {
  contentVersion: String!
  locale: String!
  reviewStatus: String!        # draft | reviewed
  "Whether the day-one frame has been done. Does NOT gate the loop."
  frameDone: Boolean!
  graduationSurfaced: Boolean!
  "How far the app has withdrawn its prompts. Derived, capped, never shown."
  promptFadeLevel: Int!
}

type NtcPaletteEntry { id: String!  label: String! }
type NtcFrameCopy    { ... }          # five beats + the reroute + beat 2
type NtcLoopCopy     { ... }          # prompts, terse variants, helpers, close
type NoticingContent {
  contentVersion: String!
  locale: String!
  reviewStatus: String!
  places: [NtcPaletteEntry!]!
  cues: [NtcPaletteEntry!]!           # beat-1 step 3, the frame's only new palette
  needs: [NtcPaletteEntry!]!          # the shared palette
  capacity: NtcCapacityCopy!
  frame: NtcFrameCopy!
  loop: NtcLoopCopy!
  graduation: NtcGraduationCopy!
  thirdPartyWarning: String!
}

type NtcEntry   { id: ID!  passIndex: Int!  place: String  person: String
                  observation: String  need: String  smallThing: String
                  capacityTags: String  motiveNote: String }
type NtcSitting { id: ID!  completedAt: String  createdAt: String!  entries: [NtcEntry!]! }

"A catch, composed server-side. The lexicon never ships to a browser."
type NtcCatch   { type: String!  line: String!  hints: [String!]!
                  dismiss: String!  note: String!  routeTo: String }

type NtcEntryResult  { sitting: NtcSitting!  catch: NtcCatch }
type NtcFinishResult { sitting: NtcSitting!  graduation: NtcGraduationCopy }

extend type Query {
  noticingState: NoticingState!
  noticingContent: NoticingContent!
  activeNoticingSitting: NtcSitting
  "The person's own record, reverse-chronological. No search, no person filter — see §9.4."
  noticingHistory(limit: Int): [NtcSitting!]!
}

extend type Mutation {
  completeNoticingFrame(moment: String, unsaidNeed: String, visibleCues: String,
                        wishedInstead: Boolean, welcomeGuess: String): NoticingState!
  startNoticingSitting(wasPrompted: Boolean): NtcSitting!
  updateNoticingEntry(entryId: ID!, place: String, person: String,
                      observation: String, need: String, smallThing: String): NtcEntryResult!
  setNoticingCapacity(entryId: ID!, capacityTags: String!): NtcSitting!
  setNoticingMotive(entryId: ID!, motiveNote: String!): NtcSitting!
  addNoticingPass(sittingId: ID!): NtcSitting!
  finishNoticingSitting(sittingId: ID!): NtcFinishResult!
}
```

Note what has no field: nothing takes a `person` or `search` argument, nothing returns a count, and there is no query that groups by anything but a sitting. `noticingHistory` returns sittings in reverse order and computes nothing — grouping into days is the client's job, because a day is a local-timezone concept and the server does not know the offset.

## 8. The catch engine

`services/noticing/catches.ts` is `feelingsNeeds/distinctions.ts` with one structural change: three catch types instead of one, so cooldown is per-type.

| Kept as-is | Changed |
|---|---|
| authored lexicon, no model, no classifier | three lexicons (`read`, `strategy`, `protective`), keyed by type |
| `normalizeForMatch`, case-insensitive, word boundaries | matched **per field**, and the field mapping is part of the contract |
| longest match wins | — |
| at most one catch per pass | plus `catchesPerSitting: 1` across passes |
| declinable — `dismiss` is load-bearing, not politeness | N6-c has no hint chips; it **routes** to Reflect instead of offering an answer |
| cooldown derived from prior entries | per type, `catchCooldownDays: 3` |

**The field contract, and it is the important part.** Module 1's matcher binds itself to the feeling field only, because several triggers are ordinary words that would over-fire inside prose. Noticing needs the same discipline plus one rule of its own:

| Catch | Matches against | Never against |
|---|---|---|
| N6-a read-as-observation | `observation` | anything else |
| N6-b strategy-as-need | `need`, `smallThing` | `observation` — a strategy *observed* is just a fact |
| N6-c protective-motive | `smallThing`, `motiveNote` | `observation` |
| *all three* | — | **`person`** |

The last row is a fence, not an optimization. A matcher that ran over the person field would be the tool forming an opinion about a named human being. It is asserted in the catch suite (§9.3) and stated in the file's docblock.

## 9. Tests

Four suites mirroring Module 1's, plus one new kind.

**9.1 `noticingContent.unit.test.ts`** — the pack builds for both locales; palette sizes match `DIALS`; every cue and place id in the surface is declared in the spec and vice versa; `fa` is structurally matched and declares itself `draft`; a missing surface throws rather than falling back. **Plus the id-discipline rule of §4:** every need id Noticing shares in meaning with Learn Module 1 is asserted to carry Module 1's id, so the two palettes can differ in coverage and never in coinage. The test imports Module 1's `NEED_IDS` read-only; it is an assertion about authoring, not a runtime dependency.

**9.2 `noticingGuardrails.unit.test.ts`** — the copy sweeps, written against the authored pack rather than the intent, because every guardrail in spec §5 is a property of *copy* and copy gets edited by people thinking about how a sentence reads. Sweeps: no streak, score or total language anywhere; no word framing the other person as a project or a task; the word *help* does not appear where *notice* would do; every optional step names its skip in plain words; "not sure" is closed warmly rather than as a shortfall; the catch always offers a way to decline; nothing congratulates; graduation reads as a capability, not an achievement.

**9.3 `noticingCatches.unit.test.ts`** — word boundaries (no firing inside a longer word), longest-match-wins, one per pass and one per sitting, per-type cooldown, and **the field contract of §8, including that no lexicon is ever matched against `person`.**

**9.4 `noticingFences.unit.test.ts` — the new one, and the best idea in this plan.**

Tracker already parses its own GraphQL SDL in `schema.unit.test.ts` to catch what TypeScript cannot see inside a template literal. The same move makes the spec's structural refusals executable. This suite reads `prisma/schema.prisma` and `typeDefs.ts` as text and asserts:

- no `@@index` on any Noticing model mentions `person`;
- no model named `Person`, and no Noticing model has a field named `count`, `streak`, `total` or `tally`;
- no field in the Noticing SDL block accepts an argument named `search`, `person`, `query` or `name`;
- `noticingHistory` returns `[NtcSitting!]!` and not a person-keyed type;
- the public content type exposes no `lexicon` field.

Every one of these is something a competent developer would add in good faith on a Tuesday. A search box is the single most natural thing in the world to put above a list of text entries. Writing it in a doc makes it a thing to remember; writing it here makes it a red build.

**9.5 `noticing.integration.test.ts`** — frame once and idempotent; the loop running end to end; a pass ending at "not sure" recorded as complete; the repeat refusing past the soft cap and closing warmly; history returning only completed sittings, in reverse order, computing nothing; fade level advancing off completed sittings only, with an abandoned sitting not counting as a rep; the graduation door firing exactly once.

**Client:** the i18n scripts (`i18n:check-hardcoded`, `i18n:check-missing`) must pass, which means `impact.noticing.*` exists in **both** locale files from phase 1 — including the `contentNotYourLanguage` banner, since the practice content is English-only in the prototype and that is a real limit rather than a cosmetic one.

## 10. The two gates

Spec §10 says milestone 3 is the risk and no later milestone rescues it. Making that actionable needs a correction to the sequencing, because the feel-test as designed cannot run at phase 3: `03-spine-evaluation.md` schedules think-aloud at days 1/4/10 and a DRM pair around a fortnight of daily use, and daily use presupposes the frame (phase 4) and something to come back to (6b). So there are two gates, not one.

**Gate A — the 3-day smoke, at the end of phase 3.** Founder only, one instrument: retrospective think-aloud after each of three sittings, coded for the single distinction the feel-test turns on — *recalling a person* versus *composing an entry*. No questionnaires; at n=1 over three days they would be noise. It cannot confirm the spine. It can **disconfirm** it, which is the entire point of putting it here: composing rather than recalling, three times out of three, means phases 4–8 would be polish on the wrong object.

**Gate B — the full feel-test, phase 8.** `03-spine-evaluation.md` as written, with its decision rule and its named ambiguous outcome.

**What "stop" means at Gate A**, written now so it is not renegotiated later under sunk cost: revise the spine's *shape* — the order of the four steps, or whether the person step exists at all as a field rather than as something held in mind — and re-run the three days. Not: add copy, soften a prompt, or proceed while noting a concern.

## 11. What this plan does not settle

- **Whether `place` is pre-seeded** (spec §11). Phase 3 builds it chosen-fresh, because pre-seeding is exactly the convenience that would let a pass complete without anyone looking at anything. Reversible, and worth trying the other way at Gate A.
- **Whether the capacity portrait is shown at all** in the prototype. Phase 6 accretes it silently; showing it is a one-screen addition and a separate decision.
- **How wide "wider" actually is.** §4 argues for three directions and sizes the pool at ~20; the right number is an authoring question that phase 2 answers, and the display dial makes getting it wrong survivable.
- **The `en`-only content**, which the fa draft surface makes cheap to fix but does not fix.
- **Persian names**, pillar and tool.
- **Whether the log wants an empty state that says something**, or whether the honest empty state is emptiness. Leaning: Module 1's line ("it fills up as you go") is right, and nothing beyond it.

---

## Changelog

- **0.4 · 2026-09-21** — **Merged to `main`.** Two corrections made after walking the built tool rather than re-reading the plan: the close **absorbed** the capacity and motive questions instead of trailing them as two more screens behind an offer (spec → 0.8), and the log page stopped swallowing the server’s error — which is how a **general auth bug** surfaced that was never this tool’s (`tracker/decisions/decision-log.md` D-60). The habit this plan inherited, of giving each page its own polite local error card, is exactly what had kept that bug invisible app-wide.
- **0.3 · 2026-09-20** — **Built.** Phases 1–7 landed as seven commits on `impact-noticing`. Four things the plan got wrong or left underspecified, all now fixed upstream in the spec: `NoticingFrame.completedAt` had to be nullable (copied from a row written once at the end, but the frame commits as it goes, so the row was born complete and anyone who abandoned mid-frame was marked done); the day-one reroute cannot run step 4 unchanged, because that line asserts someone made the connection and on that path nobody did; `catchCooldownDays` was set for the rarest lexicon rather than the most common one; and "unprompted" could not mean un-cued, because `wasPrompted` is hardcoded `false` by every client in **both** this module and Feelings & Needs. The plan's own §9.4 fence suite earned its place twice over — sanity-checking it found that a case-sensitive `Noticing` match silently skipped every lowercase query name, so the Query-block fence would have passed vacuously forever.
- **0.2 · 2026-09-20** — **Phase 0 deleted: Noticing authors its own needs palette** (§4). The extraction solved a coupling problem that only existed because the palette was being shared, and sharing it was wrong on scope — a need read from outside is a wider set than a need named from inside, and the category an inherited palette could never carry is *needs that invite no offer*, without which every word on the list argues for intervention. What survives is an authoring rule with a test behind it: the same need carries the same id in both tools. Also **reverses delta 3** (§6): `lastCatchAt` stays on `NoticingState`, because this cooldown is per-type and day-based rather than per-pass, and because a **dismissed** catch is a touch the entry row cannot record. §3 gains the general form of that permission — divergence is free where the pillar's shape differs from Tracker's, and costs a second idiom where Tracker simply happens to be right — and notes it is spent exactly once.
- **0.1 · 2026-09-20** — Initial build plan against Tracker as built. Adds the file map and route namespace; **phase 0, the shared-needs-palette extraction**, with the two rejected alternatives and the persisted-id constraint; three deltas to the spec's illustrative data model (uuid/relations, fade derived not stored, `NoticingState` shrunk to the one underivable fact once cooldown is derived from `caughtTypes`); the GraphQL surface with its named absences; the catch engine's per-field matching contract including *never match `person`*; five test suites, among them **`noticingFences`**, which reads the Prisma schema and the SDL as text so the dossier fence fails the build rather than sitting in a doc; and the split of milestone 3's risk into a 3-day disconfirming smoke at phase 3 and the full feel-test at phase 8, with "stop" defined in advance.
