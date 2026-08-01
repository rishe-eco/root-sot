# Root · ریشه — Canon

This directory is the **canonical layer**: the stable, cited source of truth for what Root is and how we work. It is deliberately separate from the **living layer** — `../working/` here, plus Affine (opportunity trees, interview scripts, test plans, in-progress feature specs, kanban) — the things that change every day as discovery runs. Canon here should be stable enough to cite; if it's moving weekly, it belongs in `../working/` or Affine, not in this directory.

## House rules

- **Don't fork a decision — update it.** One file per topic. If a decision changes, edit the file and add a changelog line. Two files disagreeing within a week is the failure mode this repo exists to prevent.
- **Every file carries a header:** version, status (canonical / draft / deferred), date, owner, and a one-line "what this is."
- **Brand is the apex.** Everything derives from `01-philosophy/01-brand-definition.md`. When any file conflicts with brand, brand wins and the other file is wrong.
- **Grade your evidence.** Where a claim rests on research, say how strong the research is. Reality over fiction applies to our own foundations.
- **Grounded vs. inferred.** As-built descriptions of existing code are marked where they drop below the data-model level to inference ("verify in code").

## Read order (also the onboarding Movement 0–2 path)

1. `01-philosophy/01-brand-definition.md` — the thesis everything derives from
2. `01-philosophy/00-core-philosophy.md` — how self-authorship works, and what we build on
3. `01-philosophy/02-anti-patterns-and-constraints.md` — what we refuse, and why
4. `02-pillars/00-the-loop.md` — how the five pillars form one system
5. `02-pillars/{reflect,maintain,organize,learn,others}.md` — the pillars themselves
6. `03-engine/00-five-phase-engine.md` → `../ost.md` (the Opportunity Solution Tree) → `03-engine/02-async-coordination.md` → `03-onboarding.md`
7. `04-research/00-evidence-summary.md` + `01-known-risks-and-mitigations.md` (+ `02-durable-ai-skills.md` if you are working on the Skills Engine)
8. `../decisions/decision-log.md` — how we got here, and what we've set aside

## Map

```
ecosystem/                              ← the Root area of root-sot
  ost.md                                the Opportunity Solution Tree
  roadmap.md                            ecosystem sequencing (skeleton)
  personal-canon.md                     private register
  root-canon-log_2026-07-14_to_...md    bridge record, 14 → 22 Jul 2026
  decisions/
    README.md                           ADR convention
    decision-log.md                     append-only, living
  working/                              living layer — website specs, Learn discovery, brand assets
  research/                             evidence base + domain research
  archive/                              provenance: source records that fed the canon
  deprecated/                           superseded drafts, each logged
  canon/                                ← you are here
    README.md
    01-philosophy/
      00-core-philosophy.md
      01-brand-definition.md            (v1.0 — the apex)
      02-anti-patterns-and-constraints.md
    02-pillars/
      00-the-loop.md                    integration architecture
      reflect.md   maintain.md   organize.md   learn.md   others.md
    03-engine/
      00-five-phase-engine.md
      02-async-coordination.md
      03-onboarding.md
    04-research/
      00-evidence-summary.md
      01-known-risks-and-mitigations.md
      02-durable-ai-skills.md         the evidence base under the Skills Engine
```

**Two files were promoted out of this canon** on 2026-07-29, into the repo's navigational spine: the Opportunity Solution Tree (was `03-engine/01-opportunity-solution-tree.md`, now `../ost.md`) and the decision log (was `05-log/decision-log.md`, now `../decisions/decision-log.md`). This is why `03-engine/` skips from `00` to `02`.

**Naming note:** the master brand is **Root / ریشه** (the Persian side was revised from بن; see the decision log). Pillar files use their working names; **Others** is a working name pending resolution (see `02-pillars/others.md`).

## Status of this pass

First full draft, 2026-07-14. Brand is the founder's v1.0. Everything else is 0.1 — written from decided material across the design conversations, meant to be stable enough to start the team on and to be sharpened through contact, not frozen. Feature-spec detail for each pillar is deliberately absent; it belongs to the living layer until a pillar clears Phase 5.

**Second pass, 2026-07-22 (light).** Reconciled the canon with the seven sessions since it was created (see `../root-canon-log_2026-07-14_to_2026-07-22.md`). The canon held up well; changes were additive/refinements, not a rewrite: **Root Dev → Root Studio** (brand §6/§7, anti-patterns §4); the **reconstrual/self-distancing** finding and the **H6a/H6b** split folded into `reflect.md`, `learn.md`, and the evidence summary; the Learn **English-only-for-now build nuance** noted; **AFFiNE marked deployed** (was deferred). Touched files moved to 0.2; the decision log carries the full ledger. **Deliberately kept out:** Nahal/VPS/portal implementation detail (living layer) and the private philosophy track (`../Research/`).

**Where this canon sits.** It is one pile inside the larger `ecosystem/` area — alongside `../working/` (living-layer docs), `../research/` (evidence), `../archive/` (provenance/originals), and `../deprecated/` (superseded drafts, logged). See `../README.md` for the map of those piles, and `../../README.md` for the whole repo.
