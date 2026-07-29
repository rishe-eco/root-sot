# Tracker — R&D Notes

*The R&D log: what is being tested for graduation into the product. Designed-but-unbuilt work lives in `canon/06-specs/`; this file tracks its status, what each piece is for, and what has to be true before it ships. Update the changelog; don't fork.*

**Version 0.1 · Status: living · 2026-07-29 · Owner: _root**

---

## What "graduation" means here

A spec graduates when it ships. At that point its as-built reality moves into `canon/01-product/` and `canon/02-architecture/`, and the spec file is **marked superseded rather than deleted**. Everything on this page is graded **spec** throughout — none of it is verified against code, because none of it exists yet.

This file is the index and the status board. The specs themselves are the detail.

## In R&D now — the Skills Engine and its two tools

Three specs written **2026-07-26**, all v0.1, all status `spec`. They form one system: an engine plus two content-and-scoring packs.

| Spec | What it is | Status |
|---|---|---|
| `canon/06-specs/00-skills-engine.md` | Shared machinery: initial assessment (doubling as baseline measurement), sequenced modules on a fixed seven-step template, per-item feedback, error diagnosis, open practice, spaced review queue, progress tracking, delayed retention probe, data export. | spec |
| `canon/06-specs/01-clarity-lab.md` | Skill tool #1 — **clarity of expression**. Trained slowly, by revision. | spec |
| `canon/06-specs/02-evidence-lab.md` | Skill tool #2 — **evidence-seeking**. Trained fast, as a drilled reflex. | spec |

### The asymmetry that is the whole design risk

The two tools deliberately do **not** share pedagogy. From the engine spec:

| | Clarity Lab | Evidence Lab |
|---|---|---|
| Session shape | few, long (8–20 min), one artifact | many, short (2–4 min), 3 items |
| Unit of work | a written artifact the learner revises | a claim the learner checks |
| What's scored | the **product**, by analytic rubric | the **behavior**, by instrumentation |
| Progression | revision delta over drafts | reflex rate and latency |
| Failure mode to design against | "checkbox clarity" written to the rubric | blanket distrust instead of discrimination |

> **The stated risk, worth repeating because it is the thing to watch:** an engine that treats these as two skins on one quiz component will produce a working Clarity Lab and a **useless** Evidence Lab.

### What each tool is actually training

- **Clarity Lab.** Lineage is Grice's maxims (used as *diagnostic vocabulary for why an attempt failed*, never as commandments), Pinker on why human indirectness doesn't apply to a machine, and Williams/Turabian on subjects-as-characters and verbs-as-actions. Core loop: *write it → see what the reader actually received → diagnose the gap → revise → see the difference.* The central mechanic is the **gap reveal** — the learner predicts what the reader will produce, then sees the actual output; the distance is the lesson. Six modules, 1:1 with rubric criteria.
- **Evidence Lab.** Lineage is Wineburg & McGrew on **lateral reading** (fact-checkers were faster *and* more accurate because they left the page immediately), Caulfield's **SIFT**, and epistemic vigilance — over-trust was the single biggest predictor of a bad outcome across studies. Two non-negotiables: it trains a **reflex, not an audit** (items are timed; a 40-second correct check beats a 6-minute one), and the goal is **discrimination, not distrust** (every form contains true, well-sourced control claims; the headline metric is hit rate *minus* false-alarm rate). A tool that never lets the AI be right teaches distrust and calls it vigilance.

### Constraints these specs inherit

Stated in the specs, and each is a live temptation worth re-checking at build time:

- **No streaks, badges, or leaderboards.** Streak-style habits were deliberately removed from Tracker (`decisions/decision-log.md`; `components/habits/` is intentionally empty). The review queue — "3 modules due" — is the only recurring pressure permitted. Reintroducing streaks here contradicts a standing product decision.
- **Not a prompt-tips library.** The founding finding is that tricks perish and skills compound. No "10 magic phrases" surface, no model-specific technique content.
- **Not a chat playground.** The learner never free-chats with a model inside the Lab; every AI turn is a scored or scaffolded step.
- **Not gated onto anything.** Consistent with the Clarity Check, these tools never block another Tracker flow.
- **No proctoring.** Single-user self-development; item leakage is handled by parallel forms, not surveillance.

### Related code already on disk

The `tracker` repo carries **uncommitted** early work matching these specs — `api/src/content/skills/clarity/`, `api/src/services/skills/clarity/`, and three unit test files (`clarityDetectors`, `clarityJudge`, `clarityScoring`). That work is ahead of this log: the specs are still v0.1 `spec`, but code exists. **Reconcile before trusting either** — if the code has settled decisions the spec doesn't record, the spec is wrong and should be updated.

## Open questions before anything here graduates

1. **Does this belong in Tracker at all?** Tracker is Root's **Organize** pillar. Skill training reads closer to **Grow (Learn)** (`../ecosystem/canon/02-pillars/learn.md`). Building it inside Tracker may be a scope error — resolve against the pillar definitions before shipping, not after.
2. **Judge reliability for Clarity Lab.** The engine names rater/judge reliability as the scoring risk. No reliability target or measurement method is specified yet.
3. **Item validity for Evidence Lab.** The stated risk is item validity rather than scoring. No item-authoring or validation process exists yet.
4. **Sequencing against the Organize refactor.** `roadmap.md` §5 is the committed work. Nothing here is on that roadmap; decide explicitly whether this runs in parallel or waits, rather than letting it drift in alongside.

## Graduated

*(none yet)*

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Indexes the three Skills Engine specs (all 2026-07-26) at repo consolidation; records the uncommitted clarity code found in the `tracker` repo and the four open questions.
