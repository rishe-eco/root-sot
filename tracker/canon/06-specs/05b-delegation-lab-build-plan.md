# Delegation Lab — build plan

*The order it gets built in, the exact files, the arithmetic that would otherwise be invented, and the gate at the end of each phase. Implements `05-delegation-lab.md`; wireframes `05a-delegation-lab-wireframes.html`. Written to be handed to a coding agent together with those two files. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-08-11 · Owner: _root**

---

## 0. Read this first

**Read, in order:** `../02-architecture/04-conventions.md` · `../03-engineering/01-testing.md` · `00-skills-engine.md` §3, §5, §7, §8, §9, §12 · `05-delegation-lab.md` — **§1 and §2 are not background, they are the build's constraints** · then open the wireframes.

**Then read `03b-decomposition-lab-build-plan.md` §0** for the five facts about the existing codebase that every tool in this engine depends on, and `04b-verification-lab-build-plan.md` §1 for the dependency-matrix pattern this document reuses.

**Three things about this tool that make it unlike the other four, and that a competent agent will otherwise smooth away:**

1. **It is built expecting a null result.** §12 of the spec carries a pre-registered null — self-assessment calibration improves, reliance discrimination does not. That is what the published literature predicts. **Do not add anything that makes a null harder to see**: no composite "delegation score", no encouraging copy that implies progress the numbers do not show, no chart that joins calibration and discrimination into one trend.
2. **Two numbers are never added together.** Over-reliance and under-reliance are reported side by side, everywhere, forever. A single "reliance" figure would render the exact trade the literature warns about — reducing one failure by increasing the other — as improvement.
3. **The measurement is arithmetic on authored numbers.** No model, no network, no judge, anywhere in the scored path. If a phase ends otherwise, the phase is wrong.

## 1. Dependency on the other tools

| Piece | If `03` or `04` shipped | If neither did |
|---|---|---|
| `SkillAttempt.responseStructure` | exists — reuse | **add it here** |
| Skill-agnostic `services/skills/probes.ts` | exists — register and go | **build it here**, skill-agnostic, per `03b` §3 Phase 5 |
| Review scheduling fixed for all skills | fixed | **fix it here** — Clarity sets `masteredAt` but never `nextReviewAt`; `skillDueReviews` reads evidence only |
| `SkillCheckEvent` as ordering primitive | in use by 3–4 tools | unchanged either way |

Check `prisma/schema.prisma` and `services/skills/` before writing the migration. **This tool needs no `rung` column** — the two-rung progression is specific to Verification Lab's cost bench and has no analogue here.

## 2. What this plan implements

Settled 2026-08-11 and closed:

1. **G5 accepts either lever.** Under high stakes, *reducing reliance* and *keeping reliance while making it recoverable* both reach level 2. Only treating the two framings identically fails. **The recoverability move is recorded; its quality is never scored here** — that is Verification Lab's measurement, and importing it would make a learner weak at #4 lose points on a delegation criterion.
2. **The population WOA baseline (0.39) is withheld** until the baseline probe completes — or 12 scored items if the baseline was skipped — then shown permanently, **on the progress surface only.** Never during an item, never at a reveal.
3. **The `g6` sequence is three rounds** (**D-24**), behind a content constant `G6_ROUNDS`, measuring the documented post-error drop and deferring the undocumented recovery pattern.
4. **The number line does not mirror in RTL.** Smaller values left in both locales.
5. **Western digits in both locales**, as everywhere else in this engine.

## 3. Phases

### Phase 0 — Confirm the ground · *no code*

Both suites green and counts recorded. Resolve §1. Verify `03b` §0's five facts.

### Phase 1 — Migration · *one commit*

```prisma
enum SkillKey { clarity evidence decomposition verification delegation }
```

Plus `SkillAttempt.responseStructure String?` **only if §1 says it is missing**. That is the whole schema change.

```bash
cd api && npx prisma migrate dev --name add_delegation_lab && npx prisma generate
```

