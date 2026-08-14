# Verification Lab — build plan

*The order it gets built in, the exact files, the algorithms that would otherwise be invented, and the gate at the end of each phase. Implements `04-verification-lab.md`; wireframes `04a-verification-lab-wireframes.html`. Written to be handed to a coding agent together with those two files. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-08-11 · Owner: _root**

---

## 0. Read this first

**Read, in order:** `../02-architecture/04-conventions.md` · `../03-engineering/01-testing.md` · `00-skills-engine.md` §3, §5, §7, §8, §9, §12 · `04-verification-lab.md` (**§4a is the part most easily got wrong**) · then open the wireframes in a browser.

**Then read `03b-decomposition-lab-build-plan.md` §0 and §4** even if Decomposition Lab was never built. Its §0 lists five facts about the existing codebase that this build also depends on, and its §4 establishes the algorithm-spelling-out convention this document continues. Both tools sit on the same engine.

**The property to protect through every phase:** the measurement path never acquires a credential dependency. Every criterion here resolves against an authored key or an instrumented event. A judge is optional, confined to practice feedback and one descriptive metric. If a phase ends with a probe that needs `ANTHROPIC_API_KEY`, the phase is wrong.

## 1. Dependency on Decomposition Lab — read before Phase 1

These two tools share engine deltas. Either order works; what changes is how much of Phase 1 and Phase 5 this build pays for.

| Piece | If `03` has shipped | If it has not |
|---|---|---|
| `SkillAttempt.responseStructure` | exists — reuse it | **add it here** (same column, same purpose: a small JSON artifact rather than prose) |
| Skill-agnostic probes (`services/skills/probes.ts`) | exists — Phase 5 is a thin extension | **Phase 5 builds it**, and must be written skill-agnostic because Clarity and Evidence inherit it |
| Shared review scheduling fixed for all skills | fixed in `03` Phase 1b | **fix it here**, same way: Clarity sets `masteredAt` but never `nextReviewAt`, and `skillDueReviews` reads evidence only |
| `SkillCheckEvent` as the ordering primitive | three tools on it | four either way — no change needed |

**Check which world you are in before writing the migration**, by reading `prisma/schema.prisma` for `responseStructure` and `SkillKey`, and `services/skills/` for `probes.ts`.

## 2. What this plan implements

Settled 2026-08-11 and not open for re-litigation during the build:

1. **Two rungs** (`04-verification-lab.md` §4a). Assisted = hard ceiling + enumerated element list, V4 feedback-only, mastery unreachable. Unassisted = no ceiling + free-text-then-list, sufficient cost revealed after commit. **Probes run unassisted at every timepoint regardless of the learner's practice rung.**
2. **The discrimination line appears on every reveal**, in all four states, and is **never suppressed after N sightings**. The negative form disappears when the learner stops triggering it, not when the UI stops saying it.
3. **Six bench entries per item.** If a later variant authors more and shows six, the six must be a **fixed deterministic subset per item**, never a per-learner sample.
4. **The cost prediction is in** — one number, committed before any spend, on the unassisted rung.
5. **Western digits in both locales.** Records existing behaviour; do not introduce Persian-digit rendering anywhere.

## 3. Phases

### Phase 0 — Confirm the ground · *no code*

`cd api && npm test` and `cd client && npm test` both green before touching anything; record the counts. Resolve §1's dependency question. Verify `03b` §0's five facts still hold.

### Phase 1 — Migration · *one commit*

```prisma
enum SkillKey { clarity evidence decomposition verification }

model SkillModuleProgress {
  /// "assisted" | "unassisted" — the rung this module is currently practised at
  /// (04-verification-lab.md §4a). Per module, not per learner: competence here
  /// is uneven by fault class.
  rung String @default("assisted")
}

model SkillAttempt {
  /// The rung this attempt was taken on. Stamped, never derived — a module's
  /// rung changes over time, so deriving it would retroactively relabel history
  /// and silently join two different instruments into one trend line.
  rung String?
  /// Only if 03 has not already added it.
  responseStructure String?
}
```

```bash
cd api && npx prisma migrate dev --name add_verification_lab && npx prisma generate
```

