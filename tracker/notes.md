# Tracker — R&D Notes

*The R&D log: what is being tested for graduation into the product. Designed-but-unbuilt work lives in `canon/06-specs/`; this file tracks its status, what each piece is for, and what has to be true before it ships. Update the changelog; don't fork.*

**Version 0.2 · Status: living · 2026-08-01 · Owner: _root**

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

The `tracker` repo carries **committed** early work matching these specs (in the single `init` commit; working tree clean) — and it is **broader than clarity**: `api/src/content/skills/` (both `clarity/v1` and `evidence/v1`, `en`+`fa`), the shared `api/src/services/skills/` (`evidenceSession`, `mastery`, `planning`, `profile`, `scheduler`, `scoring`) plus `services/skills/clarity/`, unit tests (`clarityDetectors`, `clarityJudge`, `clarityScoring`, `skillScoring`) and a `skills.integration` test, and early client pages (`EvidenceDrillPage`, `EvidenceLabPage`, `SkillPlanPanel`). That work is ahead of this log: the specs are still v0.1 `spec`, but code exists. **Reconcile before trusting either** — if the code has settled decisions the spec doesn't record, the spec is wrong and should be updated.

## Open questions before anything here graduates

1. ~~**Does this belong in Tracker at all?**~~ **Resolved 2026-08-01** (`../ecosystem/decisions/decision-log.md`). It belongs conceptually to **Grow (Learn)** (`../ecosystem/canon/02-pillars/learn.md` §1 — skill-training builds durable capacity on purpose). Tracker is a **staging ground**, not the Organize pillar, so hosting it here is not a scope error; code location does not determine ownership. It stays a **second Learn content family**, distinct from Module 1 (Feelings & Needs), and may later move to its own app. Open-Qs 2–3 (reliability gates) still stand.
2. **Judge reliability for Clarity Lab.** The engine names rater/judge reliability as the scoring risk. No reliability target or measurement method is specified yet.
3. **Item validity for Evidence Lab.** The stated risk is item validity rather than scoring. No item-authoring or validation process exists yet.
4. **Sequencing against the Organize refactor.** `roadmap.md` §5 is the committed work. Nothing here is on that roadmap; decide explicitly whether this runs in parallel or waits, rather than letting it drift in alongside.

## Graduated

*(none yet)*

---

## Changelog

- **0.2 · 2026-08-01** — Resolved open-Q #1 (the Skills Engine belongs to **Grow (Learn)**; Tracker is a staging ground — decision log, 2026-08-01). Corrected the "related code on disk" note: it is **committed** (single `init` commit) and broader than clarity — evidence content, shared services, and early client pages are present too.
- **0.1 · 2026-07-29** — Initial. Indexes the three Skills Engine specs (all 2026-07-26) at repo consolidation; records the uncommitted clarity code found in the `tracker` repo and the four open questions.