Convention #11: data-model doc and a decision-log migration note in the same commit. If §1 puts the shared-scheduler fix here, that is a separate second commit.

### Phase 2 — Content pack and validator · *no credential*

```
api/src/content/skills/delegation/
  types.ts   validate.ts
  v1/  spec.ts  rubric.ts  surface.en.ts  surface.fa.ts  index.ts
```

```ts
export const G6_ROUNDS = 3;                    // D-24 — a constant, never a literal

type DelegationItemSpec = {
  itemId: string;
  moduleKey: DelegationModuleKey;
  formId: FormId;
  difficulty: Difficulty;
  kind: "estimate" | "cue" | "split" | "stakes" | "sequence";
  /** The quantity. Truth is authored; the learner's estimate supplies their competence. */
  truth: number;
  unit: string;
  plausibleRange: [number, number];   // an estimate outside this is void, not wrong
  advice: number;
  cueDirection: "trust" | "keep" | "none";
  cueOptions?: { cueId: string; kind: "category" | "instance" | "none"; bearsOnRelative: boolean }[];
  splitPieces?: { pieceId: string; keyDisposition: "give" | "keep" | "either" }[];
  stakesPairId?: string;              // both halves carry it; neither scores alone
  sequenceRounds?: { advice: number; truth: number; isSeededError: boolean }[];
  keyNote: string;
  keyVerifiedAt: string | null;
};
```

**`adviceQuality` is derived, never authored** — `|advice − truth|` compared against the learner's `|initial − truth|` at scoring time. It is learner-relative by construction, which is the whole reason the instrument self-normalises: the learner's own initial estimate measures their competence on that item, so no domain-expertise questionnaire is needed.

Validator rules, all errors unless noted:

| Code | Rule |
|---|---|
| `advice-balance` | advice closer to truth than a naive midpoint on **50% ± 1 item** of each module pool and each form. **Not ⅓ — see spec §4**; the failure here is symmetric and an imbalanced pack teaches a disposition |
| `cue-balance` | all three `cueDirection` values present in every module pool and every form |
| `advice-implausible` | `advice` inside `plausibleRange`. Advice you would dismiss on sight teaches nothing about weighting |
| `advice-equals-initial-impossible` | `advice ≠ truth`, or WOA is undefined for every learner who guesses correctly |
| `cue-options-shape` | `cue` items carry ≥1 `category` distractor, ≥1 `instance` option, and exactly one `none` option |
| `stakes-orphan` | every `stakesPairId` appears exactly twice |
| `sequence-shape` | `sequenceRounds.length === G6_ROUNDS`, exactly one `isSeededError`, and it is **round 2** |
| `pool-too-small` | ≥6 pool items per module; `g5` counted in pairs, `g6` in sequences |
| `no-persian-digits` | no `[۰-۹٠-٩]` in any surface string |
| `locale-parity` · `key-unverified` *(warning)* · `locale-draft` *(warning)* | as the other packs |

**Authoring constraint, and it is the hard one:** truths must be *estimable* and *checkable* and the set must span the learner's competence range — distances, dates, populations, durations, counts, prices, physical quantities. General-audience per D-17. If every item lands where the learner knows nothing, "keep your own answer" is never correct and the instrument silently degrades into a deference meter.

### Phase 3 — Scoring, session service, GraphQL · *no credential*

```
api/src/services/skills/delegation/
  woa.ts                    # §4.1 — the one file everything else depends on
  metrics.ts                # discrimination, over/under, net gain, anchoring, calibration, drop
  scoring.ts                # per-criterion levels + evidence
  delegationSession.ts      # serve → commit estimate → serve advice → commit revision → cue → score
```

**The ordering rule that makes the instrument valid, and the only thing in this tool that can silently destroy it:**

> **The advice is absent from the served payload until `estimate_committed` is stamped.** Not hidden, not disabled, not `display:none` — **absent**. WOA is meaningless if the initial estimate can move after the advice is seen, and it is the number every metric here derives from.

