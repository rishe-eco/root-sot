# Monitoring Lab — build plan

*The order it gets built in, the exact files, the statistics that would otherwise be invented, and the gate at the end of each phase. Implements `06-monitoring-lab.md`; wireframes `06a-monitoring-lab-wireframes.html`. Written to be handed to a coding agent together with those two files. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-08-12 · Owner: _root**

---

## 0. Read this first

**Read, in order:** `../02-architecture/04-conventions.md` · `../03-engineering/01-testing.md` · `00-skills-engine.md` §3, §5, §7, §8, §9, §12 · `06-monitoring-lab.md` — **§2 is the build's constraint set, not background** · then open the wireframes.

**Then read `03b-decomposition-lab-build-plan.md` §0** for the five codebase facts every tool in this engine depends on.

**Four things about this tool that are unlike the other five:**

1. **The artifact is a prediction, not a product.** Every item collects a claim the learner makes about *themselves*, then measures it. The ordering rule — prediction stamped before the item becomes answerable — is not a nicety here; it is the entire instrument.
2. **Two numbers never appear apart.** Resolution and task performance are a bordered pair. This mirrors Delegation Lab's over/under pair but for a different reason: there, splitting them prevents a trade from looking like progress; **here, joining them prevents a confound from looking like a skill.**
3. **The content job is the largest of the six.** Short-answer acceptable-answer sets, matched assisted/unassisted pairs, three-step causal lists, authored transcripts with typed *and weighted* influences, clean controls, and countermeasure lists. Phase 2 is where this build will be underestimated.
4. **This is the easiest place in the engine to accidentally build a nag.** A tool about attention, with a decay chart in it, one careless copy decision away from "you've been sloppy lately." The standing refusal (**D-3**) applies with force.

## 1. Dependency on the other tools

| Piece | If any of `03`–`05` shipped | If none did |
|---|---|---|
| `SkillAttempt.responseStructure` | exists — reuse | **add it here** |
| Skill-agnostic `services/skills/probes.ts` | exists — register | **build it here**, skill-agnostic |
| Review scheduling fixed for all skills | fixed | **fix it here** |

Check `prisma/schema.prisma` and `services/skills/` before writing the migration. **No `rung` column, no new tables.**

## 2. What this plan implements

Settled 2026-08-12 and closed:

1. **The §1.1 AI-literacy finding is withheld** until the learner's own post-AI inflation number exists, then shown attached to it — **including when that number is near zero**, saying so. A finding that appears only when damning is a lecture wearing a statistic.
2. **Three causal steps per `s2` item**, behind a constant `S2_STEPS`.
3. **Cross-tool transfer:** the hypothesis is recorded in spec §9a; **`skillCrossExport` is P2**; nothing cross-tool is shown to the learner.
4. **Resolution is never rendered without task performance beside it.**
5. **Planted and clean transcript turns are styled identically**; ~⅓ of transcripts are clean.
6. **Persian `s4` transcripts are re-authored, not translated** (تعارف); everything else translates.
7. **Western digits in both locales.**

## 3. Phases

### Phase 0 — Confirm the ground · *no code*
Both suites green, counts recorded. Resolve §1. Verify `03b` §0's five facts.

### Phase 1 — Migration · *one commit*

```prisma
enum SkillKey { clarity evidence decomposition verification delegation monitoring }
```

Plus `SkillAttempt.responseStructure String?` **only if §1 says it is missing**. That is all. Convention #11: data-model doc and decision-log migration note in the same commit.

### Phase 2 — Content pack and validator · *the large phase*

```
api/src/content/skills/monitoring/
  types.ts   validate.ts
  v1/  spec.ts  rubric.ts  surface.en.ts  surface.fa.ts  index.ts
```

```ts
export const S2_STEPS = 3;
export const MIN_ANSWER_VARIANTS = 3;

type MonitoringItemSpec = {
  itemId: string;
  moduleKey: MonitoringModuleKey;
  formId: FormId;
  difficulty: Difficulty;
  kind: "recall" | "pair" | "explain" | "transcript" | "longset";

  /** recall — short answer. A narrow key silently inverts the resolution measure. */
  answerVariants?: string[];                 // >= MIN_ANSWER_VARIANTS, normalized at build
  requiredTokens?: string[][];               // alternative token-set matches

  /** pair — matched assisted/unassisted. Both halves carry the id; neither scores alone. */
  pairId?: string;
  pairHalf?: "assisted" | "unassisted";
  authoredExplanation?: string;              // shown on the assisted half only

  /** explain — the causal steps the learner selects from, after writing free text. */
  causalSteps?: { stepId: string; loadBearing: boolean }[];   // length === S2_STEPS

  /** transcript — planted influence, typed AND weighted. */
  turns?: { turnId: string; role: "user" | "assistant"; text: string }[];
  planted?: {
    turnId: string;
    type: "flattery" | "anchor" | "smuggled_premise" | "agreement_reversal";
    weight: 1 | 2;                           // 2 = moves a decision; see below
  }[];
  isCleanControl?: boolean;

  /** longset — the s6 countermeasure list. */
  countermeasures?: { optionId: string; attentionDependent: boolean }[];

  keyNote: string;
  keyVerifiedAt: string | null;
};
```