`rung` is a column on `SkillAttempt` rather than a field inside `behaviors` JSON for the same reason `SkillCheckEvent` is rows: it is a **series-splitting key**, so it has to be queryable and groupable, not parsed out of a blob per row.

**Convention #11: update `../02-architecture/01-data-model.md` and add a migration note to `../../decisions/decision-log.md` in the same commit.** If §1 put the shared-scheduler fix in this build, that is a **second, separate commit** — do not tangle it with the migration.

### Phase 2 — Content pack and validator · *no credential*

```
api/src/content/skills/verification/
  types.ts                 # module keys, criteria, item/bench/element types, toPublicVerificationItem()
  validate.ts
  v1/
    spec.ts   rubric.ts   surface.en.ts   surface.fa.ts   index.ts
```

Register in `versions.ts`: `CURRENT_VERSION.verification = "verification/v1"` plus `VERIFICATION_VERSIONS` and `ENROLLABLE_VERIFICATION_VERSIONS`.

The item spec, which is most of the design:

```ts
type BenchEntry = {
  checkId: string;
  costSeconds: number;
  independent: boolean;      // false for self-critique, stated confidence, re-asking the same model
  discriminating: boolean;   // would have returned differently had the artifact been wrong
  bearsOnClaim: boolean;     // may be true while discriminating is false: correct, and irrelevant
};

type VerificationItemSpec = {
  itemId: string;
  moduleKey: VerificationModuleKey;
  formId: FormId;                       // "A" | "B" | "C" | "pool"
  difficulty: Difficulty;
  profile: FaultProfile;                // §5 of the spec; CORRECT and NO_ORACLE are the controls
  oracleClass: "partial" | "metamorphic" | "full" | "none";
  bench: BenchEntry[];                  // exactly 6
  elements: { elementId: string; decoy: boolean }[];   // >=4, >=2 decoys
  failingElementId: string | null;      // null on CORRECT and NO_ORACLE
  keyVerdict: "supported" | "unsupported" | "outdated" | "cannot_verify";
  notWorthChecking: boolean;            // a control the key says needs no check at all
  keyNote: string;
  keyVerifiedAt: string | null;
};
```

**`cheapestSufficientCost` is derived, never authored** — it is `min(costSeconds)` over entries where `discriminating === true`. Authoring it separately gives it somewhere to drift to, and a wrong value silently mis-scores V4 on every attempt of that item.

Validator rules, all errors unless noted:

| Code | Rule |
|---|---|
| `bench-size` | exactly 6 entries |
| `bench-no-discriminating` | ≥1 entry with `discriminating: true`, else the item is unsolvable and V3 unscoreable |
| `bench-all-discriminating` | ≥1 entry with `discriminating: false`, else V3 is free and the item measures nothing |
| `bench-no-costume` | ≥1 entry with `independent: false` on `v2` module items — the costumes must be present to be recognised |
| `elements-too-few` | ≥4 elements |
| `elements-no-decoys` | ≥2 decoys, else the list narrows to its own answer |
| `element-key-missing` | `failingElementId` present and non-decoy for every non-control item; null for controls |
| `oracle-class-coverage` | ≥4 distinct `oracleClass` values across each module pool |
| `pool-too-small` | ≥6 pool items per module |
| `control-ratio` | ≥2 controls per module pool, including ≥1 `CORRECT` and ≥1 `NO_ORACLE`; ≥⅓ per form |
| `form-composition` | forms A/B/C: 6 scored items each, 4 faulty + 2 control, matched across forms on profile and difficulty |
| `locale-parity` | identical `itemId` set and identical specs across `en`/`fa` |
| `no-persian-digits` | no `[۰-۹٠-٩]` in any surface string — decision 2.5 |
| `key-unverified` | *warning* — blocks probes, not practice |
| `locale-draft` | *warning* |

`fa` is a **translation of a locale-invariant spec**, like Decomposition and unlike Clarity/Evidence: the faults are units, magnitudes, boundaries and inverted logic, which survive translation. Conventions #7a/#7b/#7c apply. Ship `reviewStatus: "draft"`.

Test: `verificationContent.unit.test.ts`, per `01-testing.md` §2 — the invariants that live *between* two hand-written files.

### Phase 3 — Scoring, session service, GraphQL · *no credential*