| Operation | Stamps | Rejects when |
|---|---|---|
| `startDelegationItem(mode, moduleKey)` | opens attempt | — |
| `commitDelegationEstimate(attemptId, value, confidence)` → **returns the advice** | `estimate_committed`, `confidence_committed`, `advice_shown` | estimate outside `plausibleRange` (void, not scored); already committed |
| `commitDelegationRevision(attemptId, value)` | `revision_committed` | no `estimate_committed`; already committed |
| `selectDelegationCue(attemptId, cueId)` | `cue_selected` | no `revision_committed` |
| `commitDelegationSplit(attemptId, dispositions)` | `split_committed` | split items only |
| `commitSequenceRound(attemptId, roundIndex, value, phase)` | `estimate_committed` / `revision_committed` with `roundIndex` in the payload | round out of order |

`responseStructure` JSON:

```json
{ "initial": 900, "confidence": 40, "advice": 1240, "final": 950,
  "cueId": "c3", "split": [{"pieceId":"p1","disposition":"give"}],
  "recoverabilityMove": true,
  "rounds": [{"i":1,"initial":…,"advice":…,"final":…}] }
```

`scores` adds `woa`, `benchmark`, `discriminationContribution`, `direction` (`"over" | "under" | "ok"`), `netGain`.

**A `g6` sequence is one attempt with `G6_ROUNDS` rounds** in that array — never linked attempts, or every per-attempt metric in the engine is wrong for that module. **A `g5` pair scores as a difference**; the service refuses to score one half alone.

Own GraphQL types (`DelegationModule`, `DelegationServedItem`, `DelegationAdvice`, `DelegationAttemptResult`, `DelegationProgress`). Convention #1 everywhere. Reuse `logSkillCheckEvent`.

