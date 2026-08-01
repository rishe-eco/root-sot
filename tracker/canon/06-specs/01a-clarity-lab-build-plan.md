# Clarity Lab — build plan

*The order the surface gets built in, what each phase delivers, and exactly what has to be configured before the AI-dependent half can run. Implements `01-clarity-lab.md`; wireframes drawn 2026-08-01. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-08-01 · Owner: _root**

---

## 1. The three decisions this plan implements

Settled 2026-08-01 after the wireframe review:

1. **Offline path first.** Ship the half of Clarity Lab that needs no model at all, then add the half that does. Rationale below.
2. **Ship visible-but-uncalibrated.** Reader-scored criteria are marked *feedback only* and contribute to no probe total until the calibration pass is done. Same precedent as Evidence Lab: practice works, measurement is gated, the gate says so out loud.
3. **Three practice items per module.** Eighteen total, authored before the frontend rather than after — cheaper than rediscovering the gap the way Evidence Lab did (**D-17**).

## 2. What "offline" means here, precisely

Clarity Lab's item types do not have a uniform dependency on a model. The split is clean and it is the reason the phasing works:

| Item type | Needs a model? | Why |
|---|---|---|
| **Revision** | **No** | The weak text *and* the reader's misread are both authored into the content pack. The gap reveal is a playback, not a generation. |
| **Repair** | **No** | One seeded fault, scored by the R4/R6 detectors. |
| **Elicitation** | **Yes, twice over** | The reader's output must respond to *the learner's own text*, so it cannot be authored. And R3 (necessary context supplied) is judge-only — there is no detector for it. |

So the offline build is not a degraded preview. It is **revision and repair, complete**, including the diagnose step, diagnosis accuracy, the gap reveal, the revision chain and the delta. What it cannot do is elicitation, which is the scored core of the probe — so the offline build trains but does not measure.

**Scoring in offline mode.** R1, R4 and R6 are scored by detectors. R2, R3 and R5 are reported as **unscored** and removed from both numerator and denominator (`7/10, 5 of 6 criteria` — never a silently weakened `7/12`). Mastery is unreachable and the tool says why: the missing criteria are context and success criteria, half the skill, and redefining mastery down to whatever happens to be measurable would hand out mastery of something nobody assessed.

**Diagnosis accuracy is fully available offline** and is worth noting, because it is the transferable half of the skill and it costs nothing: the learner's tagged criteria are compared against the item's authored `seededFaults`. No model is involved in that comparison at any point.

## 3. Phases

### Phase 1 — Content · *no credential required*

Eighteen practice items, three per module, all offline-capable, `en` + `fa`.

- `c1-ask`, `c2-deliverable`, `c3-context`, `c5-done` → **revision** items. Three each.
- `c4-referents`, `c6-economy` → **repair** drills. Three each.

Repair drills stay confined to `c4` and `c6` per spec §5; the other four modules get revision items, which is on-message rather than a compromise — revision is the tool's declared centre of gravity.

Also in this phase: a Clarity content validator mirroring Evidence's, enforcing locale parity, `MIN_POOL_ITEMS_PER_MODULE = 3`, seeded faults matching the module's own criterion, and — new for this tool — **a per-module count of *offline-capable* pool items**, so a module cannot silently become AI-only.

### Phase 2 — Session service and GraphQL · *no credential required* · **built 2026-08-01**

Larger than Evidence Lab's equivalent, because a Clarity attempt carries more state and more of it is order-sensitive:

- serve item → open attempt
- **lock prediction** (elicitation only; server-stamped, not editable after)
- **lock diagnosis** (server-stamped, before any score is returned)
- score → return per-criterion levels with evidence
- **link revision** to its draft via `revisionOfAttemptId`, compute delta

The two locks are the same category of thing as Evidence Lab's check-event ordering: the *sequence* is the measurement, so it is stamped server-side and a client cannot assert it after the fact. A score request that arrives before a diagnosis lock is rejected rather than served.

*As built, three things worth keeping:*

- **The locks reuse `SkillCheckEvent` rather than adding columns.** `prediction_locked` and `diagnosis_locked` are event rows carrying the text or the tag list as payload, with the offset stamped server-side. That model exists precisely because "the ordering is the measurement", so no migration was needed and the two tools now record their forcing functions the same way.
- **A revision is a second attempt row**, linked by `revisionOfAttemptId`, never an edit. That is what makes the delta a comparison of two scored artifacts rather than a diff of one mutable field — and it also supplies the mastery rule for free: `unscaffolded` is simply `revisionOfAttemptId == null`, read from the data rather than carried as a flag. A revision follows feedback that named exactly what failed, so counting it would measure the feedback rather than the learner.
- **Elicitation items are withheld when no reader is configured.** Serving one and dead-ending at the reveal is worse than serving fewer items, so the candidate filter drops them and the progress surface reports `readerAvailable: false`.