```
api/src/services/skills/verification/
  detectors.ts             # V1 oracle-bears-on-claim (keyed), V6 residual-risk presence
  metrics.ts               # ritual state, cost ratio, discrimination, agreement, prediction error
  scoring.ts               # per-criterion levels + evidence + strict composite
  verificationSession.ts   # serve → name oracle → reveal checks → commit → localise → score
```

**The bench-leak rule shapes the API.** A served item carries bench entries as `{checkId, label, costSeconds}` **only** — no `independent`, no `discriminating`, no outcome. Outcomes are served **one at a time, on selection**:

| Operation | Stamps | Rejects when |
|---|---|---|
| `startVerificationItem(mode, moduleKey)` | opens the attempt, stamps `rung` | — |
| `nameVerificationOracle(attemptId, text, predictedCostSeconds?)` | `oracle_named` | any `check_selected` already exists |
| `revealVerificationCheck(attemptId, checkId)` → **that one outcome** | `check_selected`, `check_revealed` | no `oracle_named`; already revealed; assisted rung and the ceiling would be exceeded |
| `commitVerificationVerdict(attemptId, {verdict, confidence, residualRisk, elementId? \| elementFreeText?})` | `verdict_set` (+`localization_set` on assisted) | already committed |
| `setVerificationLocalization(attemptId, elementId)` | `localization_set` | unassisted only; no `verdict_set` |

**Assisted rung:** the element list is included in the verdict step, `elementId` arrives with the commit, scoring runs there.
**Unassisted rung:** the commit carries `elementFreeText`, the response returns the element list, and **scoring runs at `setVerificationLocalization`** — nothing is revealed before it.

`responseStructure` JSON:

```json
{ "oracle": { "text": "…", "predictedCostSeconds": 15 },
  "checksRun": ["c1","c4"],
  "verdict": "unsupported", "confidence": 90,
  "elementFreeText": "the multiplication", "elementId": "e3",
  "residualRisk": "the kWh estimate is still unchecked" }
```

`scores` JSON adds to the standard shape: `strict`, `ritualState`, `costSpent`, `costRatio`, `rung`.

GraphQL: own types (`VerificationModule`, `VerificationServedItem`, `VerificationBenchEntry`, `VerificationCheckOutcome`, `VerificationAttemptResult`, `VerificationProgress`), queries `verificationModules` / `verificationProgress`, plus `setVerificationRung(moduleKey, rung)` for the offered promotion. Reuse `logSkillCheckEvent`, `skipSkillAssessment`, `resetSkillProgress` unchanged. Convention #1 on every resolver.

Tests: `verificationMetrics.unit.test.ts` (all four ritual states, cost ratio boundaries, discrimination), `verificationScoring.unit.test.ts`, `verification.integration.test.ts` — including **the fixture that matters most: a correct verdict reached with only non-discriminating checks must score strict composite 0, V3 = 0, ritual state `none-could-fail`.**

### Phase 4 — Frontend · *no credential*

```
client/app/components/skills/
  VerificationLabPage.tsx       # plates 1, 9
  VerificationSessionPage.tsx   # plates 2, 5, 7 — stage machine, rung-aware
  OracleBench.tsx               # plates 3, 4 — new component
  VerificationReveal.tsx        # plate 6 — new component
```