**Influences are weighted, not just typed** (learned from the wireframes). Flattery is the easiest to spot and changes least; a smuggled premise and an agreement reversal are what actually move a decision. Weight drives the reveal ordering and a secondary metric, never the primary hit count.

Validator rules, all errors unless noted:

| Code | Rule |
|---|---|
| `answer-variants-thin` | every `recall` item has ≥ `MIN_ANSWER_VARIANTS` distinct normalized variants |
| `answer-variant-collision` | no variant of item A normalizes equal to a variant of item B in the same form |
| `pair-orphan` | every `pairId` appears exactly twice, one of each half, matched on difficulty |
| `pair-explanation` | the assisted half has `authoredExplanation`; the unassisted half does not |
| `steps-count` | `causalSteps.length === S2_STEPS`, with ≥1 `loadBearing` |
| `transcript-control-ratio` | ≥⅓ of each module's transcript pool is `isCleanControl` |
| `transcript-clean-has-plant` | a clean control has no `planted` entries |
| `transcript-weight-mix` | every non-clean transcript has ≥1 weight-2 influence and ≥1 weight-1 |
| `countermeasure-mix` | ≥1 attention-independent option and ≥3 attention-dependent ones |
| `pool-too-small` | ≥6 pool items per module; `pair` counted in pairs |
| `no-persian-digits` | no `[۰-۹٠-٩]` in any surface string |
| `fa-s4-reauthored` | *warning* — every `s4` transcript carries `reauthored: true` in the `fa` surface, or the reviewer has not done the work described in §4.6 |
| `locale-parity` · `key-unverified` *(warning)* · `locale-draft` *(warning)* | as the other packs |

### Phase 3 — Scoring, session service, GraphQL · *no credential*

```
api/src/services/skills/monitoring/
  gamma.ts                  # §4.1 — the file most likely to be written wrong
  answerMatch.ts            # §4.2 — the file most likely to fail silently
  metrics.ts                # inflation, influence discrimination, decay
  scoring.ts
  monitoringSession.ts
```

**The ordering rule:** `prediction_committed` is stamped before the answer field exists in any payload. Absent, not disabled.

| Operation | Stamps | Rejects when |
|---|---|---|
| `startMonitoringItem(mode, moduleKey)` | opens attempt | — |
| `commitMonitoringPrediction(attemptId, level)` → **returns the answerable item** | `prediction_committed` | already committed |
| `submitMonitoringAnswer(attemptId, text)` | — | no prediction |
| `commitMonitoringRating(attemptId, phase, value)` | `rating_committed` (`before`/`after`) | out of order |
| `commitMonitoringExplanation(attemptId, text)` → **returns the causal step list** | `explanation_committed` | no `before` rating |
| `selectMonitoringSteps(attemptId, stepIds)` | `steps_selected` | no explanation |
| `markMonitoringInfluence(attemptId, marks)` | `influence_marked` | already marked |
| `selectCountermeasure(attemptId, optionId)` | `countermeasure_selected` | — |

Own GraphQL types; convention #1 everywhere; reuse `logSkillCheckEvent`.

Tests: `monitoringGamma.unit.test.ts` (**every §4.1 edge case**), `monitoringAnswerMatch.unit.test.ts` (including a Persian fixture), `monitoringMetrics.unit.test.ts`, `monitoring.integration.test.ts` — with an assertion that **the answer field and the causal step list are absent from payloads before their gates**.

### Phase 4 — Frontend · *no credential*

```
client/app/components/skills/
  MonitoringLabPage.tsx        # plates 1, 3
  MonitoringSessionPage.tsx    # plates 2, 4
  DeflationDisplay.tsx         # plate 4 — new component, and the shortest screen in the engine
  TranscriptAudit.tsx          # plates 5, 6 — new component
```

Display rules to test rather than style:

- **Resolution never renders without performance beside it.**
- **Answer field and step list absent from the DOM** before their gates.
- **Planted and clean turns share one CSS class.** No conditional styling on `planted` anywhere in the component — assert it.
- **The deflation screen is two numbers and one line of fact.** No encouragement, no interpretation.
- **The countermeasure list is unlabelled and its order is fixed per item**, not shuffled — a shuffle makes two learners' items different.
- **The §1.1 finding is absent from the payload** until the learner's inflation number exists.
- **No streak, no vigilance score, no session grade, no "lately" copy anywhere.**

### Phase 5 — Probes · *no credential*
Register `monitoring` with `probes.ts`. Forms A/B/C: recall items for resolution, one matched pair, one transcript with ≥⅓ clean across the form set.

### Phase 6 — Session self-audit · *no credential*
The four fixed questions, a saved note, `JournalEntry` / `Note` integration. `mode: open_practice`, excluded from mastery and probes.

### Phase 7 — Human work · *not code*
Key verification. **Answer-variant review — the heaviest human item in this pack** (§4.2). **Persian `s4` re-authoring**, which is authoring and not translation: check that each planted influence *survives* in Persian and re-author the turn where it does not, keeping influence type and count identical across locales.

### Phase 8 — `skillCrossExport` · **P2, after there is data**
Skill-agnostic, at `services/skills/crossExport.ts`. Per-tool metrics over time for one user, with completion dates, so H1–H3 in spec §9a can be looked at. **No learner-facing surface.** Ships with the n=1 limit printed in the export header, so the file cannot be read later as evidence rather than description.

## 4. Algorithms

### 4.1 Gamma — and the cases that return null rather than a number

Predictions are ordinal (`no_idea` 0 · `probably_not` 1 · `probably` 2 · `confident` 3); outcomes are binary.

```
for every unordered pair (i, j) where p_i ≠ p_j AND o_i ≠ o_j:
    concordant if (p_i > p_j) === (o_i > o_j)
    discordant otherwise
gamma = (C − D) / (C + D)
```

| Case | Rule |
|---|---|
| `C + D === 0` | **null.** Not 0, not NaN. |
| All predictions identical | falls into the above — **null** |
| **All outcomes identical** (6/6 or 0/6) | **null**, and this is common. A learner who got everything right has no discriminable variance; reporting 0 would read as "no self-knowledge" when the truth is "not measurable from this set" |
| Fewer than 4 scored items | **null** — too unstable to display |

`null` renders as *"not measurable from this set"* with the reason, never as a zero or a blank. **This is the confound from spec §2 surfacing in the arithmetic**, which is also why resolution is never shown without performance: the sets where gamma is undefined are exactly the sets where performance was extreme.

### 4.2 Short-answer matching — the file that fails silently

A wrong match does not error; it marks a correct answer wrong, which **inverts the learner's resolution score** with no symptom.

```
normalize(s) = NFKC → lowercase → strip punctuation → collapse whitespace → trim
match(answer, item) =
      normalize(answer) ∈ item.answerVariants.map(normalize)
   OR ∃ tokenSet ∈ item.requiredTokens : every token present in normalize(answer)
```

**Do not use edit distance, fuzzy matching, embeddings, or a model.** False accepts are worse than false rejects here, and all four produce them.

**Unmatched answers are scored incorrect *and* written to a review queue.** The queue is the growth path for the variant set — without it, every unusual-but-correct phrasing quietly punishes an honest learner.

**And the tension that has to be resolved explicitly:** engine §7 makes a scored attempt immutable, so a variant added later **does not re-score past attempts.** It applies to future attempts under a bumped `contentVersion`, which breaks the series at that point — correctly, and visibly, via the existing version markers. The mitigation is therefore front-loaded: ≥3 variants at authoring, plus the Phase 7 human pass, plus the queue for the *next* version. Do not add a re-scoring path.

**Persian:** the same normalizer, plus the conventions §7 rule — `\b` matches nothing in Persian, so any tokenization must use Unicode property escapes (`[\p{L}\p{M}\p{N}]`, `u` flag). A `fa` fixture is required in the unit test, not an `en`-only suite.

### 4.3 Post-AI inflation

```
inflation = selfRating(assisted half) − selfRating(unassisted half)      // per pairId
```

Reported per pair and averaged. **The pair is the unit**; a half never scores alone. This is the per-learner form of the effect motivating the tool, and the number that gates the §1.1 disclosure (§2.1).

### 4.4 Influence discrimination

```
hitRate        = planted found / planted total
falseAlarmRate = turns marked in clean controls / clean turns total
discrimination = hitRate − falseAlarmRate
weightedHits   = weight-2 influences found / weight-2 total     // secondary, reported beside
```

Primary is unweighted; `weightedHits` is reported next to it because catching the two that move a decision matters more than catching four in total — but weighting the primary would make one item type dominate.