Clarity got its **own GraphQL types** (`ClarityModule`, `ClarityServedItem`, `ClarityAttemptResult`, `ClarityProgress`) rather than widening the Evidence ones. The two tools measure different things — behaviour against an authored key versus a product against a rubric — and a shared type would have had to make every field on both sides nullable to accommodate the other.

### Phase 3 — Frontend, plates 1–8 · *no credential required* · **built 2026-08-01**

Wireframes: `` artifact, draft 1. Plate 4 (the three-pane gap reveal) is the only genuinely novel component; the rest is a rearrangement of things Evidence Lab already has. Elicitation screens are built in this phase but gated behind the credential check, showing the "needs a reader" state rather than being hidden — an absent feature that explains its own absence is better than one that silently isn't there.

`en` + `fa`, with RTL passes on the artifact editor, the three panes and the rubric rail.

*As built:* two pages (`ClarityLabPage`, `ClaritySessionPage`) plus a shared `RubricRail`, 176 i18n keys at `en`/`fa` parity, three frontend tests.

**The stage order differs by item type, and not arbitrarily** — the diagnose step means something different in each. A *revision* item diagnoses someone else's text and then rewrites it, so diagnosis comes first and is the reading exercise. An *elicitation* item writes, predicts, sees the gap, and only then diagnoses its own text — because until the gap reveal there is nothing to diagnose. A *repair* drill has its fault named in the prompt, so there is no diagnose step at all. What is constant is the rule: whatever the learner commits, they commit it before any score appears.

Two display rules are load-bearing enough to be tested rather than left to styling: an **unscored criterion renders as the words "not scored", never as an empty two-pip row**, because an empty row is indistinguishable from a level of 0; and the total reads **`5 / 6`, with "3 of 6 criteria scored" beneath it**, never a silently weakened `5 / 12`.

### Phase 4 — Elicitation · **credential required** (§4)

- The **reader** — a second model call, distinct from the judge (§4.2).
- **R2, R3, R5 scoring** via the existing judge, which is already built and tested.
- Prediction accuracy metric.
- Elicitation items authored: the pack has one (`cl-p1`), and the probe form needs two per form.

### Phase 5 — Calibration · *human work, not code*

~20 human-scored samples per criterion, double-scored by two raters and reconciled, per locale. Until a criterion passes, it runs feedback-only. Tracked separately, same shape as the Evidence verification brief (`02a-...`). Persian needs this **more** than English does, not less: with R4 and R6 routed to the judge in `fa`, more of the Persian score depends on the judge than the English score does.

---

## 4. What has to be configured

### 4.1 The credential

**One environment variable, read by the API only.** Nothing in the client ever sees it.

```bash
# api/.env
ANTHROPIC_API_KEY=sk-ant-...
```

`ANTHROPIC_AUTH_TOKEN` is accepted as an alternative; either satisfies the check in `src/services/skills/clarity/anthropicJudge.ts`.

**It does not matter which account or organisation the key belongs to.** The code reads the environment variable and constructs the SDK client from it; nothing is tied to an identity, a workspace or a project. A key issued from a different account than the one being used elsewhere works without any change here.

Four things worth confirming about whichever key gets used, because each one fails at a different time:

| Check | Fails when | Symptom |
|---|---|---|
| Model access — `claude-opus-5` and `claude-sonnet-5` | First judge call | 404 on the model id. The models are pinned in `judge.ts` as `JUDGE_MODEL_PROBE` and `JUDGE_MODEL_PRACTICE`; change them there, not at the call site. |
| Spend limit / credit balance | Mid-session, unpredictably | The judge records a per-criterion failure and drops that criterion. The attempt still scores; the criterion reads unscored. |
| Rate limits | Under concurrent use | Same as above. Single-user use will not come close. |
| Key scope, if the account uses workspaces | First call | A workspace-scoped key that lacks the models behaves as a model-access failure. |

**No credential is needed for phases 1–3.** `createAnthropicJudge()` returns `null` when the variable is absent, and that is a supported state rather than an error path — the detectors still score R1/R4/R6 and the UI says plainly that three criteria need a reader.