Routes `/tools/skills/verification` and `/…/session` in `protectedRoutes.tsx`; documents in `queries.ts` via `useApi()` (convention #6); strings in both locales under `skills.*` (convention #7); `ModuleIntroOverlay` with `moduleKey = "skills.verification"`; **do not touch `OnboardingSlideshow`**.

Display rules to test rather than style:

- Cost visible before a check is run; **outcome never visible before it is run.**
- The element list is **absent from the DOM** during check selection — not hidden with CSS. A list in the markup is a list in devtools.
- The discrimination line renders on **every** reveal, in the correct one of four states, and is never suppressed by a seen-count.
- V4 renders as "not scored on this rung" on assisted attempts, with the total reading `9 / 10` and "5 of 6 criteria scored" beneath.
- No trend line joins attempts across rungs; a promotion renders a visible series marker.

RTL pass on bench, outcomes and reveal panes. Western digits in both locales — no numeral transliteration anywhere. One test file, `client/app/test/VerificationSession.test.tsx`, covering the four discrimination states and the element-list absence.

### Phase 5 — Probes · *no credential*

If `probes.ts` exists (§1), this phase is: register `verification` with it, author forms A/B/C, and assert probes force `rung: "unassisted"`. If it does not exist, build it per `03b` §3 Phase 5 — skill-agnostic, at `services/skills/probes.ts`, with a test that exercises two skill keys.

**The assertion that protects everything else:** a probe attempt is stamped `rung: "unassisted"` regardless of the learner's module rung. Tiering the instrument between baseline and post would make a promoted learner appear to get worse.

### Phase 6 — Judge · **credential required** · optional

Two uses, both outside measurement: prose feedback on the free-text oracle statement in practice, and **recall–recognition agreement** (does the learner's free-text localisation match the element they then picked). Agreement is `null` without a credential and nothing downstream changes. Reuse `services/skills/clarity/anthropicJudge.ts`. `createAnthropicJudge()` returning `null` is a supported state.

### Phase 7 — Real-work verification record · *no credential*

Free-text oracle, no bench, paste-back of what the learner found outside the app, producing the record card (claim · oracle · result · verdict · residual risk), saveable as a `JournalEntry` or `Note`. `mode: open_practice`, excluded from mastery and probes. **No sandbox, no calculator, no search proxy** — see §4.

### Phase 8 — Human work · *not code*

Key verification for the 18 probe items, including **re-deriving every authored bench outcome** — an outcome that is wrong is a silent mis-score with no symptom. Native Persian review. Rubric agreement pass, ~20 double-scored samples per criterion per locale; below threshold a criterion runs feedback-only and says so. Add to `../../../team/open-work.md` when Phase 2 lands.

## 4. Algorithms

### 4.1 Ritual state — four values, all reported

```
run = checks the learner revealed before verdict_set
if run.length === 0                      -> "none-run"
else if run.every(c => !c.discriminating) -> "none-could-fail"     // the ritual state
else if run.some(c => !c.discriminating)  -> "some-could-fail"
else                                      -> "all-could-fail"
```

**Ritual rate** counts only `none-could-fail` over attempts with ≥1 check. `none-run` is abstention, a different failure, and pooling the two would make the headline metric uninterpretable. All four states drive the reveal line (spec §10); only one drives the metric.

### 4.2 Strict composite

```
oracleOk   = V1 === 2
couldFail  = V3 === 2
verdictOk  = verdict === key.keyVerdict
strict     = oracleOk && couldFail && verdictOk
```

Binarised at level 2 on both criteria — conservative, matching Evidence Lab's L × I × A. A composite that accepted partial credit would let a half-formed check count as a check.

### 4.3 Cost

```
spent      = sum(costSeconds of revealed checks)
cheapest   = min(costSeconds where discriminating)      // derived, §3 Phase 2
ratio      = spent / cheapest
V4 = 0  if ratio > 3, or the item is notWorthChecking and any check was run
V4 = 2  if ratio <= V4_NEAR   (V4_NEAR = 1.5, a named constant — expect to tune it)
V4 = 1  otherwise
```

On the **assisted rung V4 is `null`**, not 0. Ratio is still computed and displayed; it just enters no total. A ceiling makes ratio > 3 unreachable, so scoring it there would be scoring a different criterion.

### 4.4 Discrimination, agreement, prediction

```
discrimination = hits / faultyItems − falseAlarms / controlItems
agreement      = matches(elementFreeText, chosenElementId) / attempts   // judge-only; null without one
predictionErr  = |predictedCostSeconds − cheapest| / cheapest           // descriptive, never scored
```

### 4.5 Promotion

Offered — never applied — when, on the assisted rung for that module, the learner reaches strict composite on **≥4 of the last 6** attempts **with no control false alarm**. `setVerificationRung` is the only way the rung changes, and it is always a learner action. **There is no automatic demotion.** A learner may step back voluntarily.

## 5. What must not be built — check at every gate

- [ ] **Never ship bench outcomes with the served item.** One outcome, on selection, from the server.
- [ ] **Never render the element list during check selection** — absent from the DOM, not hidden.
- [ ] **Never execute the learner's check.** No sandbox, no calculator, no search proxy, no "run this for me".
- [ ] **Never suppress the discrimination line** after N sightings, and never make its positive form congratulatory.
- [ ] **Never tier a probe**, and never pool a metric across rungs.
- [ ] **Never auto-demote a rung.**
- [ ] **Never put the judge in the measurement path.** Agreement is `null` without a credential and that is fine.
- [ ] **No generic verification checklist surface.** Oracles are per fault class; the inspection experiments are the reason.
- [ ] **No Persian digits.** Validator-enforced.
- [ ] **No key material in any client payload** before the corresponding reveal — bench tags, outcomes, profiles, `failingElementId`, verdicts. Asserted by test.
- [ ] **Do not touch other tools' content or scoring.** Shared files this build may modify: `versions.ts`, `scheduler.ts`, `mastery.ts`, `probes.ts`, `typeDefs.ts`, the three resolver files, `protectedRoutes.tsx`, `queries.ts`, the two locale files.

## 6. Acceptance, per phase

| Phase | Gate |
|---|---|
| 0 | Both suites green; §1 resolved; `03b` §0 facts verified |
| 1 | Migration clean; `SkillKey` has the new value; `rung` on both models; data-model doc + decision log updated in the same commit |
| 2 | Validator zero errors; warnings only `key-unverified` / `locale-draft`; every §3 count asserted; `cheapestSufficientCost` derived and asserted against a hand-computed fixture |
| 3 | Full path completes on both rungs. Reveal before `oracle_named` **rejected**; second commit **rejected**; ceiling breach on assisted **rejected**. The correct-verdict-by-ritual fixture scores strict 0. No key material in any payload |
| 4 | A module sitting completes with **no credential**; four discrimination states each render; element list absent from DOM during selection; V4 renders "not scored" on assisted with `9 / 10`; both i18n checks clean; RTL pass; no Persian digits |
| 5 | Baseline → six modules → post → 7-day delayed completes, **every probe attempt stamped `rung: "unassisted"`** (asserted); full probe with outbound network blocked (asserted) |
| 6 | Agreement populates with a credential and is `null` without one, with no other behaviour change |
| 7 | Record saves as journal/note; open-practice attempts appear in history and in no mastery or probe total |
| 8 | Per-criterion agreement at threshold before that criterion enters a probe total; below-threshold criteria feedback-only and visibly marked |

## 7. Commit sequence

```
add verification to SkillKey; per-module rung; attempt rung stamp
verification/v1 content pack and validator
verification scoring, session service and GraphQL
verification lab frontend; the oracle bench
the ritual-first reveal
register verification with skill probes
judge-backed oracle feedback and recall-recognition agreement
real-work verification records
```

## 8. Risks to the build itself

| Risk | Looks like | Guard |
|---|---|---|
| **The bench leaks** | Whole bench with tags/outcomes in one payload because it is convenient | Payload-shape test; one outcome per server round-trip |
| **The element list leaks** | Rendered hidden rather than absent | DOM-absence test, not a visibility test |
| **V4 scored under a ceiling** | Assisted attempts show `x / 12` | Test asserting `null` and the `n / 10` render |
| **Ritual line becomes a badge** | Positive form written as praise, or suppressed after a few sightings | Copy review against the four-state table; test that the line renders on every reveal |
| **`cheapestSufficientCost` drifts** | Authored alongside the bench and silently disagreeing with it | Derived in code; fixture test |
| **Probe tiering creeps in** | "It would be kinder to let beginners probe assisted" | Assertion in Phase 5; the reason is written in spec §4a |
| **Persian digits reintroduced** | A well-meaning locale pass | Validator rule `no-persian-digits` |

---

## Changelog

- **0.1 · 2026-08-11** — Written after the wireframe review settled the four decisions in §2. Adds three things the spec did not carry: `rung` as a stamped column on `SkillAttempt` rather than a derived value (a module's rung changes, so deriving it would retroactively relabel history), `cheapestSufficientCost` as **derived rather than authored** (an authored copy has somewhere to drift to and fails silently), and the bench-leak rule expressed as an API shape — one outcome per server round-trip, since a served bench carrying its own answers is the one payload that would quietly invalidate every item. §1 makes the plan executable whether or not Decomposition Lab has shipped.
