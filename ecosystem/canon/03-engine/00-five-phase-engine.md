# Root · ریشه — The Development Engine (Five Phases)
*Source of truth. Short on purpose. How we discover and build each pillar. Update the changelog; don't fork.*

**Version 0.1 (draft) · 2026-07-14 · Owner: _root**

---

## 1. What it is

A repeatable discovery-and-build loop, run per pillar, structured around a single living artifact (the Opportunity Solution Tree — see `../../ost.md`). It replaces an earlier 14-step checklist; the steps weren't wrong, but most were "build the artifact," and the artifact is the tree. The engine's job is to move down that tree, phase by phase, with a real deliverable at each gate — which is also what makes async work (see `02-async-coordination.md`).

## 2. The five phases

**Phase 1 — Establish outcome & map opportunity space** (~3–5 days, async-capable)
Lock a single product outcome (the tree's root; doesn't change mid-loop). Recruit 7–10 people whose context makes the pillar relevant; run story-based interviews until 3–5 agree to test later. Analyze into a *cluster of 3–5 related opportunities*, not one — mapped visually with reasoning on each. *Deliverable:* opportunity branch of the tree, with notes.

**Phase 2 — Choose an opportunity & generate solutions** (~2–3 days)
Pick one target opportunity (most common × most impactful × most solvable). Generate 3–5 genuinely different solution approaches, each with its assumptions made explicit. Choose the first to test (highest confidence × lowest risk), and break it into 4–6 assumptions ranked by risk. *Deliverable:* solution branch + ranked assumptions.

**Phase 3 — Design & run the test** (~4–5 days)
Design a test that can *falsify the riskiest assumption* fast. Build only enough prototype to run that test. Run it with the committed testers. Analyze against the pre-written questions — which assumptions held, which failed, what was learned. *Deliverables:* test plan, minimal prototype, analysis (facts, not conclusions).

**Phase 4 — Decide & iterate** (~1–2 days; the one synchronous gate)
Read the tree together. Choose: (a) *iterate* the solution (assumptions held, execution rough), (b) *pivot* to another solution for the same opportunity (assumptions failed), or (c) *move on* to the next sibling opportunity (solved well enough). *Deliverable:* decision recorded on the tree; next assignment. You don't restart Phase 1 — you move down the tree (pivot→Phase 2/3, iterate→Phase 3, move-on→Phase 2 for the next opportunity).

**Phase 5 — Consolidation & integration** (~1–2 weeks, once ~3 opportunities are solved)
Crystallize what testing taught into the actual feature set and interaction design, then UX polish and design handoff. This is where a pillar's *feature spec* is born (and, per README, graduates from Affine into canon). *Deliverable:* feature spec + design ready for development.

## 3. Rhythm and limits

A discovery loop (Phases 1–4) runs ~10–15 days and solves one opportunity; 2–3 loops precede Phase 5. **WIP limit: one pillar in Phase 3 (test) at a time** — testing needs coordination. Multiple pillars can sit in Phases 1–2 (discovery/ideation) in parallel, since those are largely independent.

## 4. Variable depth

Uniform process across non-uniform uncertainty is waste. A pillar with strong anchors (Reflect, Learn) needs less empathize-depth than a barely-defined one (Others). A short uncertainty triage at the front of each pillar sizes how much of each phase it actually needs.

## 5. Two disciplines that protect the engine

- **Pilot on low novelty, not Others.** First real runs go on a slice of Organize or Reflect, so you're stress-testing the *engine*, not the *concept*. Piloting on Others confounds "is the process working" with "is the idea right."
- **Don't specify before contact.** Lock only the *canonical, evidence-independent* layer up front (brand, philosophy, vocabulary, ways-of-working, this engine's skeleton). Everything evidence-dependent (a pillar's actual features, guideline detail, UX) gets a container left deliberately empty until contact fills it. Fully specifying in a vacuum is the exact trap Root exists to fight, one level up — and effort spent there converts to commitment that then resists the discovery meant to correct it.

## 6. Open questions

- Exact done-checklists per phase gate (drafted in `02-async-coordination.md`, sharpened by piloting).
- How Phase 5 feature specs are versioned as they graduate into canon.

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Five phases from the reworked engine; the 14-step checklist folded into tree-building; WIP limit, variable depth, pilot-low-novelty and don't-specify-before-contact disciplines.