### 4.2 The reader is a second call, and it is not the judge

This is the part that does not exist yet and is easy to under-scope. The judge *grades* a text against a rubric. The reader *responds* to it, and the entire mechanic depends on that response being honest rather than charitable:

- **No system prompt telling it to be helpful, thorough or generous.** A model instructed to do its best with an ambiguous request will paper over the ambiguity, and the gap reveal collapses — the learner writes something under-specified and gets a good answer back, learning the opposite of the lesson.
- **The prompt is the learner's text and nothing else.** No scenario, no context sheet, no rubric. The reader must be in exactly the epistemic position the learner's text puts them in, which is the whole point.
- **Model choice is a pedagogical parameter, not a cost one.** Too capable a reader recovers from vagueness and there is no gap to show; too weak a reader fails on texts that were actually fine, and the learner is punished for someone else's incompetence. Start on the same tier as the practice judge (Sonnet) and treat it as tunable — the honest test is whether the reader ever produces a *good* answer from a *good* request. If it doesn't, the reader is wrong, not the learner.
- **Cache nothing.** The judge's rubric prefix is identical across attempts and worth caching; the reader's input is unique by construction and there is no stable prefix to cache.

Record the reader's model id per attempt alongside `rubricVersion`. A reader change alters what the learner sees more than a judge change does, and comparing prediction-accuracy across two different readers is comparing two different instruments.

### 4.3 Cost

Small enough not to be a planning constraint, and worth writing down anyway so nobody has to guess:

- **Practice sitting, elicitation:** one reader call (short in, short out) plus up to six judge calls, each sharing a cached rubric prefix. Cache reads bill at roughly a tenth of input, which is what keeps a fully-judged six-criterion artifact in the single-digit cents.
- **Revision and repair sittings:** free. No calls at all.
- **Calibration:** ~120 judge calls per locale for a 20-sample × 6-criterion pass, run once per rubric version. The Batch API halves it if the pass is run offline, which it can be — calibration is not interactive.

The 1-hour cache TTL is deliberate and already implemented: usage here is bursty and low-traffic — one sitting, then nothing for days — so a 5-minute cache would be cold on essentially every session. The doubled write cost is worth paying once per sitting.

### 4.4 Nothing else

No other service, key, webhook or account is required by any phase. Evidence Lab needs no credential at all and is unaffected by everything above.

---

## 5. Acceptance, per phase

**Phase 1** — Validator passes: locale parity, ≥3 pool items per module, ≥3 *offline-capable* pool items per module, every item's seeded faults include its module's own criterion. Every repair drill's weak text fails its own bar under the detectors, and a competent fix clears it — asserted by test, so a drill can never disagree with the rubric it teaches.

**Phase 2** — A full revision item completes: serve → diagnose lock → score → revise → delta, with the draft/revision pair linked. A score request before a diagnosis lock is rejected. No rubric key, seeded-fault list or scoring hint appears in any client payload (asserted by test).

**Phase 3** — A learner can complete a module sitting end to end with **no credential configured**, with R1/R4/R6 scored, R2/R3/R5 shown as unscored with the reason, and mastery visibly unreachable. `en` and `fa` at key parity; RTL pass on the three panes.

**Phase 4** — An elicitation item completes with a live reader; `usage.cache_read_input_tokens` is non-zero on the second and later criteria of an attempt (a persistent zero means the prompt split has regressed and the cache is doing nothing). Identical submission re-scored returns the identical cached score.

**Phase 5** — Per-criterion agreement at or above threshold before that criterion contributes to a probe total; criteria below it stay feedback-only and stay visibly marked.

---

## Changelog

- **0.3 · 2026-08-01** — Phase 3 built: two pages plus a shared rubric rail, `en`/`fa` at parity, Clarity Lab now reachable from Tools. Stage order per item type documented; unscored-is-not-zero and the `n / 6` total pinned by test.
- **0.2 · 2026-08-01** — Phases 1 and 2 built. Phase 2 notes added: the locks reuse `SkillCheckEvent` (no migration), a revision is a second attempt row and supplies the unscaffolded flag for free, elicitation is withheld without a reader, and Clarity got its own GraphQL types rather than widening Evidence's.
- **0.1 · 2026-08-01** — Written after the wireframe review settled offline-first, ship-uncalibrated, and three items per module. Documents the item-type dependency split that makes the phasing possible, the single credential required, and the reader-versus-judge distinction that Phase 4 turns on.