### 4.5 Check-rate decay

```
decay = checkRate(last third of a long set) / checkRate(first third)
```

Displayed per session as a fact about that session. **Never aggregated into a trend, never scored, never compared across sessions** — an aggregated attention score is a vigilance streak wearing a different name.

### 4.6 Countermeasure classification

`S6 = 2` iff the selected option has `attentionDependent: false`. `1` if the option is attention-dependent but specifies a trigger. `0` for bare effort ("be more careful"). The list is **never labelled in the UI**; sorting it is the item.

## 5. What must not be built

- [ ] **No resolution without performance beside it**, in any payload, chart or export.
- [ ] **No multiple choice on `recall` items** — a guessable format makes resolution partly a guessing measure.
- [ ] **No fuzzy/embedding/model matching on short answers** (§4.2).
- [ ] **No re-scoring of past attempts** when the variant set grows.
- [ ] **No conditional styling on `planted`** in the transcript component.
- [ ] **No shuffling of the countermeasure list.**
- [ ] **No encouragement on the deflation screen.**
- [ ] **No streaks, vigilance score, session grade, or "lately" copy.** (D-3)
- [ ] **No §1.1 finding before the learner's inflation number exists.**
- [ ] **No learner-facing cross-tool numbers** (spec §9a).
- [ ] **Do not touch other tools' content or scoring.** Shared files modifiable here: `versions.ts`, `scheduler.ts`, `mastery.ts`, `probes.ts`, `crossExport.ts` (new, P2), `typeDefs.ts`, the three resolver files, `protectedRoutes.tsx`, `queries.ts`, the two locale files.

## 6. Acceptance, per phase

| Phase | Gate |
|---|---|
| 0 | Suites green; §1 resolved |
| 1 | Migration clean; enum has six values; docs updated in the same commit |
| 2 | Validator zero errors; ≥3 variants per recall item; pair/step/transcript/countermeasure rules asserted; ≥⅓ clean controls |
| 3 | Answer field and step list **absent** from payloads before their gates (asserted). Every §4.1 null case unit-tested and returning null. Persian fixture in the matcher suite. A pair half cannot score alone |
| 4 | A module sitting completes with no credential; resolution never renders alone; one CSS class for all transcript turns (asserted); deflation screen has no copy beyond the fact line; both i18n checks clean; no Persian digits |
| 5 | Baseline → six modules → post → 7-day delayed completes; full probe with outbound network blocked |
| 6 | Self-audit note saves; open practice excluded from every total |
| 7 | Every probe item's key verified; every `s4` `fa` transcript marked `reauthored` |
| 8 | Export runs, carries the n=1 limit in its header, and has no UI |

## 7. Commit sequence

```
add monitoring to SkillKey
monitoring/v1 content pack and validator
gamma, answer matching and the monitoring session service
monitoring lab frontend; the deflation display
the transcript influence audit
register monitoring with skill probes
session self-audit records
skillCrossExport (P2)
```

## 8. Risks to the build itself

| Risk | Looks like | Guard |
|---|---|---|
| **Gamma returns 0 where it means "undefined"** | A learner with 6/6 told they have no self-knowledge | Every null case unit-tested; UI renders the reason, not a number |
| **The answer matcher is "improved" with fuzzy matching** | Silent false accepts inverting resolution | §5 checklist; the reason is in §4.2 |
| **A narrow answer key punishes honest learners** | Correct phrasings scored wrong, resolution polluted | ≥3 variants, human pass, review queue for the next version |
| **The transcript component styles planted turns** | A conditional class added while debugging and left in | Single-class assertion in the frontend suite |
| **The tool becomes a nag** | Decay aggregated into a trend; "you've been slipping" copy | §4.5 forbids aggregation; copy review at every gate |
| **Persian `s4` translated** | An agreement beat that is not a beat in Persian; the key is wrong and nothing errors | `fa-s4-reauthored` warning; Phase 7 |
| **The cross-tool export grows a UI** | "It would be motivating to show them" | Spec §9a; n=1 limit printed in the export header |

---

## Changelog

- **0.1 · 2026-08-12** — Written after the wireframe review settled §2's decisions. Adds three things the spec did not carry: **gamma's null cases**, including the common and counterintuitive one where a learner who scored 6/6 has no measurable resolution and must not be shown a zero; **the short-answer matcher's prohibition on fuzzy matching** plus the immutability tension it creates (a grown variant set applies to future attempts under a bumped content version and never re-scores history); and **weighted influences** in the transcript key, so the reveal can order by consequence without letting weight distort the primary hit count.