Tests: `delegationWoa.unit.test.ts` (§4.1's edge cases, all of them), `delegationMetrics.unit.test.ts`, `delegation.integration.test.ts` — **including a test that the advice field is absent from the served payload before commit**, which is the assertion this tool lives on.

### Phase 4 — Frontend · *no credential*

```
client/app/components/skills/
  DelegationLabPage.tsx        # plates 1, 7
  DelegationSessionPage.tsx    # plates 2, 3, 5
  ThreePositionReveal.tsx      # plate 4 — the new component
  AdvisorSequence.tsx          # plate 6
```

Routes, `queries.ts` documents via `useApi()`, both locales under `skills.*`, `ModuleIntroOverlay` with `moduleKey = "skills.delegation"`, no `OnboardingSlideshow` changes.

Display rules to test rather than style:

- **Advice absent from the DOM** before the estimate commits.
- **The initial estimate stays visible** during revision — the movement is the measurement.
- **WOA never rendered during an item.** Reveal only.
- **Over- and under-reliance render as one bordered pair**; no view sums or averages them.
- **Calibration and discrimination render as separate lines with no causal arrow.**
- **The number line does not mirror in RTL** — the track stays LTR while labels and surrounding prose flip.
- **The two failure directions get different copy** — *you ignored help* and *you took harm* are not one lesson.

One test file, `client/app/test/DelegationSession.test.tsx`: advice-absence, WOA-absence-during-item, and the RTL axis direction.

### Phase 5 — Probes · *no credential*

Register `delegation` with `probes.ts`, or build it per `03b` if absent. Forms A/B/C, 6 scored items, advice balanced 50/50, all three cue directions. Self-report collected, never scored.

**Gate the population baseline here** (§2.2): `DelegationProgress.populationBaseline` resolves to `null` until the baseline probe completes or 12 scored items exist. Absent from the payload, not hidden client-side.

### Phase 6 — Real-work delegation record · *no credential*

The only mode in the engine that spans two sittings: logged **before** the decision (what I am handing over, what I am keeping, what would tell me the split was wrong), a reminder, then the outcome. `mode: open_practice`; excluded from mastery and probes; saveable as `JournalEntry` or `Note`.

### Phase 7 — Human work · *not code*

Key verification for the probe items — **including re-deriving every `truth`**, since a wrong truth value inverts advice quality and silently reverses the headline metric. Native Persian review. No judge calibration pass: this tool has no judge.

## 4. Arithmetic

### 4.1 Weight of advice — and its four edge cases

```
WOA = (final − initial) / (advice − initial)
```

Every one of these will occur in real data and each needs a decided answer, not a runtime surprise:

| Case | Rule |
|---|---|
| `advice === initial` | WOA **undefined** → the item contributes to no WOA-derived metric. The validator prevents authored ties, but a learner can guess the advice value exactly. |
| `final` beyond `advice` (overshoot past the advice) | **Clamp to 1.0** for scoring, and record the raw value. Overshooting is real behaviour and worth having in the data; letting it exceed 1 would let one item dominate a mean. |
| `final` moved *away* from advice | **Clamp to 0.0**, record raw as negative. Reactance is a genuine pattern and deserves to be visible in the export. |
| estimate outside `plausibleRange` | **Void** — scored on nothing, flagged, and never averaged in as a zero. |

Clamp for scoring, retain raw for export. A metric that silently clamps and does not retain has thrown away the most interesting learners.

### 4.2 The benchmark, per item

```
cueDirection "none"  -> benchmark = 0.50      // averaging beats both when you can't tell
cueDirection "trust" -> benchmark = 0.75
cueDirection "keep"  -> benchmark = 0.25
```

G3 level: `|WOA − benchmark| ≤ 0.2` → 2; `≤ 0.4` → 1; else 0. The two cued values are **named constants** (`BENCH_TRUST`, `BENCH_KEEP`) and are expected to be tuned once real data exists — they are a defensible starting position, not a finding.

### 4.3 The headline metrics

```
discrimination = mean(WOA | cueDirection = "trust") − mean(WOA | cueDirection = "keep")
overReliance   = share of items where WOA > 0.5 AND adviceError > initialError
underReliance  = share of items where WOA < 0.25 AND adviceError < initialError / 2
netGain        = mean(|initial − truth| − |final − truth|)
anchoring      = mean(|WOA − 0.5| | cueDirection = "none")
calibration    = Brier over (confidence/100) against (initialError < median item error)
dropRatio      = WOA(round 3) / WOA(round 1)          // g6; undefined if round 1 WOA is ~0
```

**`overReliance` and `underReliance` are returned as a two-field object and never as a sum.** Do not add a convenience field that combines them; someone will chart it.

### 4.4 G5, the stakes pair

```
lowHalf, highHalf = the two attempts sharing stakesPairId
reducedReliance   = WOA(high) <= WOA(low) − PAIR_DELTA          // PAIR_DELTA = 0.15
insuredReliance   = WOA(high) >= WOA(low) − PAIR_DELTA AND recoverabilityMove(high)
G5 = 2  if reducedReliance OR insuredReliance
G5 = 1  if some change but below PAIR_DELTA and no recoverability move
G5 = 0  if |WOA(high) − WOA(low)| < NO_CHANGE_EPS (0.05) and no recoverability move
```

`recoverabilityMove` is a **boolean the learner sets** — "I'd check this before acting" — and **nothing in this tool grades the check**. That boolean is the entire footprint of the #4 cross-link; resist every temptation to score what they would check or how well.

### 4.5 Mastery

Per spec §7: discrimination ≥ 0.25, anchoring ≤ 0.15, netGain > 0, **and** neither error rate above the module threshold — across two distinct calendar days on unscaffolded items. The fourth clause is load-bearing: discrimination is a *difference* and says nothing about the level, so a systematically over-trusting learner can score well on it.

## 5. What must not be built

- [ ] **No combined "reliance" or "delegation" score**, anywhere, in any payload, chart or export.
- [ ] **No causal framing between calibration and discrimination** in copy or layout.
- [ ] **Advice never in a payload before `estimate_committed`.**
- [ ] **WOA never rendered during an item.**
- [ ] **No grading of the recoverability check** (§4.4).
- [ ] **The number line does not mirror in RTL**; digits stay Western.
- [ ] **No population baseline before the gate** (§2.2) — absent from the payload, not hidden in the client.
- [ ] **No encouraging copy that implies progress the numbers don't show.** This tool must be able to tell a learner nothing moved.
- [ ] **No `rung` mechanic.** Not this tool.
- [ ] **Do not touch other tools' content or scoring.** Shared files modifiable here: `versions.ts`, `scheduler.ts`, `mastery.ts`, `probes.ts`, `typeDefs.ts`, the three resolver files, `protectedRoutes.tsx`, `queries.ts`, the two locale files.

## 6. Acceptance, per phase

| Phase | Gate |
|---|---|
| 0 | Suites green; §1 resolved |
| 1 | Migration clean; enum has five values; data-model doc + decision log in the same commit |
| 2 | Validator zero errors; advice balance 50/50 ± 1 asserted; all three cue directions present; `sequenceRounds.length === G6_ROUNDS` with the error on round 2; no orphan stakes pair |
| 3 | **Advice absent from the served payload before commit** (asserted). All four §4.1 edge cases covered by unit tests. A `g5` half cannot be scored alone. A `g6` sequence persists as one attempt. Raw WOA retained alongside clamped |
| 4 | A module sitting completes with no credential; advice absent from DOM; WOA absent during item; over/under render as a pair with no sum anywhere; RTL axis stays LTR; both i18n checks clean; no Persian digits |
| 5 | Baseline → six modules → post → 7-day delayed completes; full probe with outbound network blocked; **`populationBaseline` is `null` in every payload before the gate** (asserted) |
| 6 | Before/after record saves; open-practice excluded from every total |
| 7 | Every probe item's `truth` independently re-derived and `keyVerifiedAt` set |

## 7. Commit sequence

```
add delegation to SkillKey
delegation/v1 content pack and validator
weight-of-advice scoring, session service and GraphQL
delegation lab frontend; the three-position reveal
the advisor sequence
register delegation with skill probes; gate the population baseline
real-work delegation records
```

## 8. Risks to the build itself

| Risk | Looks like | Guard |
|---|---|---|
| **A combined reliance score appears** | "It's confusing to show two numbers" | §5 checklist at every gate; the reason is in spec §1 |
| **Advice leaks into the first payload** | Served with the item because it is one query | Payload-shape test; two round-trips by design |
| **WOA edge cases crash or silently skew** | Division by zero; a single overshoot dominating a mean | All four cases in §4.1 unit-tested |
| **A wrong `truth` inverts the headline** | Advice quality computed against a bad value; discrimination reverses sign with no symptom | Phase 7 re-derivation; `keyVerifiedAt` gates probes |
| **The baseline anchor ships early** | Rendered but hidden client-side | Null in the payload, asserted |
| **The RTL axis gets mirrored** | A well-meaning RTL pass flips everything | Direction test in the frontend suite |
| **`G6_ROUNDS` becomes a literal** | `rounds[4]` somewhere | Grep gate; D-24 exists so the constant can change cheaply |

---

## Changelog

- **0.1 · 2026-08-11** — Written after the wireframe review settled §2's five decisions. Adds three things the spec did not carry: the **four WOA edge cases** with a decided rule each and the clamp-for-scoring / retain-raw-for-export split (a metric that clamps without retaining discards its most interesting learners); **`adviceQuality` as derived rather than authored**, which is what makes the instrument self-normalising against each learner's own competence; and the **`recoverabilityMove` boolean as the entire footprint of the #4 cross-link**, so G5 can accept either lever without importing Verification Lab's measurement.
